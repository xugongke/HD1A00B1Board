/**
 * @file    heater_ctrl.c
 * @brief   太阳能热水器加热控制模块实现
 *
 * 硬件背景:
 *   继电器采用磁保持继电器(双线圈), 断开/闭合各需一个脉冲驱动
 *   MOS管并联在继电器两端, 用于吸合前短接降低火花
 *   继电器状态通过数字输入引脚反馈 (低电平=闭合, 高电平=断开)
 *
 * 控制架构:
 *   主机通过ES1642载波模块发送加热命令(g_master_cmd)
 *   从机结合本地安全检测(温度/电压)决定是否执行
 *
 * heater_process() 核心决策流程:
 *   ┌─────────────────────────────────┐
 *   │ 1. 采集温度和电压               │
 *   │ 2. 更新LED指示灯状态            │
 *   │ 3. 温度≥75℃ 或 传感器异常?      │──→ 强制关闭加热, 清除主机命令
 *   │ 4. 继电器控制异常?              │──→ LED闪烁报警30秒后自动恢复
 *   │ 5. 电压低于载波通信阈值?        │──→ 进入低压自主控制模式
 *   │ 6. 主机命令=启动加热?           │──→ 检查电压→启动加热(最多重试3次)
 *   │ 7. 主机命令=停止加热?           │──→ 关闭加热(最多重试3次)
 *   └─────────────────────────────────┘
 */

#include "heater_ctrl.h"
#include "ek_gpio.h"
#include "ek_tim.h"

/* ==================== NTC温度查表 ==================== */

/*
 * 50K NTC热敏电阻 + 10K分压电阻, 接3.3V电源
 * ADC 10位分辨率 (0~1023)
 *
 * 查表方式: 每个表项对应一个温度点的ADC值
 * 4°C步长, 索引0=-20℃, 索引35=120℃, 共36个表项(72字节)
 * 温度计算: 实际温度 = 索引 × 4 - 20
 *
 * 查找算法: 二分查找, 在TempTable中找到ADC值对应的索引位置
 *
 * 为什么用4°C步长而不是1°C:
 *   - 老工程用1°C步长需要141个表项(占用282字节Flash)
 *   - 4°C步长只需36个表项(72字节), 节省210字节
 *   - 配合软件滤波, 实际控制精度±2°C, 满足热水器10℃控制带需求
 *   - STM8S003只有8KB Flash, 每一字节都很宝贵
 */
static const uint16_t TempTable[141] = {
    /*  -20C ~    9C */
    0x3EB, 0x3EA, 0x3E9, 0x3E7, 0x3E6, 0x3E4, 0x3E3, 0x3E1, 0x3E0, 0x3DE,
    /*  -10C ~   19C */
    0x3DC, 0x3DA, 0x3D8, 0x3D6, 0x3D4, 0x3D2, 0x3CF, 0x3CD, 0x3CA, 0x3C7,
    /*    0C ~   29C */
    0x3C5, 0x3C2, 0x3BF, 0x3BC, 0x3B8, 0x3B5, 0x3B2, 0x3AE, 0x3AA, 0x3A6,
    /*   10C ~   39C */
    0x3A2, 0x39E, 0x39A, 0x396, 0x391, 0x38C, 0x387, 0x383, 0x37D, 0x378,
    /*   20C ~   49C */
    0x373, 0x36D, 0x367, 0x362, 0x35C, 0x355, 0x34F, 0x349, 0x342, 0x33B,
    /*   30C ~   59C */
    0x334, 0x32D, 0x326, 0x31F, 0x317, 0x310, 0x308, 0x300, 0x2F8, 0x2F0,
    /*   40C ~   69C */
    0x2E8, 0x2E0, 0x2D7, 0x2CF, 0x2C6, 0x2BE, 0x2B5, 0x2AC, 0x2A3, 0x29A,
    /*   50C ~   79C */
    0x291, 0x288, 0x27F, 0x276, 0x26C, 0x263, 0x25A, 0x251, 0x247, 0x23E,
    /*   60C ~   89C */
    0x235, 0x22C, 0x222, 0x219, 0x210, 0x207, 0x1FE, 0x1F5, 0x1EC, 0x1E3,
    /*   70C ~   99C */
    0x1DA, 0x1D1, 0x1C8, 0x1BF, 0x1B7, 0x1AE, 0x1A6, 0x19D, 0x195, 0x18D,
    /*   80C ~  109C */
    0x185, 0x17D, 0x175, 0x16D, 0x165, 0x15E, 0x156, 0x14F, 0x148, 0x141,
    /*   90C ~  119C */
    0x13A, 0x133, 0x12C, 0x125, 0x11F, 0x119, 0x112, 0x10C, 0x106, 0x100,
    /*  100C ~  120C */
    0x0FA, 0x0F4, 0x0EF, 0x0E9, 0x0E4, 0x0DF, 0x0DA, 0x0D5, 0x0D0, 0x0CC,
    /*  110C ~  120C */
    0x0C7, 0x0C3, 0x0BF, 0x0BA, 0x0B6, 0x0B2, 0x0AE, 0x0AB, 0x0A7, 0x0A3,
    /*  120C ~  120C */
    0x0A0
};

/* ==================== 模块全局变量 ==================== */

int8_t  g_temperature = 0;      /* 当前水箱温度 (单位:℃) */
uint16_t g_input_vol = 0;       /* 当前光伏输入电压 (单位:V) */
uint8_t  g_master_cmd = 1;      /* 主机命令: 0=停止加热, 1=启动加热 (默认=1, 上电无主机命令时自动启动加热) */
HeaterState_t g_state = {.bits.dc_heating = 1};    /* 当前设备状态 (用于上报主机) */
uint32_t g_energy_Ws = 0;     /* 累计用电量(单位:瓦秒), 仅增不减, 掉电清零 */

/* 电压阈值直接使用头文件中的宏定义 VOL_START_72V / VOL_THRES_72V / VOL_THRES_HIGH_72V,
 * 不再用静态变量, 节省STM8S003宝贵的RAM空间 */


static uint8_t s_abnormal_flag = 0;   /* 继电器控制异常标志 (3次重试均失败) */
static uint16_t s_normal_cnt = 0;     /* 异常恢复倒计时计数器 */

/* ==================== 内部函数声明 ==================== */

static void adc_read_channel(uint16_t *value, ADC1_Channel_TypeDef channel, uint8_t samples);
static void led_on(void);
static void led_off(void);
static void led_toggle(void);

/* ==================== ADC初始化与采样 ========================= */

/*
 * heater_ctrl_init - ADC外设初始化
 * 配置ADC1为单次转换模式, 右对齐, 用于温度和电压采集
ADC1_SCHMITTTRIG_ALL, DISABLE 会禁用所有ADC通道的施密特触发器，包括：

AIN5 = PD5 = UART1_TX
AIN6 = PD6 = UART1_RX
禁用PD6的施密特触发器 = 断开PD6的数字输入缓冲器 = UART1再也无法识别RX引脚上的电平变化 → 中断只触发一次后就不再触发了！

禁用串口的施密特触发器之后，串口就获取不到0和1了也就读取不到数据了
 */
void heater_ctrl_init(void)
{
    ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,
              ADC1_CHANNEL_3,
              ADC1_PRESSEL_FCPU_D10,
              ADC1_EXTTRIG_TIM,
              DISABLE,
              ADC1_ALIGN_RIGHT,
              (ADC1_SchmittTrigg_TypeDef)(ADC1_SCHMITTTRIG_CHANNEL3 | ADC1_SCHMITTTRIG_CHANNEL4),
              DISABLE);
    ADC1_Cmd(ENABLE);
}

/*
 * adc_read_channel - 读取指定ADC通道, 多次采样取平均值
 * @param value    输出平均ADC值
 * @param channel  ADC通道号 (AIN3=电压, AIN4=温度)
 * @param samples  采样次数 (通常为5)
 *
 * 采样流程: 切换通道 → 启动转换 → 等待EOC → 读取结果 → 累加 → 取平均
 */
static void adc_read_channel(uint16_t *value, ADC1_Channel_TypeDef channel, uint8_t samples)
{
    uint16_t sum = 0, i;
    ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, channel, ADC1_ALIGN_RIGHT);
    
    /* 空转换：让采样保持电容建立到新通道电压 */
    ADC1_Cmd(ENABLE);
    while (ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
    ADC1_ClearFlag(ADC1_FLAG_EOC);
    (void)ADC1_GetConversionValue();
    
    for (i = 0; i < samples; i++)
    {
        ADC1_Cmd(ENABLE);
        while (ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
        ADC1_ClearFlag(ADC1_FLAG_EOC);
        sum += (uint16_t)ADC1_GetConversionValue();
    }
    *value = sum / samples;
}

/* ==================== LED状态指示 ========================= */
/* LED(OUT1) 用于指示当前加热状态:
 *   亮 = 正在加热
 *   灭 = 停止加热
 *   闪烁 = 继电器控制异常
 * 注意: 电源反接时不控制LED (由反接保护电路处理)
 */
static void led_on(void)  { BOARD_OUT1_ON(); }
static void led_off(void) { BOARD_OUT1_OFF(); }
static void led_toggle(void) { BOARD_OUT1_REV(); }

/* ==================== 继电器状态 / 电源检测 ========================= */

/*
 * heater_get_relay_state - 读取继电器当前物理状态
 * 返回值: RELAY_STATE_CLOSE(0) = 继电器闭合, 加热管通电加热
 *         RELAY_STATE_DISCONNECT(1) = 继电器断开, 加热管断电
 * 检测方式: 通过数字输入引脚(INPUT1)读取, 低电平=闭合
 */
uint8_t heater_get_relay_state(void)
{
    return (board_input1_read() == 0) ? RELAY_STATE_CLOSE : RELAY_STATE_DISCONNECT;
}

/*
 * heater_is_power_reverse - 检测光伏电源是否反接
 * 返回值: 0=正常, 1=反接
 * 检测方式: 通过数字输入引脚(INPUT2)读取
 */
uint8_t heater_is_power_reverse(void)
{
    return board_input2_read();
}

/* ==================== 温度采集 ========================= */

/*
 * heater_get_temperature - 获取水箱温度
 *
 * 处理流程:
 *   1. ADC采样AIN4通道 (NTC热敏电阻)
 *   2. 传感器异常检测:
 *      - ADC值 < TempTable[140] → 温度过高(可能短路), 返回120℃
 *      - ADC值 > TempTable[0]  → 温度过低(可能断路), 返回-20℃
 *      - 需连续TEMP_ERR_RETRY_CNT次才确认, 防止误判
 *   3. 二分查找TempTable, 确定当前温度区间
 *   4. 温度计算: 实际温度 = 索引 × 4 - 20
 *   5. 软件滤波: 当前值与上次值取平均, 每3次采样更新一次输出
 *
 * @return 当前温度值 (单位:℃), 范围-20~120
 */
int8_t heater_get_temperature(void)
{
    int16_t i, high, low;
    uint16_t adc_value;

    /* 第1步: ADC采样 */
    adc_read_channel(&adc_value, ADC1_CHANNEL_4, ADC_SAMPLE_NUMS);

    /* 传感器短路检测 (ADC值低于最低温度点 → 温度超过120℃) */
    if (adc_value < TempTable[140]) { g_temperature = 120; return g_temperature; }

    /* 传感器断路检测 (ADC值高于最高温度点 → 温度低于-20℃) */
    if (adc_value > TempTable[0]) { g_temperature = -20; return g_temperature; }

    /* 第3步: 二分查找确定温度索引 (36项, 4°C步长) */
    i = 70;    /* 起始猜测点: 18×4-20=52℃ */
    high = 140;  /* 搜索上界 */
    low  = 0;   /* 搜索下界 */
    while (high > (low + 2))
    {
        if (adc_value < TempTable[i]) { low = i; }   /* ADC值小 → 温度高 → 查高温区 */
        else if (adc_value == TempTable[i]) { break; } /* 精确匹配 */
        else { high = i; }                             /* ADC值大 → 温度低 → 查低温区 */
        i = (high + low) / 2;
    }

    /* 第4步: 索引转实际温度 (4°C步长查表, 精度±2°C满足热水器需求) */
    g_temperature = (int8_t)(i - 20);

    return g_temperature;
}

/* ==================== 电压采集 ========================= */

/*
 * heater_get_input_vol - 获取光伏板输入电压
 *
 * 硬件: 200K+10K电阻分压 → ADC采样 → 软件换算
 * 换算公式: V输入 = ADC值 × 5 × 21 / 1024 = ADC值 × 105 / 1024
 *   5    = ADC参考电压(V)
 *   21   = 分压系数 (上200K + 下10K, (200+10)/10 = 21)
 *   1024 = 10位ADC满量程
 * 应该把分压电阻修改为300K+10K, 分压系数变为31
 * 注意: 必须先乘后除! 若先做 (ADC值>>10) 再相乘, 由于ADC值∈[0,1023],
 *       ADC值/1024 会被整除截断为0, 导致结果恒为0。
 *
 * 同时更新 g_state.bits.power_reverse 电源反接状态
 *
 * @return 输入电压值 (单位:V), 8位无符号
 */
uint8_t heater_get_input_vol(void)
{
    uint32_t cal;
    uint16_t adc_value;
    adc_read_channel(&adc_value, ADC1_CHANNEL_3, ADC_SAMPLE_NUMS);
    cal = adc_value;
    cal = cal * 5;             /* 先乘ADC参考电压5V */
    cal = cal * 21;            /* 再乘分压系数 (200K+10K, 比=21) */
    cal = cal >> 10;           /* 最后除以1024(10位ADC满量程); 若先除会被整除为0! */
    g_input_vol = (uint16_t)cal;
    g_state.bits.power_reverse = heater_is_power_reverse() ? 1 : 0;
    return (uint8_t)g_input_vol;
}

/* ==================== 继电器控制 ========================= */

/*
 * heater_open - 启动加热 (闭合继电器)
 *
 * 安全机制:
 *   1. 温度 < -10℃ (传感器异常) 或 温度 ≥ 75℃ → 拒绝启动, 返回成功(不加热)
 *
 * 控制时序 (磁保持继电器 + MOS管):
 *   ┌──────────────────────────────────────────────────┐
 *   │ 1. 检查是否已经闭合 → 已闭合则直接返回成功       │
 *   │ 2. OUT2=ON  → 闭合MOS管, 短接继电器两端(降火花) │
 *   │ 3. 延时MOS_PRE_DELAY_MS等待MOS完全导通            │
 *   │ 4. 轮询等待继电器反馈(最长50×10ms=500ms)          │
 *   │ 5. OUT3=OFF → 触发继电器闭合脉冲                  │
 *   │ 6. 延时RELAY_ACTION_DELAY_MS等待继电器动作        │
 *   │ 7. 延时400ms等待状态稳定                           │
 *   │ 8. 验证继电器是否确实闭合 → 更新LED和状态         │
 *   └──────────────────────────────────────────────────┘
 *
 * @return 1=成功, 0=失败
 */
uint8_t heater_open(void)
{
    uint8_t retry;

    /* 安全检查: 温度异常时拒绝启动加热 */
    if ((g_temperature < -10) || (g_temperature > TEMP_HIGH_THRESHOLD)) { return 1; }

    /* 如果继电器已处于闭合状态, 无需操作 */
    if (heater_get_relay_state() == RELAY_STATE_CLOSE)
    {
        if (!heater_is_power_reverse()) { led_on(); }
        return 1;
    }

    /* 步骤2: 先闭合MOS管, 短接继电器两端, 降低继电器吸合时的电弧 */
    BOARD_OUT2_ON();     /* OUT2 → MOS管栅极, 高电平导通 */
    ek_delay(MOS_PRE_DELAY_MS);  /* 等待MOS管完全导通 */

    /* 步骤3: 等待MOS管导通后电流稳定, 继电器两端电压降低 */
    retry = 50;
    while (--retry)
    {
        if (heater_get_relay_state() == RELAY_STATE_CLOSE) { break; }
        ek_delay(10);
    }

    /* 步骤4: 触发继电器闭合 (磁保持继电器需要脉冲驱动) */
    BOARD_OUT3_OFF();    /* OUT3 → 继电器闭合线圈, 低电平触发 */
    ek_delay(RELAY_ACTION_DELAY_MS);
    ek_delay(400);

    /* 步骤5: 验证继电器是否成功闭合 */
    if (heater_get_relay_state() == RELAY_STATE_CLOSE)
    {
        if (!heater_is_power_reverse()) { led_on(); }
        g_state.bits.dc_heating = 1;
        return 1;
    }
    g_state.bits.dc_heating = 0;
    return 0;
}

/*
 * heater_close - 停止加热 (断开继电器)
 *
 * 控制时序:
 *   ┌──────────────────────────────────────────────────┐
 *   │ 1. 检查是否已经断开 → 已断开则直接返回成功       │
 *   │ 2. OUT2=ON  → 闭合MOS管, 短接继电器两端(降火花) │
 *   │ 3. 延时MOS_PRE_DELAY_MS等待MOS完全导通            │
 *   │ 4. 轮询等待电流稳定(最长50×10ms=500ms)            │
 *   │ 5. OUT3=ON  → 触发继电器断开脉冲                  │
 *   │ 6. 延时RELAY_ACTION_DELAY_MS等待继电器动作        │
 *   │ 7. OUT2=OFF → 断开MOS管                          │
 *   │ 8. OUT3=OFF → 释放继电器驱动                      │
 *   │ 9. 延时400ms → 验证断开状态                      │
 *   └──────────────────────────────────────────────────┘
 *
 * 与heater_open的区别:
 *   - open时OUT3=OFF(低电平触发闭合线圈)
 *   - close时OUT3=ON(高电平触发断开线圈)
 *   - close后需要断开MOS管(OUT2=OFF), open时MOS保持导通
 *
 * @return 1=成功, 0=失败
 */
uint8_t heater_close(void)
{
    uint8_t retry;

    /* 如果继电器已处于断开状态, 无需操作 */
    if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
    {
        if (!heater_is_power_reverse()) { led_off(); }
        g_state.bits.dc_heating = 0;
        return 1;
    }

    /* 步骤1: 先闭合MOS管, 短接继电器两端, 降低继电器断开时的电弧 */
    BOARD_OUT2_ON();
    ek_delay(MOS_PRE_DELAY_MS);

    /* 步骤2: 等待MOS管导通后电流稳定 */
    retry = 50;
    while (--retry)
    {
        if (heater_get_relay_state() == RELAY_STATE_CLOSE) { break; }
        ek_delay(10);
    }

    /* 步骤3: 触发继电器断开 */
    BOARD_OUT3_ON();     /* OUT3 → 继电器断开线圈, 高电平触发 */
    ek_delay(RELAY_ACTION_DELAY_MS);
    BOARD_OUT2_OFF();    /* 断开MOS管 */
    ek_delay(400);

    /* 步骤4: 验证继电器是否成功断开 */
    if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
    {
        if (!heater_is_power_reverse()) { led_off(); }
        g_state.bits.dc_heating = 0;
        return 1;
    }
    return 0;
}

/* ==================== 秒级延时 ========================= */

/*
 * heater_delay_seconds - 带安全监测的秒级延时
 *
 * 与普通延时的区别: 延时期间持续监测温度和电压
 * 如果温度异常(<-10℃ 或 ≥75℃)则立即关闭加热并返回
 * 这保证了在长时间等待过程中不会出现失控加热
 *
 * @param sec 延时秒数
 */
void heater_delay_seconds(uint16_t sec)
{
    if (sec == 0) return;
    while (sec--)
    {
        heater_get_input_vol();     /* 更新电压 */
        heater_get_temperature();   /* 更新温度 */
        ek_delay(1000);             /* 等待1秒 */
        /* 安全保护: 温度异常立即关闭加热 */
        if ((g_temperature < -10) || (g_temperature >= TEMP_HIGH_THRESHOLD)) { heater_close(); }
    }
}

/* ==================== 用电量计量 ========================= */

/*
 * heater_energy_accumulate - 每秒累加一次用电量 (在 TIM4 秒中断 ek_soft_timer 中调用)
 *
 * 原理: 数值积分(分段累加)。每秒用当前光伏电压计算瞬时功率 P=U?/R,
 *       累加到 g_energy_Ws(瓦秒)。因为每秒都用当时的真实电压,
 *       所以加热时间越长, 采样点越多但每个点都准, 总误差不随时间发散。
 *
 * 纯整数运算(无浮点):
 *   P(W) = U?/14.06 = U?×100/1406  (R=14.06Ω 用 1406 厘欧表示)
 *   例如 U=72V → 72?×100/1406 = 518400/1406 ≈ 368W
 *
 * 精度: 整数除法每秒截断误差 <1W, 一天(86400s)累积 <24Wh,
 *       相对每天1~3kWh耗电, 误差 <1%, 远优于 ±5% 要求。
 */
void heater_energy_accumulate(void)
{
    if (g_state.bits.dc_heating)          /* 仅在直流加热激活时累计 */
    {
        uint16_t u = g_input_vol;         /* 当前光伏电压(V) */
        uint32_t p = (uint32_t)u * u * 100U / HEATER_RESISTANCE_CENTI;  /* 当前功率(W) */
        g_energy_Ws += p;                 /* 累加瓦秒 */
    }
}

/*
 * heater_get_energy_wh - 获取累计用电量
 * @return 累计用电量(Wh) = 瓦秒总数 / 3600
 */
uint32_t heater_get_energy_wh(void)
{
    return g_energy_Ws / 3600U;
}

/* ==================== 加热控制主处理 ==================== */

/*
 * heater_process - 加热控制主逻辑 (在main的while(1)中循环调用)
 *
 * 完整决策流程:
 *
 *   ┌─────────────────────────────────────────────────┐
 *   │ 第1步: 数据采集                                  │
 *   │   采集当前温度 → g_temperature                   │
 *   │   采集当前电压 → g_input_vol                     │
 *   │   更新LED指示灯 (正常时: 闭合=亮, 断开=灭)       │
 *   ├─────────────────────────────────────────────────┤
 *   │ 第2步: 最高优先级 - 安全保护                     │
 *   │   温度 ≥ 75℃ 或 温度 < -10℃(传感器故障)?        │
 *   │   ├── 是 → 强制关闭加热(最多重试3次)             │
 *   │   │        清除主机命令 g_master_cmd=0           │
 *   │   │        直接return (不再执行后续逻辑)         │
 *   │   └── 否 → 继续                                 │
 *   ├─────────────────────────────────────────────────┤
 *   │ 第3步: 异常恢复处理                              │
 *   │   s_abnormal_flag==1? (之前3次重试都失败)        │
 *   │   ├── 是 → LED闪烁 + 延时500ms                  │
 *   │   │        累计60次(约30秒)后清除异常标志        │
 *   │   │        直接return                            │
 *   │   └── 否 → 继续                                 │
 *   ├─────────────────────────────────────────────────┤
 *   │ 第4步: 低压自主控制                              │
 *   │   电压 < VOL_THRES (载波通信无法工作)?           │
 *   │   ├── 是 → 二次确认(5秒后再测)                   │
 *   │   │   ├── 仍低 → 进入低压循环:                   │
 *   │   │   │   继电器断开+电压>VolStart+温度安全?     │
 *   │   │   │   └── 自主启动加热(最多重试3次)          │
 *   │   │   │   电压恢复到VolThresHigh? → 退出循环     │
 *   │   │   └── 已恢复 → return                       │
 *   │   └── 否 → 继续                                 │
 *   ├─────────────────────────────────────────────────┤
 *   │ 第5步: 执行主机命令 (电压已足够, 无需再检查)     │
 *   │   g_master_cmd==1 (启动加热)?                    │
 *   │   ├── 是 → 继电器当前断开?                       │
 *   │   │        └── 启动加热(最多重试3次)             │
 *   │   │            失败3次 → 置异常标志              │
 *   │   └── 否 (g_master_cmd==0, 停止加热)            │
 *   │            继电器当前闭合?                        │
 *   │            └── 关闭加热(最多重试3次)             │
 *   │                失败3次 → 置异常标志              │
 *   └─────────────────────────────────────────────────┘
 *
 * 重试机制说明:
 *   每次OpenHeater/CloseHeater失败后, 等待120秒再重试
 *   最多重试HEATER_RETRY_MAX(3)次
 *   3次都失败则进入异常状态(s_abnormal_flag=1)
 *   异常状态下LED每500ms闪烁一次, 持续30秒后自动恢复
 */
void heater_process(void)
{
    uint8_t i;

    /* ====== 第1步: 数据采集 ====== */
    heater_get_temperature();
    heater_get_input_vol();

    /* 更新LED指示 (电源正常时根据继电器状态控制LED) */
    if (!heater_is_power_reverse())
    {
        if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
        { 
          led_off(); 
        }
        else 
        { 
          led_on(); 
        }
    }

    /* ====== 第2步: 安全保护 (最高优先级) ====== */
    /* 温度≥75℃ 或 传感器异常(<-10℃) → 必须停止加热 */
    if ((g_temperature >= TEMP_HIGH_THRESHOLD) || (g_temperature < -10))
    {
        g_state.bits.dry_burn_err = 1;
        if (heater_get_relay_state() == RELAY_STATE_CLOSE)
        {
            heater_delay_seconds(15);  /* 延时15秒再关 (防止温度波动导致频繁开关) */
            for (i = 0; i < HEATER_RETRY_MAX; i++)
            {
                if (heater_close() == 1) 
                {
                  g_state.bits.relay_err = 0;
                  break;       /* 关闭成功 */
                }
                g_state.bits.relay_err = 1;
                heater_delay_seconds(120);             /* 失败后等2分钟再试 */
            }
        }
        g_master_cmd = 0;  /* 清除主机命令, 强制停止 */
        return;            /* 安全保护后直接返回, 不执行正常控制 */
    }
    else
    {
      g_state.bits.dry_burn_err = 0;
    }

    /* ====== 第3步: 异常恢复处理，闪灯30s ====== */
    if (s_abnormal_flag)
    {
        ek_delay(250);    /* 500ms延时, LED闪烁频率约1Hz */
        led_toggle();     /* LED翻转 */
        ek_delay(250);    /* 500ms延时, LED闪烁频率约1Hz */
        s_normal_cnt++;
        if (s_normal_cnt >= 60)  /* 60次 × 500ms = 30秒后恢复 */
        {
            s_normal_cnt = 0;
            s_abnormal_flag = 0;  /* 清除异常标志, 重新进入正常控制 */
            g_state.bits.relay_err = 0;
        }
        return;
    }

    /* ====== 第4步: 低压自主控制 ====== */
    /* 参考老工程师逻辑: 当光伏电压低于VOL_THRES_72V时, 载波通信模块无法工作,
     * 无法接收主机命令, 此时从机需要自主判断是否启动加热:
     *   - 电压已足够低(VOL_THRES)且二次确认仍低 → 进入低压模式
     *   - 低压模式下: 继电器断开 + 电压>VolStart + 温度安全 → 自主启动加热
     *   - 低压模式下持续循环, 直到电压恢复到VOL_THRES_HIGH以上才退出
     *   - 退出低压模式后回到正常控制流程(return, 下次循环由主机命令控制)
     */
    if (g_input_vol < VOL_THRES_72V)
    {
        /* 第一次检测到电压过低, 等待5秒后二次确认, 防止电压瞬时波动 */
        heater_delay_seconds(5);
        heater_get_input_vol();
        if (g_input_vol >= VOL_THRES_72V)
        {
            return;  /* 电压已恢复, 回到正常控制, 下次循环再处理 */
        }

        /* 二次确认电压确实过低, 进入低压自主控制循环 */
        do {
            /* 如果继电器当前断开, 且电压>VolStart 且 温度安全, 则自主启动加热 */
            if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
            {//如果电压小于17V，小板直接无法启动，继电器恢复常闭状态，直接启动加热
                if (g_temperature < TEMP_HIGH_THRESHOLD)
                {
                    for (i = 0; i < HEATER_RETRY_MAX; i++)
                    {
                        if (heater_open() == 1) { break; }
                        heater_delay_seconds(120);
                    }
                    s_abnormal_flag = (i == HEATER_RETRY_MAX) ? 1 : 0;
                }
            }

            /* 更新电压, 判断是否可以退出低压模式 */
            heater_get_input_vol();
            if (g_input_vol < VOL_THRES_HIGH_72V)
            {
                /* 电压仍然过低, 等待1分钟后再次检测 */
                heater_delay_seconds(60);
                heater_get_input_vol();
                if (g_input_vol < VOL_THRES_HIGH_72V)
                {
                    continue;  /* 电压仍然不足, 继续低压模式循环 */
                }
                else
                {
                    break;     /* 电压恢复到VolThresHigh以上, 退出低压模式 */
                }
            }
            else
            {
                break;         /* 电压已恢复到VolThresHigh以上, 退出低压模式 */
            }
        } while (1);

        return;  /* 退出低压模式后返回, 下次循环进入正常主机命令控制 */
    }

    /* ====== 第5步: 执行主机命令 ====== */
    /* 注意: 能执行到这里说明电压 >= VOL_THRES_72V(23V) >= VOL_START_72V(30V),
     *       无需再次检查光伏电压是否足够 (参考老工程师逻辑) */
    if (g_master_cmd == 1)
    {
        /* 主机命令=启动加热 */
        if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
        {
            /* 继电器当前断开, 尝试启动加热 */
            for (i = 0; i < HEATER_RETRY_MAX; i++)
            {
                if (heater_open() == 1)
                {
                    g_state.bits.relay_err = 0;
                    break;     /* 启动成功 */
                }
                g_state.bits.relay_err = 1;
                heater_delay_seconds(120);          /* 失败后等2分钟再试 */
            }
            /* 3次都失败 → 进入异常状态 */
            s_abnormal_flag = (i == HEATER_RETRY_MAX) ? 1 : 0;
        }
    }
    else
    {
        /* 主机命令=停止加热 */
        if (heater_get_relay_state() == RELAY_STATE_CLOSE)
        {
            /* 继电器当前闭合, 尝试关闭加热 */
            for (i = 0; i < HEATER_RETRY_MAX; i++)
            {
                if (heater_close() == 1) 
                {
                  g_state.bits.relay_err = 0;
                  break;        /* 关闭成功 */
                }
                g_state.bits.relay_err = 1;
                heater_delay_seconds(120);              /* 失败后等2分钟再试 */
            }
            /* 3次都失败 → 进入异常状态 */
            s_abnormal_flag = (i == HEATER_RETRY_MAX) ? 1 : 0;
        }
    }
}

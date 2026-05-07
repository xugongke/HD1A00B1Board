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
 *   │ 5. 主机命令=启动加热?           │──→ 检查电压→启动加热(最多重试3次)
 *   │ 6. 主机命令=停止加热?           │──→ 关闭加热(最多重试3次)
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
 * 4°C步长, 索引0=-20℃, 索引35=120℃, 共36个表项
 * 温度计算: 实际温度 = 索引 × 4 - 20
 *
 * 查找算法: 二分查找, 在TempTable中找到ADC值对应的索引位置
 *
 * 为什么用4°C步长而不是1°C:
 *   - 老工程用1°C步长需要141个表项(占用282字节Flash)
 *   - 4°C步长只需36个表项(72字节), 节省210字节
 *   - 配合软件滤波, 实际控制精度±2~3℃, 满足热水器10℃控制带需求
 *   - STM8S003只有8KB Flash, 每一字节都很宝贵
 */
static const uint16_t TempTable[36] = {
    /* 索引 0~9:  -20℃ ~ 16℃ (低温段, ADC值较大, NTC电阻高) */
    0x3EB, 0x3E6, 0x3E0, 0x3D8, 0x3CF, 0x3C5, 0x3B8, 0x3AA, 0x39A, 0x387,
    /* 索引 10~19: 20℃ ~ 56℃ (常温段) */
    0x373, 0x35C, 0x342, 0x326, 0x308, 0x2E8, 0x2C6, 0x2A3, 0x27F, 0x25A,
    /* 索引 20~29: 60℃ ~ 96℃ (高温段) */
    0x235, 0x210, 0x1EC, 0x1C8, 0x1A6, 0x185, 0x165, 0x148, 0x12C, 0x112,
    /* 索引 30~35: 100℃ ~ 120℃ (超高温段, ADC值小, NTC电阻低) */
    0x0FA, 0x0E4, 0x0D0, 0x0BF, 0x0AE, 0x0A0
};

/* ==================== 模块全局变量 ==================== */

int8_t  g_temperature = 0;      /* 当前水箱温度 (单位:℃) */
uint16_t g_input_vol = 0;       /* 当前光伏输入电压 (单位:V) */
uint8_t  g_master_cmd = 0;      /* 主机命令: 0=停止加热, 1=启动加热 */
HeaterState_t g_state = {0};    /* 当前设备状态 (用于上报主机) */

static uint16_t s_vol_start = VOL_START_72V;  /* 启动加热的最低电压阈值 */

static int8_t  s_temp_last = 0;       /* 上一次温度采样值 (用于滤波) */
static uint8_t s_temp_filter_cnt = 0; /* 温度滤波计数器 */

static uint8_t s_over_err_cnt = 0;    /* 传感器异常连续检测计数 */
static uint8_t s_err_over_cycle = 0;  /* 传感器异常确认周期数 */
#define TEMP_ERR_RETRY_CNT  1          /* 连续异常多少次后确认 (防抖) */

static uint8_t s_abnormal_flag = 0;   /* 继电器控制异常标志 (3次重试均失败) */
static uint16_t s_normal_cnt = 0;     /* 异常恢复倒计时计数器 */

/* ==================== 内部函数声明 ==================== */

static void adc_read_channel(uint16_t *value, ADC1_Channel_TypeDef channel, uint16_t samples);
static void led_on(void);
static void led_off(void);
static void led_toggle(void);

/* ==================== ADC初始化与采样 ========================= */

/*
 * heater_ctrl_init - ADC外设初始化
 * 配置ADC1为单次转换模式, 右对齐, 用于温度和电压采集
 */
void heater_ctrl_init(void)
{
    ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,
              ADC1_CHANNEL_3,
              ADC1_PRESSEL_FCPU_D10,
              ADC1_EXTTRIG_TIM,
              DISABLE,
              ADC1_ALIGN_RIGHT,
              ADC1_SCHMITTTRIG_ALL,
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
static void adc_read_channel(uint16_t *value, ADC1_Channel_TypeDef channel, uint16_t samples)
{
    uint32_t sum = 0;
    uint16_t i, count;
    ADC1_ConversionConfig(ADC1_CONVERSIONMODE_SINGLE, channel, ADC1_ALIGN_RIGHT);
    for (i = 0; i < samples; i++)
    {
        ADC1_Cmd(ENABLE);
        while (ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
        ADC1_ClearFlag(ADC1_FLAG_EOC);
        count = ADC1_GetConversionValue();
        sum += count;
    }
    *value = (uint16_t)(sum / samples);
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
static void led_toggle(void) { BOARD_OUT1_PORT->ODR ^= BOARD_OUT1_PIN; }

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
 *      - ADC值 < TempTable[35] → 温度过高(可能短路), 返回120℃
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

    /* 第2步: 传感器短路检测 (ADC值低于最低温度点 → 温度超过120℃) */
    if (adc_value < TempTable[35])
    {
        s_over_err_cnt++;
        if (s_over_err_cnt > TEMP_ERR_RETRY_CNT) { s_over_err_cnt = 0; s_err_over_cycle++; }
        if (s_err_over_cycle > 1) { g_temperature = 120; }
        return g_temperature;
    }

    /* 传感器断路检测 (ADC值高于最高温度点 → 温度低于-20℃) */
    if (adc_value > TempTable[0])
    {
        s_over_err_cnt++;
        if (s_over_err_cnt > TEMP_ERR_RETRY_CNT) { s_err_over_cycle++; s_over_err_cnt = 0; }
        if (s_err_over_cycle > 1) { g_temperature = -20; }
        return g_temperature;
    }

    /* 传感器正常, 清除异常计数 */
    s_over_err_cnt = 0;
    s_err_over_cycle = 0;

    /* 第3步: 二分查找确定温度索引 */
    i = 18;    /* 起始猜测点: 18×4-20=52℃ (热水器典型工作温度) */
    high = 35;  /* 搜索上界 */
    low  = 0;   /* 搜索下界 */
    while (high > (low + 2))
    {
        if (adc_value < TempTable[i]) { low = i; }   /* ADC值小 → 温度高 → 查高温区 */
        else if (adc_value == TempTable[i]) { break; } /* 精确匹配 */
        else { high = i; }                             /* ADC值大 → 温度低 → 查低温区 */
        i = (high + low) / 2;
    }

    /* 第4步: 索引转实际温度 */
    i = i * 4 - 20;  /* 温度 = 索引×4 - 20 */

    /* 第5步: 首次采样直接使用, 后续采样进行滤波 */
    if (s_temp_last == 0) { s_temp_last = i; g_temperature = i; }

    s_temp_filter_cnt++;
    i = (i + s_temp_last) / 2;   /* 当前采样与上次取平均, 平滑突变 */
    if (s_temp_filter_cnt > 2)
    {
        g_temperature = i;        /* 每3次采样更新一次输出温度 */
        s_temp_filter_cnt = 0;
    }
    else
    {
        s_temp_last = i;          /* 中间值存入last, 下次继续平均 */
    }

    return g_temperature;
}

/* ==================== 电压采集 ========================= */

/*
 * heater_get_input_vol - 获取光伏板输入电压
 *
 * 硬件: 200K+10K电阻分压 → ADC采样 → 软件换算
 * 公式: V输入 = ADC值 × 105 / 1024
 *       (105 = 5V × 21K / 10K / 1024 的简化系数)
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
    cal = 105 * cal;     /* 乘以分压系数 */
    cal = cal >> 10;     /* 除以1024 */
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
    retry = 0;
    while (retry < 50)
    {
        if (heater_get_relay_state() == RELAY_STATE_CLOSE) { break; }
        retry++;
        ek_delay(10);
    }

    /* 步骤4: 触发继电器闭合 (磁保持继电器需要脉冲驱动) */
    BOARD_OUT3_OFF();    /* OUT3 → 继电器闭合线圈, 低电平触发 */
    ek_delay(RELAY_ACTION_DELAY_MS);  /* 等待继电器机械动作完成 */
    BOARD_OUT3_OFF();    /* 保持关闭状态 */
    ek_delay(400);       /* 等待状态稳定 */

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
    retry = 0;
    while (retry < 50)
    {
        if (heater_get_relay_state() == RELAY_STATE_CLOSE) { break; }
        retry++;
        ek_delay(10);
    }

    /* 步骤3: 触发继电器断开 */
    BOARD_OUT3_ON();     /* OUT3 → 继电器断开线圈, 高电平触发 */
    ek_delay(RELAY_ACTION_DELAY_MS);
    BOARD_OUT2_OFF();    /* 断开MOS管 */
    ek_delay(10);
    BOARD_OUT3_OFF();    /* 释放继电器驱动 */
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
        heater_get_temperature();   /* 再次采样温度(提高可靠性) */
        /* 安全保护: 温度异常立即关闭加热 */
        if ((g_temperature < -10) || (g_temperature >= TEMP_HIGH_THRESHOLD)) { heater_close(); }
    }
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
 *   │ 第4步: 执行主机命令                              │
 *   │   g_master_cmd==1 (启动加热)?                    │
 *   │   ├── 是 → 电压 ≥ 启动阈值?                     │
 *   │   │        ├── 是 → 继电器当前断开?              │
 *   │   │        │        └── 启动加热(最多重试3次)    │
 *   │   │        │            失败3次 → 置异常标志     │
 *   │   │        └── 否 → 不操作(电压不足)             │
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
        if (heater_get_relay_state() == RELAY_STATE_DISCONNECT) { led_off(); }
        else { led_on(); }
    }

    /* ====== 第2步: 安全保护 (最高优先级) ====== */
    /* 温度≥75℃ 或 传感器异常(<-10℃) → 必须停止加热 */
    if ((g_temperature >= TEMP_HIGH_THRESHOLD) || (g_temperature < -10))
    {
        if (heater_get_relay_state() == RELAY_STATE_CLOSE)
        {
            heater_delay_seconds(15);  /* 延时15秒再关 (防止温度波动导致频繁开关) */
            for (i = 0; i < HEATER_RETRY_MAX; i++)
            {
                if (heater_close() == 1) break;       /* 关闭成功 */
                heater_delay_seconds(120);             /* 失败后等2分钟再试 */
            }
        }
        g_master_cmd = 0;  /* 清除主机命令, 强制停止 */
        return;            /* 安全保护后直接返回, 不执行正常控制 */
    }

    /* ====== 第3步: 异常恢复处理 ====== */
    if (s_abnormal_flag)
    {
        ek_delay(500);    /* 500ms延时, LED闪烁频率约1Hz */
        led_toggle();     /* LED翻转 */
        s_normal_cnt++;
        if (s_normal_cnt >= 60)  /* 60次 × 500ms = 30秒后恢复 */
        {
            s_normal_cnt = 0;
            s_abnormal_flag = 0;  /* 清除异常标志, 重新进入正常控制 */
        }
        return;
    }

    /* ====== 第4步: 执行主机命令 ====== */
    if (g_master_cmd == 1)
    {
        /* 主机命令=启动加热 */
        if (g_input_vol >= s_vol_start)  /* 检查光伏电压是否足够 */
        {
            if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
            {
                /* 继电器当前断开, 尝试启动加热 */
                for (i = 0; i < HEATER_RETRY_MAX; i++)
                {
                    if (heater_open() == 1) break;     /* 启动成功 */
                    heater_delay_seconds(120);          /* 失败后等2分钟再试 */
                }
                /* 3次都失败 → 进入异常状态 */
                s_abnormal_flag = (i == HEATER_RETRY_MAX) ? 1 : 0;
            }
        }
    }
    else
    {
        /* 主机命令=停止加热 (或无命令) */
        if (heater_get_relay_state() == RELAY_STATE_CLOSE)
        {
            /* 继电器当前闭合, 尝试关闭加热 */
            for (i = 0; i < HEATER_RETRY_MAX; i++)
            {
                if (heater_close() == 1) break;        /* 关闭成功 */
                heater_delay_seconds(120);              /* 失败后等2分钟再试 */
            }
            /* 3次都失败 → 进入异常状态 */
            s_abnormal_flag = (i == HEATER_RETRY_MAX) ? 1 : 0;
        }
    }
}

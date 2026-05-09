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

/* ==================== 非阻塞状态机 ====================
 *
 * 核心思想: 用状态机代替阻塞延时
 * 原来的问题: heater_delay_seconds(120) 会阻塞CPU 120秒
 *            期间 es1642_app_poll() 无法执行, 通信卡死
 * 解决方案: 每次调用 heater_process() 只做一小步就返回
 *          让出CPU给 es1642_app_poll() 执行通信
 *
 * 状态转移图:
 *   IDLE ──(温度≥75℃)──→ SAFETY_WAIT(15s) ──→ 执行close ──→ IDLE
 *   IDLE ──(主机命令)──→ 执行open/close ──(失败)──→ RETRY_WAIT(120s) ──→ 重试
 *   3次重试均失败 ──→ ABNORMAL(30s LED闪烁) ──→ IDLE
 *
 * 所有等待状态(SAFETY_WAIT/RETRY_WAIT/ABNORMAL)都是非阻塞的:
 *   - 每次调用立即返回, 不会卡住主循环
 *   - 等待期间每秒采样一次温度/电压(保持安全监测)
 *   - 主循环中 es1642_app_poll() 可正常执行
 */

typedef enum {
    FSM_IDLE = 0,          /* 正常监测: 采样传感器, 检查命令 */
    FSM_SAFETY_WAIT,       /* 温度异常, 等待15秒后关闭继电器 */
    FSM_RETRY_WAIT,        /* 继电器操作失败, 等待120秒重试 */
    FSM_ABNORMAL           /* 3次重试失败, LED闪烁30秒恢复 */
} HeaterFSM;

static HeaterFSM s_fsm = FSM_IDLE;
static uint32_t  s_wait_target = 0;    /* 等待结束的目标时刻 (tick) */
static uint32_t  s_last_sample = 0;    /* 上次传感器采样时刻 (tick) */
static uint8_t   s_retry_cnt = 0;      /* 重试计数器 0~HEATER_RETRY_MAX */
static uint8_t   s_retry_action = 0;   /* 重试动作: 0=close, 1=open */

/* ==================== 内部函数声明 ==================== */

static void adc_read_channel(uint16_t *value, ADC1_Channel_TypeDef channel, uint16_t samples);
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
uint8_t val;
uint8_t heater_get_relay_state(void)
{
    val = board_input1_read();
    return (val == 0) ? RELAY_STATE_CLOSE : RELAY_STATE_DISCONNECT;
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

    /* 第3步: 二分查找确定温度索引 (36项, 4°C步长) */
    i = 18;    /* 起始猜测点: 18×4-20=52℃ */
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

/* ==================== 非阻塞时间检查工具 ==================== */

/*
 * tick_elapsed - 检查从 start 时刻起是否已经过 ms 毫秒
 * 处理 uint32 溢出的情况 (约49天后溢出, 仍然正确)
 */
static uint8_t tick_elapsed(uint32_t start, uint32_t ms)
{
    return (uint8_t)((ek_get_tick() - start) >= ms);
}

/* ==================== 非阻塞加热控制主处理 ==================== */

/*
 * heater_process - 非阻塞状态机 (在main的while(1)中快速循环调用)
 *
 * 与旧版本的区别:
 *   旧版: heater_delay_seconds(120) 阻塞CPU 120秒, 通信卡死
 *   新版: 设置目标等待时间后立即返回, 下次进来检查时间到没到
 *         主循环中 es1642_app_poll() 可持续执行, 通信不中断
 *
 * 调用频率要求:
 *   主循环中需要足够快地调用此函数 (至少每100ms一次)
 *   继电器操作(heater_open/close)内部仍有~1秒的阻塞延时
 *   这是继电器机械动作所需的, 无法避免, 且1秒通信中断可接受
 *
 * 状态转移图:
 *
 *   ┌─────── IDLE ───────────────────────────────────────────────┐
 *   │ 每个周期: 采样传感器, 更新LED                                │
 *   │ 温度≥75℃ 或 <-10℃ 且 继电器闭合?                            │
 *   │   └──→ 设置等待15秒 → 进入 FSM_SAFETY_WAIT                  │
 *   │ 温度正常 且 主机命令=启动 且 电压够 且 继电器断开?            │
 *   │   └──→ 执行 heater_open()                                   │
 *   │       ├── 成功 → 回到 IDLE                                  │
 *   │       └── 失败 → 设置等待120秒 → 进入 FSM_RETRY_WAIT         │
 *   │ 温度正常 且 主机命令=停止 且 继电器闭合?                      │
 *   │   └──→ 执行 heater_close()                                  │
 *   │       ├── 成功 → 回到 IDLE                                  │
 *   │       └── 失败 → 设置等待120秒 → 进入 FSM_RETRY_WAIT         │
 *   └─────────────────────────────────────────────────────────────┘
 *
 *   ┌─────── FSM_SAFETY_WAIT ────────────────────────────────────┐
 *   │ 等待期间: 每秒采样一次温度/电压 (安全监测)                    │
 *   │ 15秒到期?                                                    │
 *   │   └──→ 执行 heater_close()                                  │
 *   │       ├── 成功 → 回到 IDLE                                  │
 *   │       └── 失败 → 重试计数++ → 等待120秒 → FSM_RETRY_WAIT    │
 *   └─────────────────────────────────────────────────────────────┘
 *
 *   ┌─────── FSM_RETRY_WAIT ─────────────────────────────────────┐
 *   │ 等待期间: 每秒采样一次温度/电压                              │
 *   │ 120秒到期?                                                   │
 *   │   └──→ 重试继电器操作                                       │
 *   │       ├── 成功 → 回到 IDLE                                  │
 *   │       └── 失败 → 重试计数++                                 │
 *   │           重试≥3次? → 进入 FSM_ABNORMAL                     │
 *   │           否则 → 再等120秒                                   │
 *   └─────────────────────────────────────────────────────────────┘
 *
 *   ┌─────── FSM_ABNORMAL ───────────────────────────────────────┐
 *   │ LED 每500ms闪烁一次                                         │
 *   │ 累计60次(30秒)后 → 回到 IDLE, 清除异常标志                  │
 *   └─────────────────────────────────────────────────────────────┘
 */
void heater_process(void)
{
    uint32_t now = ek_get_tick();

    switch (s_fsm)
    {
    /* ====== IDLE: 正常监测状态 ====== */
    case FSM_IDLE:
    {
        /* 采样传感器数据 */
        heater_get_temperature();
        heater_get_input_vol();

        /* 更新LED指示 */
        if (!heater_is_power_reverse())
        {
            if (heater_get_relay_state() == RELAY_STATE_DISCONNECT) { led_off(); }
            else { led_on(); }
        }

        /* 最高优先级: 安全保护 - 温度异常 */
        if ((g_temperature >= TEMP_HIGH_THRESHOLD) || (g_temperature < -10))
        {
            g_master_cmd = 0;  /* 清除主机命令 */
            if (heater_get_relay_state() == RELAY_STATE_CLOSE)
            {
                /* 继电器正在加热, 需要先等15秒再关 */
                s_wait_target = now + (15UL * 1000UL);
                s_last_sample = now;
                s_retry_cnt = 0;
                s_retry_action = 0;  /* close */
                s_fsm = FSM_SAFETY_WAIT;
            }
            return;
        }

        /* 执行主机命令 */
        if (g_master_cmd == 1)
        {
            /* 主机命令=启动加热 */
            if (g_input_vol >= s_vol_start)
            {
                if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
                {
                    if (heater_open() == 1)
                    {
                        /* 启动成功, 回到IDLE */
                    }
                    else
                    {
                        /* 启动失败, 进入重试等待 */
                        s_retry_cnt = 1;
                        s_retry_action = 1;  /* open */
                        s_wait_target = now + (120UL * 1000UL);
                        s_last_sample = now;
                        s_fsm = FSM_RETRY_WAIT;
                    }
                }
            }
        }
        else
        {
            /* 主机命令=停止加热 */
            if (heater_get_relay_state() == RELAY_STATE_CLOSE)
            {
                if (heater_close() == 1)
                {
                    /* 关闭成功, 回到IDLE */
                }
                else
                {
                    /* 关闭失败, 进入重试等待 */
                    s_retry_cnt = 1;
                    s_retry_action = 0;  /* close */
                    s_wait_target = now + (120UL * 1000UL);
                    s_last_sample = now;
                    s_fsm = FSM_RETRY_WAIT;
                }
            }
        }
        break;
    }

    /* ====== SAFETY_WAIT: 温度异常, 等待15秒后关闭 ====== */
    case FSM_SAFETY_WAIT:
    {
        /* 等待期间每秒采样一次传感器 (安全监测) */
        if (tick_elapsed(s_last_sample, 1000UL))
        {
            heater_get_temperature();
            heater_get_input_vol();
            s_last_sample = now;
            /* 极端情况: 温度继续升高中, 如果继电器已经断开则直接回IDLE */
            if (heater_get_relay_state() == RELAY_STATE_DISCONNECT)
            {
                s_fsm = FSM_IDLE;
                break;
            }
        }

        /* 等待15秒到期 */
        if (tick_elapsed(s_wait_target, 0UL) == 0) { break; }

        /* 15秒到, 执行关闭继电器 */
        if (heater_close() == 1)
        {
            /* 关闭成功 */
            s_fsm = FSM_IDLE;
        }
        else
        {
            /* 关闭失败, 进入重试等待 */
            s_retry_cnt++;
            s_retry_action = 0;  /* close */
            s_wait_target = now + (120UL * 1000UL);
            s_last_sample = now;
            if (s_retry_cnt >= HEATER_RETRY_MAX)
            {
                s_normal_cnt = 0;
                s_fsm = FSM_ABNORMAL;
            }
            else
            {
                s_fsm = FSM_RETRY_WAIT;
            }
        }
        break;
    }

    /* ====== RETRY_WAIT: 继电器操作失败, 等待120秒重试 ====== */
    case FSM_RETRY_WAIT:
    {
        /* 等待期间每秒采样一次传感器 (安全监测) */
        if (tick_elapsed(s_last_sample, 1000UL))
        {
            heater_get_temperature();
            heater_get_input_vol();
            s_last_sample = now;
            /* 安全保护: 如果温度异常且正在加热, 立即强制关闭 */
            if ((g_temperature >= TEMP_HIGH_THRESHOLD) || (g_temperature < -10))
            {
                if (heater_get_relay_state() == RELAY_STATE_CLOSE)
                {
                    heater_close();  /* 立即关闭, 不等待 */
                }
                g_master_cmd = 0;
            }
        }

        /* 等待120秒到期 */
        if (tick_elapsed(s_wait_target, 0UL) == 0) { break; }

        /* 120秒到, 执行重试 */
        if (s_retry_action == 1)
        {
            /* 重试启动加热 */
            if (heater_open() == 1)
            {
                s_fsm = FSM_IDLE;  /* 成功 */
            }
            else
            {
                s_retry_cnt++;
                if (s_retry_cnt >= HEATER_RETRY_MAX)
                {
                    s_normal_cnt = 0;
                    s_fsm = FSM_ABNORMAL;
                }
                else
                {
                    /* 再等120秒 */
                    s_wait_target = now + (120UL * 1000UL);
                    s_last_sample = now;
                }
            }
        }
        else
        {
            /* 重试关闭加热 */
            if (heater_close() == 1)
            {
                s_fsm = FSM_IDLE;  /* 成功 */
            }
            else
            {
                s_retry_cnt++;
                if (s_retry_cnt >= HEATER_RETRY_MAX)
                {
                    s_normal_cnt = 0;
                    s_fsm = FSM_ABNORMAL;
                }
                else
                {
                    s_wait_target = now + (120UL * 1000UL);
                    s_last_sample = now;
                }
            }
        }
        break;
    }

    /* ====== ABNORMAL: 3次重试均失败, LED闪烁30秒后恢复 ====== */
    case FSM_ABNORMAL:
    {
        /* LED每500ms闪烁一次 (非阻塞方式) */
        if (tick_elapsed(s_wait_target, 500UL))
        {
            led_toggle();
            s_normal_cnt++;
            s_wait_target = now;
            if (s_normal_cnt >= 60)  /* 60 × 500ms = 30秒 */
            {
                s_normal_cnt = 0;
                s_fsm = FSM_IDLE;  /* 恢复正常控制 */
            }
        }
        break;
    }

    default:
        s_fsm = FSM_IDLE;
        break;
    }
}

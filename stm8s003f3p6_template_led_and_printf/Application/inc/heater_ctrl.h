/**
 * @file    heater_ctrl.h
 * @brief   太阳能热水器加热控制模块
 * @note    基于老工程师 hd1a00b1_v4.0 工程移植，适配新硬件引脚定义
 *
 * 引脚映射 (新硬件):
 *   BOARD_OUT1 (PC4) - 调试LED
 *   BOARD_OUT2 (PC5) - MOS管控制 (继电器分流)
 *   BOARD_OUT3 (PC6) - 磁保持继电器动作引脚
 *   BOARD_IN1  (PB5) - 继电器状态检测 (数字输入)
 *   BOARD_IN2  (PC7) - 电源反接检测 (数字输入)
 *   BOARD_ADC1 (PD2) - 光伏输入电压检测 (AIN3)
 *   BOARD_ADC2 (PD3) - NTC温度传感器 (AIN4)
 */

#ifndef __HEATER_CTRL_H
#define __HEATER_CTRL_H

#include "stm8s.h"

/* ==================== 温度阈值配置 ==================== */

#define TEMP_HIGH_THRESHOLD   75    /* 温度高阈值, 高于该温度时停止加热 */
#define TEMP_LOW_THRESHOLD    65    /* 温度低阈值, 低于该温度时启动加热 */

/* ==================== 电压阈值配置 (单位: V, 经ADC换算后) ==================== */

/* 72V光伏板参数 */
#define VOL_START_72V         17    /* 启动加热最低电压 (载波通信正常时的阈值) */  
#define VOL_THRES_72V         23    /* 低压阈值: 低于此电压载波通信无法工作 */
#define VOL_THRES_HIGH_72V    28    /* 低压恢复阈值: 电压回升到此值以上退出低压模式 */

/* 36V光伏板参数 */
//#define VOL_START_36V         16
//#define VOL_THRES_36V         18
//#define VOL_THRES_HIGH_36V    21

/* ==================== 继电器状态 ==================== */

#define RELAY_STATE_CLOSE      0   /* 继电器闭合，加热管加热 */
#define RELAY_STATE_DISCONNECT 1   /* 继电器断开，加热管停止加热 */

/* ==================== ADC配置 ==================== */

#define ADC_SAMPLE_NUMS        5   /* ADC多次采样取平均 */

/* ==================== 重试配置 ==================== */

#define HEATER_RETRY_MAX       3   /* 继电器操作最大重试次数 */
#define RELAY_CHECK_WAIT_MS    500 /* 继电器操作后等待检测时间 ms */
#define RELAY_ACTION_DELAY_MS  150 /* 继电器动作延迟 ms */
#define MOS_PRE_DELAY_MS       100 /* MOS管预闭合延迟 ms */

/* ==================== 从机状态字 ==================== */

typedef union {
    uint8_t byte;
    struct {
        uint8_t ac_heating    : 1;  /* bit0: 1=交流加热中 */
        uint8_t dc_heating    : 1;  /* bit1: 1=直流加热中（有效） */
        uint8_t ac_present    : 1;  /* bit2: 交流电是否存在 */
        uint8_t dc_present    : 1;  /* bit3: 直流电是否存在 */
        uint8_t vol_high_alarm: 1;  /* bit4: 光伏电压过高报警 */
        uint8_t relay_err     : 1;  /* bit5: 继电器控制异常 （有效）*/
        uint8_t dry_burn_err  : 1;  /* bit6: 温度异常 （有效）*/
        uint8_t power_reverse : 1;  /* bit7: 电源正负接反 （有效）*/
    } bits;
} HeaterState_t;

/* ==================== 公开变量声明 ==================== */

extern int8_t  g_temperature;     /* 当前水箱温度 (℃) */
extern uint16_t g_input_vol;      /* 当前光伏输入电压 (V, 经换算) */
extern uint8_t  g_master_cmd;     /* 主机命令: 0=停止, 1=启动加热 */
extern HeaterState_t g_state;     /* 从机状态字 */

/* ==================== 公开函数声明 ==================== */

/**
 * @brief  加热控制模块初始化 (ADC等)
 */
void heater_ctrl_init(void);

/**
 * @brief  读取当前水箱温度 (NTC 50K, 10K分压)
 * @return 温度值 (℃), 范围 -20 ~ 120
 */
int8_t heater_get_temperature(void);

/**
 * @brief  读取光伏输入电压
 * @return 电压值 (V, 经换算)
 */
uint8_t heater_get_input_vol(void);

/**
 * @brief  读取继电器当前状态 (数字输入)
 * @return RELAY_STATE_CLOSE 或 RELAY_STATE_DISCONNECT
 */
uint8_t heater_get_relay_state(void);

/**
 * @brief  读取电源反接检测 (数字输入)
 * @return 1=反接, 0=正常
 */
uint8_t heater_is_power_reverse(void);

/**
 * @brief  启动直流加热
 * @return 1=成功, 0=失败
 */
uint8_t heater_open(void);

/**
 * @brief  停止直流加热
 * @return 1=成功, 0=失败
 */
uint8_t heater_close(void);

/**
 * @brief  加热控制主循环处理函数, 需在 main while(1) 中周期调用
 * @note   内部包含温度/电压采集和安全保护逻辑
 */
void heater_process(void);

/**
 * @brief  延时指定秒数, 期间保持温度采集和安全检测
 * @param  sec 延时秒数
 */
void heater_delay_seconds(uint16_t sec);

#endif /* __HEATER_CTRL_H */

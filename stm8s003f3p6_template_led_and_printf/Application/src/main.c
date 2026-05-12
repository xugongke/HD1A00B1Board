/**
 * @file    main.c
 * @brief   太阳能热水器从机主程序
 *
 * 功能概述:
 *   1. 通过 ES1642 载波模块接收主机调度命令
 *   2. 根据主机命令 + 本地安全检测 (温度/电压) 控制继电器加热
 *   3. 定时上报温度、电压、状态给主机
 */

#include "stm8s.h"
#include "ek_clk.h"
#include "ek_gpio.h"
#include "ek_tim.h"
#include "ek_uart.h"
#include "es1642_port_stm8.h"
#include "heater_ctrl.h"

/* ==================== 看门狗配置 ==================== */

#define WDG_ENABLE  1

#if WDG_ENABLE
static void iwdg_init(void)
{
    IWDG_Enable();
    IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
    IWDG_SetPrescaler(IWDG_Prescaler_256);   /* 64KHZ / 256 ≈ 1.024s */
    IWDG_SetReload(0xFF);                     /* 重载值255, 约1秒超时 */
}

static void iwdg_feed(void)
{
    IWDG_ReloadCounter();
}
#endif

/* ==================== 状态上报周期 ==================== */

#define REPORT_INTERVAL_MS  5000  /* 每5秒上报一次状态 */

/* ==================== 主函数 ==================== */

void main(void)
{
     disableInterrupts();

    /* 系统时钟初始化 */
    ek_sys_clk_init();

    /* 看门狗初始化 */
#if WDG_ENABLE
    iwdg_init();
#endif

    /* 外设初始化 */
    ek_gpio_init();
    ek_sys_tim_init();
    ek_uart_init();

    /* 加热控制模块初始化 (ADC) */
    heater_ctrl_init();

    /* ES1642载波通信初始化 */
    es1642_app_init();

    enableInterrupts();

    /* 上电延时等待电压稳定 */
    ek_delay(200);

    /* LED上电指示 */
    BOARD_OUT1_ON();
    heater_delay_seconds(6);  /* 延时6秒, 等待系统稳定 */
    BOARD_OUT1_OFF();

    /* 主循环 */
    while (1)
    {
#if WDG_ENABLE
        iwdg_feed();
#endif

        /* ES1642载波通信轮询 (接收/发送) */
        es1642_app_poll();

        /* 加热控制处理 (采集+安全检测+控制) */
        heater_process();

        /* 喂狗 */
#if WDG_ENABLE
        iwdg_feed();
#endif

        /* 主循环延时约1秒 (heater_process内部已有延时) */
    }
}

#ifdef USE_FULL_ASSERT
void assert_failed(u8 *file, u32 line)
{
    (void)file;
    (void)line;
    while (1)
    {
    }
}
#endif

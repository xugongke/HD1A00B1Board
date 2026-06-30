#include "ek_tim.h"
#include "ek_gpio.h"
#include "heater_ctrl.h"
#include "stm8s_iwdg.h"

/* forward declaration to avoid include path issue */
extern void es1642_app_poll(void);

#ifndef WDG_ENABLE
#define WDG_ENABLE  1  /* ???????, ????????? */
#endif

__IO uint32_t ek_delay_tick = 0;

/* software timer */
u32 tick_10ms;
u32 sec_time;
void ek_soft_timer(void)
{
    /* for led control */
    tick_10ms++;        //对毫秒数记录
    if((tick_10ms % ONE_SECOND_TICK) == 0){
       sec_time++;
       /* 每秒累加一次用电量: 加热中则按当前电压 P=U?/R 分段积分(瓦秒) */
       heater_energy_accumulate();
    }
     if((tick_10ms % (ONE_SECOND_TICK/4)) == 0)
    {
        if (g_state.bits.power_reverse != 0){
            BOARD_OUT1_REV();
        }
    }
}

/* nms @1ms */
void ek_delay(__IO uint32_t nms)
{
    ek_delay_tick = nms;
    
    /* wait */
    while(ek_delay_tick)
    {
        es1642_app_poll();
#if WDG_ENABLE
        IWDG_ReloadCounter();  /* 延时期间喂狗, 防止长时间延时触发看门狗复位 */
#endif
    }
}

/* count for delay function */
void ek_delay_counter(void)
{
    if(ek_delay_tick)
    {
        ek_delay_tick--;
    }
}

/* hardware timer init */
void ek_sys_tim_init(void)
{
    /* system timer reset */
    TIM4_DeInit();
    
    /* 8MHz / 64 = 125kHz, ARR = 125 -> 1ms period */
    TIM4_TimeBaseInit(TIM4_PRESCALER_64, EK_UPDATE_TIME);
    
    /* arr register preload */
    TIM4_ARRPreloadConfig(ENABLE);
    
    /* clear update flag */
    TIM4_ClearFlag(TIM4_FLAG_UPDATE);
    
    /* enable update interrupt */
    TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
    
    /* start timer */
    TIM4_Cmd(ENABLE);
}

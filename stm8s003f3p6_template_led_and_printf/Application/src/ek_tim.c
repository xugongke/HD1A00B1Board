#include "ek_tim.h"
#include "ek_gpio.h"

__IO uint32_t ek_delay_tick = 0;
static __IO uint32_t ek_sys_tick = 0;

/* get system tick in ms (non-blocking timer) */
uint32_t ek_get_tick(void)
{
    return ek_sys_tick;
}

/* software timer */
void ek_soft_timer(void)
{
    /* for led control */
}

/* count for delay function */
void ek_delay_counter(void)
{
    ek_sys_tick++;
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

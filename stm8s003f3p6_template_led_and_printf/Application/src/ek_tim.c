#include "ek_tim.h"
#include "ek_gpio.h"

__IO uint32_t ek_delay_tick = 0;
static volatile uint32_t ek_millis_tick = 0;

/* software timer */
void ek_soft_timer(void)
{
    /* for led control */
}

/* nms @1ms */
void ek_delay(__IO uint32_t nms)
{
    ek_delay_tick = nms;
    while (ek_delay_tick);
}

/* count for delay function */
void ek_delay_counter(void)
{
    ek_millis_tick++;
    if (ek_delay_tick)
    {
        ek_delay_tick--;
    }
}

/* get elapsed milliseconds since boot */
uint32_t ek_millis(void)
{
    return ek_millis_tick;
}

/* hardware timer init - use TIM2 (16-bit) */
void ek_sys_tim_init(void)
{
    TIM2_DeInit();

    /* 16MHz / 16 = 1MHz, ARR=999 ¡ú 1ms overflow */
    TIM2_TimeBaseInit(TIM2_PRESCALER_16, EK_UPDATE_TIME);

    TIM2_ARRPreloadConfig(ENABLE);
    TIM2_ClearFlag(TIM2_FLAG_UPDATE);
    TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
    TIM2_Cmd(ENABLE);
}

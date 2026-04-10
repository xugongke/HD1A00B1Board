#include "ek_gpio.h"
#include "ek_tim.h"

/* led control variable */
ek_led_handle_typedef ek_led_handle = {0};

/* led control function */
void ek_systick_led(void)
{
    /* led frequent */
    if(ek_led_handle.timer == 0)
    {
        /* start led timer, and control led state */
        ek_led_handle.timer = EK_LED_PERIOD;
        ek_led_handle.flag = !ek_led_handle.flag;
        
        /* led off */
        if(ek_led_handle.flag) ek_led_of;
        /* led on */
        else                   ek_led_on;
    }
}

/* gpio init */
void ek_gpio_init(void)
{
    /* gpio init for led */
    GPIO_Init(EK_LED_PORT, EK_LED_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
    
    /* default, led off */
    ek_led_of;
}

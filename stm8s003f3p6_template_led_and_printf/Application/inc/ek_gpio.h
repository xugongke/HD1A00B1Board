#ifndef __EK_GPIO_H
#define __EK_GPIO_H

#include "stm8s.h"

/* led port and pin */
#define EK_LED_PORT     GPIOB
#define EK_LED_PIN      GPIO_PIN_5

/* led control, low level to light */
#define ek_led_on       GPIO_WriteLow(EK_LED_PORT, EK_LED_PIN)
#define ek_led_of       GPIO_WriteHigh(EK_LED_PORT, EK_LED_PIN)

/* nms @1ms, the max value is 65535 */
#define EK_LED_PERIOD   500

typedef struct
{
    __IO uint16_t timer;
    __IO uint8_t  flag;
} ek_led_handle_typedef;

extern ek_led_handle_typedef ek_led_handle;

void ek_gpio_init(void);
void ek_systick_led(void);

#endif

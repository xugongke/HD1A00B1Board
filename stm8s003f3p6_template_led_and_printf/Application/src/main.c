#include "stm8s.h"
#include "ek_clk.h"
#include "ek_gpio.h"
#include "ek_tim.h"
#include "ek_uart.h"
#include "es1642_port_stm8.h"

void main(void)
{
    ek_sys_clk_init();
    ek_gpio_init();
    ek_sys_tim_init();
    ek_uart_init();
    es1642_app_init();

    enableInterrupts();
    ek_delay(10);
    
    ES1642_ReadMac();//∂¡»°macµÿ÷∑
    
    while (1)
    {
        es1642_app_poll();
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

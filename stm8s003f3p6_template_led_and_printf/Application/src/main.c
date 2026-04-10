#include "stm8s.h"
#include "ek_clk.h"
#include "ek_gpio.h"
#include "ek_tim.h"
#include "ek_uart.h"

/**
  * STM8S003F3P6
  */
void main(void)
{
    /* system clock init */
    ek_sys_clk_init();
    
    /* gpio init */
    ek_gpio_init();
  
    /* system timer init */
    ek_sys_tim_init();
    
    /* uart init */
    ek_uart_init();
    
    /* enable interrupt */
    enableInterrupts();
    
    /* delay 1ms */
    ek_delay(1);
    
    /* printf info */
    printf("this is a template program.\r\n");

    while (1)
    {
        /* led control */
        ek_systick_led();
    }
  
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  while (1)
  {
  }
}
#endif

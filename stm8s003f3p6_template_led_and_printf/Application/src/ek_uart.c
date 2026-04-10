#include "ek_uart.h"

/* printf function */
int putchar (int c)
{
    /* used uart to send data */
    UART1_SendData8(c);
    /* wait for send complete */
    while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);

    return (c);
}

/* uart init function */
void ek_uart_init(void)
{
    /* reset uart */
    UART1_DeInit();

    /* uart init, 115200-8-N-1 */
    UART1_Init( EK_UART_BAUDRATE, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, 
               UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE );
}

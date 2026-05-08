#include "ek_uart.h"

#define UART_RX_FIFO_SIZE 64U

static volatile uint8_t s_rx_fifo[UART_RX_FIFO_SIZE];
static volatile uint8_t s_rx_w = 0U;
static volatile uint8_t s_rx_r = 0U;

int putchar(int c)
{
    UART1_SendData8((uint8_t)c);
    while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET)
    {
    }
    return c;
}

void ek_uart_send_bytes(const uint8_t *data, uint16_t len)
{
    uint16_t i;
    for (i = 0U; i < len; ++i)
    {
        UART1_SendData8(data[i]);
        while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET)
        {
        }
    }
}

uint8_t ek_uart_read_byte(uint8_t *byte)
{
    if ((byte == 0) || (s_rx_r == s_rx_w))
    {
        return 0U;
    }

    *byte = s_rx_fifo[s_rx_r];
    s_rx_r = (uint8_t)((s_rx_r + 1U) % UART_RX_FIFO_SIZE);
    return 1U;
}

void ek_uart_rx_isr(void)
{
    /* Read SR first - required to clear OR (Overrun) flag:
     * STM8S OR clearing sequence: read SR, then read DR */
    uint8_t sr = UART1->SR;

    /* Read DR to clear RXNE and complete OR clearing */
    uint8_t data = (uint8_t)UART1->DR;

    /* Only store data if RXNE was set (not just an OR error) */
    if (sr & (uint8_t)UART1_FLAG_RXNE)
    {
        uint8_t next = (uint8_t)((s_rx_w + 1U) % UART_RX_FIFO_SIZE);

        if (next != s_rx_r)
        {
            s_rx_fifo[s_rx_w] = data;
            s_rx_w = next;
        }
    }
}

void ek_uart_init(void)
{
    UART1_DeInit();
    UART1_Init(EK_UART_BAUDRATE,
               UART1_WORDLENGTH_8D,
               UART1_STOPBITS_1,
               UART1_PARITY_NO,
               UART1_SYNCMODE_CLOCK_DISABLE,
               UART1_MODE_TXRX_ENABLE);

    UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
}

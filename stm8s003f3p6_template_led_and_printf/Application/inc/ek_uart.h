#ifndef __EK_UART_H
#define __EK_UART_H

#include "stm8s.h"
#include <stdio.h>

#define EK_UART_BAUDRATE ((uint32_t)9600)

void ek_uart_init(void);
void ek_uart_send_bytes(const uint8_t *data, uint16_t len);
uint8_t ek_uart_read_byte(uint8_t *byte);
void ek_uart_rx_isr(void);

#endif

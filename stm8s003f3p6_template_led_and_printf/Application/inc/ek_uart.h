#ifndef __EK_UART_H
#define __EK_UART_H

#include "stm8s.h"
#include <stdio.h>

/* uart baudrate */
#define EK_UART_BAUDRATE   ((uint32_t)115200)

void ek_uart_init(void);

#endif

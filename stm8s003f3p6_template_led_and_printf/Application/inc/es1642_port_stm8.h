#ifndef __ES1642_PORT_STM8_H
#define __ES1642_PORT_STM8_H

#include "stm8s.h"
#include "es1642.h"

void es1642_app_init(void);
void es1642_app_poll(void);
void es1642_uart_rx_irq_handler(void);
int ES1642_ReadMac(void);

#endif

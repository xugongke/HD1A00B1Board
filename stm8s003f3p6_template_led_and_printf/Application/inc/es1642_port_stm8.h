#ifndef __ES1642_PORT_STM8_H
#define __ES1642_PORT_STM8_H

#include "stm8s.h"
#include "es1642.h"

int32_t stm8_es1642_write(const uint8_t *data, uint16_t len);
void es1642_on_frame(es1642_handle_t *handle, const es1642_frame_t *frame);

void es1642_app_init(void);
void es1642_app_poll(void);
void es1642_uart_rx_irq_handler(void);
int ES1642_ReadMac(void);

#endif

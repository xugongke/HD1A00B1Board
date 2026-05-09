#ifndef __EK_TIM_H
#define __EK_TIM_H

#include "stm8s.h"

/**
  * TIM4 8-bit timer, 8MHz / 64 = 125kHz, ARR = 125 -> 1ms period
  */
#define EK_UPDATE_TIME        125

void ek_sys_tim_init(void);
void ek_soft_timer(void);
void ek_delay_counter(void);
void ek_delay(__IO uint32_t nms);
uint32_t ek_get_tick(void);

#endif

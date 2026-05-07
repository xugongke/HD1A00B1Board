#ifndef __EK_TIM_H
#define __EK_TIM_H

#include "stm8s.h"

/**
  * TIM2 16-bit timer, 16MHz / 16 = 1MHz, ARR = 999 ¡ú 1ms period
  */
#define EK_UPDATE_TIME        999

void ek_sys_tim_init(void);
void ek_soft_timer(void);
void ek_delay_counter(void);
void ek_delay(__IO uint32_t nms);
uint32_t ek_millis(void);

#endif

#ifndef __EK_TIM_H
#define __EK_TIM_H

#include "stm8s.h"

/** 
  * 125KHz clock, 1ms update, 
  * this is a 8 bit timer, the max value is 255
  */
#define EK_UPDATE_TIME        125

void ek_sys_tim_init(void);
void ek_soft_timer(void);
void ek_delay_counter(void);
void ek_delay(__IO uint32_t nms);

#endif

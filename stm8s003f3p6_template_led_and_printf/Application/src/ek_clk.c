#include "ek_clk.h"

void ek_sys_clk_init(void)
{
    /* reset clock */
    CLK_DeInit();
    
    /* set hsi prescaler */
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
}

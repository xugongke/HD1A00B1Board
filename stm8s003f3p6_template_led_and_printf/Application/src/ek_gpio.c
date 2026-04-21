#include "ek_gpio.h"
void board_outputs_all_off(void)
{
    BOARD_OUT1_OFF();
    BOARD_OUT2_OFF();
    BOARD_OUT3_OFF();
}

uint8_t board_input1_read(void)
{
    return (GPIO_ReadInputPin(BOARD_IN1_PORT, BOARD_IN1_PIN) != RESET) ? 1U : 0U;
}

uint8_t board_input2_read(void)
{
    return (GPIO_ReadInputPin(BOARD_IN2_PORT, BOARD_IN2_PIN) != RESET) ? 1U : 0U;
}

void ek_gpio_init(void)
{
    /* outputs */
    GPIO_Init(BOARD_OUT1_PORT, BOARD_OUT1_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
    GPIO_Init(BOARD_OUT2_PORT, BOARD_OUT2_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
    GPIO_Init(BOARD_OUT3_PORT, BOARD_OUT3_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
    board_outputs_all_off();

    /* digital inputs */
    GPIO_Init(BOARD_IN1_PORT, BOARD_IN1_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(BOARD_IN2_PORT, BOARD_IN2_PIN, GPIO_MODE_IN_PU_NO_IT);

    /* ADC pins keep input floating */
    GPIO_Init(BOARD_ADC1_PORT, BOARD_ADC1_PIN, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(BOARD_ADC2_PORT, BOARD_ADC2_PIN, GPIO_MODE_IN_FL_NO_IT);
}

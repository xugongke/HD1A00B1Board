#ifndef __EK_GPIO_H
#define __EK_GPIO_H

#include "stm8s.h"

#define BOARD_UART_TX_PORT          GPIOD
#define BOARD_UART_TX_PIN           GPIO_PIN_5
#define BOARD_UART_RX_PORT          GPIOD
#define BOARD_UART_RX_PIN           GPIO_PIN_6

#define BOARD_ADC1_PORT             GPIOD
#define BOARD_ADC1_PIN              GPIO_PIN_2
#define BOARD_ADC2_PORT             GPIOD
#define BOARD_ADC2_PIN              GPIO_PIN_3

#define BOARD_IN1_PORT              GPIOB
#define BOARD_IN1_PIN               GPIO_PIN_5
#define BOARD_IN2_PORT              GPIOC
#define BOARD_IN2_PIN               GPIO_PIN_7

#define ES1642_RES_PORT             GPIOC
#define ES1642_RES_PIN              GPIO_PIN_3
#define BOARD_OUT1_PORT             GPIOC
#define BOARD_OUT1_PIN              GPIO_PIN_4
#define BOARD_OUT2_PORT             GPIOC
#define BOARD_OUT2_PIN              GPIO_PIN_5
#define BOARD_OUT3_PORT             GPIOC
#define BOARD_OUT3_PIN              GPIO_PIN_6

#define BOARD_OUT1_ON()             GPIO_WriteHigh(BOARD_OUT1_PORT, BOARD_OUT1_PIN)
#define BOARD_OUT1_OFF()            GPIO_WriteLow(BOARD_OUT1_PORT, BOARD_OUT1_PIN)
#define BOARD_OUT1_REV()            GPIO_WriteReverse(BOARD_OUT1_PORT,BOARD_OUT1_PIN)

#define BOARD_OUT2_ON()             GPIO_WriteHigh(BOARD_OUT2_PORT, BOARD_OUT2_PIN)
#define BOARD_OUT2_OFF()            GPIO_WriteLow(BOARD_OUT2_PORT, BOARD_OUT2_PIN)
#define BOARD_OUT3_ON()             GPIO_WriteHigh(BOARD_OUT3_PORT, BOARD_OUT3_PIN)
#define BOARD_OUT3_OFF()            GPIO_WriteLow(BOARD_OUT3_PORT, BOARD_OUT3_PIN)
#define ES1642_RES_ON()             GPIO_WriteLow(ES1642_RES_PORT, ES1642_RES_PIN)
#define ES1642_RES_OFF()            GPIO_WriteHigh(ES1642_RES_PORT, ES1642_RES_PIN)

void ek_gpio_init(void);
void board_outputs_all_off(void);
uint8_t board_input1_read(void);
uint8_t board_input2_read(void);

#endif

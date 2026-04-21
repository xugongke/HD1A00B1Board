#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\src\\ek_tim.c"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Application\\inc\\ek_tim.h"



#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/**
  ******************************************************************************
  * @file    stm8s.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all HW registers definitions and memory mapping.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */
  
/* Uncomment the line below according to the target STM8S or STM8A device used in your
   application. */

 /* #define STM8S208 */      /*!< STM8S High density devices with CAN */
 /* #define STM8S207 */      /*!< STM8S High density devices without CAN */
 /* #define STM8S007 */      /*!< STM8S Value Line High density devices */
 /* #define STM8AF52Ax */    /*!< STM8A High density devices with CAN */
 /* #define STM8AF62Ax */    /*!< STM8A High density devices without CAN */
 /* #define STM8S105 */      /*!< STM8S Medium density devices */
 /* #define STM8S005 */      /*!< STM8S Value Line Medium density devices */
 /* #define STM8AF626x */    /*!< STM8A Medium density devices */
 /* #define STM8AF622x */    /*!< STM8A Low density devices */
 /* #define STM8S103 */      /*!< STM8S Low density devices */
 /* #define STM8S003 */      /*!< STM8S Value Line Low density devices */
 /* #define STM8S903 */      /*!< STM8S Low density devices */
 /* #define STM8S001 */      /*!< STM8S Value Line Low denisty devices */

/*   Tip: To avoid modifying this file each time you need to switch between these
        devices, you can define the device in your toolchain compiler preprocessor. 

  - High-Density STM8A devices are the STM8AF52xx STM8AF6269/8x/Ax,
    STM8AF51xx, and STM8AF6169/7x/8x/9x/Ax microcontrollers where the Flash memory
    density ranges between 32 to 128 Kbytes
  - Medium-Density STM8A devices are the STM8AF622x/4x, STM8AF6266/68,
    STM8AF612x/4x, and STM8AF6166/68 microcontrollers where the Flash memory 
    density ranges between 8 to 32 Kbytes
  - High-Density STM8S devices are the STM8S207xx, STM8S007 and STM8S208xx microcontrollers
    where the Flash memory density ranges between 32 to 128 Kbytes.
  - Medium-Density STM8S devices are the STM8S105x and STM8S005 microcontrollers
    where the Flash memory density ranges between 16 to 32-Kbytes.
  - Low-Density STM8A devices are the STM8AF622x microcontrollers where the Flash
    density is 8 Kbytes. 
  - Low-Density STM8S devices are the STM8S103xx, STM8S003, STM8S903xx and STM8S001 microcontrollers
    where the Flash density is 8 Kbytes. */

#line 77 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/******************************************************************************/
/*                   Library configuration section                            */
/******************************************************************************/
/* Check the used compiler */
#line 91 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 98 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @brief  In the following line adjust the value of External High Speed oscillator (HSE)
   used in your application

   Tip: To avoid modifying this file each time you need to use different HSE, you
        can define the HSE value in your toolchain compiler preprocessor.
  */
#line 114 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @brief  Definition of Device on-chip RC oscillator frequencies
  */



#line 148 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* For FLASH routines, select whether pointer will be declared as near (2 bytes,
   to handle code smaller than 64KB) or far (3 bytes, to handle code larger 
   than 64K) */



/*!< Used with memory Models for code smaller than 64K */
#line 163 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* Uncomment the line below to enable the FLASH functions execution from RAM */

/* #define RAM_EXECUTION  (1) */


#line 180 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/*!< [31:16] STM8S Standard Peripheral Library main version V2.3.0*/
#line 190 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/******************************************************************************/

/* Includes ------------------------------------------------------------------*/

/* Exported types and constants ----------------------------------------------*/

/** @addtogroup Exported_types
  * @{
  */

/**
 * IO definitions
 *
 * define access restrictions to peripheral registers
 */




/*!< Signed integer types  */
typedef   signed char     int8_t;
typedef   signed short    int16_t;
typedef   signed long     int32_t;

/*!< Unsigned integer types  */
typedef unsigned char     uint8_t;
typedef unsigned short    uint16_t;
typedef unsigned long     uint32_t;

/*!< STM8 Standard Peripheral Library old types (maintained for legacy purpose) */

typedef int32_t  s32;
typedef int16_t s16;
typedef int8_t  s8;

typedef uint32_t  u32;
typedef uint16_t u16;
typedef uint8_t  u8;


typedef enum {FALSE = 0, TRUE = !FALSE} bool;

typedef enum {RESET = 0, SET = !RESET} FlagStatus, ITStatus, BitStatus, BitAction;

typedef enum {DISABLE = 0, ENABLE = !DISABLE} FunctionalState;


typedef enum {ERROR = 0, SUCCESS = !ERROR} ErrorStatus;

#line 249 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */
  
/** @addtogroup MAP_FILE_Exported_Types_and_Constants
  * @{
  */

/******************************************************************************/
/*                          IP registers structures                           */
/******************************************************************************/

/**
  * @brief  General Purpose I/Os (GPIO)
  */
typedef struct GPIO_struct
{
  volatile uint8_t ODR; /*!< Output Data Register */
  volatile uint8_t IDR; /*!< Input Data Register */
  volatile uint8_t DDR; /*!< Data Direction Register */
  volatile uint8_t CR1; /*!< Configuration Register 1 */
  volatile uint8_t CR2; /*!< Configuration Register 2 */
}
GPIO_TypeDef;

/**
  * @}
  */

/** @addtogroup GPIO_Registers_Reset_Value
  * @{
  */






/**
  * @}
  */

/*----------------------------------------------------------------------------*/


/**
  * @brief  Analog to Digital Converter (ADC1)
  */
 typedef struct ADC1_struct
 {
  volatile uint8_t DB0RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB0RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB1RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB1RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB2RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB2RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB3RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB3RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB4RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB4RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB5RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB5RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB6RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB6RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB7RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB7RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB8RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB8RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  volatile uint8_t DB9RH;         /*!< ADC1 Data Buffer Register (MSB)  */
  volatile uint8_t DB9RL;         /*!< ADC1 Data Buffer Register (LSB)  */
  uint8_t RESERVED[12];       /*!< Reserved byte */
  volatile uint8_t CSR;           /*!< ADC1 control status register */
  volatile uint8_t CR1;           /*!< ADC1 configuration register 1 */
  volatile uint8_t CR2;           /*!< ADC1 configuration register 2 */
  volatile uint8_t CR3;           /*!< ADC1 configuration register 3  */
  volatile uint8_t DRH;           /*!< ADC1 Data high */
  volatile uint8_t DRL;           /*!< ADC1 Data low */
  volatile uint8_t TDRH;          /*!< ADC1 Schmitt trigger disable register high */
  volatile uint8_t TDRL;          /*!< ADC1 Schmitt trigger disable register low */
  volatile uint8_t HTRH;          /*!< ADC1 high threshold register High*/
  volatile uint8_t HTRL;          /*!< ADC1 high threshold register Low*/
  volatile uint8_t LTRH;          /*!< ADC1 low threshold register high */
  volatile uint8_t LTRL;          /*!< ADC1 low threshold register low */
  volatile uint8_t AWSRH;         /*!< ADC1 watchdog status register high */
  volatile uint8_t AWSRL;         /*!< ADC1 watchdog status register low */
  volatile uint8_t AWCRH;         /*!< ADC1 watchdog control register high */
  volatile uint8_t AWCRL;         /*!< ADC1 watchdog control register low */
 }
 ADC1_TypeDef;

/** @addtogroup ADC1_Registers_Reset_Value
  * @{
  */
#line 355 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/**
  * @}
  */

/** @addtogroup ADC1_Registers_Bits_Definition
  * @{
  */



















/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Analog to Digital Converter (ADC2)
  */
#line 431 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/**
  * @}
  */

/*----------------------------------------------------------------------------*/

/**
  * @brief  Auto Wake Up (AWU) peripheral registers.
  */
typedef struct AWU_struct
{
  volatile uint8_t CSR; /*!< AWU Control status register */
  volatile uint8_t APR; /*!< AWU Asynchronous prescaler buffer */
  volatile uint8_t TBR; /*!< AWU Time base selection register */
}
AWU_TypeDef;

/** @addtogroup AWU_Registers_Reset_Value
  * @{
  */




/**
  * @}
  */

/** @addtogroup AWU_Registers_Bits_Definition
  * @{
  */









/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Beeper (BEEP) peripheral registers.
  */

typedef struct BEEP_struct
{
  volatile uint8_t CSR; /*!< BEEP Control status register */
}
BEEP_TypeDef;

/** @addtogroup BEEP_Registers_Reset_Value
  * @{
  */

/**
  * @}
  */

/** @addtogroup BEEP_Registers_Bits_Definition
  * @{
  */



/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Clock Controller (CLK)
  */
typedef struct CLK_struct
{
  volatile uint8_t ICKR;     /*!< Internal Clocks Control Register */
  volatile uint8_t ECKR;     /*!< External Clocks Control Register */
  uint8_t RESERVED;      /*!< Reserved byte */
  volatile uint8_t CMSR;     /*!< Clock Master Status Register */
  volatile uint8_t SWR;      /*!< Clock Master Switch Register */
  volatile uint8_t SWCR;     /*!< Switch Control Register */
  volatile uint8_t CKDIVR;   /*!< Clock Divider Register */
  volatile uint8_t PCKENR1;  /*!< Peripheral Clock Gating Register 1 */
  volatile uint8_t CSSR;     /*!< Clock Security System Register */
  volatile uint8_t CCOR;     /*!< Configurable Clock Output Register */
  volatile uint8_t PCKENR2;  /*!< Peripheral Clock Gating Register 2 */
  uint8_t RESERVED1;     /*!< Reserved byte */
  volatile uint8_t HSITRIMR; /*!< HSI Calibration Trimmer Register */
  volatile uint8_t SWIMCCR;  /*!< SWIM clock control register */
}
CLK_TypeDef;

/** @addtogroup CLK_Registers_Reset_Value
  * @{
  */

#line 543 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup CLK_Registers_Bits_Definition
  * @{
  */
#line 557 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
















#line 584 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"



















/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer with complementary PWM outputs (TIM1)
  */

typedef struct TIM1_struct
{
  volatile uint8_t CR1;   /*!< control register 1 */
  volatile uint8_t CR2;   /*!< control register 2 */
  volatile uint8_t SMCR;  /*!< Synchro mode control register */
  volatile uint8_t ETR;   /*!< external trigger register */
  volatile uint8_t IER;   /*!< interrupt enable register*/
  volatile uint8_t SR1;   /*!< status register 1 */
  volatile uint8_t SR2;   /*!< status register 2 */
  volatile uint8_t EGR;   /*!< event generation register */
  volatile uint8_t CCMR1; /*!< CC mode register 1 */
  volatile uint8_t CCMR2; /*!< CC mode register 2 */
  volatile uint8_t CCMR3; /*!< CC mode register 3 */
  volatile uint8_t CCMR4; /*!< CC mode register 4 */
  volatile uint8_t CCER1; /*!< CC enable register 1 */
  volatile uint8_t CCER2; /*!< CC enable register 2 */
  volatile uint8_t CNTRH; /*!< counter high */
  volatile uint8_t CNTRL; /*!< counter low */
  volatile uint8_t PSCRH; /*!< prescaler high */
  volatile uint8_t PSCRL; /*!< prescaler low */
  volatile uint8_t ARRH;  /*!< auto-reload register high */
  volatile uint8_t ARRL;  /*!< auto-reload register low */
  volatile uint8_t RCR;   /*!< Repetition Counter register */
  volatile uint8_t CCR1H; /*!< capture/compare register 1 high */
  volatile uint8_t CCR1L; /*!< capture/compare register 1 low */
  volatile uint8_t CCR2H; /*!< capture/compare register 2 high */
  volatile uint8_t CCR2L; /*!< capture/compare register 2 low */
  volatile uint8_t CCR3H; /*!< capture/compare register 3 high */
  volatile uint8_t CCR3L; /*!< capture/compare register 3 low */
  volatile uint8_t CCR4H; /*!< capture/compare register 3 high */
  volatile uint8_t CCR4L; /*!< capture/compare register 3 low */
  volatile uint8_t BKR;   /*!< Break Register */
  volatile uint8_t DTR;   /*!< dead-time register */
  volatile uint8_t OISR;  /*!< Output idle register */
}
TIM1_TypeDef;

/** @addtogroup TIM1_Registers_Reset_Value
  * @{
  */

#line 685 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup TIM1_Registers_Bits_Definition
  * @{
  */
/* CR1*/
#line 701 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/* CR2*/




/* SMCR*/



/*ETR*/




/*IER*/
#line 724 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/*SR1*/
#line 733 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/*SR2*/




/*EGR*/
#line 747 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/*CCMR*/
#line 754 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"


/*CCER1*/
#line 765 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/*CCER2*/
#line 772 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/*CNTRH*/

/*CNTRL*/

/*PSCH*/

/*PSCL*/

/*ARR*/


/*RCR*/

/*CCR1*/


/*CCR2*/


/*CCR3*/


/*CCR4*/


/*BKR*/
#line 805 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/*DTR*/

/*OISR*/
#line 815 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer (TIM2)
  */

typedef struct TIM2_struct
{
  volatile uint8_t CR1;   /*!< control register 1 */

	uint8_t RESERVED1; /*!< Reserved register */
	uint8_t RESERVED2; /*!< Reserved register */

  volatile uint8_t IER;   /*!< interrupt enable register */
  volatile uint8_t SR1;   /*!< status register 1 */
  volatile uint8_t SR2;   /*!< status register 2 */
  volatile uint8_t EGR;   /*!< event generation register */
  volatile uint8_t CCMR1; /*!< CC mode register 1 */
  volatile uint8_t CCMR2; /*!< CC mode register 2 */
  volatile uint8_t CCMR3; /*!< CC mode register 3 */
  volatile uint8_t CCER1; /*!< CC enable register 1 */
  volatile uint8_t CCER2; /*!< CC enable register 2 */
  volatile uint8_t CNTRH; /*!< counter high */
  volatile uint8_t CNTRL; /*!< counter low */
  volatile uint8_t PSCR;  /*!< prescaler register */
  volatile uint8_t ARRH;  /*!< auto-reload register high */
  volatile uint8_t ARRL;  /*!< auto-reload register low */
  volatile uint8_t CCR1H; /*!< capture/compare register 1 high */
  volatile uint8_t CCR1L; /*!< capture/compare register 1 low */
  volatile uint8_t CCR2H; /*!< capture/compare register 2 high */
  volatile uint8_t CCR2L; /*!< capture/compare register 2 low */
  volatile uint8_t CCR3H; /*!< capture/compare register 3 high */
  volatile uint8_t CCR3L; /*!< capture/compare register 3 low */
}
TIM2_TypeDef;

/** @addtogroup TIM2_Registers_Reset_Value
  * @{
  */

#line 879 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup TIM2_Registers_Bits_Definition
  * @{
  */
/*CR1*/





/*IER*/




/*SR1*/




/*SR2*/



/*EGR*/




/*CCMR*/





/*CCER1*/




/*CCER2*/


/*CNTR*/


/*PSCR*/

/*ARR*/


/*CCR1*/


/*CCR2*/


/*CCR3*/



/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer (TIM3)
  */
typedef struct TIM3_struct
{
  volatile uint8_t CR1;   /*!< control register 1 */
  volatile uint8_t IER;   /*!< interrupt enable register */
  volatile uint8_t SR1;   /*!< status register 1 */
  volatile uint8_t SR2;   /*!< status register 2 */
  volatile uint8_t EGR;   /*!< event generation register */
  volatile uint8_t CCMR1; /*!< CC mode register 1 */
  volatile uint8_t CCMR2; /*!< CC mode register 2 */
  volatile uint8_t CCER1; /*!< CC enable register 1 */
  volatile uint8_t CNTRH; /*!< counter high */
  volatile uint8_t CNTRL; /*!< counter low */
  volatile uint8_t PSCR;  /*!< prescaler register */
  volatile uint8_t ARRH;  /*!< auto-reload register high */
  volatile uint8_t ARRL;  /*!< auto-reload register low */
  volatile uint8_t CCR1H; /*!< capture/compare register 1 high */
  volatile uint8_t CCR1L; /*!< capture/compare register 1 low */
  volatile uint8_t CCR2H; /*!< capture/compare register 2 high */
  volatile uint8_t CCR2L; /*!< capture/compare register 2 low */
}
TIM3_TypeDef;

/** @addtogroup TIM3_Registers_Reset_Value
  * @{
  */

#line 995 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup TIM3_Registers_Bits_Definition
  * @{
  */
/*CR1*/





/*IER*/



/*SR1*/



/*SR2*/


/*EGR*/



/*CCMR*/





/*CCER1*/




/*CNTR*/


/*PSCR*/

/*ARR*/


/*CCR1*/


/*CCR2*/


/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  8-bit system timer (TIM4)
  */

typedef struct TIM4_struct
{
  volatile uint8_t CR1;  /*!< control register 1 */

	uint8_t RESERVED1; /*!< Reserved register */
	uint8_t RESERVED2; /*!< Reserved register */

  volatile uint8_t IER;  /*!< interrupt enable register */
  volatile uint8_t SR1;  /*!< status register 1 */
  volatile uint8_t EGR;  /*!< event generation register */
  volatile uint8_t CNTR; /*!< counter register */
  volatile uint8_t PSCR; /*!< prescaler register */
  volatile uint8_t ARR;  /*!< auto-reload register */
}
TIM4_TypeDef;

/** @addtogroup TIM4_Registers_Reset_Value
  * @{
  */

#line 1085 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup TIM4_Registers_Bits_Definition
  * @{
  */
/*CR1*/





/*IER*/

/*SR1*/

/*EGR*/

/*CNTR*/

/*PSCR*/

/*ARR*/


/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer with synchro module (TIM5)
  */

typedef struct TIM5_struct
{
  volatile uint8_t CR1;       /*!<TIM5 Control Register 1                */
  volatile uint8_t CR2;       /*!<TIM5 Control Register 2                */
  volatile uint8_t SMCR;      /*!<TIM5 Slave Mode Control Register       */
  volatile uint8_t IER;       /*!<TIM5 Interrupt Enable Register         */
  volatile uint8_t SR1;       /*!<TIM5 Status Register 1                 */
  volatile uint8_t SR2;       /*!<TIM5 Status Register 2                 */
  volatile uint8_t EGR;       /*!<TIM5 Event Generation Register         */
  volatile uint8_t CCMR1;     /*!<TIM5 Capture/Compare Mode Register 1   */
  volatile uint8_t CCMR2;     /*!<TIM5 Capture/Compare Mode Register 2   */
  volatile uint8_t CCMR3;     /*!<TIM5 Capture/Compare Mode Register 3   */
  volatile uint8_t CCER1;     /*!<TIM5 Capture/Compare Enable Register 1 */
  volatile uint8_t CCER2;     /*!<TIM5 Capture/Compare Enable Register 2 */
  volatile uint8_t CNTRH;     /*!<TIM5 Counter High                      */
  volatile uint8_t CNTRL;     /*!<TIM5 Counter Low                       */
  volatile uint8_t PSCR;      /*!<TIM5 Prescaler Register                */
  volatile uint8_t ARRH;      /*!<TIM5 Auto-Reload Register High         */
  volatile uint8_t ARRL;      /*!<TIM5 Auto-Reload Register Low          */
  volatile uint8_t CCR1H;     /*!<TIM5 Capture/Compare Register 1 High   */
  volatile uint8_t CCR1L;     /*!<TIM5 Capture/Compare Register 1 Low    */
  volatile uint8_t CCR2H;     /*!<TIM5 Capture/Compare Register 2 High   */
  volatile uint8_t CCR2L;     /*!<TIM5 Capture/Compare Register 2 Low    */
  volatile uint8_t CCR3H;     /*!<TIM5 Capture/Compare Register 3 High   */
  volatile uint8_t CCR3L;     /*!<TIM5 Capture/Compare Register 3 Low    */
}TIM5_TypeDef;

/** @addtogroup TIM5_Registers_Reset_Value
  * @{
  */

#line 1175 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup TIM5_Registers_Bits_Definition
  * @{
  */
/* CR1*/





/* CR2*/


/* SMCR*/



/*IER*/





/*SR1*/





/*SR2*/



/*EGR*/





/*CCMR*/





/*CCER1*/




/*CCER2*/


/*CNTR*/


/*PSCR*/

/*ARR*/


/*CCR1*/


/*CCR2*/


/*CCR3*/


/*CCMR*/

/**
  * @}
  */
	
/*----------------------------------------------------------------------------*/
/**
  * @brief  8-bit system timer  with synchro module(TIM6)
  */

typedef struct TIM6_struct
{
    volatile uint8_t CR1; 	/*!< control register 1 */
    volatile uint8_t CR2; 	/*!< control register 2 */
    volatile uint8_t SMCR; 	/*!< Synchro mode control register */
    volatile uint8_t IER; 	/*!< interrupt enable register  */
    volatile uint8_t SR1; 	/*!< status register 1    */
    volatile uint8_t EGR; 	/*!< event generation register */
    volatile uint8_t CNTR; 	/*!< counter register  */
    volatile uint8_t PSCR; 	/*!< prescaler register */
    volatile uint8_t ARR; 	/*!< auto-reload register */
}
TIM6_TypeDef;
/** @addtogroup TIM6_Registers_Reset_Value
  * @{
  */
#line 1285 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
* @}
*/

/** @addtogroup TIM6_Registers_Bits_Definition
  * @{
  */
/* CR1*/





/* CR2*/

/* SMCR*/



/* IER*/


/* SR1*/


/* EGR*/


/* CNTR*/

/* PSCR*/



/**
  * @}
  */
/*----------------------------------------------------------------------------*/
/**
  * @brief  Inter-Integrated Circuit (I2C)
  */

typedef struct I2C_struct
{
  volatile uint8_t CR1;       /*!< I2C control register 1 */
  volatile uint8_t CR2;       /*!< I2C control register 2 */
  volatile uint8_t FREQR;     /*!< I2C frequency register */
  volatile uint8_t OARL;      /*!< I2C own address register LSB */
  volatile uint8_t OARH;      /*!< I2C own address register MSB */
  uint8_t RESERVED1;      /*!< Reserved byte */
  volatile uint8_t DR;        /*!< I2C data register */
  volatile uint8_t SR1;       /*!< I2C status register 1 */
  volatile uint8_t SR2;       /*!< I2C status register 2 */
  volatile uint8_t SR3;       /*!< I2C status register 3 */
  volatile uint8_t ITR;       /*!< I2C interrupt register */
  volatile uint8_t CCRL;      /*!< I2C clock control register low */
  volatile uint8_t CCRH;      /*!< I2C clock control register high */
  volatile uint8_t TRISER;    /*!< I2C maximum rise time register */
  uint8_t RESERVED2;      /*!< Reserved byte */
}
I2C_TypeDef;

/** @addtogroup I2C_Registers_Reset_Value
  * @{
  */

#line 1365 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup I2C_Registers_Bits_Definition
  * @{
  */






















#line 1402 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
























/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Interrupt Controller (ITC)
  */

typedef struct ITC_struct
{
  volatile uint8_t ISPR1; /*!< Interrupt Software Priority register 1 */
  volatile uint8_t ISPR2; /*!< Interrupt Software Priority register 2 */
  volatile uint8_t ISPR3; /*!< Interrupt Software Priority register 3 */
  volatile uint8_t ISPR4; /*!< Interrupt Software Priority register 4 */
  volatile uint8_t ISPR5; /*!< Interrupt Software Priority register 5 */
  volatile uint8_t ISPR6; /*!< Interrupt Software Priority register 6 */
  volatile uint8_t ISPR7; /*!< Interrupt Software Priority register 7 */
  volatile uint8_t ISPR8; /*!< Interrupt Software Priority register 8 */
}
ITC_TypeDef;

/** @addtogroup ITC_Registers_Reset_Value
  * @{
  */



/**
  * @}
  */

/** @addtogroup CPU_Registers_Bits_Definition
  * @{
  */



/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  External Interrupt Controller (EXTI)
  */

typedef struct EXTI_struct
{
  volatile uint8_t CR1; /*!< External Interrupt Control Register for PORTA to PORTD */
  volatile uint8_t CR2; /*!< External Interrupt Control Register for PORTE and TLI */
}
EXTI_TypeDef;

/** @addtogroup EXTI_Registers_Reset_Value
  * @{
  */




/**
  * @}
  */

/** @addtogroup EXTI_Registers_Bits_Definition
  * @{
  */









/**
  * @}
  */



/*----------------------------------------------------------------------------*/
/**
  * @brief  FLASH program and Data memory (FLASH)
  */

typedef struct FLASH_struct
{
  volatile uint8_t CR1;       /*!< Flash control register 1 */
  volatile uint8_t CR2;       /*!< Flash control register 2 */
  volatile uint8_t NCR2;      /*!< Flash complementary control register 2 */
  volatile uint8_t FPR;       /*!< Flash protection register */
  volatile uint8_t NFPR;      /*!< Flash complementary protection register */
  volatile uint8_t IAPSR;     /*!< Flash in-application programming status register */
  uint8_t RESERVED1;      /*!< Reserved byte */
  uint8_t RESERVED2;      /*!< Reserved byte */
  volatile uint8_t PUKR;      /*!< Flash program memory unprotection register */
  uint8_t RESERVED3;      /*!< Reserved byte */
  volatile uint8_t DUKR;      /*!< Data EEPROM unprotection register */
}
FLASH_TypeDef;

/** @addtogroup FLASH_Registers_Reset_Value
  * @{
  */

#line 1540 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup FLASH_Registers_Bits_Definition
  * @{
  */




























/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Option Bytes (OPT)
  */
typedef struct OPT_struct
{
  volatile uint8_t OPT0;  /*!< Option byte 0: Read-out protection (not accessible in IAP mode) */
  volatile uint8_t OPT1;  /*!< Option byte 1: User boot code */
  volatile uint8_t NOPT1; /*!< Complementary Option byte 1 */
  volatile uint8_t OPT2;  /*!< Option byte 2: Alternate function remapping */
  volatile uint8_t NOPT2; /*!< Complementary Option byte 2 */
  volatile uint8_t OPT3;  /*!< Option byte 3: Watchdog option */
  volatile uint8_t NOPT3; /*!< Complementary Option byte 3 */
  volatile uint8_t OPT4;  /*!< Option byte 4: Clock option */
  volatile uint8_t NOPT4; /*!< Complementary Option byte 4 */
  volatile uint8_t OPT5;  /*!< Option byte 5: HSE clock startup */
  volatile uint8_t NOPT5; /*!< Complementary Option byte 5 */
  uint8_t RESERVED1;  /*!< Reserved Option byte*/
  uint8_t RESERVED2; /*!< Reserved Option byte*/
  volatile uint8_t OPT7;  /*!< Option byte 7: flash wait states */
  volatile uint8_t NOPT7; /*!< Complementary Option byte 7 */
}
OPT_TypeDef;

/*----------------------------------------------------------------------------*/
/**
  * @brief  Independent Watchdog (IWDG)
  */

typedef struct IWDG_struct
{
  volatile uint8_t KR;  /*!< Key Register */
  volatile uint8_t PR;  /*!< Prescaler Register */
  volatile uint8_t RLR; /*!< Reload Register */
}
IWDG_TypeDef;

/** @addtogroup IWDG_Registers_Reset_Value
  * @{
  */




/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Window Watchdog (WWDG)
  */

typedef struct WWDG_struct
{
  volatile uint8_t CR; /*!< Control Register */
  volatile uint8_t WR; /*!< Window Register */
}
WWDG_TypeDef;

/** @addtogroup WWDG_Registers_Reset_Value
  * @{
  */




/**
  * @}
  */

/** @addtogroup WWDG_Registers_Bits_Definition
  * @{
  */








/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Reset Controller (RST)
  */

typedef struct RST_struct
{
  volatile uint8_t SR; /*!< Reset status register */
}
RST_TypeDef;

/** @addtogroup RST_Registers_Bits_Definition
  * @{
  */







/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Serial Peripheral Interface (SPI)
  */

typedef struct SPI_struct
{
  volatile uint8_t CR1;    /*!< SPI control register 1 */
  volatile uint8_t CR2;    /*!< SPI control register 2 */
  volatile uint8_t ICR;    /*!< SPI interrupt control register */
  volatile uint8_t SR;     /*!< SPI status register */
  volatile uint8_t DR;     /*!< SPI data I/O register */
  volatile uint8_t CRCPR;  /*!< SPI CRC polynomial register */
  volatile uint8_t RXCRCR; /*!< SPI Rx CRC register */
  volatile uint8_t TXCRCR; /*!< SPI Tx CRC register */
}
SPI_TypeDef;

/** @addtogroup SPI_Registers_Reset_Value
  * @{
  */

#line 1721 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup SPI_Registers_Bits_Definition
  * @{
  */

#line 1736 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 1744 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"






#line 1757 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Universal Synchronous Asynchronous Receiver Transmitter (UART1)
  */

typedef struct UART1_struct
{
  volatile uint8_t SR;   /*!< UART1 status register */
  volatile uint8_t DR;   /*!< UART1 data register */
  volatile uint8_t BRR1; /*!< UART1 baud rate register */
  volatile uint8_t BRR2; /*!< UART1 DIV mantissa[11:8] SCIDIV fraction */
  volatile uint8_t CR1;  /*!< UART1 control register 1 */
  volatile uint8_t CR2;  /*!< UART1 control register 2 */
  volatile uint8_t CR3;  /*!< UART1 control register 3 */
  volatile uint8_t CR4;  /*!< UART1 control register 4 */
  volatile uint8_t CR5;  /*!< UART1 control register 5 */
  volatile uint8_t GTR;  /*!< UART1 guard time register */
  volatile uint8_t PSCR; /*!< UART1 prescaler register */
}
UART1_TypeDef;

/** @addtogroup UART1_Registers_Reset_Value
  * @{
  */

#line 1797 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup UART1_Registers_Bits_Definition
  * @{
  */

#line 1814 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"






#line 1828 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 1837 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 1844 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"












/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Universal Synchronous Asynchronous Receiver Transmitter (UART2)
  */

typedef struct UART2_struct
{
  volatile uint8_t SR;   /*!< UART1 status register */
  volatile uint8_t DR;   /*!< UART1 data register */
  volatile uint8_t BRR1; /*!< UART1 baud rate register */
  volatile uint8_t BRR2; /*!< UART1 DIV mantissa[11:8] SCIDIV fraction */
  volatile uint8_t CR1;  /*!< UART1 control register 1 */
  volatile uint8_t CR2;  /*!< UART1 control register 2 */
  volatile uint8_t CR3;  /*!< UART1 control register 3 */
  volatile uint8_t CR4;  /*!< UART1 control register 4 */
  volatile uint8_t CR5;  /*!< UART1 control register 5 */
	volatile uint8_t CR6;  /*!< UART1 control register 6 */
  volatile uint8_t GTR;  /*!< UART1 guard time register */
  volatile uint8_t PSCR; /*!< UART1 prescaler register */
}
UART2_TypeDef;

/** @addtogroup UART2_Registers_Reset_Value
  * @{
  */

#line 1897 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup UART2_Registers_Bits_Definition
  * @{
  */

#line 1914 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"






#line 1928 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 1937 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 1944 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"











#line 1961 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */


/*----------------------------------------------------------------------------*/
/**
  * @brief  LIN Universal Asynchronous Receiver Transmitter (UART3)
  */

typedef struct UART3_struct
{
  volatile uint8_t SR;       /*!< status register */
  volatile uint8_t DR;       /*!< data register */
  volatile uint8_t BRR1;     /*!< baud rate register */
  volatile uint8_t BRR2;     /*!< DIV mantissa[11:8] SCIDIV fraction */
  volatile uint8_t CR1;      /*!< control register 1 */
  volatile uint8_t CR2;      /*!< control register 2 */
  volatile uint8_t CR3;      /*!< control register 3 */
  volatile uint8_t CR4;      /*!< control register 4 */
  uint8_t RESERVED; /*!< Reserved byte */
  volatile uint8_t CR6;      /*!< control register 5 */
}
UART3_TypeDef;

/** @addtogroup UART3_Registers_Reset_Value
  * @{
  */

#line 1999 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup UART3_Registers_Bits_Definition
  * @{
  */

#line 2016 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"






#line 2030 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 2039 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"









#line 2054 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief Universal Synchronous Asynchronous Receiver Transmitter (UART4)
  */
#line 2162 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/**
  * @brief  Controller Area Network  (CAN)
  */

typedef struct
{
  volatile uint8_t MCR;    /*!< CAN master control register */
  volatile uint8_t MSR;    /*!< CAN master status register */
  volatile uint8_t TSR;    /*!< CAN transmit status register */
  volatile uint8_t TPR;    /*!< CAN transmit priority register */
  volatile uint8_t RFR;    /*!< CAN receive FIFO register */
  volatile uint8_t IER;    /*!< CAN interrupt enable register */
  volatile uint8_t DGR;    /*!< CAN diagnosis register */
  volatile uint8_t PSR;    /*!< CAN page selection register */

  union
  {
    struct
    {
      volatile uint8_t MCSR;
      volatile uint8_t MDLCR;
      volatile uint8_t MIDR1;
      volatile uint8_t MIDR2;
      volatile uint8_t MIDR3;
      volatile uint8_t MIDR4;
      volatile uint8_t MDAR1;
      volatile uint8_t MDAR2;
      volatile uint8_t MDAR3;
      volatile uint8_t MDAR4;
      volatile uint8_t MDAR5;
      volatile uint8_t MDAR6;
      volatile uint8_t MDAR7;
      volatile uint8_t MDAR8;
      volatile uint8_t MTSRL;
      volatile uint8_t MTSRH;
    }TxMailbox;

    struct
    {
      volatile uint8_t FR01;
      volatile uint8_t FR02;
      volatile uint8_t FR03;
      volatile uint8_t FR04;
      volatile uint8_t FR05;
      volatile uint8_t FR06;
      volatile uint8_t FR07;
      volatile uint8_t FR08;
      
      volatile uint8_t FR09;
      volatile uint8_t FR10;
      volatile uint8_t FR11;
      volatile uint8_t FR12;
      volatile uint8_t FR13;
      volatile uint8_t FR14;
      volatile uint8_t FR15;
      volatile uint8_t FR16;
    }Filter;

    struct
    {
      volatile uint8_t F0R1;
      volatile uint8_t F0R2;
      volatile uint8_t F0R3;
      volatile uint8_t F0R4;
      volatile uint8_t F0R5;
      volatile uint8_t F0R6;
      volatile uint8_t F0R7;
      volatile uint8_t F0R8;

      volatile uint8_t F1R1;
      volatile uint8_t F1R2;
      volatile uint8_t F1R3;
      volatile uint8_t F1R4;
      volatile uint8_t F1R5;
      volatile uint8_t F1R6;
      volatile uint8_t F1R7;
      volatile uint8_t F1R8;
    }Filter01;
    
    struct
    {
      volatile uint8_t F2R1;
      volatile uint8_t F2R2;
      volatile uint8_t F2R3;
      volatile uint8_t F2R4;
      volatile uint8_t F2R5;
      volatile uint8_t F2R6;
      volatile uint8_t F2R7;
      volatile uint8_t F2R8;
	
      volatile uint8_t F3R1;
      volatile uint8_t F3R2;
      volatile uint8_t F3R3;
      volatile uint8_t F3R4;
      volatile uint8_t F3R5;
      volatile uint8_t F3R6;
      volatile uint8_t F3R7;
      volatile uint8_t F3R8;
    }Filter23;
    
    struct
    {
      volatile uint8_t F4R1;
      volatile uint8_t F4R2;
      volatile uint8_t F4R3;
      volatile uint8_t F4R4;
      volatile uint8_t F4R5;
      volatile uint8_t F4R6;
      volatile uint8_t F4R7;
      volatile uint8_t F4R8;
			
      volatile uint8_t F5R1;
      volatile uint8_t F5R2;
      volatile uint8_t F5R3;
      volatile uint8_t F5R4;
      volatile uint8_t F5R5;
      volatile uint8_t F5R6;
      volatile uint8_t F5R7;
      volatile uint8_t F5R8;
    } Filter45;
    
    struct
    {
      volatile uint8_t ESR;
      volatile uint8_t EIER;
      volatile uint8_t TECR;
      volatile uint8_t RECR;
      volatile uint8_t BTR1;
      volatile uint8_t BTR2;
      uint8_t Reserved1[2];
      volatile uint8_t FMR1;
      volatile uint8_t FMR2;
      volatile uint8_t FCR1;
      volatile uint8_t FCR2;
      volatile uint8_t FCR3;
      uint8_t Reserved2[3];
    }Config;
    
    struct
    {
      volatile uint8_t MFMI;
      volatile uint8_t MDLCR;
      volatile uint8_t MIDR1;
      volatile uint8_t MIDR2;
      volatile uint8_t MIDR3;
      volatile uint8_t MIDR4;
      volatile uint8_t MDAR1;
      volatile uint8_t MDAR2;
      volatile uint8_t MDAR3;
      volatile uint8_t MDAR4;
      volatile uint8_t MDAR5;
      volatile uint8_t MDAR6;
      volatile uint8_t MDAR7;
      volatile uint8_t MDAR8;
      volatile uint8_t MTSRL;
      volatile uint8_t MTSRH;
    }RxFIFO;
  }Page; 
} CAN_TypeDef;

/** @addtogroup CAN_Registers_Bits_Definition
  * @{
  */
/******************************* Common ***************************************/
/* CAN Master Control Register bits */
#line 2343 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* CAN Master Status Register bits */
#line 2351 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* CAN Transmit Status Register bits */
#line 2360 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 2368 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/* CAN Receive FIFO Register bits */





/* CAN Interrupt Register bits */







/* CAN diagnostic Register bits */







/* CAN page select Register bits */




/******************** Tx MailBox & Fifo Page common bits **********************/
#line 2402 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"








/************************* Filter Page ****************************************/

/* CAN Error Status Register bits */
#line 2420 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* CAN Error Status Register bits */






/* CAN transmit error counter Register bits(CAN_TECR) */
#line 2437 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* CAN RECEIVE error counter Register bits(CAN_TECR) */
#line 2447 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/* CAN filter mode register bits (CAN_FMR) */
#line 2457 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"






/* CAN filter Config register bits (CAN_FCR) */
#line 2470 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 2483 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/** @addtogroup CAN_Registers_Reset_Value
  * @{
  */
#line 2499 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

#line 2509 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"





/**
  * @}
  */

/**
  * @brief  Configuration Registers (CFG)
  */

typedef struct CFG_struct
{
  volatile uint8_t GCR; /*!< Global Configuration register */
}
CFG_TypeDef;

/** @addtogroup CFG_Registers_Reset_Value
  * @{
  */



/**
  * @}
  */

/** @addtogroup CFG_Registers_Bits_Definition
  * @{
  */




/**
  * @}
  */

/******************************************************************************/
/*                          Peripherals Base Address                          */
/******************************************************************************/

/** @addtogroup MAP_FILE_Base_Addresses
  * @{
  */
#line 2592 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/******************************************************************************/
/*                          Peripherals declarations                          */
/******************************************************************************/











































































































#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"



/* Includes ------------------------------------------------------------------*/
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
/**
  ******************************************************************************
  * @file    stm8s.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all HW registers definitions and memory mapping.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#line 2829 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 6 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"

/* Uncomment the line below to enable peripheral header file inclusion */
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_adc1.h"
/**
  ******************************************************************************
  * @file    stm8s_adc1.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all the prototypes/macros for the ADC1 peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported types ------------------------------------------------------------*/

/** @addtogroup ADC1_Exported_Types
  * @{
  */

/**
  * @brief  ADC1 clock prescaler selection
  */

typedef enum 
{
  ADC1_PRESSEL_FCPU_D2  = (uint8_t)0x00, /**< Prescaler selection fADC1 = fcpu/2 */
  ADC1_PRESSEL_FCPU_D3  = (uint8_t)0x10, /**< Prescaler selection fADC1 = fcpu/3 */
  ADC1_PRESSEL_FCPU_D4  = (uint8_t)0x20, /**< Prescaler selection fADC1 = fcpu/4 */
  ADC1_PRESSEL_FCPU_D6  = (uint8_t)0x30, /**< Prescaler selection fADC1 = fcpu/6 */
  ADC1_PRESSEL_FCPU_D8  = (uint8_t)0x40, /**< Prescaler selection fADC1 = fcpu/8 */
  ADC1_PRESSEL_FCPU_D10 = (uint8_t)0x50, /**< Prescaler selection fADC1 = fcpu/10 */
  ADC1_PRESSEL_FCPU_D12 = (uint8_t)0x60, /**< Prescaler selection fADC1 = fcpu/12 */
  ADC1_PRESSEL_FCPU_D18 = (uint8_t)0x70  /**< Prescaler selection fADC1 = fcpu/18 */
} ADC1_PresSel_TypeDef;

/**
  * @brief   ADC1 External conversion trigger event selection
  */
typedef enum 
{
  ADC1_EXTTRIG_TIM   = (uint8_t)0x00, /**< Conversion from Internal TIM1 TRGO event */
  ADC1_EXTTRIG_GPIO  = (uint8_t)0x10  /**< Conversion from External interrupt on ADC_ETR pin*/
} ADC1_ExtTrig_TypeDef;

/**
  * @brief  ADC1 data alignment
  */
typedef enum 
{
  ADC1_ALIGN_LEFT  = (uint8_t)0x00, /**< Data alignment left */
  ADC1_ALIGN_RIGHT = (uint8_t)0x08  /**< Data alignment right */
} ADC1_Align_TypeDef;

/**
  * @brief  ADC1 Interrupt source
  */
typedef enum 
{
  ADC1_IT_AWDIE = (uint16_t)0x010, /**< Analog WDG interrupt enable */
  ADC1_IT_EOCIE = (uint16_t)0x020, /**< EOC interrupt enable */
  ADC1_IT_AWD   = (uint16_t)0x140, /**< Analog WDG status */
  ADC1_IT_AWS0  = (uint16_t)0x110, /**< Analog channel 0 status */
  ADC1_IT_AWS1  = (uint16_t)0x111, /**< Analog channel 1 status */
  ADC1_IT_AWS2  = (uint16_t)0x112, /**< Analog channel 2 status */
  ADC1_IT_AWS3  = (uint16_t)0x113, /**< Analog channel 3 status */
  ADC1_IT_AWS4  = (uint16_t)0x114, /**< Analog channel 4 status */
  ADC1_IT_AWS5  = (uint16_t)0x115, /**< Analog channel 5 status */
  ADC1_IT_AWS6  = (uint16_t)0x116, /**< Analog channel 6 status */
  ADC1_IT_AWS7  = (uint16_t)0x117, /**< Analog channel 7 status */
  ADC1_IT_AWS8  = (uint16_t)0x118, /**< Analog channel 8 status */
  ADC1_IT_AWS9  = (uint16_t)0x119, /**< Analog channel 9 status */
  ADC1_IT_AWS12 = (uint16_t)0x11C, /**< Analog channel 12 status */
                                   /* refer to product datasheet for channel 12 availability */
  ADC1_IT_EOC   = (uint16_t)0x080  /**< EOC pending bit */

} ADC1_IT_TypeDef;

/**
  * @brief  ADC1 Flags
  */
typedef enum 
{
  ADC1_FLAG_OVR   = (uint8_t)0x41, /**< Overrun status flag */
  ADC1_FLAG_AWD   = (uint8_t)0x40, /**< Analog WDG status */
  ADC1_FLAG_AWS0  = (uint8_t)0x10, /**< Analog channel 0 status */
  ADC1_FLAG_AWS1  = (uint8_t)0x11, /**< Analog channel 1 status */
  ADC1_FLAG_AWS2  = (uint8_t)0x12, /**< Analog channel 2 status */
  ADC1_FLAG_AWS3  = (uint8_t)0x13, /**< Analog channel 3 status */
  ADC1_FLAG_AWS4  = (uint8_t)0x14, /**< Analog channel 4 status */
  ADC1_FLAG_AWS5  = (uint8_t)0x15, /**< Analog channel 5 status */
  ADC1_FLAG_AWS6  = (uint8_t)0x16, /**< Analog channel 6 status */
  ADC1_FLAG_AWS7  = (uint8_t)0x17, /**< Analog channel 7 status */
  ADC1_FLAG_AWS8  = (uint8_t)0x18, /**< Analog channel 8  status*/
  ADC1_FLAG_AWS9  = (uint8_t)0x19, /**< Analog channel 9 status */
  ADC1_FLAG_AWS12 = (uint8_t)0x1C, /**< Analog channel 12 status */
                                  /* refer to product datasheet for channel 12 availability */
  ADC1_FLAG_EOC   = (uint8_t)0x80  /**< EOC falg */
}ADC1_Flag_TypeDef;


/**
  * @brief  ADC1 schmitt Trigger
  */
typedef enum 
{
  ADC1_SCHMITTTRIG_CHANNEL0  = (uint8_t)0x00, /**< Schmitt trigger disable on AIN0 */
  ADC1_SCHMITTTRIG_CHANNEL1  = (uint8_t)0x01, /**< Schmitt trigger disable on AIN1 */
  ADC1_SCHMITTTRIG_CHANNEL2  = (uint8_t)0x02, /**< Schmitt trigger disable on AIN2 */
  ADC1_SCHMITTTRIG_CHANNEL3  = (uint8_t)0x03, /**< Schmitt trigger disable on AIN3 */
  ADC1_SCHMITTTRIG_CHANNEL4  = (uint8_t)0x04, /**< Schmitt trigger disable on AIN4 */
  ADC1_SCHMITTTRIG_CHANNEL5  = (uint8_t)0x05, /**< Schmitt trigger disable on AIN5 */
  ADC1_SCHMITTTRIG_CHANNEL6  = (uint8_t)0x06, /**< Schmitt trigger disable on AIN6 */
  ADC1_SCHMITTTRIG_CHANNEL7  = (uint8_t)0x07, /**< Schmitt trigger disable on AIN7 */
  ADC1_SCHMITTTRIG_CHANNEL8  = (uint8_t)0x08, /**< Schmitt trigger disable on AIN8 */
  ADC1_SCHMITTTRIG_CHANNEL9  = (uint8_t)0x09, /**< Schmitt trigger disable on AIN9 */
  ADC1_SCHMITTTRIG_CHANNEL12 = (uint8_t)0x0C, /**< Schmitt trigger disable on AIN12 */  
                                              /* refer to product datasheet for channel 12 availability */ 
  ADC1_SCHMITTTRIG_ALL       = (uint8_t)0xFF /**< Schmitt trigger disable on All channels */ 
} ADC1_SchmittTrigg_TypeDef;

/**
  * @brief  ADC1 conversion mode selection
  */

typedef enum 
{
  ADC1_CONVERSIONMODE_SINGLE     = (uint8_t)0x00, /**< Single conversion mode */
  ADC1_CONVERSIONMODE_CONTINUOUS = (uint8_t)0x01  /**< Continuous conversion mode */
} ADC1_ConvMode_TypeDef;

/**
  * @brief  ADC1 analog channel selection
  */

typedef enum 
{
  ADC1_CHANNEL_0  = (uint8_t)0x00, /**< Analog channel 0 */
  ADC1_CHANNEL_1  = (uint8_t)0x01, /**< Analog channel 1 */
  ADC1_CHANNEL_2  = (uint8_t)0x02, /**< Analog channel 2 */
  ADC1_CHANNEL_3  = (uint8_t)0x03, /**< Analog channel 3 */
  ADC1_CHANNEL_4  = (uint8_t)0x04, /**< Analog channel 4 */
  ADC1_CHANNEL_5  = (uint8_t)0x05, /**< Analog channel 5 */
  ADC1_CHANNEL_6  = (uint8_t)0x06, /**< Analog channel 6 */
  ADC1_CHANNEL_7  = (uint8_t)0x07, /**< Analog channel 7 */
  ADC1_CHANNEL_8  = (uint8_t)0x08, /**< Analog channel 8 */
  ADC1_CHANNEL_9  = (uint8_t)0x09, /**< Analog channel 9 */
  ADC1_CHANNEL_12 = (uint8_t)0x0C /**< Analog channel 12 */ 
                 /* refer to product datasheet for channel 12 availability */
} ADC1_Channel_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup ADC1_Private_Macros
  * @brief  Macros used by the assert function to check the different functions parameters.
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different prescaler's values.
  */
#line 197 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_adc1.h"

/**
  * @brief  Macro used by the assert function to check the different external trigger values.
  */



/**
  * @brief  Macro used by the assert function to check the different alignment modes.
  */



/**
  * @brief  Macro used by the assert function to check the Interrupt source.
  */



/**
  * @brief  Macro used by the assert function to check the ADC1 Flag.
  */
#line 232 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_adc1.h"

/**
  * @brief  Macro used by the assert function to check the ADC1 pending bits.
  */
#line 249 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_adc1.h"

/**
  * @brief  Macro used by the assert function to check the different schmitt trigger values.
  */
#line 265 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_adc1.h"

/**
  * @brief  Macro used by the assert function to check the different conversion modes.
  */



/**
  * @brief  Macro used by the assert function to check the different channels values.
  */
#line 286 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_adc1.h"

/**
  * @brief  Macro used by the assert function to check the possible buffer values.
  */


/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup ADC1_Exported_Functions
  * @{
  */
void ADC1_DeInit(void);
void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, 
               ADC1_Channel_TypeDef ADC1_Channel,
               ADC1_PresSel_TypeDef ADC1_PrescalerSelection, 
               ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, 
               FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, 
               ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, 
               FunctionalState ADC1_SchmittTriggerState);
void ADC1_Cmd(FunctionalState NewState);
void ADC1_ScanModeCmd(FunctionalState NewState);
void ADC1_DataBufferCmd(FunctionalState NewState);
void ADC1_ITConfig(ADC1_IT_TypeDef ADC1_IT, FunctionalState NewState);
void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler);
void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel,
                              FunctionalState NewState);
void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, 
                           ADC1_Channel_TypeDef ADC1_Channel, 
                           ADC1_Align_TypeDef ADC1_Align);
void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState);
void ADC1_AWDChannelConfig(ADC1_Channel_TypeDef Channel, FunctionalState NewState);
void ADC1_StartConversion(void);
uint16_t ADC1_GetConversionValue(void);
void ADC1_SetHighThreshold(uint16_t Threshold);
void ADC1_SetLowThreshold(uint16_t Threshold);
uint16_t ADC1_GetBufferValue(uint8_t Buffer);
FlagStatus ADC1_GetAWDChannelStatus(ADC1_Channel_TypeDef Channel);
FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag);
void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag);
ITStatus ADC1_GetITStatus(ADC1_IT_TypeDef ITPendingBit);
void ADC1_ClearITPendingBit(ADC1_IT_TypeDef ITPendingBit);
/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 11 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_awu.h"
/**
  ******************************************************************************
  * @file    stm8s_awu.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the AWU peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported types ------------------------------------------------------------*/

/** @addtogroup AWU_Exported_Types
  * @{
  */

/**
  * @brief  AWU TimeBase selection
  */

typedef enum
{
  AWU_TIMEBASE_NO_IT  = (uint8_t)0,    /*!< No AWU interrupt selected */
  AWU_TIMEBASE_250US  = (uint8_t)1,    /*!< AWU Timebase equals 0.25 ms */
  AWU_TIMEBASE_500US  = (uint8_t)2,    /*!< AWU Timebase equals 0.5 ms */
  AWU_TIMEBASE_1MS    = (uint8_t)3,    /*!< AWU Timebase equals 1 ms */
  AWU_TIMEBASE_2MS    = (uint8_t)4,    /*!< AWU Timebase equals 2 ms */
  AWU_TIMEBASE_4MS    = (uint8_t)5,    /*!< AWU Timebase equals 4 ms */
  AWU_TIMEBASE_8MS    = (uint8_t)6,    /*!< AWU Timebase equals 8 ms */
  AWU_TIMEBASE_16MS   = (uint8_t)7,    /*!< AWU Timebase equals 16 ms */
  AWU_TIMEBASE_32MS   = (uint8_t)8,    /*!< AWU Timebase equals 32 ms */
  AWU_TIMEBASE_64MS   = (uint8_t)9,    /*!< AWU Timebase equals 64 ms */
  AWU_TIMEBASE_128MS  = (uint8_t)10,   /*!< AWU Timebase equals 128 ms */
  AWU_TIMEBASE_256MS  = (uint8_t)11,   /*!< AWU Timebase equals 256 ms */
  AWU_TIMEBASE_512MS  = (uint8_t)12,   /*!< AWU Timebase equals 512 ms */
  AWU_TIMEBASE_1S     = (uint8_t)13,   /*!< AWU Timebase equals 1 s */
  AWU_TIMEBASE_2S     = (uint8_t)14,   /*!< AWU Timebase equals 2 s */
  AWU_TIMEBASE_12S    = (uint8_t)15,   /*!< AWU Timebase equals 12 s */
  AWU_TIMEBASE_30S    = (uint8_t)16    /*!< AWU Timebase equals 30 s */
} AWU_Timebase_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @addtogroup AWU_Exported_Constants
  * @{
  */




/**
  * @}
  */

/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup AWU_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different functions parameters.
  */

/**
  * @brief   Macro used by the assert function to check the AWU timebases
  */
#line 116 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_awu.h"

/**
  * @brief    Macro used by the assert function to check the LSI frequency (in Hz)
  */




/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup AWU_Exported_Functions
  * @{
  */
void AWU_DeInit(void);
void AWU_Init(AWU_Timebase_TypeDef AWU_TimeBase);
void AWU_Cmd(FunctionalState NewState);
void AWU_LSICalibrationConfig(uint32_t LSIFreqHz);
void AWU_IdleModeEnable(void);
FlagStatus AWU_GetFlagStatus(void);

/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 17 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_beep.h"
/**
  ******************************************************************************
  * @file    stm8s_beep.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the BEEP peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */


/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported types ------------------------------------------------------------*/

/** @addtogroup BEEP_Exported_Types
  * @{
  */

/**
  * @brief  BEEP Frequency selection
  */
typedef enum {
  BEEP_FREQUENCY_1KHZ = (uint8_t)0x00,  /*!< Beep signal output frequency equals to 1 KHz */
  BEEP_FREQUENCY_2KHZ = (uint8_t)0x40,  /*!< Beep signal output frequency equals to 2 KHz */
  BEEP_FREQUENCY_4KHZ = (uint8_t)0x80   /*!< Beep signal output frequency equals to 4 KHz */
} BEEP_Frequency_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @addtogroup BEEP_Exported_Constants
  * @{
  */






/**
  * @}
  */

/* Exported macros -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/

/** @addtogroup BEEP_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different functions parameters.
  */

/**
  * @brief  Macro used by the assert function to check the BEEP frequencies.
  */





/**
  * @brief   Macro used by the assert function to check the LSI frequency (in Hz).
  */




/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup BEEP_Exported_Functions
  * @{
  */

void BEEP_DeInit(void);
void BEEP_Init(BEEP_Frequency_TypeDef BEEP_Frequency);
void BEEP_Cmd(FunctionalState NewState);
void BEEP_LSICalibrationConfig(uint32_t LSIFreqHz);


/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 18 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_clk.h"
/**
  ******************************************************************************
  * @file    stm8s_clk.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the CLK peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */


/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/
/* Contains the description of all STM8 hardware registers */


/* Exported types ------------------------------------------------------------*/
/** @addtogroup CLK_Exported_Types
  * @{
  */

/**
   * @brief  Switch Mode Auto, Manual.
   */
typedef enum {
  CLK_SWITCHMODE_MANUAL = (uint8_t)0x00, /*!< Enable the manual clock switching mode */
  CLK_SWITCHMODE_AUTO   = (uint8_t)0x01  /*!< Enable the automatic clock switching mode */
} CLK_SwitchMode_TypeDef;

/**
   * @brief  Current Clock State.
   */
typedef enum {
  CLK_CURRENTCLOCKSTATE_DISABLE = (uint8_t)0x00, /*!< Current clock disable */
  CLK_CURRENTCLOCKSTATE_ENABLE  = (uint8_t)0x01  /*!< Current clock enable */
} CLK_CurrentClockState_TypeDef;

/**
   * @brief   Clock security system configuration.
   */
typedef enum {
  CLK_CSSCONFIG_ENABLEWITHIT = (uint8_t)0x05, /*!< Enable CSS with detection interrupt */
  CLK_CSSCONFIG_ENABLE    = (uint8_t)0x01, /*!< Enable CSS without detection interrupt */
  CLK_CSSCONFIG_DISABLE      = (uint8_t)0x00  /*!< Leave CSS desactivated (to be used in CLK_Init() function) */
} CLK_CSSConfig_TypeDef;

/**
   * @brief   CLK Clock Source.
   */
typedef enum {
  CLK_SOURCE_HSI    = (uint8_t)0xE1, /*!< Clock Source HSI. */
  CLK_SOURCE_LSI    = (uint8_t)0xD2, /*!< Clock Source LSI. */
  CLK_SOURCE_HSE    = (uint8_t)0xB4 /*!< Clock Source HSE. */
} CLK_Source_TypeDef;

/**
   * @brief   CLK HSI Calibration Value.
   */
typedef enum {
  CLK_HSITRIMVALUE_0   = (uint8_t)0x00, /*!< HSI Calibration Value 0 */
  CLK_HSITRIMVALUE_1   = (uint8_t)0x01, /*!< HSI Calibration Value 1 */
  CLK_HSITRIMVALUE_2   = (uint8_t)0x02, /*!< HSI Calibration Value 2 */
  CLK_HSITRIMVALUE_3   = (uint8_t)0x03, /*!< HSI Calibration Value 3 */
  CLK_HSITRIMVALUE_4   = (uint8_t)0x04, /*!< HSI Calibration Value 4 */
  CLK_HSITRIMVALUE_5   = (uint8_t)0x05, /*!< HSI Calibration Value 5 */
  CLK_HSITRIMVALUE_6   = (uint8_t)0x06, /*!< HSI Calibration Value 6 */
  CLK_HSITRIMVALUE_7   = (uint8_t)0x07  /*!< HSI Calibration Value 7 */
} CLK_HSITrimValue_TypeDef;

/**
   * @brief    CLK  Clock Output
   */
typedef enum {
  CLK_OUTPUT_HSI      = (uint8_t)0x00, /*!< Clock Output HSI */
  CLK_OUTPUT_LSI      = (uint8_t)0x02, /*!< Clock Output LSI */
  CLK_OUTPUT_HSE      = (uint8_t)0x04, /*!< Clock Output HSE */
  CLK_OUTPUT_CPU      = (uint8_t)0x08, /*!< Clock Output CPU */
  CLK_OUTPUT_CPUDIV2  = (uint8_t)0x0A, /*!< Clock Output CPU/2 */
  CLK_OUTPUT_CPUDIV4  = (uint8_t)0x0C, /*!< Clock Output CPU/4 */
  CLK_OUTPUT_CPUDIV8  = (uint8_t)0x0E, /*!< Clock Output CPU/8 */
  CLK_OUTPUT_CPUDIV16 = (uint8_t)0x10, /*!< Clock Output CPU/16 */
  CLK_OUTPUT_CPUDIV32 = (uint8_t)0x12, /*!< Clock Output CPU/32 */
  CLK_OUTPUT_CPUDIV64 = (uint8_t)0x14, /*!< Clock Output CPU/64 */
  CLK_OUTPUT_HSIRC    = (uint8_t)0x16, /*!< Clock Output HSI RC */
  CLK_OUTPUT_MASTER   = (uint8_t)0x18, /*!< Clock Output Master */
  CLK_OUTPUT_OTHERS   = (uint8_t)0x1A  /*!< Clock Output OTHER */
} CLK_Output_TypeDef;

/**
   * @brief    CLK Enable peripheral
   */
/* Elements values convention: 0xXY
    X = choice between the peripheral registers
        X = 0 : PCKENR1
        X = 1 : PCKENR2
    Y = Peripheral position in the register
*/
typedef enum {
  CLK_PERIPHERAL_I2C     = (uint8_t)0x00, /*!< Peripheral Clock Enable 1, I2C */
  CLK_PERIPHERAL_SPI     = (uint8_t)0x01, /*!< Peripheral Clock Enable 1, SPI */



  CLK_PERIPHERAL_UART1   = (uint8_t)0x03, /*!< Peripheral Clock Enable 1, UART1 */

  CLK_PERIPHERAL_UART2   = (uint8_t)0x03, /*!< Peripheral Clock Enable 1, UART2 */
  CLK_PERIPHERAL_UART3   = (uint8_t)0x03, /*!< Peripheral Clock Enable 1, UART3 */
  CLK_PERIPHERAL_TIMER6  = (uint8_t)0x04, /*!< Peripheral Clock Enable 1, Timer6 */
  CLK_PERIPHERAL_TIMER4  = (uint8_t)0x04, /*!< Peripheral Clock Enable 1, Timer4 */
  CLK_PERIPHERAL_TIMER5  = (uint8_t)0x05, /*!< Peripheral Clock Enable 1, Timer5 */
  CLK_PERIPHERAL_TIMER2  = (uint8_t)0x05, /*!< Peripheral Clock Enable 1, Timer2 */
  CLK_PERIPHERAL_TIMER3  = (uint8_t)0x06, /*!< Peripheral Clock Enable 1, Timer3 */
  CLK_PERIPHERAL_TIMER1  = (uint8_t)0x07, /*!< Peripheral Clock Enable 1, Timer1 */
  CLK_PERIPHERAL_AWU     = (uint8_t)0x12, /*!< Peripheral Clock Enable 2, AWU */
  CLK_PERIPHERAL_ADC     = (uint8_t)0x13, /*!< Peripheral Clock Enable 2, ADC */
  CLK_PERIPHERAL_CAN     = (uint8_t)0x17 /*!< Peripheral Clock Enable 2, CAN */
} CLK_Peripheral_TypeDef;

/**
   * @brief   CLK Flags.
   */
/* Elements values convention: 0xXZZ
    X = choice between the flags registers
        X = 1 : ICKR
        X = 2 : ECKR
        X = 3 : SWCR
    X = 4 : CSSR
 X = 5 : CCOR
   ZZ = flag mask in the register (same as map file)
*/
typedef enum {
  CLK_FLAG_LSIRDY  = (uint16_t)0x0110, /*!< Low speed internal oscillator ready Flag */
  CLK_FLAG_HSIRDY  = (uint16_t)0x0102, /*!< High speed internal oscillator ready Flag */
  CLK_FLAG_HSERDY  = (uint16_t)0x0202, /*!< High speed external oscillator ready Flag */
  CLK_FLAG_SWIF    = (uint16_t)0x0308, /*!< Clock switch interrupt Flag */
  CLK_FLAG_SWBSY   = (uint16_t)0x0301, /*!< Switch busy Flag */
  CLK_FLAG_CSSD    = (uint16_t)0x0408, /*!< Clock security system detection Flag */
  CLK_FLAG_AUX     = (uint16_t)0x0402, /*!< Auxiliary oscillator connected to master clock */
  CLK_FLAG_CCOBSY  = (uint16_t)0x0504, /*!< Configurable clock output busy */
  CLK_FLAG_CCORDY  = (uint16_t)0x0502 /*!< Configurable clock output ready */
}CLK_Flag_TypeDef;

/**
   * @brief  CLK interrupt configuration and Flags cleared by software.
   */
typedef enum {
  CLK_IT_CSSD = (uint8_t)0x0C, /*!< Clock security system detection Flag */
  CLK_IT_SWIF = (uint8_t)0x1C /*!< Clock switch interrupt Flag */
}CLK_IT_TypeDef;

/**
   * @brief   CLK Clock Divisor.
   */

/* Warning:
   0xxxxxx = HSI divider
   1xxxxxx = CPU divider
   Other bits correspond to the divider's bits mapping
*/
typedef enum {
  CLK_PRESCALER_HSIDIV1   = (uint8_t)0x00, /*!< High speed internal clock prescaler: 1 */
  CLK_PRESCALER_HSIDIV2   = (uint8_t)0x08, /*!< High speed internal clock prescaler: 2 */
  CLK_PRESCALER_HSIDIV4   = (uint8_t)0x10, /*!< High speed internal clock prescaler: 4 */
  CLK_PRESCALER_HSIDIV8   = (uint8_t)0x18, /*!< High speed internal clock prescaler: 8 */
  CLK_PRESCALER_CPUDIV1   = (uint8_t)0x80, /*!< CPU clock division factors 1 */
  CLK_PRESCALER_CPUDIV2   = (uint8_t)0x81, /*!< CPU clock division factors 2 */
  CLK_PRESCALER_CPUDIV4   = (uint8_t)0x82, /*!< CPU clock division factors 4 */
  CLK_PRESCALER_CPUDIV8   = (uint8_t)0x83, /*!< CPU clock division factors 8 */
  CLK_PRESCALER_CPUDIV16  = (uint8_t)0x84, /*!< CPU clock division factors 16 */
  CLK_PRESCALER_CPUDIV32  = (uint8_t)0x85, /*!< CPU clock division factors 32 */
  CLK_PRESCALER_CPUDIV64  = (uint8_t)0x86, /*!< CPU clock division factors 64 */
  CLK_PRESCALER_CPUDIV128 = (uint8_t)0x87  /*!< CPU clock division factors 128 */
} CLK_Prescaler_TypeDef;

/**
   * @brief   SWIM Clock divider.
   */
typedef enum {
  CLK_SWIMDIVIDER_2 = (uint8_t)0x00, /*!< SWIM clock is divided by 2 */
  CLK_SWIMDIVIDER_OTHER = (uint8_t)0x01 /*!< SWIM clock is not divided by 2 */
}CLK_SWIMDivider_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @addtogroup CLK_Exported_Constants
  * @{
  */

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/
/** @addtogroup CLK_Private_Macros
  * @{
  */

/**
  * @brief  Macros used by the assert function in order to check the different functions parameters.
  */

/**
  * @brief  Macros used by the assert function in order to check the clock switching modes.
  */


/**
  * @brief  Macros used by the assert function in order to check the current clock state.
  */



/**
  * @brief  Macros used by the assert function in order to check the CSS configuration.
  */




/**
  * @brief  Macros used by the assert function in order to check the different clock sources.
  */




/**
  * @brief  Macros used by the assert function in order to check the different HSI trimming values.
  */
#line 262 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_clk.h"

/**
  * @brief  Macros used by the assert function in order to check the different clocks to output.
  */
#line 279 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_clk.h"

/**
  * @brief  Macros used by the assert function in order to check the different peripheral's clock.
  */
#line 297 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_clk.h"

/**
  * @brief  Macros used by the assert function in order to check the different clock flags.
  */
#line 310 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_clk.h"

/**
  * @brief  Macros used by the assert function in order to check the different clock IT pending bits.
  */


/**
  * @brief  Macros used by the assert function in order to check the different HSI prescaler values.
  */





/**
  * @brief  Macros used by the assert function in order to check the different clock  prescaler values.
  */
#line 339 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_clk.h"

/**
  * @brief  Macros used by the assert function in order to check the different SWIM dividers values.
  */


/**
  * @}
  */

/** @addtogroup CLK_Exported_functions
  * @{
  */
void CLK_DeInit(void);
void CLK_HSECmd(FunctionalState NewState);
void CLK_HSICmd(FunctionalState NewState);
void CLK_LSICmd(FunctionalState NewState);
void CLK_CCOCmd(FunctionalState NewState);
void CLK_ClockSwitchCmd(FunctionalState NewState);
void CLK_FastHaltWakeUpCmd(FunctionalState NewState);
void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState);
void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState);
ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState);
void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler);
void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO);
void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState);
void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler);
void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider);
void CLK_ClockSecuritySystemEnable(void);
void CLK_SYSCLKEmergencyClear(void);
void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue);
uint32_t CLK_GetClockFreq(void);
CLK_Source_TypeDef CLK_GetSYSCLKSource(void);
FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG);
ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT);
void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT);

/**
  * @}
  */



/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 22 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_exti.h"
/**
  ******************************************************************************
  * @file    stm8s_exti.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the EXTI peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported types ------------------------------------------------------------*/

/** @addtogroup EXTI_Exported_Types
  * @{
  */

/**
  * @brief  EXTI Sensitivity values for PORTA to PORTE
  */
typedef enum {
  EXTI_SENSITIVITY_FALL_LOW  = (uint8_t)0x00, /*!< Interrupt on Falling edge and Low level */
  EXTI_SENSITIVITY_RISE_ONLY = (uint8_t)0x01, /*!< Interrupt on Rising edge only */
  EXTI_SENSITIVITY_FALL_ONLY = (uint8_t)0x02, /*!< Interrupt on Falling edge only */
  EXTI_SENSITIVITY_RISE_FALL = (uint8_t)0x03  /*!< Interrupt on Rising and Falling edges */
} EXTI_Sensitivity_TypeDef;

/**
  * @brief  EXTI Sensitivity values for TLI
  */
typedef enum {
  EXTI_TLISENSITIVITY_FALL_ONLY = (uint8_t)0x00, /*!< Top Level Interrupt on Falling edge only */
  EXTI_TLISENSITIVITY_RISE_ONLY = (uint8_t)0x04  /*!< Top Level Interrupt on Rising edge only */
} EXTI_TLISensitivity_TypeDef;

/**
  * @brief  EXTI PortNum possible values
  */
typedef enum {
  EXTI_PORT_GPIOA = (uint8_t)0x00, /*!< GPIO Port A */
  EXTI_PORT_GPIOB = (uint8_t)0x01, /*!< GPIO Port B */
  EXTI_PORT_GPIOC = (uint8_t)0x02, /*!< GPIO Port C */
  EXTI_PORT_GPIOD = (uint8_t)0x03, /*!< GPIO Port D */
  EXTI_PORT_GPIOE = (uint8_t)0x04  /*!< GPIO Port E */
} EXTI_Port_TypeDef;

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/

/** @addtogroup EXTI_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for PORTA to PORTE.
  */






/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for TLI.
  */




/**
  * @brief  Macro used by the assert function in order to check the different Port values
  */
#line 105 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_exti.h"

/**
  * @brief  Macro used by the assert function in order to check the different values of the EXTI PinMask
  */


/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup EXTI_Exported_Functions
  * @{
  */

void EXTI_DeInit(void);
void EXTI_SetExtIntSensitivity(EXTI_Port_TypeDef Port, EXTI_Sensitivity_TypeDef SensitivityValue);
void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue);
EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_Port_TypeDef Port);
EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void);

/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 23 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_flash.h"
/**
  ******************************************************************************
  * @file    stm8s_flash.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the FLASH peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported constants --------------------------------------------------------*/

/** @addtogroup FLASH_Exported_Constants
  * @{
  */



#line 51 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_flash.h"

#line 60 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_flash.h"

#line 69 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_flash.h"








/**
  * @}
  */

/* Exported types ------------------------------------------------------------*/

/** @addtogroup FLASH_Exported_Types
  * @{
  */

/**
  * @brief  FLASH Memory types
  */
typedef enum {
    FLASH_MEMTYPE_PROG      = (uint8_t)0xFD, /*!< Program memory */
    FLASH_MEMTYPE_DATA      = (uint8_t)0xF7  /*!< Data EEPROM memory */
} FLASH_MemType_TypeDef;

/**
  * @brief  FLASH programming modes
  */
typedef enum {
    FLASH_PROGRAMMODE_STANDARD = (uint8_t)0x00, /*!< Standard programming mode */
    FLASH_PROGRAMMODE_FAST     = (uint8_t)0x10  /*!< Fast programming mode */
} FLASH_ProgramMode_TypeDef;

/**
  * @brief  FLASH fixed programming time
  */
typedef enum {
    FLASH_PROGRAMTIME_STANDARD = (uint8_t)0x00, /*!< Standard programming time fixed at 1/2 tprog */
    FLASH_PROGRAMTIME_TPROG    = (uint8_t)0x01  /*!< Programming time fixed at tprog */
} FLASH_ProgramTime_TypeDef;

/**
  * @brief  FLASH Low Power mode select
  */
typedef enum {
    FLASH_LPMODE_POWERDOWN         = (uint8_t)0x04, /*!< HALT: Power-Down / ACTIVE-HALT: Power-Down */
    FLASH_LPMODE_STANDBY           = (uint8_t)0x08, /*!< HALT: Standby    / ACTIVE-HALT: Standby */
    FLASH_LPMODE_POWERDOWN_STANDBY = (uint8_t)0x00, /*!< HALT: Power-Down / ACTIVE-HALT: Standby */
    FLASH_LPMODE_STANDBY_POWERDOWN = (uint8_t)0x0C  /*!< HALT: Standby    / ACTIVE-HALT: Power-Down */
}
FLASH_LPMode_TypeDef;

/**
  * @brief  FLASH status of the last operation
  */
typedef enum {




		FLASH_STATUS_SUCCESSFUL_OPERATION       = (uint8_t)0x04, /*!< End of operation flag */
		FLASH_STATUS_TIMEOUT = (uint8_t)0x02, /*!< Time out error */
    FLASH_STATUS_WRITE_PROTECTION_ERROR     = (uint8_t)0x01 /*!< Write attempted to protected page */
} FLASH_Status_TypeDef;

/**
  * @brief  FLASH flags definition
 * - Warning : FLAG value = mapping position register
  */
typedef enum {




    FLASH_FLAG_DUL       = (uint8_t)0x08,     /*!< Data EEPROM unlocked flag */
    FLASH_FLAG_EOP       = (uint8_t)0x04,     /*!< End of programming (write or erase operation) flag */
    FLASH_FLAG_PUL       = (uint8_t)0x02,     /*!< Flash Program memory unlocked flag */
    FLASH_FLAG_WR_PG_DIS = (uint8_t)0x01      /*!< Write attempted to protected page flag */
} FLASH_Flag_TypeDef;

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/

/**
  * @brief  Macros used by the assert function in order to check the different functions parameters.
  * @addtogroup FLASH_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the flash program Address
  */




/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the data eeprom Address
  */




/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the data eeprom and flash program Address
  */



/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the flash program Block number
  */


/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the data eeprom Block number
  */


/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the flash memory type
  */




/**
  * @brief  Macro used by the assert function in order to check the different sensitivity values for the flash program mode
  */




/**
  * @brief  Macro used by the assert function in order to check the program time mode
  */




/**
  * @brief  Macro used by the assert function in order to check the different 
  *         sensitivity values for the low power mode
  */






/**
  * @brief  Macro used by the assert function in order to check the different 
  *         sensitivity values for the option bytes Address
  */




/**
  * @brief  Macro used by the assert function in order to check the different flags values
  */
#line 247 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_flash.h"
/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup FLASH_Exported_Functions
  * @{
  */
void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType);
void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType);
void FLASH_DeInit(void);
void FLASH_ITConfig(FunctionalState NewState);
void FLASH_EraseByte(uint32_t Address);
void FLASH_ProgramByte(uint32_t Address, uint8_t Data);
uint8_t FLASH_ReadByte(uint32_t Address);
void FLASH_ProgramWord(uint32_t Address, uint32_t Data);
uint16_t FLASH_ReadOptionByte(uint16_t Address);
void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data);
void FLASH_EraseOptionByte(uint16_t Address);
void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode);
void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime);
FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void);
FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void);
uint32_t FLASH_GetBootSize(void);
FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG);

/**
@code
 All the functions declared below must be executed from RAM exclusively, except 
 for the FLASH_WaitForLastOperation function which can be executed from Flash.
 
 Steps of the execution from RAM differs from one toolchain to another.
 for more details refer to stm8s_flash.c file.
 
 To enable execution from RAM you can either uncomment the following define 
 in the stm8s.h file or define it in your toolchain compiler preprocessor
 - #define RAM_EXECUTION  (1) 

@endcode
*/
void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType);

void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer);
FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType);

/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 24 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_gpio.h"
/**
  ******************************************************************************
  * @file    stm8s_gpio.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the GPIO peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported variables ------------------------------------------------------- */
/* Exported types ------------------------------------------------------------*/

/** @addtogroup GPIO_Exported_Types
  * @{
  */

/**
  * @brief  GPIO modes
  *
  * Bits definitions:
  * - Bit 7: 0 = INPUT mode
  *          1 = OUTPUT mode
  *          1 = PULL-UP (input) or PUSH-PULL (output)
  * - Bit 5: 0 = No external interrupt (input) or No slope control (output)
  *          1 = External interrupt (input) or Slow control enabled (output)
  * - Bit 4: 0 = Low level (output)
  *          1 = High level (output push-pull) or HI-Z (output open-drain)
  */
typedef enum
{
  GPIO_MODE_IN_FL_NO_IT      = (uint8_t)0x00,  /*!< Input floating, no external interrupt */
  GPIO_MODE_IN_PU_NO_IT      = (uint8_t)0x40,  /*!< Input pull-up, no external interrupt */
  GPIO_MODE_IN_FL_IT         = (uint8_t)0x20,  /*!< Input floating, external interrupt */
  GPIO_MODE_IN_PU_IT         = (uint8_t)0x60,  /*!< Input pull-up, external interrupt */
  GPIO_MODE_OUT_OD_LOW_FAST  = (uint8_t)0xA0,  /*!< Output open-drain, low level, 10MHz */
  GPIO_MODE_OUT_PP_LOW_FAST  = (uint8_t)0xE0,  /*!< Output push-pull, low level, 10MHz */
  GPIO_MODE_OUT_OD_LOW_SLOW  = (uint8_t)0x80,  /*!< Output open-drain, low level, 2MHz */
  GPIO_MODE_OUT_PP_LOW_SLOW  = (uint8_t)0xC0,  /*!< Output push-pull, low level, 2MHz */
  GPIO_MODE_OUT_OD_HIZ_FAST  = (uint8_t)0xB0,  /*!< Output open-drain, high-impedance level,10MHz */
  GPIO_MODE_OUT_PP_HIGH_FAST = (uint8_t)0xF0,  /*!< Output push-pull, high level, 10MHz */
  GPIO_MODE_OUT_OD_HIZ_SLOW  = (uint8_t)0x90,  /*!< Output open-drain, high-impedance level, 2MHz */
  GPIO_MODE_OUT_PP_HIGH_SLOW = (uint8_t)0xD0   /*!< Output push-pull, high level, 2MHz */
}GPIO_Mode_TypeDef;

/**
  * @brief  Definition of the GPIO pins. Used by the @ref GPIO_Init function in
  * order to select the pins to be initialized.
  */

typedef enum
{
  GPIO_PIN_0    = ((uint8_t)0x01),  /*!< Pin 0 selected */
  GPIO_PIN_1    = ((uint8_t)0x02),  /*!< Pin 1 selected */
  GPIO_PIN_2    = ((uint8_t)0x04),  /*!< Pin 2 selected */
  GPIO_PIN_3    = ((uint8_t)0x08),   /*!< Pin 3 selected */
  GPIO_PIN_4    = ((uint8_t)0x10),  /*!< Pin 4 selected */
  GPIO_PIN_5    = ((uint8_t)0x20),  /*!< Pin 5 selected */
  GPIO_PIN_6    = ((uint8_t)0x40),  /*!< Pin 6 selected */
  GPIO_PIN_7    = ((uint8_t)0x80),  /*!< Pin 7 selected */
  GPIO_PIN_LNIB = ((uint8_t)0x0F),  /*!< Low nibble pins selected */
  GPIO_PIN_HNIB = ((uint8_t)0xF0),  /*!< High nibble pins selected */
  GPIO_PIN_ALL  = ((uint8_t)0xFF)   /*!< All pins selected */
}GPIO_Pin_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/

/** @addtogroup GPIO_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different functions parameters.
  */

/**
  * @brief  Macro used by the assert function in order to check the different
  * values of GPIOMode_TypeDef.
  */
#line 123 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_gpio.h"

/**
  * @brief  Macro used by the assert function in order to check the different
  * values of GPIO_Pins.
  */


/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */
/** @addtogroup GPIO_Exported_Functions
  * @{
  */

void GPIO_DeInit(GPIO_TypeDef* GPIOx);
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode);
void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal);
void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins);
void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins);
void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins);
uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx);
uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx);
BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin);
void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState);
/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 25 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"
/**
  ******************************************************************************
  * @file    stm8s_i2c.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief  This file contains all functions prototype and macros for the I2C peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported types ------------------------------------------------------------*/

/** @addtogroup I2C_Exported_Types
  * @{
  */

/**
  * @brief  I2C duty cycle (fast mode only)
  */
typedef enum
{
  I2C_DUTYCYCLE_2    = (uint8_t)0x00,  /*!< Fast mode Tlow/THigh = 2 */
  I2C_DUTYCYCLE_16_9 = (uint8_t)0x40   /*!< Fast mode Tlow/Thigh = 16/9 */
} I2C_DutyCycle_TypeDef;

/**
  * @brief  I2C Acknowledgement configuration
  */
typedef enum
{
  I2C_ACK_NONE = (uint8_t)0x00,  /*!< No acknowledge */
  I2C_ACK_CURR = (uint8_t)0x01,  /*!< Acknowledge on the current byte */
  I2C_ACK_NEXT = (uint8_t)0x02   /*!< Acknowledge on the next byte */
} I2C_Ack_TypeDef;

/**
  * @brief  I2C Addressing Mode (slave mode only)
  */
typedef enum
{
  I2C_ADDMODE_7BIT  = (uint8_t)0x00,  /*!< 7-bit slave address (10-bit address not acknowledged) */
  I2C_ADDMODE_10BIT = (uint8_t)0x80   /*!< 10-bit slave address (7-bit address not acknowledged) */
} I2C_AddMode_TypeDef;

/**
  * @brief  I2C Interrupt sources
  * Warning: the values correspond to the bit position in the ITR register
  */
typedef enum
{
    I2C_IT_ERR     = (uint8_t)0x01, 	/*!< Error Interruption */
    I2C_IT_EVT     = (uint8_t)0x02, 	/*!< Event Interruption */
    I2C_IT_BUF     = (uint8_t)0x04 	/*!< Buffer Interruption */
} I2C_IT_TypeDef;

/**
  * @brief  I2C transfer direction
  * Warning: the values correspond to the ADD0 bit position in the OARL register
  */
typedef enum
{
  I2C_DIRECTION_TX = (uint8_t)0x00,  /*!< Transmission direction */
  I2C_DIRECTION_RX = (uint8_t)0x01   /*!< Reception direction */
} I2C_Direction_TypeDef;

/**
  * @brief  I2C Flags
  * @brief Elements values convention: 0xXXYY
  *  X = SRx registers index
  *      X = 1 : SR1
  *      X = 2 : SR2
  *      X = 3 : SR3
  *  Y = Flag mask in the register
  */

typedef enum
{
  /* SR1 register flags */
  I2C_FLAG_TXEMPTY             = (uint16_t)0x0180,  /*!< Transmit Data Register Empty flag */
  I2C_FLAG_RXNOTEMPTY          = (uint16_t)0x0140,  /*!< Read Data Register Not Empty flag */
  I2C_FLAG_STOPDETECTION       = (uint16_t)0x0110,  /*!< Stop detected flag */
  I2C_FLAG_HEADERSENT          = (uint16_t)0x0108,  /*!< 10-bit Header sent flag */
  I2C_FLAG_TRANSFERFINISHED    = (uint16_t)0x0104,  /*!< Data Byte Transfer Finished flag */
  I2C_FLAG_ADDRESSSENTMATCHED  = (uint16_t)0x0102,  /*!< Address Sent/Matched (master/slave) flag */
  I2C_FLAG_STARTDETECTION      = (uint16_t)0x0101,  /*!< Start bit sent flag */

  /* SR2 register flags */
  I2C_FLAG_WAKEUPFROMHALT      = (uint16_t)0x0220,  /*!< Wake Up From Halt Flag */
  I2C_FLAG_OVERRUNUNDERRUN     = (uint16_t)0x0208,  /*!< Overrun/Underrun flag */
  I2C_FLAG_ACKNOWLEDGEFAILURE  = (uint16_t)0x0204,  /*!< Acknowledge Failure Flag */
  I2C_FLAG_ARBITRATIONLOSS     = (uint16_t)0x0202,  /*!< Arbitration Loss Flag */
  I2C_FLAG_BUSERROR            = (uint16_t)0x0201,  /*!< Misplaced Start or Stop condition */

  /* SR3 register flags */
  I2C_FLAG_GENERALCALL         = (uint16_t)0x0310,  /*!< General Call header received Flag */
  I2C_FLAG_TRANSMITTERRECEIVER = (uint16_t)0x0304,  /*!< Transmitter Receiver Flag */
  I2C_FLAG_BUSBUSY             = (uint16_t)0x0302,  /*!< Bus Busy Flag */
  I2C_FLAG_MASTERSLAVE         = (uint16_t)0x0301   /*!< Master Slave Flag */
} I2C_Flag_TypeDef;

/**
  * @brief I2C Pending bits
  * Elements values convention: 0xXYZZ
  *  X = SRx registers index
  *      X = 1 : SR1
  *      X = 2 : SR2
  *  Y = Position of the corresponding Interrupt
  *  ZZ = flag mask in the dedicated register(X register)
  */

typedef enum
{
    /* SR1 register flags */
    I2C_ITPENDINGBIT_TXEMPTY             = (uint16_t)0x1680, 	/*!< Transmit Data Register Empty  */
    I2C_ITPENDINGBIT_RXNOTEMPTY          = (uint16_t)0x1640, 	/*!< Read Data Register Not Empty  */
    I2C_ITPENDINGBIT_STOPDETECTION       = (uint16_t)0x1210, 	/*!< Stop detected  */
    I2C_ITPENDINGBIT_HEADERSENT          = (uint16_t)0x1208, 	/*!< 10-bit Header sent */
    I2C_ITPENDINGBIT_TRANSFERFINISHED    = (uint16_t)0x1204, 	/*!< Data Byte Transfer Finished  */
    I2C_ITPENDINGBIT_ADDRESSSENTMATCHED  = (uint16_t)0x1202, 	/*!< Address Sent/Matched (master/slave)  */
    I2C_ITPENDINGBIT_STARTDETECTION      = (uint16_t)0x1201, 	/*!< Start bit sent  */

    /* SR2 register flags */
    I2C_ITPENDINGBIT_WAKEUPFROMHALT      = (uint16_t)0x2220, 	/*!< Wake Up From Halt  */
    I2C_ITPENDINGBIT_OVERRUNUNDERRUN     = (uint16_t)0x2108, 	/*!< Overrun/Underrun  */
    I2C_ITPENDINGBIT_ACKNOWLEDGEFAILURE  = (uint16_t)0x2104, 	/*!< Acknowledge Failure  */
    I2C_ITPENDINGBIT_ARBITRATIONLOSS     = (uint16_t)0x2102, 	/*!< Arbitration Loss  */
    I2C_ITPENDINGBIT_BUSERROR            = (uint16_t)0x2101  	/*!< Misplaced Start or Stop condition */
} I2C_ITPendingBit_TypeDef;

/**
  * @brief I2C possible events
  * Values convention: 0xXXYY
  * XX = Event SR3 corresponding value
  * YY = Event SR1 corresponding value
  * @note if Event = EV3_2 the rule above does not apply
  * YY = Event SR2 corresponding value
  */

typedef enum
{
  /*========================================

                       I2C Master Events (Events grouped in order of communication)
                                                          ==========================================*/
  /**
    * @brief  Communication start
    *
    * After sending the START condition (I2C_GenerateSTART() function) the master
    * has to wait for this event. It means that the Start condition has been correctly
    * released on the I2C bus (the bus is free, no other devices is communicating).
    *
    */
  /* --EV5 */
  I2C_EVENT_MASTER_MODE_SELECT               = (uint16_t)0x0301,  /*!< BUSY, MSL and SB flag */

  /**
    * @brief  Address Acknowledge
    *
    * After checking on EV5 (start condition correctly released on the bus), the
    * master sends the address of the slave(s) with which it will communicate
    * (I2C_Send7bitAddress() function, it also determines the direction of the communication:
    * Master transmitter or Receiver).
    * Then the master has to wait that a slave acknowledges his address.
    * If an acknowledge is sent on the bus, one of the following events will
    * be set:
    *
    *  1) In case of Master Receiver (7-bit addressing):
    *  the I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED event is set.
    *
    *  2) In case of Master Transmitter (7-bit addressing):
    *  the I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED is set
    *
    *  3) In case of 10-Bit addressing mode, the master (just after generating the START
    *  and checking on EV5) has to send the header of 10-bit addressing mode (I2C_SendData()
    *  function).
    *  Then master should wait on EV9. It means that the 10-bit addressing
    *  header has been correctly sent on the bus.
    *  Then master should send the second part of the 10-bit address (LSB) using
    *  the function I2C_Send7bitAddress(). Then master should wait for event EV6.
    *
    */
  /* --EV6 */
  I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED = (uint16_t)0x0782,  /*!< BUSY, MSL, ADDR, TXE and TRA flags */
  I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED    = (uint16_t)0x0302,  /*!< BUSY, MSL and ADDR flags */
  /* --EV9 */
  I2C_EVENT_MASTER_MODE_ADDRESS10            = (uint16_t)0x0308,  /*!< BUSY, MSL and ADD10 flags */

  /**
    * @brief Communication events
    *
    * If a communication is established (START condition generated and slave address
    * acknowledged) then the master has to check on one of the following events for
    * communication procedures:
    *
    * 1) Master Receiver mode: The master has to wait on the event EV7 then to read
    *    the data received from the slave (I2C_ReceiveData() function).
    *
    * 2) Master Transmitter mode: The master has to send data (I2C_SendData()
    *    function) then to wait on event EV8 or EV8_2.
    *    These two events are similar:
    *     - EV8 means that the data has been written in the data register and is
    *       being shifted out.
    *     - EV8_2 means that the data has been physically shifted out and output
    *       on the bus.
    *     In most cases, using EV8 is sufficient for the application.
    *     Using EV8_2 leads to a slower communication but ensures more reliable test.
    *     EV8_2 is also more suitable than EV8 for testing on the last data transmission
    *     (before Stop condition generation).
    *
    *  @note In case the user software does not guarantee that this event EV7 is
    *  managed before the current byte end of transfer, then user may check on EV7
    *  and BTF flag at the same time (ie. (I2C_EVENT_MASTER_BYTE_RECEIVED | I2C_FLAG_BTF)).
    *  In this case the communication may be slower.
    *
    */
  /* Master RECEIVER mode -----------------------------*/
  /* --EV7 */
  I2C_EVENT_MASTER_BYTE_RECEIVED             = (uint16_t)0x0340,  /*!< BUSY, MSL and RXNE flags */

  /* Master TRANSMITTER mode --------------------------*/
  /* --EV8 */
  I2C_EVENT_MASTER_BYTE_TRANSMITTING         = (uint16_t)0x0780,  /*!< TRA, BUSY, MSL, TXE flags */
  /* --EV8_2 */

  I2C_EVENT_MASTER_BYTE_TRANSMITTED          = (uint16_t)0x0784,  /*!< EV8_2: TRA, BUSY, MSL, TXE and BTF flags */


  /*========================================

                       I2C Slave Events (Events grouped in order of communication)
                                                          ==========================================*/

  /**
    * @brief  Communication start events
    *
    * Wait on one of these events at the start of the communication. It means that
    * the I2C peripheral detected a Start condition on the bus (generated by master
    * device) followed by the peripheral address.
    * The peripheral generates an ACK condition on the bus (if the acknowledge
    * feature is enabled through function I2C_AcknowledgeConfig()) and the events
    * listed above are set :
    *
    * 1) In normal case (only one address managed by the slave), when the address
    *   sent by the master matches the own address of the peripheral (configured by
    *   I2C_OwnAddress1 field) the I2C_EVENT_SLAVE_XXX_ADDRESS_MATCHED event is set
    *   (where XXX could be TRANSMITTER or RECEIVER).
    *
    * 2) In case the address sent by the master is General Call (address 0x00) and 
    *   if the General Call is enabled for the peripheral (using function I2C_GeneralCallCmd()) 
    *   the following event is set I2C_EVENT_SLAVE_GENERALCALLADDRESS_MATCHED.  
    * 
    */

  /* --EV1  (all the events below are variants of EV1) */
  /* 1) Case of One Single Address managed by the slave */
  I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED    = (uint16_t)0x0202,  /*!< BUSY and ADDR flags */
  I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED = (uint16_t)0x0682,  /*!< TRA, BUSY, TXE and ADDR flags */

  /* 2) Case of General Call enabled for the slave */
  I2C_EVENT_SLAVE_GENERALCALLADDRESS_MATCHED  = (uint16_t)0x1200,  /*!< EV2: GENCALL and BUSY flags */

  /**
    * @brief  Communication events
    *
    * Wait on one of these events when EV1 has already been checked :
    *
    * - Slave RECEIVER mode:
    *     - EV2: When the application is expecting a data byte to be received.
    *     - EV4: When the application is expecting the end of the communication:
    *       master sends a stop condition and data transmission is stopped.
    *
    * - Slave Transmitter mode:
    *    - EV3: When a byte has been transmitted by the slave and the application
    *      is expecting the end of the byte transmission.
    *      The two events I2C_EVENT_SLAVE_BYTE_TRANSMITTED and I2C_EVENT_SLAVE_BYTE_TRANSMITTING
    *      are similar. The second one can optionally be used when the user software
    *      doesn't guarantee the EV3 is managed before the current byte end of transfer.
    *    - EV3_2: When the master sends a NACK in order to tell slave that data transmission
    *      shall end (before sending the STOP condition).
    *      In this case slave has to stop sending data bytes and expect a Stop
    *      condition on the bus.
    *
    *  @note In case the  user software does not guarantee that the event EV2 is
    *  managed before the current byte end of transfer, then user may check on EV2
    *  and BTF flag at the same time (ie. (I2C_EVENT_SLAVE_BYTE_RECEIVED | I2C_FLAG_BTF)).
    *  In this case the communication may be slower.
    *
    */
  /* Slave RECEIVER mode --------------------------*/
  /* --EV2 */
  I2C_EVENT_SLAVE_BYTE_RECEIVED              = (uint16_t)0x0240,  /*!< BUSY and RXNE flags */
  /* --EV4  */
  I2C_EVENT_SLAVE_STOP_DETECTED              = (uint16_t)0x0010,  /*!< STOPF flag */

  /* Slave TRANSMITTER mode -----------------------*/
  /* --EV3 */
  I2C_EVENT_SLAVE_BYTE_TRANSMITTED           = (uint16_t)0x0684,  /*!< TRA, BUSY, TXE and BTF flags */
  I2C_EVENT_SLAVE_BYTE_TRANSMITTING          = (uint16_t)0x0680,  /*!< TRA, BUSY and TXE flags */
  /* --EV3_2 */
  I2C_EVENT_SLAVE_ACK_FAILURE                = (uint16_t)0x0004  /*!< AF flag */
} I2C_Event_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/** @addtogroup I2C_Exported_Constants
  * @{
  */
#line 342 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"

/**
  * @}
  */

/* Exported macros -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/

/** @addtogroup I2C_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different functions parameters.
  */

/**
  * @brief   Macro used by the assert function to check the different I2C duty cycles.
  */




/**
  * @brief   Macro used by the assert function to check the different acknowledgement configuration
  */





/**
  * @brief   Macro used by the assert function to check the different I2C addressing modes.
  */




/**
  * @brief   Macro used by the assert function to check the different I2C interrupt types.
  */
#line 391 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"
/**
  * @brief   Macro used by the assert function to check the different I2C communcation direction.
  */




/**
  * @brief   Macro used by the assert function to check the different I2C flags.
  */
#line 418 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"
/**
  * @brief   Macro used by the assert function to check the I2C flags to clear.
  */




/**
  * @brief   Macro used by the assert function to check the different I2C possible pending bits.
  */
#line 441 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"
    
/**
  * @brief  Macro used by the assert function to check the different I2C possible
  *   pending bits to clear by writing 0.
  */
#line 452 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"
   
/**
  * @brief   Macro used by the assert function to check the different I2C possible events.
  */
#line 472 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_i2c.h"

/**
  * @brief   Macro used by the assert function to check the different I2C possible own address.
  */



/* The address must be even */



/**
  * @brief   Macro used by the assert function to check that I2C Input clock frequency must be between 1MHz and 50MHz.
  */




/**
  * @brief   Macro used by the assert function to check that I2C Output clock frequency must be between 1Hz and 400kHz.
  */



/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */
/** @addtogroup I2C_Exported_Functions
  * @{
  */

void I2C_DeInit(void);
void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
              I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
              I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz );
void I2C_Cmd(FunctionalState NewState);
void I2C_GeneralCallCmd(FunctionalState NewState);
void I2C_GenerateSTART(FunctionalState NewState);
void I2C_GenerateSTOP(FunctionalState NewState);
void I2C_SoftwareResetCmd(FunctionalState NewState);
void I2C_StretchClockCmd(FunctionalState NewState);
void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack);
void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle);
void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState);
uint8_t I2C_ReceiveData(void);
void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction);
void I2C_SendData(uint8_t Data);
/**
 * @brief
 ****************************************************************************************
 *
 *                         I2C State Monitoring Functions
 *
 ****************************************************************************************
 * This I2C driver provides three different ways for I2C state monitoring
 *  depending on the application requirements and constraints:
 *
 *
 * 1) Basic state monitoring:
 *    Using I2C_CheckEvent() function:
 *    It compares the status registers (SR1, SR2 and SR3) content to a given event
 *    (can be the combination of one or more flags).
 *    It returns SUCCESS if the current status includes the given flags
 *    and returns ERROR if one or more flags are missing in the current status.
 *    - When to use:
 *      - This function is suitable for most applications as well as for startup
 *      activity since the events are fully described in the product reference manual
 *      (RM0016).
 *      - It is also suitable for users who need to define their own events.
 *    - Limitations:
 *      - If an error occurs (ie. error flags are set besides to the monitored flags),
 *        the I2C_CheckEvent() function may return SUCCESS despite the communication
 *        hold or corrupted real state.
 *        In this case, it is advised to use error interrupts to monitor the error
 *        events and handle them in the interrupt IRQ handler.
 *
 *        @note
 *        For error management, it is advised to use the following functions:
 *          - I2C_ITConfig() to configure and enable the error interrupts (I2C_IT_ERR).
 *          - I2C_IRQHandler() which is called when the I2C interrupts occur.
 *          - I2C_GetFlagStatus() or I2C_GetITStatus() to be called into the
 *           I2Cx_IRQHandler() function in order to determine which error occurred.
 *          - I2C_ClearFlag() or I2C_ClearITPendingBit() and/or I2C_SoftwareResetCmd()
 *            and/or I2C_GenerateStop() in order to clear the error flag and
 *            source and return to correct communication status.
 *
 *
 *  2) Advanced state monitoring:
 *     Using the function I2C_GetLastEvent() which returns the image of both SR1
 *     & SR3 status registers in a single word (uint16_t) (Status Register 3 value
 *     is shifted left by 8 bits and concatenated to Status Register 1).
 *     - When to use:
 *       - This function is suitable for the same applications above but it allows to
 *         overcome the limitations of I2C_GetFlagStatus() function (see below).
 *         The returned value could be compared to events already defined in the
 *         library (stm8s_i2c.h) or to custom values defined by user.
 *       - This function is suitable when multiple flags are monitored at the same time.
 *       - At the opposite of I2C_CheckEvent() function, this function allows user to
 *         choose when an event is accepted (when all events flags are set and no
 *         other flags are set or just when the needed flags are set like
 *         I2C_CheckEvent() function).
 *     - Limitations:
 *       - User may need to define his own events.
 *       - Same remark concerning the error management is applicable for this
 *         function if user decides to check only regular communication flags (and
 *         ignores error flags).
 *
 *
 *  3) Flag-based state monitoring:
 *     Using the function I2C_GetFlagStatus() which simply returns the status of
 *     one single flag (ie. I2C_FLAG_RXNE ...).
 *     - When to use:
 *        - This function could be used for specific applications or in debug phase.
 *        - It is suitable when only one flag checking is needed (most I2C events
 *          are monitored through multiple flags).
 *     - Limitations:
 *        - When calling this function, the Status register is accessed. Some flags are
 *          cleared when the status register is accessed. So checking the status
 *          of one Flag, may clear other ones.
 *        - Function may need to be called twice or more in order to monitor one
 *          single event.
 *
 */

/**
 *
 *  1) Basic state monitoring
 *******************************************************************************
 */
ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event);
/**
 *
 *  2) Advanced state monitoring
 *******************************************************************************
 */
I2C_Event_TypeDef I2C_GetLastEvent(void);
/**
 *
 *  3) Flag-based state monitoring
 *******************************************************************************
 */
FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag);
/**
 *
 *******************************************************************************
 */
void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG);
ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit);
void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit);


/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 26 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_itc.h"
/**
  ******************************************************************************
  * @file    stm8s_itc.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the ITC peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/* Exported types ------------------------------------------------------------*/

/** @addtogroup ITC_Exported_Types
  * @{
  */

/**
  * @brief  ITC Interrupt Lines selection
  */
typedef enum {
  ITC_IRQ_TLI            = (uint8_t)0,   /*!< Software interrupt */
  ITC_IRQ_AWU            = (uint8_t)1,   /*!< Auto wake up from halt interrupt */
  ITC_IRQ_CLK            = (uint8_t)2,   /*!< Clock controller interrupt */
  ITC_IRQ_PORTA          = (uint8_t)3,   /*!< Port A external interrupts */
  ITC_IRQ_PORTB          = (uint8_t)4,   /*!< Port B external interrupts */
  ITC_IRQ_PORTC          = (uint8_t)5,   /*!< Port C external interrupts */
  ITC_IRQ_PORTD          = (uint8_t)6,   /*!< Port D external interrupts */
  ITC_IRQ_PORTE          = (uint8_t)7,   /*!< Port E external interrupts */
  









  ITC_IRQ_SPI            = (uint8_t)10,  /*!< SPI interrupt */
  ITC_IRQ_TIM1_OVF       = (uint8_t)11,  /*!< TIM1 update/overflow/underflow/trigger/
                                         break interrupt*/
  ITC_IRQ_TIM1_CAPCOM    = (uint8_t)12,  /*!< TIM1 capture/compare interrupt */
  





  ITC_IRQ_TIM2_OVF       = (uint8_t)13,  /*!< TIM2 update /overflow interrupt */
  ITC_IRQ_TIM2_CAPCOM    = (uint8_t)14,  /*!< TIM2 capture/compare interrupt */


  ITC_IRQ_TIM3_OVF       = (uint8_t)15,  /*!< TIM3 update /overflow interrupt*/
  ITC_IRQ_TIM3_CAPCOM    = (uint8_t)16,  /*!< TIM3 update /overflow interrupt */



  ITC_IRQ_UART1_TX       = (uint8_t)17,  /*!< UART1 TX interrupt */
  ITC_IRQ_UART1_RX       = (uint8_t)18,  /*!< UART1 RX interrupt */





  
  ITC_IRQ_I2C            = (uint8_t)19,  /*!< I2C interrupt */
  












  ITC_IRQ_ADC1           = (uint8_t)22,  /*!< ADC1 interrupt */






  ITC_IRQ_TIM4_OVF       = (uint8_t)23,  /*!< TIM4 update /overflow interrupt */


  ITC_IRQ_EEPROM_EEC     = (uint8_t)24  /*!< Flash interrupt */
} ITC_Irq_TypeDef;

/**
  * @brief  ITC Priority Levels selection
  */
typedef enum {
  ITC_PRIORITYLEVEL_0 = (uint8_t)0x02, /*!< Software priority level 0 (cannot be written) */
  ITC_PRIORITYLEVEL_1 = (uint8_t)0x01, /*!< Software priority level 1 */
  ITC_PRIORITYLEVEL_2 = (uint8_t)0x00, /*!< Software priority level 2 */
  ITC_PRIORITYLEVEL_3 = (uint8_t)0x03  /*!< Software priority level 3 */
} ITC_PriorityLevel_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/

/** @addtogroup ITC_Exported_Constants
  * @{
  */


/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/

/**
  * @brief  Macros used by the assert function in order to check the different functions parameters.
  * @addtogroup ITC_Private_Macros
  * @{
  */

/* Used by assert function */


/* Used by assert function */






/* Used by assert function */


/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup ITC_Exported_Functions
  * @{
  */

uint8_t ITC_GetCPUCC(void);
void ITC_DeInit(void);
uint8_t ITC_GetSoftIntStatus(void);
void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue);
ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_Irq_TypeDef IrqNum);

/**
  * @}
  */




/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 27 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_iwdg.h"
/**
  ******************************************************************************
  * @file    stm8s_iwdg.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototypes and macros for the IWDG peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/** @addtogroup IWDG_Private_Define
  * @{
  */

/**
  * @brief  Define used to prevent watchdog reset
  */


/**
  * @brief  Define used to start the watchdog counter down
  */


/**
 * @}
 */

/** @addtogroup IWDG_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function in order to check the different
  * values of the prescaler.
  */
#line 72 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_iwdg.h"

/**
  * @brief  Macro used by the assert function in order to check the different
  * values of the counter register.
  */


/**
  * @}
  */

/** @addtogroup IWDG_Exported_Types
  * @{
  */

/** IWDG write  access enumeration */
typedef enum
{
  IWDG_WriteAccess_Enable  = (uint8_t)0x55, /*!< Code 0x55 in Key register, allow write access to Prescaler and Reload registers */
  IWDG_WriteAccess_Disable = (uint8_t)0x00  /*!< Code 0x00 in Key register, not allow write access to Prescaler and Reload registers */
} IWDG_WriteAccess_TypeDef;

/** IWDG prescaler enumaration */
typedef enum
{
  IWDG_Prescaler_4   = (uint8_t)0x00, /*!< Used to set prescaler register to 4 */
  IWDG_Prescaler_8   = (uint8_t)0x01, /*!< Used to set prescaler register to 8 */
  IWDG_Prescaler_16  = (uint8_t)0x02, /*!< Used to set prescaler register to 16 */
  IWDG_Prescaler_32  = (uint8_t)0x03, /*!< Used to set prescaler register to 32 */
  IWDG_Prescaler_64  = (uint8_t)0x04, /*!< Used to set prescaler register to 64 */
  IWDG_Prescaler_128 = (uint8_t)0x05, /*!< Used to set prescaler register to 128 */
  IWDG_Prescaler_256 = (uint8_t)0x06  /*!< Used to set prescaler register to 256 */
} IWDG_Prescaler_TypeDef;

/**
  * @}
  */

/** @addtogroup IWDG_Exported_Functions
  * @{
  */

void IWDG_WriteAccessCmd(IWDG_WriteAccess_TypeDef IWDG_WriteAccess);
void IWDG_SetPrescaler(IWDG_Prescaler_TypeDef IWDG_Prescaler);
void IWDG_SetReload(uint8_t IWDG_Reload);
void IWDG_ReloadCounter(void);
void IWDG_Enable(void);

/**
  * @}
  */



/**
  * @}
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 28 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_rst.h"
/**
  ******************************************************************************
  * @file    stm8s_rst.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the RST peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/** @addtogroup RST_Exported_Types
  * @{
  */
typedef enum {
  RST_FLAG_EMCF    = (uint8_t)0x10, /*!< EMC reset flag */
  RST_FLAG_SWIMF   = (uint8_t)0x08, /*!< SWIM reset flag */
  RST_FLAG_ILLOPF  = (uint8_t)0x04, /*!< Illigal opcode reset flag */
  RST_FLAG_IWDGF   = (uint8_t)0x02, /*!< Independent watchdog reset flag */
  RST_FLAG_WWDGF   = (uint8_t)0x01  /*!< Window watchdog reset flag */
}RST_Flag_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/

/** @addtogroup RST_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different functions parameters.
  */
/**
  * @brief  Macro used by the assert function to check the different RST flags.
  */






/**
  * @}
  */

/** @addtogroup RST_Exported_functions
  * @{
  */
FlagStatus RST_GetFlagStatus(RST_Flag_TypeDef RST_Flag);
void RST_ClearFlag(RST_Flag_TypeDef RST_Flag);

/**
  * @}
  */



/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 29 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_spi.h"
/**
  ******************************************************************************
  * @file    stm8s_spi.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the SPI peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/** @addtogroup SPI_Exported_Types
  * @{
  */

/**
  * @brief  SPI data direction mode
  * Warning: element values correspond to BDM, BDOE, RXONLY bits position
  */
typedef enum {
  SPI_DATADIRECTION_2LINES_FULLDUPLEX = (uint8_t)0x00, /*!< 2-line uni-directional data mode enable */
  SPI_DATADIRECTION_2LINES_RXONLY     = (uint8_t)0x04, /*!< Receiver only in 2 line uni-directional data mode */
  SPI_DATADIRECTION_1LINE_RX          = (uint8_t)0x80, /*!< Receiver only in 1 line bi-directional data mode */
  SPI_DATADIRECTION_1LINE_TX          = (uint8_t)0xC0  /*!< Transmit only in 1 line bi-directional data mode */
} SPI_DataDirection_TypeDef;

/**
  * @brief  SPI Slave Select management
  * Warning: element values correspond to LSBFIRST bit position
  */
typedef enum
{
  SPI_NSS_SOFT  = (uint8_t)0x02, /*!< Software slave management disabled */
  SPI_NSS_HARD  = (uint8_t)0x00  /*!< Software slave management enabled */
} SPI_NSS_TypeDef;


/**
  * @brief  SPI direction transmit/receive
  */

typedef enum {
  SPI_DIRECTION_RX = (uint8_t)0x00, /*!< Selects Rx receive direction in bi-directional mode */
  SPI_DIRECTION_TX = (uint8_t)0x01  /*!< Selects Tx transmission direction in bi-directional mode */
} SPI_Direction_TypeDef;

/**
  * @brief  SPI master/slave mode
  * Warning: element values correspond to MSTR bit position
  */
typedef enum {
  SPI_MODE_MASTER = (uint8_t)0x04, /*!< SPI Master configuration */
  SPI_MODE_SLAVE  = (uint8_t)0x00  /*!< SPI Slave configuration */
} SPI_Mode_TypeDef;

/**
  * @brief  SPI BaudRate Prescaler
  * Warning: element values correspond to BR bits position
  */
typedef enum {
  SPI_BAUDRATEPRESCALER_2   = (uint8_t)0x00, /*!< SPI frequency = frequency(CPU)/2 */
  SPI_BAUDRATEPRESCALER_4   = (uint8_t)0x08, /*!< SPI frequency = frequency(CPU)/4 */
  SPI_BAUDRATEPRESCALER_8   = (uint8_t)0x10, /*!< SPI frequency = frequency(CPU)/8 */
  SPI_BAUDRATEPRESCALER_16  = (uint8_t)0x18, /*!< SPI frequency = frequency(CPU)/16 */
  SPI_BAUDRATEPRESCALER_32  = (uint8_t)0x20, /*!< SPI frequency = frequency(CPU)/32 */
  SPI_BAUDRATEPRESCALER_64  = (uint8_t)0x28, /*!< SPI frequency = frequency(CPU)/64 */
  SPI_BAUDRATEPRESCALER_128 = (uint8_t)0x30, /*!< SPI frequency = frequency(CPU)/128 */
  SPI_BAUDRATEPRESCALER_256 = (uint8_t)0x38  /*!< SPI frequency = frequency(CPU)/256 */
} SPI_BaudRatePrescaler_TypeDef;

/**
  * @brief  SPI Clock Polarity
  * Warning: element values correspond to CPOL bit position
  */
typedef enum {
  SPI_CLOCKPOLARITY_LOW  = (uint8_t)0x00, /*!< Clock to 0 when idle */
  SPI_CLOCKPOLARITY_HIGH = (uint8_t)0x02  /*!< Clock to 1 when idle */
} SPI_ClockPolarity_TypeDef;

/**
  * @brief  SPI Clock Phase
  * Warning: element values correspond to CPHA bit position
  */
typedef enum {
  SPI_CLOCKPHASE_1EDGE = (uint8_t)0x00, /*!< The first clock transition is the first data capture edge */
  SPI_CLOCKPHASE_2EDGE = (uint8_t)0x01  /*!< The second clock transition is the first data capture edge */
} SPI_ClockPhase_TypeDef;

/**
  * @brief  SPI Frame Format: MSB or LSB transmitted first
  * Warning: element values correspond to LSBFIRST bit position
  */
typedef enum {
  SPI_FIRSTBIT_MSB = (uint8_t)0x00, /*!< MSB bit will be transmitted first */
  SPI_FIRSTBIT_LSB = (uint8_t)0x80  /*!< LSB bit will be transmitted first */
} SPI_FirstBit_TypeDef;

/**
  * @brief  SPI CRC Transmit/Receive
  */
typedef enum {
  SPI_CRC_RX = (uint8_t)0x00, /*!< Select Tx CRC register */
  SPI_CRC_TX = (uint8_t)0x01  /*!< Select Rx CRC register */
} SPI_CRC_TypeDef;

/**
  * @brief  SPI flags definition - Warning : FLAG value = mapping position register
  */
typedef enum {
  SPI_FLAG_BSY    = (uint8_t)0x80, /*!< Busy flag */
  SPI_FLAG_OVR    = (uint8_t)0x40, /*!< Overrun flag */
  SPI_FLAG_MODF   = (uint8_t)0x20, /*!< Mode fault */
  SPI_FLAG_CRCERR = (uint8_t)0x10, /*!< CRC error flag */
  SPI_FLAG_WKUP   = (uint8_t)0x08, /*!< Wake-up flag */
  SPI_FLAG_TXE    = (uint8_t)0x02, /*!< Transmit buffer empty */
  SPI_FLAG_RXNE   = (uint8_t)0x01  /*!< Receive buffer empty */
} SPI_Flag_TypeDef;

/**
  * @brief  SPI_IT possible values
  * Elements values convention: 0xYX
  *   X: Position of the corresponding Interrupt
  *   Y: ITPENDINGBIT position
  */
typedef enum
{
  SPI_IT_WKUP   = (uint8_t)0x34,  /*!< Wake-up interrupt*/
  SPI_IT_OVR   = (uint8_t)0x65,  /*!< Overrun interrupt*/
  SPI_IT_MODF   = (uint8_t)0x55,  /*!< Mode fault interrupt*/
  SPI_IT_CRCERR = (uint8_t)0x45,  /*!< CRC error interrupt*/
  SPI_IT_TXE    = (uint8_t)0x17,  /*!< Transmit buffer empty interrupt*/
  SPI_IT_RXNE   = (uint8_t)0x06,   /*!< Receive buffer not empty interrupt*/
  SPI_IT_ERR    = (uint8_t)0x05   /*!< Error interrupt*/
} SPI_IT_TypeDef;

/**
  * @}
  */

/* Private define ------------------------------------------------------------*/

/** @addtogroup SPI_Private_Macros
  * @brief  Macros used by the assert_param function to check the different functions parameters.
  * @{
  */

/**
  * @brief  Macro used by the assert_param function in order to check the data direction mode values
  */





/**
  * @brief  Macro used by the assert_param function in order to check the mode 
  *         half duplex data direction values
  */



/**
  * @brief  Macro used by the assert_param function in order to check the NSS 
  *         management values
  */




/**
  * @brief  Macro used by the assert_param function in order to check the different
  *         sensitivity values for the CRC polynomial
  */


/**
  * @brief  Macro used by the assert_param function in order to check the SPI Mode values
  */



/**
  * @brief  Macro used by the assert_param function in order to check the baudrate values
  */
#line 220 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_spi.h"

/**
  * @brief  Macro used by the assert_param function in order to check the polarity values
  */



/**
  * @brief  Macro used by the assert_param function in order to check the phase values
  */



/**
  * @brief  Macro used by the assert_param function in order to check the first 
  *         bit to be transmited values
  */



/**
  * @brief  Macro used by the assert_param function in order to check the CRC 
  *         Transmit/Receive
  */



/**
  * @brief  Macro used by the assert_param function in order to check the 
  *         different flags values
  */
#line 258 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_spi.h"

/**
  * @brief  Macro used by the assert_param function in order to check the 
  *         different sensitivity values for the flag that can be cleared 
  *         by writing 0
  */



/**
  * @brief  Macro used by the assert_param function in order to check the 
  *        different sensitivity values for the Interrupts
  */





/**
  * @brief  Macro used by the assert_param function in order to check the 
  *         different sensitivity values for the pending bit
  */
#line 286 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_spi.h"

/**
  * @brief  Macro used by the assert_param function in order to check the 
  *         different sensitivity values for the pending bit that can be cleared
  *         by writing 0
  */



/**
  * @}
  */

/** @addtogroup SPI_Exported_Functions
  * @{
  */
void SPI_DeInit(void);
void SPI_Init(SPI_FirstBit_TypeDef FirstBit, 
              SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, 
              SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, 
              SPI_ClockPhase_TypeDef ClockPhase, 
              SPI_DataDirection_TypeDef Data_Direction, 
              SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial);
void SPI_Cmd(FunctionalState NewState);
void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState);
void SPI_SendData(uint8_t Data);
uint8_t SPI_ReceiveData(void);
void SPI_NSSInternalSoftwareCmd(FunctionalState NewState);
void SPI_TransmitCRC(void);
void SPI_CalculateCRCCmd(FunctionalState NewState);
uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC);
void SPI_ResetCRC(void);
uint8_t SPI_GetCRCPolynomial(void);
void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction);
FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG);
void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG);
ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT);
void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT);

/**
  * @}
  */



/**
  * @}
  */
  

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 30 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"
/**
  ******************************************************************************
  * @file    stm8s_tim1.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the TIM1 peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */
  
/** @addtogroup TIM1_Exported_Types
 * @{
 */

/** TIM1 Output Compare and PWM modes */

typedef enum
{
  TIM1_OCMODE_TIMING     = ((uint8_t)0x00),
  TIM1_OCMODE_ACTIVE     = ((uint8_t)0x10),
  TIM1_OCMODE_INACTIVE   = ((uint8_t)0x20),
  TIM1_OCMODE_TOGGLE     = ((uint8_t)0x30),
  TIM1_OCMODE_PWM1       = ((uint8_t)0x60),
  TIM1_OCMODE_PWM2       = ((uint8_t)0x70)
}TIM1_OCMode_TypeDef;

#line 61 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"

#line 70 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"

/** TIM1 One Pulse Mode */
typedef enum
{
  TIM1_OPMODE_SINGLE                 = ((uint8_t)0x01),
  TIM1_OPMODE_REPETITIVE             = ((uint8_t)0x00)
}TIM1_OPMode_TypeDef;




/** TIM1 Channel */

typedef enum
{
  TIM1_CHANNEL_1                     = ((uint8_t)0x00),
  TIM1_CHANNEL_2                     = ((uint8_t)0x01),
  TIM1_CHANNEL_3                     = ((uint8_t)0x02),
  TIM1_CHANNEL_4                     = ((uint8_t)0x03)
}TIM1_Channel_TypeDef;















/** TIM1 Counter Mode */
typedef enum
{
  TIM1_COUNTERMODE_UP                = ((uint8_t)0x00),
  TIM1_COUNTERMODE_DOWN              = ((uint8_t)0x10),
  TIM1_COUNTERMODE_CENTERALIGNED1    = ((uint8_t)0x20),
  TIM1_COUNTERMODE_CENTERALIGNED2    = ((uint8_t)0x40),
  TIM1_COUNTERMODE_CENTERALIGNED3    = ((uint8_t)0x60)
}TIM1_CounterMode_TypeDef;







/** TIM1 Output Compare Polarity */
typedef enum
{
  TIM1_OCPOLARITY_HIGH               = ((uint8_t)0x00),
  TIM1_OCPOLARITY_LOW                = ((uint8_t)0x22)
}TIM1_OCPolarity_TypeDef;




/** TIM1 Output Compare N Polarity */
typedef enum
{
  TIM1_OCNPOLARITY_HIGH              = ((uint8_t)0x00),
  TIM1_OCNPOLARITY_LOW               = ((uint8_t)0x88)
}TIM1_OCNPolarity_TypeDef;




/** TIM1 Output Compare states */
typedef enum
{
  TIM1_OUTPUTSTATE_DISABLE           = ((uint8_t)0x00),
  TIM1_OUTPUTSTATE_ENABLE            = ((uint8_t)0x11)
}TIM1_OutputState_TypeDef;




/** TIM1 Output Compare N States */
typedef enum
{
  TIM1_OUTPUTNSTATE_DISABLE = ((uint8_t)0x00),
  TIM1_OUTPUTNSTATE_ENABLE  = ((uint8_t)0x44)
} TIM1_OutputNState_TypeDef;




/** TIM1 Break Input enable/disable */
typedef enum
{
  TIM1_BREAK_ENABLE                  = ((uint8_t)0x10),
  TIM1_BREAK_DISABLE                 = ((uint8_t)0x00)
}TIM1_BreakState_TypeDef;



/** TIM1 Break Polarity */
typedef enum
{
  TIM1_BREAKPOLARITY_LOW             = ((uint8_t)0x00),
  TIM1_BREAKPOLARITY_HIGH            = ((uint8_t)0x20)
}TIM1_BreakPolarity_TypeDef;



/** TIM1 AOE Bit Set/Reset */
typedef enum
{
  TIM1_AUTOMATICOUTPUT_ENABLE        = ((uint8_t)0x40),
  TIM1_AUTOMATICOUTPUT_DISABLE       = ((uint8_t)0x00)
}TIM1_AutomaticOutput_TypeDef;




/** TIM1 Lock levels */
typedef enum
{
  TIM1_LOCKLEVEL_OFF                 = ((uint8_t)0x00),
  TIM1_LOCKLEVEL_1                   = ((uint8_t)0x01),
  TIM1_LOCKLEVEL_2                   = ((uint8_t)0x02),
  TIM1_LOCKLEVEL_3                   = ((uint8_t)0x03)
}TIM1_LockLevel_TypeDef;






/** TIM1 OSSI: Off-State Selection for Idle mode states */
typedef enum
{
  TIM1_OSSISTATE_ENABLE              = ((uint8_t)0x04),
  TIM1_OSSISTATE_DISABLE             = ((uint8_t)0x00)
}TIM1_OSSIState_TypeDef;




/** TIM1 Output Compare Idle State */
typedef enum
{
  TIM1_OCIDLESTATE_SET               = ((uint8_t)0x55),
  TIM1_OCIDLESTATE_RESET             = ((uint8_t)0x00)
}TIM1_OCIdleState_TypeDef;




/** TIM1 Output Compare N Idle State */
typedef enum
{
  TIM1_OCNIDLESTATE_SET             = ((uint8_t)0x2A),
  TIM1_OCNIDLESTATE_RESET           = ((uint8_t)0x00)
}TIM1_OCNIdleState_TypeDef;




/** TIM1 Input Capture Polarity */
typedef enum
{
  TIM1_ICPOLARITY_RISING            = ((uint8_t)0x00),
  TIM1_ICPOLARITY_FALLING           = ((uint8_t)0x01)
}TIM1_ICPolarity_TypeDef;




/** TIM1 Input Capture Selection */
typedef enum
{
  TIM1_ICSELECTION_DIRECTTI          = ((uint8_t)0x01),
  TIM1_ICSELECTION_INDIRECTTI        = ((uint8_t)0x02),
  TIM1_ICSELECTION_TRGI              = ((uint8_t)0x03)
}TIM1_ICSelection_TypeDef;





/** TIM1 Input Capture Prescaler */
typedef enum
{
  TIM1_ICPSC_DIV1                    = ((uint8_t)0x00),
  TIM1_ICPSC_DIV2                    = ((uint8_t)0x04),
  TIM1_ICPSC_DIV4                    = ((uint8_t)0x08),
  TIM1_ICPSC_DIV8                    = ((uint8_t)0x0C)
}TIM1_ICPSC_TypeDef;






/** TIM1 Input Capture Filer Value */



/** TIM1 External Trigger Filer Value */


/** TIM1 interrupt sources */
typedef enum
{
  TIM1_IT_UPDATE                     = ((uint8_t)0x01),
  TIM1_IT_CC1                        = ((uint8_t)0x02),
  TIM1_IT_CC2                        = ((uint8_t)0x04),
  TIM1_IT_CC3                        = ((uint8_t)0x08),
  TIM1_IT_CC4                        = ((uint8_t)0x10),
  TIM1_IT_COM                        = ((uint8_t)0x20),
  TIM1_IT_TRIGGER                    = ((uint8_t)0x40),
  TIM1_IT_BREAK                      = ((uint8_t)0x80)
}TIM1_IT_TypeDef;



#line 299 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"


/** TIM1 External Trigger Prescaler */
typedef enum
{
  TIM1_EXTTRGPSC_OFF                 = ((uint8_t)0x00),
  TIM1_EXTTRGPSC_DIV2                = ((uint8_t)0x10),
  TIM1_EXTTRGPSC_DIV4                = ((uint8_t)0x20),
  TIM1_EXTTRGPSC_DIV8                = ((uint8_t)0x30)
}TIM1_ExtTRGPSC_TypeDef;






/** TIM1 Internal Trigger Selection */
typedef enum
{
  TIM1_TS_TIM6                       = ((uint8_t)0x00),  /*!< TRIG Input source =  TIM6 TRIG Output  */
  TIM1_TS_TIM5                       = ((uint8_t)0x30),  /*!< TRIG Input source =  TIM5 TRIG Output  */
  TIM1_TS_TI1F_ED                    = ((uint8_t)0x40),
  TIM1_TS_TI1FP1                     = ((uint8_t)0x50),
  TIM1_TS_TI2FP2                     = ((uint8_t)0x60),
  TIM1_TS_ETRF                       = ((uint8_t)0x70)
}TIM1_TS_TypeDef;

#line 332 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"






/** TIM1 TIx External Clock Source */
typedef enum
{
  TIM1_TIXEXTERNALCLK1SOURCE_TI1ED   = ((uint8_t)0x40),
  TIM1_TIXEXTERNALCLK1SOURCE_TI1     = ((uint8_t)0x50),
  TIM1_TIXEXTERNALCLK1SOURCE_TI2     = ((uint8_t)0x60)
}TIM1_TIxExternalCLK1Source_TypeDef;





/** TIM1 External Trigger Polarity */
typedef enum
{
  TIM1_EXTTRGPOLARITY_INVERTED       = ((uint8_t)0x80),
  TIM1_EXTTRGPOLARITY_NONINVERTED    = ((uint8_t)0x00)
}TIM1_ExtTRGPolarity_TypeDef;




/** TIM1 Prescaler Reload Mode */
typedef enum
{
  TIM1_PSCRELOADMODE_UPDATE          = ((uint8_t)0x00),
  TIM1_PSCRELOADMODE_IMMEDIATE       = ((uint8_t)0x01)
}TIM1_PSCReloadMode_TypeDef;




/** TIM1 Encoder Mode */
typedef enum
{
  TIM1_ENCODERMODE_TI1               = ((uint8_t)0x01),
  TIM1_ENCODERMODE_TI2               = ((uint8_t)0x02),
  TIM1_ENCODERMODE_TI12              = ((uint8_t)0x03)
}TIM1_EncoderMode_TypeDef;





/** TIM1 Event Source */
typedef enum
{
  TIM1_EVENTSOURCE_UPDATE            = ((uint8_t)0x01),
  TIM1_EVENTSOURCE_CC1               = ((uint8_t)0x02),
  TIM1_EVENTSOURCE_CC2               = ((uint8_t)0x04),
  TIM1_EVENTSOURCE_CC3               = ((uint8_t)0x08),
  TIM1_EVENTSOURCE_CC4               = ((uint8_t)0x10),
  TIM1_EVENTSOURCE_COM               = ((uint8_t)0x20),
  TIM1_EVENTSOURCE_TRIGGER           = ((uint8_t)0x40),
  TIM1_EVENTSOURCE_BREAK             = ((uint8_t)0x80)
}TIM1_EventSource_TypeDef;



/** TIM1 Update Source */
typedef enum
{
  TIM1_UPDATESOURCE_GLOBAL           = ((uint8_t)0x00),
  TIM1_UPDATESOURCE_REGULAR          = ((uint8_t)0x01)
}TIM1_UpdateSource_TypeDef;




/** TIM1 Trigger Output Source */
typedef enum
{
  TIM1_TRGOSOURCE_RESET              = ((uint8_t)0x00),
  TIM1_TRGOSOURCE_ENABLE             = ((uint8_t)0x10),
  TIM1_TRGOSOURCE_UPDATE             = ((uint8_t)0x20),
  TIM1_TRGOSource_OC1                = ((uint8_t)0x30),
  TIM1_TRGOSOURCE_OC1REF             = ((uint8_t)0x40),
  TIM1_TRGOSOURCE_OC2REF             = ((uint8_t)0x50),
  TIM1_TRGOSOURCE_OC3REF             = ((uint8_t)0x60)
}TIM1_TRGOSource_TypeDef;

#line 426 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"

/** TIM1 Slave Mode */
typedef enum
{
  TIM1_SLAVEMODE_RESET               = ((uint8_t)0x04),
  TIM1_SLAVEMODE_GATED               = ((uint8_t)0x05),
  TIM1_SLAVEMODE_TRIGGER             = ((uint8_t)0x06),
  TIM1_SLAVEMODE_EXTERNAL1           = ((uint8_t)0x07)
}TIM1_SlaveMode_TypeDef;






/** TIM1 Flags */
typedef enum
{
  TIM1_FLAG_UPDATE                   = ((uint16_t)0x0001),
  TIM1_FLAG_CC1                      = ((uint16_t)0x0002),
  TIM1_FLAG_CC2                      = ((uint16_t)0x0004),
  TIM1_FLAG_CC3                      = ((uint16_t)0x0008),
  TIM1_FLAG_CC4                      = ((uint16_t)0x0010),
  TIM1_FLAG_COM                      = ((uint16_t)0x0020),
  TIM1_FLAG_TRIGGER                  = ((uint16_t)0x0040),
  TIM1_FLAG_BREAK                    = ((uint16_t)0x0080),
  TIM1_FLAG_CC1OF                    = ((uint16_t)0x0200),
  TIM1_FLAG_CC2OF                    = ((uint16_t)0x0400),
  TIM1_FLAG_CC3OF                    = ((uint16_t)0x0800),
  TIM1_FLAG_CC4OF                    = ((uint16_t)0x1000)
}TIM1_FLAG_TypeDef;

#line 470 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim1.h"



/** TIM1 Forced Action */
typedef enum
{
  TIM1_FORCEDACTION_ACTIVE           = ((uint8_t)0x50),
  TIM1_FORCEDACTION_INACTIVE         = ((uint8_t)0x40)
}TIM1_ForcedAction_TypeDef;



/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/

/** @addtogroup TIM1_Exported_Functions
  * @{
  */

void TIM1_DeInit(void);
void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler, 
                       TIM1_CounterMode_TypeDef TIM1_CounterMode,
                       uint16_t TIM1_Period, uint8_t TIM1_RepetitionCounter);
void TIM1_OC1Init(TIM1_OCMode_TypeDef TIM1_OCMode, 
                  TIM1_OutputState_TypeDef TIM1_OutputState, 
                  TIM1_OutputNState_TypeDef TIM1_OutputNState, 
                  uint16_t TIM1_Pulse, TIM1_OCPolarity_TypeDef TIM1_OCPolarity, 
                  TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity, 
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState, 
                  TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState);
void TIM1_OC2Init(TIM1_OCMode_TypeDef TIM1_OCMode, 
                  TIM1_OutputState_TypeDef TIM1_OutputState, 
                  TIM1_OutputNState_TypeDef TIM1_OutputNState, 
                  uint16_t TIM1_Pulse, TIM1_OCPolarity_TypeDef TIM1_OCPolarity, 
                  TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity, 
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState, 
                  TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState);
void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode, 
                  TIM1_OutputState_TypeDef TIM1_OutputState, 
                  TIM1_OutputNState_TypeDef TIM1_OutputNState, 
                  uint16_t TIM1_Pulse, TIM1_OCPolarity_TypeDef TIM1_OCPolarity, 
                  TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity, 
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState, 
                  TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState);
void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode, 
                  TIM1_OutputState_TypeDef TIM1_OutputState, uint16_t TIM1_Pulse,
                  TIM1_OCPolarity_TypeDef TIM1_OCPolarity, 
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState);
void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState, 
                     TIM1_LockLevel_TypeDef TIM1_LockLevel, uint8_t TIM1_DeadTime,
                     TIM1_BreakState_TypeDef TIM1_Break, 
                     TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity, 
                     TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput);
void TIM1_ICInit(TIM1_Channel_TypeDef TIM1_Channel, 
                 TIM1_ICPolarity_TypeDef TIM1_ICPolarity, 
                 TIM1_ICSelection_TypeDef TIM1_ICSelection, 
                 TIM1_ICPSC_TypeDef TIM1_ICPrescaler, uint8_t TIM1_ICFilter);
void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel, 
                     TIM1_ICPolarity_TypeDef TIM1_ICPolarity, 
                     TIM1_ICSelection_TypeDef TIM1_ICSelection, 
                     TIM1_ICPSC_TypeDef TIM1_ICPrescaler, uint8_t TIM1_ICFilter);
void TIM1_Cmd(FunctionalState NewState);
void TIM1_CtrlPWMOutputs(FunctionalState NewState);
void TIM1_ITConfig(TIM1_IT_TypeDef TIM1_IT, FunctionalState NewState);
void TIM1_InternalClockConfig(void);
void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler, 
                              TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity, 
                              uint8_t ExtTRGFilter);
void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler, 
                              TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity, 
                              uint8_t ExtTRGFilter);
void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler, 
                    TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity, 
                    uint8_t ExtTRGFilter);
void TIM1_TIxExternalClockConfig(TIM1_TIxExternalCLK1Source_TypeDef TIM1_TIxExternalCLKSource, 
                                 TIM1_ICPolarity_TypeDef TIM1_ICPolarity, 
                                 uint8_t ICFilter);
void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource);
void TIM1_UpdateDisableConfig(FunctionalState NewState);
void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource);
void TIM1_SelectHallSensor(FunctionalState NewState);
void TIM1_SelectOnePulseMode(TIM1_OPMode_TypeDef TIM1_OPMode);
void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource);
void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode);
void TIM1_SelectMasterSlaveMode(FunctionalState NewState);
void TIM1_EncoderInterfaceConfig(TIM1_EncoderMode_TypeDef TIM1_EncoderMode, 
                                 TIM1_ICPolarity_TypeDef TIM1_IC1Polarity, 
                                 TIM1_ICPolarity_TypeDef TIM1_IC2Polarity);
void TIM1_PrescalerConfig(uint16_t Prescaler, TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode);
void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode);
void TIM1_ForcedOC1Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction);
void TIM1_ForcedOC2Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction);
void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction);
void TIM1_ForcedOC4Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction);
void TIM1_ARRPreloadConfig(FunctionalState NewState);
void TIM1_SelectCOM(FunctionalState NewState);
void TIM1_CCPreloadControl(FunctionalState NewState);
void TIM1_OC1PreloadConfig(FunctionalState NewState);
void TIM1_OC2PreloadConfig(FunctionalState NewState);
void TIM1_OC3PreloadConfig(FunctionalState NewState);
void TIM1_OC4PreloadConfig(FunctionalState NewState);
void TIM1_OC1FastConfig(FunctionalState NewState);
void TIM1_OC2FastConfig(FunctionalState NewState);
void TIM1_OC3FastConfig(FunctionalState NewState);
void TIM1_OC4FastConfig(FunctionalState NewState);
void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource);
void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity);
void TIM1_OC1NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity);
void TIM1_OC2PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity);
void TIM1_OC2NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity);
void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity);
void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity);
void TIM1_OC4PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity);
void TIM1_CCxCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState);
void TIM1_CCxNCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState);
void TIM1_SelectOCxM(TIM1_Channel_TypeDef TIM1_Channel, TIM1_OCMode_TypeDef TIM1_OCMode);
void TIM1_SetCounter(uint16_t Counter);
void TIM1_SetAutoreload(uint16_t Autoreload);
void TIM1_SetCompare1(uint16_t Compare1);
void TIM1_SetCompare2(uint16_t Compare2);
void TIM1_SetCompare3(uint16_t Compare3);
void TIM1_SetCompare4(uint16_t Compare4);
void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler);
void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler);
void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler);
void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler);
uint16_t TIM1_GetCapture1(void);
uint16_t TIM1_GetCapture2(void);
uint16_t TIM1_GetCapture3(void);
uint16_t TIM1_GetCapture4(void);
uint16_t TIM1_GetCounter(void);
uint16_t TIM1_GetPrescaler(void);
FlagStatus TIM1_GetFlagStatus(TIM1_FLAG_TypeDef TIM1_FLAG);
void TIM1_ClearFlag(TIM1_FLAG_TypeDef TIM1_FLAG);
ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT);
void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT);

/**
  * @}
  */



/**
  * @}
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 31 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim2.h"
/**
  ******************************************************************************
  * @file    stm8s_tim2.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the TIM2 peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/* Exported types ------------------------------------------------------------*/


/** TIM2 Forced Action */
typedef enum
{
  TIM2_FORCEDACTION_ACTIVE           = ((uint8_t)0x50),
  TIM2_FORCEDACTION_INACTIVE         = ((uint8_t)0x40)
}TIM2_ForcedAction_TypeDef;




/** TIM2 Prescaler */
typedef enum
{
  TIM2_PRESCALER_1  = ((uint8_t)0x00),
  TIM2_PRESCALER_2    = ((uint8_t)0x01),
  TIM2_PRESCALER_4    = ((uint8_t)0x02),
  TIM2_PRESCALER_8     = ((uint8_t)0x03),
  TIM2_PRESCALER_16   = ((uint8_t)0x04),
  TIM2_PRESCALER_32     = ((uint8_t)0x05),
  TIM2_PRESCALER_64    = ((uint8_t)0x06),
  TIM2_PRESCALER_128   = ((uint8_t)0x07),
  TIM2_PRESCALER_256   = ((uint8_t)0x08),
  TIM2_PRESCALER_512   = ((uint8_t)0x09),
  TIM2_PRESCALER_1024  = ((uint8_t)0x0A),
  TIM2_PRESCALER_2048 = ((uint8_t)0x0B),
  TIM2_PRESCALER_4096   = ((uint8_t)0x0C),
  TIM2_PRESCALER_8192 = ((uint8_t)0x0D),
  TIM2_PRESCALER_16384 = ((uint8_t)0x0E),
  TIM2_PRESCALER_32768 = ((uint8_t)0x0F)
}TIM2_Prescaler_TypeDef;

#line 89 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim2.h"

/** TIM2 Output Compare and PWM modes */
typedef enum
{
  TIM2_OCMODE_TIMING     = ((uint8_t)0x00),
  TIM2_OCMODE_ACTIVE     = ((uint8_t)0x10),
  TIM2_OCMODE_INACTIVE   = ((uint8_t)0x20),
  TIM2_OCMODE_TOGGLE     = ((uint8_t)0x30),
  TIM2_OCMODE_PWM1       = ((uint8_t)0x60),
  TIM2_OCMODE_PWM2       = ((uint8_t)0x70)
}TIM2_OCMode_TypeDef;

#line 107 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim2.h"

#line 116 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim2.h"

/** TIM2 One Pulse Mode */
typedef enum
{
  TIM2_OPMODE_SINGLE                 = ((uint8_t)0x01),
  TIM2_OPMODE_REPETITIVE             = ((uint8_t)0x00)
}TIM2_OPMode_TypeDef;




/** TIM2 Channel */
typedef enum
{
  TIM2_CHANNEL_1                     = ((uint8_t)0x00),
  TIM2_CHANNEL_2                     = ((uint8_t)0x01),
  TIM2_CHANNEL_3                     = ((uint8_t)0x02)
}TIM2_Channel_TypeDef;








/** TIM2 Output Compare Polarity */
typedef enum
{
  TIM2_OCPOLARITY_HIGH               = ((uint8_t)0x00),
  TIM2_OCPOLARITY_LOW                = ((uint8_t)0x22)
}TIM2_OCPolarity_TypeDef;




/** TIM2 Output Compare states */
typedef enum
{
  TIM2_OUTPUTSTATE_DISABLE           = ((uint8_t)0x00),
  TIM2_OUTPUTSTATE_ENABLE            = ((uint8_t)0x11)
}TIM2_OutputState_TypeDef;




/** TIM2 Input Capture Polarity */
typedef enum
{
  TIM2_ICPOLARITY_RISING            = ((uint8_t)0x00),
  TIM2_ICPOLARITY_FALLING           = ((uint8_t)0x44)
}TIM2_ICPolarity_TypeDef;




/** TIM2 Input Capture Selection */
typedef enum
{
  TIM2_ICSELECTION_DIRECTTI          = ((uint8_t)0x01),
  TIM2_ICSELECTION_INDIRECTTI        = ((uint8_t)0x02),
  TIM2_ICSELECTION_TRGI              = ((uint8_t)0x03)
}TIM2_ICSelection_TypeDef;








/** TIM2 Input Capture Prescaler */
typedef enum
{
  TIM2_ICPSC_DIV1                    = ((uint8_t)0x00),
  TIM2_ICPSC_DIV2                    = ((uint8_t)0x04),
  TIM2_ICPSC_DIV4                    = ((uint8_t)0x08),
  TIM2_ICPSC_DIV8                    = ((uint8_t)0x0C)
}TIM2_ICPSC_TypeDef;






/** TIM2 Input Capture Filer Value */


/** TIM2 interrupt sources */
typedef enum
{
  TIM2_IT_UPDATE                     = ((uint8_t)0x01),
  TIM2_IT_CC1                        = ((uint8_t)0x02),
  TIM2_IT_CC2                        = ((uint8_t)0x04),
  TIM2_IT_CC3                        = ((uint8_t)0x08)
}TIM2_IT_TypeDef;








/** TIM2 Prescaler Reload Mode */
typedef enum
{
  TIM2_PSCRELOADMODE_UPDATE          = ((uint8_t)0x00),
  TIM2_PSCRELOADMODE_IMMEDIATE       = ((uint8_t)0x01)
}TIM2_PSCReloadMode_TypeDef;




/** TIM2 Event Source */
typedef enum
{
  TIM2_EVENTSOURCE_UPDATE            = ((uint8_t)0x01),
  TIM2_EVENTSOURCE_CC1               = ((uint8_t)0x02),
  TIM2_EVENTSOURCE_CC2               = ((uint8_t)0x04),
  TIM2_EVENTSOURCE_CC3               = ((uint8_t)0x08)
}TIM2_EventSource_TypeDef;



/** TIM2 Update Source */
typedef enum
{
  TIM2_UPDATESOURCE_GLOBAL           = ((uint8_t)0x00),
  TIM2_UPDATESOURCE_REGULAR          = ((uint8_t)0x01)
}TIM2_UpdateSource_TypeDef;




/** TIM2 Flags */
typedef enum
{
  TIM2_FLAG_UPDATE                   = ((uint16_t)0x0001),
  TIM2_FLAG_CC1                      = ((uint16_t)0x0002),
  TIM2_FLAG_CC2                      = ((uint16_t)0x0004),
  TIM2_FLAG_CC3                      = ((uint16_t)0x0008),
  TIM2_FLAG_CC1OF                    = ((uint16_t)0x0200),
  TIM2_FLAG_CC2OF                    = ((uint16_t)0x0400),
  TIM2_FLAG_CC3OF                    = ((uint16_t)0x0800)
}TIM2_FLAG_TypeDef;

#line 270 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim2.h"


                                    
/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/

/** @addtogroup TIM2_Exported_Functions
  * @{
  */

void TIM2_DeInit(void);
void TIM2_TimeBaseInit(TIM2_Prescaler_TypeDef TIM2_Prescaler, uint16_t TIM2_Period);
void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode, TIM2_OutputState_TypeDef TIM2_OutputState, uint16_t TIM2_Pulse, TIM2_OCPolarity_TypeDef TIM2_OCPolarity);
void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode, TIM2_OutputState_TypeDef TIM2_OutputState, uint16_t TIM2_Pulse, TIM2_OCPolarity_TypeDef TIM2_OCPolarity);
void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode, TIM2_OutputState_TypeDef TIM2_OutputState, uint16_t TIM2_Pulse, TIM2_OCPolarity_TypeDef TIM2_OCPolarity);
void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel, TIM2_ICPolarity_TypeDef TIM2_ICPolarity, TIM2_ICSelection_TypeDef TIM2_ICSelection,  TIM2_ICPSC_TypeDef TIM2_ICPrescaler, uint8_t TIM2_ICFilter);
void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel, TIM2_ICPolarity_TypeDef TIM2_ICPolarity, TIM2_ICSelection_TypeDef TIM2_ICSelection,  TIM2_ICPSC_TypeDef TIM2_ICPrescaler, uint8_t TIM2_ICFilter);
void TIM2_Cmd(FunctionalState NewState);
void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState);
void TIM2_InternalClockConfig(void);
void TIM2_UpdateDisableConfig(FunctionalState NewState);
void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource);
void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode);
void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler, TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode);
void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction);
void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction);
void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction);
void TIM2_ARRPreloadConfig(FunctionalState NewState);
void TIM2_CCPreloadControl(FunctionalState NewState);
void TIM2_OC1PreloadConfig(FunctionalState NewState);
void TIM2_OC2PreloadConfig(FunctionalState NewState);
void TIM2_OC3PreloadConfig(FunctionalState NewState);
void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource);
void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity);
void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity);
void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity);
void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState);
void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode);
void TIM2_SetCounter(uint16_t Counter);
void TIM2_SetAutoreload(uint16_t Autoreload);
void TIM2_SetCompare1(uint16_t Compare1);
void TIM2_SetCompare2(uint16_t Compare2);
void TIM2_SetCompare3(uint16_t Compare3);
void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler);
void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler);
void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler);
uint16_t TIM2_GetCapture1(void);
uint16_t TIM2_GetCapture2(void);
uint16_t TIM2_GetCapture3(void);
uint16_t TIM2_GetCounter(void);
TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void);
FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG);
void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG);
ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT);
void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT);

/**
  * @}
  */



/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 33 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim4.h"
/**
  ******************************************************************************
  * @file    stm8s_tim4.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the TIM4 peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/* Exported types ------------------------------------------------------------*/

/** @addtogroup TIM4_Exported_Types
  * @{
  */



/** TIM4 Prescaler */
typedef enum
{
  TIM4_PRESCALER_1  = ((uint8_t)0x00),
  TIM4_PRESCALER_2    = ((uint8_t)0x01),
  TIM4_PRESCALER_4    = ((uint8_t)0x02),
  TIM4_PRESCALER_8     = ((uint8_t)0x03),
  TIM4_PRESCALER_16   = ((uint8_t)0x04),
  TIM4_PRESCALER_32     = ((uint8_t)0x05),
  TIM4_PRESCALER_64    = ((uint8_t)0x06),
  TIM4_PRESCALER_128   = ((uint8_t)0x07)
} TIM4_Prescaler_TypeDef;

#line 68 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_tim4.h"

/** TIM4 One Pulse Mode */
typedef enum
{
  TIM4_OPMODE_SINGLE                 = ((uint8_t)0x01),
  TIM4_OPMODE_REPETITIVE             = ((uint8_t)0x00)
} TIM4_OPMode_TypeDef;




/** TIM4 Prescaler Reload Mode */
typedef enum
{
  TIM4_PSCRELOADMODE_UPDATE          = ((uint8_t)0x00),
  TIM4_PSCRELOADMODE_IMMEDIATE       = ((uint8_t)0x01)
} TIM4_PSCReloadMode_TypeDef;




/** TIM4 Update Source */
typedef enum
{
  TIM4_UPDATESOURCE_GLOBAL           = ((uint8_t)0x00),
  TIM4_UPDATESOURCE_REGULAR          = ((uint8_t)0x01)
} TIM4_UpdateSource_TypeDef;




/** TIM4 Event Source */
typedef enum
{
  TIM4_EVENTSOURCE_UPDATE            = ((uint8_t)0x01)
}TIM4_EventSource_TypeDef;



/** TIM4 Flags */
typedef enum
{
  TIM4_FLAG_UPDATE                   = ((uint8_t)0x01)
}TIM4_FLAG_TypeDef;





/** TIM4 interrupt sources */
typedef enum
{
  TIM4_IT_UPDATE                     = ((uint8_t)0x01)
}TIM4_IT_TypeDef;





/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/

/** @addtogroup TIM4_Exported_Functions
  * @{
  */
void TIM4_DeInit(void);
void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period);
void TIM4_Cmd(FunctionalState NewState);
void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState);
void TIM4_UpdateDisableConfig(FunctionalState NewState);
void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource);
void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode);
void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode);
void TIM4_ARRPreloadConfig(FunctionalState NewState);
void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource);
void TIM4_SetCounter(uint8_t Counter);
void TIM4_SetAutoreload(uint8_t Autoreload);
uint8_t TIM4_GetCounter(void);
TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void);
FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG);
void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG);
ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT);
void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT);


/**
  * @}
  */



/**
  * @}
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 40 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_uart1.h"
/**
  ********************************************************************************
  * @file    stm8s_uart1.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototypes and macros for the UART1 peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/* Exported types ------------------------------------------------------------*/

/** @addtogroup UART1_Exported_Types
  * @{
  */


/**
  * @brief  UART1 Irda Modes
  */

typedef enum { UART1_IRDAMODE_NORMAL    = (uint8_t)0x00, /**< 0x00 Irda Normal Mode   */
               UART1_IRDAMODE_LOWPOWER  = (uint8_t)0x01  /**< 0x01 Irda Low Power Mode */
             } UART1_IrDAMode_TypeDef;

/**
  * @brief  UART1 WakeUP Modes
  */
typedef enum { UART1_WAKEUP_IDLELINE       = (uint8_t)0x00, /**< 0x01 Idle Line wake up                */
               UART1_WAKEUP_ADDRESSMARK    = (uint8_t)0x08  /**< 0x02 Address Mark wake up          */
             } UART1_WakeUp_TypeDef;

/**
  * @brief  UART1 LIN Break detection length possible values
  */
typedef enum { UART1_LINBREAKDETECTIONLENGTH_10BITS = (uint8_t)0x00, /**< 0x01 10 bits Lin Break detection            */
               UART1_LINBREAKDETECTIONLENGTH_11BITS = (uint8_t)0x01  /**< 0x02 11 bits Lin Break detection          */
             } UART1_LINBreakDetectionLength_TypeDef;

/**
  * @brief  UART1 stop bits possible values
  */

typedef enum { UART1_STOPBITS_1   = (uint8_t)0x00,    /**< One stop bit is  transmitted at the end of frame*/
               UART1_STOPBITS_0_5 = (uint8_t)0x10,    /**< Half stop bits is transmitted at the end of frame*/
               UART1_STOPBITS_2   = (uint8_t)0x20,    /**< Two stop bits are  transmitted at the end of frame*/
               UART1_STOPBITS_1_5 = (uint8_t)0x30     /**< One and half stop bits*/
             } UART1_StopBits_TypeDef;

/**
  * @brief  UART1 parity possible values
  */
typedef enum { UART1_PARITY_NO     = (uint8_t)0x00,      /**< No Parity*/
               UART1_PARITY_EVEN   = (uint8_t)0x04,      /**< Even Parity*/
               UART1_PARITY_ODD    = (uint8_t)0x06       /**< Odd Parity*/
             } UART1_Parity_TypeDef;

/**
  * @brief  UART1 Synchrone modes
  */
typedef enum { UART1_SYNCMODE_CLOCK_DISABLE    = (uint8_t)0x80, /**< 0x80 Sync mode Disable, SLK pin Disable */
               UART1_SYNCMODE_CLOCK_ENABLE     = (uint8_t)0x08, /**< 0x08 Sync mode Enable, SLK pin Enable     */
               UART1_SYNCMODE_CPOL_LOW         = (uint8_t)0x40, /**< 0x40 Steady low value on SCLK pin outside transmission window */
               UART1_SYNCMODE_CPOL_HIGH        = (uint8_t)0x04, /**< 0x04 Steady high value on SCLK pin outside transmission window */
               UART1_SYNCMODE_CPHA_MIDDLE      = (uint8_t)0x20, /**< 0x20 SCLK clock line activated in middle of data bit     */
               UART1_SYNCMODE_CPHA_BEGINING    = (uint8_t)0x02, /**< 0x02 SCLK clock line activated at beginning of data bit  */
               UART1_SYNCMODE_LASTBIT_DISABLE  = (uint8_t)0x10, /**< 0x10 The clock pulse of the last data bit is not output to the SCLK pin */
               UART1_SYNCMODE_LASTBIT_ENABLE   = (uint8_t)0x01  /**< 0x01 The clock pulse of the last data bit is output to the SCLK pin */
             } UART1_SyncMode_TypeDef;

/**
  * @brief  UART1 Word length possible values
  */
typedef enum { UART1_WORDLENGTH_8D = (uint8_t)0x00,/**< 0x00 8 bits Data  */
               UART1_WORDLENGTH_9D = (uint8_t)0x10 /**< 0x10 9 bits Data  */
             } UART1_WordLength_TypeDef;

/**
  * @brief  UART1 Mode possible values
  */
typedef enum { UART1_MODE_RX_ENABLE     = (uint8_t)0x08,  /**< 0x08 Receive Enable */
               UART1_MODE_TX_ENABLE     = (uint8_t)0x04,  /**< 0x04 Transmit Enable */
               UART1_MODE_TX_DISABLE    = (uint8_t)0x80,  /**< 0x80 Transmit Disable */
               UART1_MODE_RX_DISABLE    = (uint8_t)0x40,  /**< 0x40 Single-wire Half-duplex mode */
               UART1_MODE_TXRX_ENABLE   = (uint8_t)0x0C  /**< 0x0C Transmit Enable and Receive Enable */
             } UART1_Mode_TypeDef;

/**
  * @brief  UART1 Flag possible values
  */
typedef enum { UART1_FLAG_TXE   = (uint16_t)0x0080, /*!< Transmit Data Register Empty flag */
               UART1_FLAG_TC    = (uint16_t)0x0040, /*!< Transmission Complete flag */
               UART1_FLAG_RXNE  = (uint16_t)0x0020, /*!< Read Data Register Not Empty flag */
               UART1_FLAG_IDLE  = (uint16_t)0x0010, /*!< Idle line detected flag */
               UART1_FLAG_OR    = (uint16_t)0x0008, /*!< OverRun error flag */
               UART1_FLAG_NF    = (uint16_t)0x0004, /*!< Noise error flag */
               UART1_FLAG_FE    = (uint16_t)0x0002, /*!< Framing Error flag */
               UART1_FLAG_PE    = (uint16_t)0x0001, /*!< Parity Error flag */
               UART1_FLAG_LBDF  = (uint16_t)0x0210, /*!< Line Break Detection Flag */
               UART1_FLAG_SBK   = (uint16_t)0x0101  /*!< Send Break characters Flag */
             } UART1_Flag_TypeDef;

/**
  * @brief  UART1 Interrupt definition
  * UART1_IT possible values
  * Elements values convention: 0xZYX
  * X: Position of the corresponding Interrupt
  *   - For the following values, X means the interrupt position in the CR2 register.
  *     UART1_IT_TXE
  *     UART1_IT_TC
  *     UART1_IT_RXNE
  *     UART1_IT_IDLE 
  *     UART1_IT_OR 
  *   - For the UART1_IT_PE value, X means the flag position in the CR1 register.
  *   - For the UART1_IT_LBDF value, X means the flag position in the CR4 register.
  * Y: Flag position
  *  - For the following values, Y means the flag (pending bit) position in the SR register.
  *     UART1_IT_TXE
  *     UART1_IT_TC
  *     UART1_IT_RXNE
  *     UART1_IT_IDLE 
  *     UART1_IT_OR
  *     UART1_IT_PE
  *  - For the UART1_IT_LBDF value, Y means the flag position in the CR4 register.
  * Z: Register index: indicate in which register the dedicated interrupt source is:
  *  - 1==> CR1 register
  *  - 2==> CR2 register
  *  - 3==> CR4 register
  */
typedef enum { UART1_IT_TXE        = (uint16_t)0x0277, /*!< Transmit interrupt */
               UART1_IT_TC         = (uint16_t)0x0266, /*!< Transmission Complete interrupt */
               UART1_IT_RXNE       = (uint16_t)0x0255, /*!< Receive interrupt */
               UART1_IT_IDLE       = (uint16_t)0x0244, /*!< IDLE line interrupt */
               UART1_IT_OR         = (uint16_t)0x0235, /*!< Overrun Error interrupt */
               UART1_IT_PE         = (uint16_t)0x0100, /*!< Parity Error interrupt */
               UART1_IT_LBDF       = (uint16_t)0x0346, /**< LIN break detection interrupt */
               UART1_IT_RXNE_OR    = (uint16_t)0x0205  /*!< Receive/Overrun interrupt */
             } UART1_IT_TypeDef;

/**
  * @}
  */

/* Exported constants --------------------------------------------------------*/
/* Exported macros ------------------------------------------------------------*/

/* Private macros ------------------------------------------------------------*/

/** @addtogroup UART1_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function to check the different functions parameters.
  */

/**
 * @brief Macro used by the assert_param function in order to check the different
 *        sensitivity values for the MODEs possible combination should be one of
 *        the following
 */
#line 200 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_uart1.h"

/**
 * @brief Macro used by the assert_param function in order to check the different
 *        sensitivity values for the WordLengths
 */




/**
  * @brief  Macro used by the assert_param function in order to check the different
  *         sensitivity values for the SyncModes; it should exclude values such 
  *         as  UART1_CLOCK_ENABLE|UART1_CLOCK_DISABLE
  */






/**
  * @brief  Macro used by the assert_param function in order to check the different
  *         sensitivity values for the FLAGs
  */
#line 235 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_uart1.h"
/**
  * @brief  Macro used by the assert_param function in order to check the different
  *         sensitivity values for the FLAGs that can be cleared by writing 0
  */






/**
  * @brief  Macro used by the assert_param function in order to check the different 
  *         sensitivity values for the Interrupts
  */

#line 257 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_uart1.h"

/**
  * @brief  Macro used by the assert function in order to check the different 
  *         sensitivity values for the pending bit
  */
#line 270 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_uart1.h"

/**
  * @brief  Macro used by the assert function in order to check the different 
  *         sensitivity values for the pending bit that can be cleared by writing 0
  */





/**
 * @brief Macro used by the assert_param function in order to check the different
 *        sensitivity values for the IrDAModes
 */




/**
  * @brief  Macro used by the assert_param function in order to check the different
  *         sensitivity values for the WakeUps
  */




/**
  * @brief  Macro used by the assert_param function in order to check the different 
  *        sensitivity values for the LINBreakDetectionLengths
  */




/**
  * @brief  Macro used by the assert_param function in order to check the different
  *         sensitivity values for the UART1_StopBits
  */





/**
 * @brief Macro used by the assert_param function in order to check the different
 *        sensitivity values for the Parity
 */




/**
 * @brief Macro used by the assert_param function in order to check the maximum
 *        baudrate value
 */



/**
 * @brief Macro used by the assert_param function in order to check the address
 *        of the UART1 or UART node
 */



/**
  * @}
  */

/* Exported functions ------------------------------------------------------- */

/** @addtogroup UART1_Exported_Functions
  * @{
  */

void UART1_DeInit(void);
void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
                UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
                UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode);
void UART1_Cmd(FunctionalState NewState);
void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState);
void UART1_HalfDuplexCmd(FunctionalState NewState);
void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode);
void UART1_IrDACmd(FunctionalState NewState);
void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength);
void UART1_LINCmd(FunctionalState NewState);
void UART1_SmartCardCmd(FunctionalState NewState);
void UART1_SmartCardNACKCmd(FunctionalState NewState);
void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp);
void UART1_ReceiverWakeUpCmd(FunctionalState NewState);
uint8_t UART1_ReceiveData8(void);
uint16_t UART1_ReceiveData9(void);
void UART1_SendData8(uint8_t Data);
void UART1_SendData9(uint16_t Data);
void UART1_SendBreak(void);
void UART1_SetAddress(uint8_t UART1_Address);
void UART1_SetGuardTime(uint8_t UART1_GuardTime);
void UART1_SetPrescaler(uint8_t UART1_Prescaler);
FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG);
void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG);
ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT);
void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT);

/**
  * @}
  */



/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 48 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s_wwdg.h"
/**
  ********************************************************************************
  * @file    stm8s_wwdg.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the WWDG peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/



/* Includes ------------------------------------------------------------------*/


/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */

/* Private macros ------------------------------------------------------------*/

/** @addtogroup WWDG_Private_Macros
  * @{
  */

/**
  * @brief  Macro used by the assert function in order to check the
  * values of the window register.
  */


/**
  * @brief  Macro used by the assert function in order to check the different
  * values of the counter register.
  */


/**
  * @}
  */

/* Exported types ------------------------------------------------------------*/

/* Exported functions ------------------------------------------------------- */

/** @addtogroup WWDG_Exported_Functions
  * @{
  */

void WWDG_Init(uint8_t Counter, uint8_t WindowValue);
void WWDG_SetCounter(uint8_t Counter);
uint8_t WWDG_GetCounter(void);
void WWDG_SWReset(void);
void WWDG_SetWindowValue(uint8_t WindowValue);


/**
  * @}
  */



/**
  * @}
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 60 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\stm8s_conf.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Uncomment the line below to expanse the "assert_param" macro in the
   Standard Peripheral Library drivers code */


/* Exported macro ------------------------------------------------------------*/


/**
  * @brief  The assert_param macro is used for function's parameters check.
  * @param expr: If expr is false, it calls assert_failed function
  *   which reports the name of the source file and the source
  *   line number of the call that failed.
  *   If expr is true, it returns no value.
  * @retval : None
  */

/* Exported functions ------------------------------------------------------- */
void assert_failed(uint8_t* file, uint32_t line);




#line 2709 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"


/* Exported macro --------------------------------------------------------------*/

/*============================== Interrupts ====================================*/
#line 1 "E:\\IARSTM8\\stm8\\inc\\c\\intrinsics.h"
/**************************************************
 *
 * Intrinsic functions.
 *
 * Copyright 2010 IAR Systems AB.
 *
 * $Revision: 2677 $
 *
 **************************************************/





  #pragma system_include


#pragma language=save
#pragma language=extended


/*
 * The return type of "__get_interrupt_state".
 */

typedef unsigned char __istate_t;






  __intrinsic void __enable_interrupt(void);     /* RIM */
  __intrinsic void __disable_interrupt(void);    /* SIM */

  __intrinsic __istate_t __get_interrupt_state(void);
  __intrinsic void       __set_interrupt_state(__istate_t);

  /* Special instruction intrinsics */
  __intrinsic void __no_operation(void);         /* NOP */
  __intrinsic void __halt(void);                 /* HALT */
  __intrinsic void __trap(void);                 /* TRAP */
  __intrinsic void __wait_for_event(void);       /* WFE */
  __intrinsic void __wait_for_interrupt(void);   /* WFI */

  /* Bit manipulation */
  __intrinsic void __BCPL(unsigned char __near *, unsigned char);
  __intrinsic void __BRES(unsigned char __near *, unsigned char);
  __intrinsic void __BSET(unsigned char __near *, unsigned char);






#pragma language=restore

#line 2735 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"
#line 2744 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/*============================== Interrupt vector Handling ========================*/











#line 2767 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Libraries\\STM8S_StdPeriph_Driver\\inc\\stm8s.h"

/*============================== Interrupt Handler declaration ========================*/






/*============================== Handling bits ====================================*/
/*-----------------------------------------------------------------------------
Method : I
Description : Handle the bit from the character variables.
Comments :    The different parameters of commands are
              - VAR : Name of the character variable where the bit is located.
              - Place : Bit position in the variable (7 6 5 4 3 2 1 0)
              - Value : Can be 0 (reset bit) or not 0 (set bit)
              The "MskBit" command allows to select some bits in a source
              variables and copy it in a destination var (return the value).
              The "ValBit" command returns the value of a bit in a char
              variable: the bit is reset if it returns 0 else the bit is set.
              This method generates not an optimised code yet.
-----------------------------------------------------------------------------*/

















/*============================== Assert Macros ====================================*/




/*-----------------------------------------------------------------------------
Method : II
Description : Handle directly the bit.
Comments :    The idea is to handle directly with the bit name. For that, it is
              necessary to have RAM area descriptions (example: HW register...)
              and the following command line for each area.
              This method generates the most optimized code.
-----------------------------------------------------------------------------*/







/* Exported functions ------------------------------------------------------- */



/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
#line 5 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Application\\inc\\ek_tim.h"

/** 
  * 125KHz clock, 1ms update, 
  * this is a 8 bit timer, the max value is 255
  */


void ek_sys_tim_init(void);
void ek_soft_timer(void);
void ek_delay_counter(void);
void ek_delay(volatile uint32_t nms);

#line 2 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\src\\ek_tim.c"
#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Application\\inc\\ek_gpio.h"



#line 1 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\board_config.h"





/* Project.txt pin mapping */















#line 28 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\board_config.h"

#line 35 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\inc\\board_config.h"

#line 6 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\EWSTM8\\..\\Application\\inc\\ek_gpio.h"

void ek_gpio_init(void);
void board_outputs_all_off(void);
uint8_t board_input1_read(void);
uint8_t board_input2_read(void);

#line 3 "F:\\Cubemx_Project\\STM8XB\\stm8s003f3p6_template_led_and_printf\\Application\\src\\ek_tim.c"

volatile uint32_t ek_delay_tick = 0;

/* software timer */
void ek_soft_timer(void)
{
    /* for led control */
    if(ek_led_handle.timer)
    {
        ek_led_handle.timer--;
    }
}

/* nms @1ms */
void ek_delay(volatile uint32_t nms)
{
    ek_delay_tick = nms;
    
    /* wait */
    while(ek_delay_tick);
}

/* count for delay function */
void ek_delay_counter(void)
{
    if(ek_delay_tick)
    {
        ek_delay_tick--;
    }
}

/* hardware timer init */
void ek_sys_tim_init(void)
{
    /* system timer reset */
    TIM4_DeInit();
    
    /* set clock, and update period */
    TIM4_TimeBaseInit(TIM4_PRESCALER_64, 125);
    
    /* arr register preload */
    TIM4_ARRPreloadConfig(ENABLE);
    
    /* clear update flag */
    TIM4_ClearFlag(TIM4_FLAG_UPDATE);
    
    /* enable update interrupt */
    TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
    
    /* start timer */
    TIM4_Cmd(ENABLE);
}

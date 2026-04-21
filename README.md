# ES1642 -> STM8S003F3P6 移植建议文件

这不是原仓库的完整副本，而是一组可直接拷入工程的修改文件与骨架代码。

## 已按 Project.txt 配置的引脚
- PD5: UART1_TX
- PD6: UART1_RX
- PD2: ADC_IN3
- PD3: ADC_IN4
- PB5: 输入
- PC4: 输出
- PC5: 输出
- PC6: 输出
- PC7: 输入
- PD1: SWIM

## 建议替换/新增的文件
- `Application/inc/board_config.h`
- `Application/inc/ek_gpio.h`
- `Application/src/ek_gpio.c`
- `Application/inc/ek_uart.h`
- `Application/src/ek_uart.c`
- `Application/inc/es1642_port_stm8.h`
- `Application/src/es1642_port_stm8.c`
- `Application/src/main.c`

## 还需要你在原工程中同步处理的地方
1. 把 `es1642/es1642.c` 与 `es1642/es1642.h` 加入 IAR 工程分组。
2. 把上面新增的两个 `es1642_port_stm8.*` 文件加入工程。
3. 在 `stm8s_it.c` 的 UART1 RX 中断里调用 `es1642_uart_rx_irq_handler()`。
4. 如需真正删除搜索/远程控制等代码，可在 `es1642.h/.c` 中移除：
   - `ES1642_SendStartSearch`
   - `ES1642_SendStopSearch`
   - `ES1642_SendSearchReply`
   - `ES1642_SendRemoteReadVersion`
   - `ES1642_SendRemoteReadMac`
   - `ES1642_SendRemoteReadNetParam`
   以及对应 `CMD/typedef/decode`。

## 当前提供的策略
当前版本采用“先不调用、不接入”的方式，让从机先跑通：
- 只保留 UART 收发
- 只处理普通数据帧 `0x14/0x15`
- 其他命令收到后可以选择空应答或忽略

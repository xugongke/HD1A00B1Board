#include "es1642_port_stm8.h"
#include "ek_uart.h"
#include "ek_gpio.h"
#include "heater_ctrl.h"

#define MASTER_CMD_SET_ADDR    0x01  /* 主机命令: 设置通信地址 */
#define MASTER_CMD_HEATER_ON   0x02  /* 主机命令: 启动加热 */
#define MASTER_CMD_HEATER_OFF  0x03  /* 主机命令: 停止加热 */
#define MASTER_CMD_READ_STATUS 0x04  /* 主机命令: 读取从机状态 */

#define SLAVE_RESULT_OK        0x01
#define SLAVE_RESULT_FAIL      0x00

static es1642_handle_t g_es1642;
static uint8_t mac_addr[ES1642_ADDR_LEN];

int32_t stm8_es1642_write(const uint8_t *data, uint16_t len)
{
    if ((data == 0) || (len == 0U))
    {
        return 0;
    }

    ek_uart_send_bytes(data, len);
    return (int32_t)len;
}

static es1642_search_notify_t notify;
static es1642_recv_data_t recv_data;

void es1642_on_frame(es1642_handle_t *handle, const es1642_frame_t *frame)
{
    es1642_status_t status;
    if ((handle == 0) || (frame == 0)) { return; }

    switch (frame->cmd)
    {
      case ES1642_CMD_RECV_DATA:
      {
          status = ES1642_DecodeRecvData(frame, &recv_data);
          if (status == ES1642_STATUS_OK)
          {
              if (recv_data.user_data_len >= 2U)
              {
                  uint8_t cmd = recv_data.user_data[0];
                  uint8_t data_len = recv_data.user_data[1];
                  const uint8_t *data = &recv_data.user_data[2];
                  if (recv_data.user_data_len >= (2U + data_len))
                  {
                      switch (cmd)
                      {
                      case MASTER_CMD_SET_ADDR:
                          if (data_len == ES1642_ADDR_LEN)
                          {
                              ES1642_SendSetAddr(handle, data);
                          }
                          break;
                      case MASTER_CMD_HEATER_ON:
                          /* 主机命令启动加热: 设置全局命令标志 + 回复ACK */
                          g_master_cmd = 1;
                          {
                              uint8_t reply[3] = {MASTER_CMD_HEATER_ON, 0x01, SLAVE_RESULT_OK};
                              (void)ES1642_SendData(handle, recv_data.src_addr, reply, 3U, 0U);
                          }
                          break;
                      case MASTER_CMD_HEATER_OFF:
                          /* 主机命令停止加热: 清除全局命令标志 + 回复ACK */
                          g_master_cmd = 0;
                          {
                              uint8_t reply[3] = {MASTER_CMD_HEATER_OFF, 0x01, SLAVE_RESULT_OK};
                              (void)ES1642_SendData(handle, recv_data.src_addr, reply, 3U, 0U);
                          }
                          break;
                      case MASTER_CMD_READ_STATUS:
                          /* 主机请求读取从机状态: 打包温度+电压+状态+累计用电量(Wh)回复 */
                          {
                              uint32_t wh = heater_get_energy_wh();
                              /* 回复格式: [cmd=0x04][len=0x08][temp][vol_lo][vol_hi][state][wh0~wh3] */
                              uint8_t reply[2 + 8];
                              reply[0] = MASTER_CMD_READ_STATUS;
                              reply[1] = 0x08;  /* 数据长度: 8字节 */
                              reply[2] = (uint8_t)g_temperature;                    /* 温度 (int8_t) */
                              reply[3] = (uint8_t)(g_input_vol & 0xFF);             /* 电压低字节 */
                              reply[4] = (uint8_t)((g_input_vol >> 8) & 0xFF);      /* 电压高字节 */
                              reply[5] = g_state.byte;                               /* 状态字 */
                              reply[6] = (uint8_t)(wh & 0xFF);                       /* 累计用电量Wh 低字节 */
                              reply[7] = (uint8_t)((wh >> 8) & 0xFF);                /* 累计用电量Wh */
                              reply[8] = (uint8_t)((wh >> 16) & 0xFF);               /* 累计用电量Wh */
                              reply[9] = (uint8_t)((wh >> 24) & 0xFF);               /* 累计用电量Wh 高字节 */
                              (void)ES1642_SendData(handle, recv_data.src_addr, reply, sizeof(reply), 0U);
                          }
                          break;
                      default:
                          break;
                      }
                  }
              }
          }
          break;
      }
      case ES1642_CMD_SET_ADDR:
      {
          status = ES1642_DecodeEmptyResponse(frame, ES1642_CMD_SET_ADDR);
          if (status == ES1642_STATUS_OK)
          {
              uint8_t reply[3] = {MASTER_CMD_SET_ADDR, 0x01, SLAVE_RESULT_OK};
              (void)ES1642_SendData(handle, recv_data.src_addr, reply, 3U, 0U);
          }
          else
          {
              uint8_t reply[3] = {MASTER_CMD_SET_ADDR, 0x01, SLAVE_RESULT_FAIL};
              (void)ES1642_SendData(handle, recv_data.src_addr, reply, 3U, 0U);
          }
          break;
      }
      case ES1642_CMD_NOTIFY_SEARCH:
      {
          ES1642_DecodeSearchNotify(frame, &notify);
          ES1642_ReadMac();
          break;
      }
      case ES1642_CMD_READ_MAC:
      {
          status = ES1642_DecodeMac(frame, mac_addr);
          if (status == ES1642_STATUS_OK)
          {
              ES1642_SendSearchReply(handle, notify.src_addr, notify.task_id, TRUE, mac_addr, ES1642_ADDR_LEN);
          }
          break;
      }
    }
}

void es1642_app_init(void)
{
    ES1642_Init(&g_es1642);
    ES1642_ResetRx(&g_es1642);
}

void es1642_app_poll(void)
{
    uint8_t byte;
    while (ek_uart_read_byte(&byte) != 0U)
    {
        (void)ES1642_InputByte(&g_es1642, byte);
    }
}

void es1642_uart_rx_irq_handler(void)
{
    ek_uart_rx_isr();
}

int ES1642_ReadMac(void)
{
    es1642_status_t status;
    status = ES1642_SendReadMac(&g_es1642);
    if (status != ES1642_STATUS_OK) { return -1; }
    return 0;
}

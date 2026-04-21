#include <string.h>
#include "es1642_port_stm8.h"
#include "ek_uart.h"
#include "ek_gpio.h"

static es1642_handle_t g_es1642;
static uint8_t mac_addr[ES1642_ADDR_LEN];

static int32_t stm8_es1642_write(const uint8_t *data, uint16_t len, void *user_arg)
{
    (void)user_arg;
    if ((data == 0) || (len == 0U))
    {
        return 0;
    }

    ek_uart_send_bytes(data, len);
    return (int32_t)len;
}

static void es1642_apply_user_command(const uint8_t *data, uint16_t len)
{
    if ((data == 0) || (len == 0U))
    {
        return;
    }

    switch (data[0])
    {
    case 0x01:
        if (len >= 2U)
        {
            if (data[1]) BOARD_OUT1_ON(); else BOARD_OUT1_OFF();
        }
        break;

    case 0x02:
        if (len >= 2U)
        {
            if (data[1]) BOARD_OUT2_ON(); else BOARD_OUT2_OFF();
        }
        break;

    case 0x03:
        if (len >= 2U)
        {
            if (data[1]) BOARD_OUT3_ON(); else BOARD_OUT3_OFF();
        }
        break;

    default:
        break;
    }
}

static void es1642_on_frame(es1642_handle_t *handle, const es1642_frame_t *frame, void *user_arg)
{
    es1642_status_t status; 
    uint8_t src_addr[6] = {0x12,0x34,0x56,0x78,0x9A,0xBC};
    if ((handle == 0) || (frame == 0))
    {
        return;
    }
    
    /* 根据指令字处理不同类型的响应 */
    switch (frame->cmd)
    {
      case ES1642_CMD_RECV_DATA:
      {
        es1642_recv_data_t recv_data;
        status = ES1642_DecodeRecvData(frame, &recv_data);
        if (status == ES1642_STATUS_OK)
        {
          if(recv_data.user_data_len == 6)
          {
            //设置通信地址
            ES1642_SendSetAddr(handle,recv_data.user_data);
          }
        }
        break;
      }
      case ES1642_CMD_SET_ADDR:
      {
          status = ES1642_DecodeEmptyResponse(frame, ES1642_CMD_SET_ADDR);
          if (status == ES1642_STATUS_OK)//如果设置通信地址成功,给主机地址发送OK
          {
              uint8_t reply[4] = {0xaa,0xaa,0xaa,0xaa};
              //给主机回复成功修改响应
             (void)ES1642_SendData(handle, src_addr, reply, 4U, 0U, FALSE);
          }
          else
          {
              uint8_t reply[4] = {0xbb,0xbb,0xbb,0xbb};
              //给主机回复修改失败响应
             (void)ES1642_SendData(handle, src_addr, reply, 4U, 0U, FALSE);
          }
          break;
      }
      case ES1642_CMD_NOTIFY_SEARCH://接收到主机正在搜索
      {
          es1642_search_notify_t notify;
          status = ES1642_DecodeSearchNotify(frame, &notify);
          if (status == ES1642_STATUS_OK)
          {
              //回复搜索,并将从机MAC地址一块发送到主机
              ES1642_SendSearchReply(handle, notify.src_addr, notify.task_id, 1, mac_addr, ES1642_ADDR_LEN);
          }
          break;
      }
      case ES1642_CMD_READ_MAC://将MAC地址保存到RAM中
      {
          status = ES1642_DecodeMac(frame, mac_addr);
          if (status == ES1642_STATUS_OK)
          {
            
          }
          break;
      }
    }

}

static void es1642_on_error(es1642_handle_t *handle, es1642_status_t status, void *user_arg)
{
    (void)handle;
    (void)status;
    (void)user_arg;
}

void es1642_app_init(void)
{
    es1642_port_t port;

    memset(&port, 0, sizeof(port));
    port.write = stm8_es1642_write;
    port.on_frame = es1642_on_frame;
    port.on_error = es1642_on_error;
    port.user_arg = 0;

    ES1642_Init(&g_es1642, &port);
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

es1642_handle_t *es1642_get_handle(void)
{
    return &g_es1642;
}
/**
 * @brief  读取模块MAC地址
 * @retval 0: 成功, -1: 失败
 */
int ES1642_ReadMac(void)
{
    es1642_status_t status;
    
    status = ES1642_SendReadMac(&g_es1642);
    
    if (status != ES1642_STATUS_OK)
    {
        return -1;
    }
    
    return 0;
}

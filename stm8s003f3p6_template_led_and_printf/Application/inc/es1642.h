/**
 * @file    es1642.h
 * @brief   ES1642 载波通信驱动 - 精简版 (热水器从机)
 * @note    仅保留热水器从机实际使用的接口
 */

#ifndef ES1642_H
#define ES1642_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

/* ========================= 基本常量 ========================= */

#define ES1642_UART_BAUDRATE         9600U
#define ES1642_FRAME_HEAD            0x79U
#define ES1642_ADDR_LEN              6U

#ifndef ES1642_MAX_DATA_LEN
#define ES1642_MAX_DATA_LEN          32U
#endif

#define ES1642_MIN_FRAME_LEN         7U
#define ES1642_MAX_FRAME_LEN         (ES1642_MIN_FRAME_LEN + ES1642_MAX_DATA_LEN)

#define ES1642_SEND_DATA_FIXED_LEN   10U
#define ES1642_RECV_DATA_FIXED_LEN   11U

/* ========================= Ctrl 控制位 ========================= */

#define ES1642_CTRL_BIT_PRM          0x40U
#define ES1642_CTRL_BIT_RESPOND      0x20U

#ifndef ES1642_CTRL_DEVICE_REQUEST
#define ES1642_CTRL_DEVICE_REQUEST       0x58U
#endif

#ifndef ES1642_CTRL_DEVICE_REPLY
#define ES1642_CTRL_DEVICE_REPLY         0x18U
#endif

/* ========================= 指令字 (仅保留使用的) ========================= */

typedef enum
{
    ES1642_CMD_READ_MAC               = 0x03,
    ES1642_CMD_SET_ADDR               = 0x0C,
    ES1642_CMD_SEND_DATA              = 0x14,
    ES1642_CMD_RECV_DATA              = 0x15,
    ES1642_CMD_NOTIFY_SEARCH          = 0x1A,
    ES1642_CMD_REPLY_SEARCH           = 0x1B
} es1642_cmd_t;

/* ========================= 协议状态码 (精简) ========================= */

typedef enum
{
    ES1642_STATUS_OK = 0,
    ES1642_STATUS_IN_PROGRESS = 1,
    ES1642_STATUS_FRAME_READY = 2,

    ES1642_STATUS_ERROR_PARAM = 0x100,
    ES1642_STATUS_ERROR_NO_TX_PORT,
    ES1642_STATUS_ERROR_BUFFER_TOO_SMALL,
    ES1642_STATUS_ERROR_BAD_HEAD,
    ES1642_STATUS_ERROR_BAD_LENGTH,
    ES1642_STATUS_ERROR_DATA_TOO_LONG,
    ES1642_STATUS_ERROR_CHECKSUM,
    ES1642_STATUS_ERROR_CMD_MISMATCH,
    ES1642_STATUS_ERROR_FRAME_IS_EXCEPTION,
    ES1642_STATUS_ERROR_NOT_EXCEPTION_FRAME,
    ES1642_STATUS_ERROR_PAYLOAD_LENGTH,
    ES1642_STATUS_ERROR_TX_FAIL
} es1642_status_t;

/* ========================= 核心结构体 (仅保留使用的) ========================= */

typedef struct
{
    uint8_t  header;
    uint16_t data_len;
    uint8_t  ctrl;
    uint8_t  cmd;
    const uint8_t *data;
    uint8_t  csum;
    uint8_t  cxor;
    bool     prm;
    bool     is_exception;
    uint8_t  exception_code;
} es1642_frame_t;

typedef struct
{
    uint32_t raw_data_ctrl;
    uint8_t  relay_depth;
    int16_t  rssi;
    uint8_t  src_addr[ES1642_ADDR_LEN];
    uint16_t user_data_len;
    const uint8_t *user_data;
} es1642_recv_data_t;

typedef struct
{
    uint16_t raw_data_ctrl;
    uint8_t  src_addr[ES1642_ADDR_LEN];
    uint8_t  task_id;
    uint8_t  attribute_len;
    const uint8_t *attribute;
} es1642_search_notify_t;

/* ========================= 句柄和回调类型 ========================= */

struct es1642_handle;
typedef struct es1642_handle es1642_handle_t;

typedef int32_t (*es1642_write_fn_t)(const uint8_t *data, uint16_t len, void *user_arg);

typedef void (*es1642_frame_cb_t)(es1642_handle_t *handle,
                                  const es1642_frame_t *frame,
                                  void *user_arg);

typedef void (*es1642_error_cb_t)(es1642_handle_t *handle,
                                  es1642_status_t status,
                                  void *user_arg);

typedef struct
{
    es1642_write_fn_t write;
    es1642_frame_cb_t on_frame;
    es1642_error_cb_t on_error;
    void *user_arg;
} es1642_port_t;

struct es1642_handle
{
    es1642_port_t port;
    uint8_t rx_buf[ES1642_MAX_FRAME_LEN];
    uint16_t rx_index;
    uint16_t rx_expected_len;
};

/* ========================= 实际使用的API ========================= */

/* 初始化/复位 */
void ES1642_Init(es1642_handle_t *handle, const es1642_port_t *port);
void ES1642_ResetRx(es1642_handle_t *handle);

/* Ctrl辅助 (仅保留实际使用的) */
uint8_t ES1642_MakeSendDataCtrlByte(bool prm);

/* 帧发送/解析 */
es1642_status_t ES1642_SendFrame(es1642_handle_t *handle, uint8_t ctrl, uint8_t cmd,
                                 const uint8_t *data, uint16_t data_len);
es1642_status_t ES1642_InputByte(es1642_handle_t *handle, uint8_t byte);

/* 数据收发 */
es1642_status_t ES1642_SendData(es1642_handle_t *handle,
                                const uint8_t dst[ES1642_ADDR_LEN],
                                const uint8_t *udata, uint16_t ulen,
                                uint8_t relay, bool prm);
es1642_status_t ES1642_DecodeRecvData(const es1642_frame_t *f, es1642_recv_data_t *rd);

/* 地址/MAC */
es1642_status_t ES1642_SendSetAddr(es1642_handle_t *handle, const uint8_t addr[ES1642_ADDR_LEN]);
es1642_status_t ES1642_SendReadMac(es1642_handle_t *h);
es1642_status_t ES1642_DecodeMac(const es1642_frame_t *f, uint8_t mac[ES1642_ADDR_LEN]);
es1642_status_t ES1642_DecodeEmptyResponse(const es1642_frame_t *f, uint8_t cmd);

/* 搜索相关 */
es1642_status_t ES1642_DecodeSearchNotify(const es1642_frame_t *f, es1642_search_notify_t *n);
es1642_status_t ES1642_SendSearchReply(es1642_handle_t *h,
                                       const uint8_t src[ES1642_ADDR_LEN],
                                       uint8_t task_id, bool participate,
                                       const uint8_t *attr, uint8_t attr_len);

#endif /* ES1642_H */

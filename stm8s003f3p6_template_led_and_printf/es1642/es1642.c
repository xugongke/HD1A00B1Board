
/**
 * @file    es1642.c
 * @brief   ES1642 模块底层通信驱动实现
 * @author  OpenAI
 * @date    2026-03-13
 */

#include "es1642.h"

#include <string.h>

/* ========================= 内部工具函数 ========================= */

static void es1642_put_le16(uint8_t *buf, uint16_t value)
{
    buf[0] = (uint8_t)(value & 0xFFU);
    buf[1] = (uint8_t)((value >> 8) & 0xFFU);
}

static uint16_t es1642_get_le16(const uint8_t *buf)
{
    return (uint16_t)((uint16_t)buf[0] | ((uint16_t)buf[1] << 8));
}

static uint32_t es1642_get_le24(const uint8_t *buf)
{
    return ((uint32_t)buf[0]) |
           ((uint32_t)buf[1] << 8) |
           ((uint32_t)buf[2] << 16);
}

static void es1642_calc_checksum(const uint8_t *buf, uint16_t len, uint8_t *csum, uint8_t *cxor)
{
    uint16_t i;
    uint8_t sum = 0U;
    uint8_t x = 0U;

    for (i = 0U; i < len; ++i)
    {
        sum = (uint8_t)(sum + buf[i]);
        x ^= buf[i];
    }

    if (csum != NULL)
    {
        *csum = sum;
    }

    if (cxor != NULL)
    {
        *cxor = x;
    }
}

static int16_t es1642_sign_extend_9bit(uint16_t value)
{
    value &= 0x01FFU;

    if ((value & 0x0100U) != 0U)
    {
        value |= 0xFE00U;
    }

    return (int16_t)value;
}

static es1642_status_t es1642_expect_normal_cmd(const es1642_frame_t *frame, uint8_t expect_cmd)
{
    if (frame == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->cmd != expect_cmd)
    {
        return ES1642_STATUS_ERROR_CMD_MISMATCH;
    }

    if (frame->is_exception)
    {
        return ES1642_STATUS_ERROR_FRAME_IS_EXCEPTION;
    }

    return ES1642_STATUS_OK;
}

static void es1642_parse_version_bytes(const uint8_t *data, es1642_version_t *version)
{
    version->vendor_id = es1642_get_le16(&data[0]);
    version->chip_type = es1642_get_le16(&data[2]);
    version->product_info = data[4];
    version->version_bcd = es1642_get_le16(&data[5]);
}

static es1642_status_t es1642_send_remote_common(es1642_handle_t *handle,
                                                 uint8_t cmd,
                                                 const uint8_t dst_addr[ES1642_ADDR_LEN])
{
    uint8_t payload[1U + ES1642_ADDR_LEN];

    if (dst_addr == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    payload[0] = 0x00U; /* 远程调试命令 Data Ctrl 固定为 00H */
    (void)memcpy(&payload[1], dst_addr, ES1642_ADDR_LEN);

    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            cmd,
                            payload,
                            (uint16_t)sizeof(payload));
}

/* ========================= 对外基础接口 ========================= */

void ES1642_Init(es1642_handle_t *handle, const es1642_port_t *port)
{
    if (handle == NULL)
    {
        return;
    }

    (void)memset(handle, 0, sizeof(*handle));

    if (port != NULL)
    {
        handle->port = *port;
    }
}

void ES1642_ResetRx(es1642_handle_t *handle)
{
    if (handle == NULL)
    {
        return;
    }

    handle->rx_index = 0U;
    handle->rx_expected_len = 0U;
}

uint8_t ES1642_MakeDeviceRequestCtrl(void)
{
    return ES1642_CTRL_DEVICE_REQUEST;
}

uint8_t ES1642_MakeDeviceReplyCtrl(void)
{
    return ES1642_CTRL_DEVICE_REPLY;
}

uint8_t ES1642_MakeDeviceExceptionCtrl(void)
{
    return (uint8_t)(ES1642_CTRL_DEVICE_REPLY | ES1642_CTRL_BIT_RESPOND);
}

uint8_t ES1642_MakeSendDataCtrlByte(bool prm)
{
    return prm ? ES1642_MakeDeviceRequestCtrl() : ES1642_MakeDeviceReplyCtrl();
}

uint16_t ES1642_MakeTxDataCtrl(uint8_t relay_depth)
{
    /* 0 表示不指定跳数，由模块自动决定 */
    relay_depth &= 0x0FU;
    return (uint16_t)((uint16_t)relay_depth << 12);
}

uint16_t ES1642_MakeSearchCtrl(uint8_t depth, es1642_search_rule_t rule)
{
    /* 协议规定：深度 0 按 15 处理 */
    if (depth == 0U)
    {
        depth = 15U;
    }

    depth &= 0x0FU;

    return (uint16_t)(((uint16_t)depth << 8) | (((uint16_t)rule & 0x07U) << 12));
}

uint16_t ES1642_MakeSearchReplyCtrl(bool participate)
{
    return participate ? 0x0100U : 0x0000U;
}

bool ES1642_IsBroadcastAddr(const uint8_t addr[ES1642_ADDR_LEN])
{
    uint8_t i;

    if (addr == NULL)
    {
        return false;
    }

    for (i = 0U; i < ES1642_ADDR_LEN; ++i)
    {
        if (addr[i] != 0xFFU)
        {
            return false;
        }
    }

    return true;
}

void ES1642_SetBroadcastAddr(uint8_t addr[ES1642_ADDR_LEN])
{
    uint8_t i;

    if (addr == NULL)
    {
        return;
    }

    for (i = 0U; i < ES1642_ADDR_LEN; ++i)
    {
        addr[i] = 0xFFU;
    }
}

void ES1642_CopyAddr(uint8_t dst[ES1642_ADDR_LEN], const uint8_t src[ES1642_ADDR_LEN])
{
    if ((dst == NULL) || (src == NULL))
    {
        return;
    }

    (void)memcpy(dst, src, ES1642_ADDR_LEN);
}

const char *ES1642_StatusString(es1642_status_t status)
{
    switch (status)
    {
        case ES1642_STATUS_OK: return "成功";
        case ES1642_STATUS_IN_PROGRESS: return "接收中";
        case ES1642_STATUS_FRAME_READY: return "收到完整帧";
        case ES1642_STATUS_ERROR_PARAM: return "参数错误";
        case ES1642_STATUS_ERROR_NO_TX_PORT: return "未注册发送回调";
        case ES1642_STATUS_ERROR_BUFFER_TOO_SMALL: return "缓存空间不足";
        case ES1642_STATUS_ERROR_BAD_HEAD: return "帧头错误";
        case ES1642_STATUS_ERROR_BAD_LENGTH: return "长度错误";
        case ES1642_STATUS_ERROR_DATA_TOO_LONG: return "数据长度过长";
        case ES1642_STATUS_ERROR_CHECKSUM: return "校验错误";
        case ES1642_STATUS_ERROR_CMD_MISMATCH: return "指令字不匹配";
        case ES1642_STATUS_ERROR_FRAME_IS_EXCEPTION: return "异常应答帧";
        case ES1642_STATUS_ERROR_NOT_EXCEPTION_FRAME: return "不是异常应答帧";
        case ES1642_STATUS_ERROR_PAYLOAD_LENGTH: return "Data 长度与协议不符";
        case ES1642_STATUS_ERROR_TX_FAIL: return "发送失败";
        default: return "未知状态";
    }
}

const char *ES1642_ExceptionString(uint8_t exception_code)
{
    switch (exception_code)
    {
        case ES1642_EXCEPTION_BAD_FORMAT: return "错误的格式";
        case ES1642_EXCEPTION_BAD_DATA_UNIT: return "错误的数据单元";
        case ES1642_EXCEPTION_BAD_LENGTH: return "错误的长度";
        case ES1642_EXCEPTION_INVALID_CMD: return "指令字无效";
        case ES1642_EXCEPTION_NO_RAM: return "RAM 空间不足";
        case ES1642_EXCEPTION_BAD_STATE: return "错误的状态";
        default: return "保留/未知异常码";
    }
}

/* ========================= 帧封装 / 发送 ========================= */

es1642_status_t ES1642_BuildFrame(uint8_t ctrl,
                                  uint8_t cmd,
                                  const uint8_t *data,
                                  uint16_t data_len,
                                  uint8_t *out_frame,
                                  uint16_t out_size,
                                  uint16_t *out_frame_len)
{
    uint8_t csum;
    uint8_t cxor;
    uint16_t total_len;

    if ((out_frame == NULL) || (out_frame_len == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if ((data_len > 0U) && (data == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (data_len > ES1642_MAX_DATA_LEN)
    {
        return ES1642_STATUS_ERROR_DATA_TOO_LONG;
    }

    total_len = (uint16_t)(ES1642_MIN_FRAME_LEN + data_len);

    if (out_size < total_len)
    {
        return ES1642_STATUS_ERROR_BUFFER_TOO_SMALL;
    }

    out_frame[0] = ES1642_FRAME_HEAD;
    es1642_put_le16(&out_frame[1], data_len);
    out_frame[3] = ctrl;
    out_frame[4] = cmd;

    if (data_len > 0U)
    {
        (void)memcpy(&out_frame[5], data, data_len);
    }

    es1642_calc_checksum(&out_frame[1], (uint16_t)(data_len + 4U), &csum, &cxor);

    out_frame[(uint16_t)(5U + data_len)] = csum;
    out_frame[(uint16_t)(6U + data_len)] = cxor;
    *out_frame_len = total_len;

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_SendFrame(es1642_handle_t *handle,
                                 uint8_t ctrl,
                                 uint8_t cmd,
                                 const uint8_t *data,
                                 uint16_t data_len)
{
    uint8_t frame_buf[ES1642_MAX_FRAME_LEN];
    uint16_t frame_len = 0U;
    int32_t send_len;
    es1642_status_t status;

    if (handle == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (handle->port.write == NULL)
    {
        return ES1642_STATUS_ERROR_NO_TX_PORT;
    }

    status = ES1642_BuildFrame(ctrl,
                               cmd,
                               data,
                               data_len,
                               frame_buf,
                               (uint16_t)sizeof(frame_buf),
                               &frame_len);
    if (status != ES1642_STATUS_OK)
    {
        return status;
    }

    send_len = handle->port.write(frame_buf, frame_len, handle->port.user_arg);

    if (send_len != (int32_t)frame_len)
    {
        return ES1642_STATUS_ERROR_TX_FAIL;
    }

    return ES1642_STATUS_OK;
}

/* ========================= 帧解析 / 流式接收 ========================= */

es1642_status_t ES1642_ParseFrame(const uint8_t *raw_frame,
                                  uint16_t frame_len,
                                  es1642_frame_t *frame)
{
    uint16_t data_len;
    uint8_t csum;
    uint8_t cxor;

    if ((raw_frame == NULL) || (frame == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (frame_len < ES1642_MIN_FRAME_LEN)
    {
        return ES1642_STATUS_ERROR_BAD_LENGTH;
    }

    if (raw_frame[0] != ES1642_FRAME_HEAD)
    {
        return ES1642_STATUS_ERROR_BAD_HEAD;
    }

    data_len = es1642_get_le16(&raw_frame[1]);

    if (data_len > ES1642_MAX_DATA_LEN)
    {
        return ES1642_STATUS_ERROR_DATA_TOO_LONG;
    }

    if (frame_len != (uint16_t)(ES1642_MIN_FRAME_LEN + data_len))
    {
        return ES1642_STATUS_ERROR_BAD_LENGTH;
    }

    es1642_calc_checksum(&raw_frame[1], (uint16_t)(data_len + 4U), &csum, &cxor);

    if ((csum != raw_frame[(uint16_t)(5U + data_len)]) ||
        (cxor != raw_frame[(uint16_t)(6U + data_len)]))
    {
        return ES1642_STATUS_ERROR_CHECKSUM;
    }

    frame->header = raw_frame[0];
    frame->data_len = data_len;
    frame->ctrl = raw_frame[3];
    frame->cmd = raw_frame[4];
    frame->data = (data_len > 0U) ? &raw_frame[5] : NULL;
    frame->csum = raw_frame[(uint16_t)(5U + data_len)];
    frame->cxor = raw_frame[(uint16_t)(6U + data_len)];
    frame->prm = ((raw_frame[3] & ES1642_CTRL_BIT_PRM) != 0U);
    frame->is_exception = ((raw_frame[3] & ES1642_CTRL_BIT_RESPOND) != 0U);
    frame->exception_code = (frame->is_exception && (data_len > 0U))
                          ? raw_frame[(uint16_t)(4U + data_len)]
                          : 0xFFU;

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_InputByte(es1642_handle_t *handle, uint8_t byte)
{
    es1642_frame_t frame;
    es1642_status_t status;

    if (handle == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    /* 尚未进入一帧，先等待帧头 */
    if (handle->rx_index == 0U)
    {
        if (byte != ES1642_FRAME_HEAD)
        {
            return ES1642_STATUS_IN_PROGRESS;
        }

        handle->rx_buf[0] = byte;
        handle->rx_index = 1U;
        handle->rx_expected_len = 0U;
        return ES1642_STATUS_IN_PROGRESS;
    }

    if (handle->rx_index >= (uint16_t)sizeof(handle->rx_buf))
    {
        ES1642_ResetRx(handle);

        if (handle->port.on_error != NULL)
        {
            handle->port.on_error(handle, ES1642_STATUS_ERROR_BUFFER_TOO_SMALL, handle->port.user_arg);
        }

        return ES1642_STATUS_ERROR_BUFFER_TOO_SMALL;
    }

    handle->rx_buf[handle->rx_index++] = byte;

    /* 收到长度字段后，立即确定整个帧长度 */
    if (handle->rx_index == 3U)
    {
        uint16_t data_len = es1642_get_le16(&handle->rx_buf[1]);

        if (data_len > ES1642_MAX_DATA_LEN)
        {
            ES1642_ResetRx(handle);

            if (handle->port.on_error != NULL)
            {
                handle->port.on_error(handle, ES1642_STATUS_ERROR_DATA_TOO_LONG, handle->port.user_arg);
            }

            return ES1642_STATUS_ERROR_DATA_TOO_LONG;
        }

        handle->rx_expected_len = (uint16_t)(ES1642_MIN_FRAME_LEN + data_len);

        if (handle->rx_expected_len > (uint16_t)sizeof(handle->rx_buf))
        {
            ES1642_ResetRx(handle);

            if (handle->port.on_error != NULL)
            {
                handle->port.on_error(handle, ES1642_STATUS_ERROR_BUFFER_TOO_SMALL, handle->port.user_arg);
            }

            return ES1642_STATUS_ERROR_BUFFER_TOO_SMALL;
        }
    }

    if ((handle->rx_expected_len > 0U) && (handle->rx_index >= handle->rx_expected_len))
    {
        status = ES1642_ParseFrame(handle->rx_buf, handle->rx_expected_len, &frame);

        if (status == ES1642_STATUS_OK)
        {
            if (handle->port.on_frame != NULL)
            {
                handle->port.on_frame(handle, &frame, handle->port.user_arg);
            }

            ES1642_ResetRx(handle);
            return ES1642_STATUS_FRAME_READY;
        }

        ES1642_ResetRx(handle);

        if (handle->port.on_error != NULL)
        {
            handle->port.on_error(handle, status, handle->port.user_arg);
        }

        return status;
    }

    return ES1642_STATUS_IN_PROGRESS;
}

es1642_status_t ES1642_InputBuffer(es1642_handle_t *handle,
                                   const uint8_t *data,
                                   uint16_t len)
{
    uint16_t i;
    es1642_status_t status = ES1642_STATUS_IN_PROGRESS;

    if (handle == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if ((len > 0U) && (data == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    for (i = 0U; i < len; ++i)
    {
        es1642_status_t one = ES1642_InputByte(handle, data[i]);

        if (one == ES1642_STATUS_FRAME_READY)
        {
            status = ES1642_STATUS_FRAME_READY;
        }
        else if ((one >= ES1642_STATUS_ERROR_PARAM) && (status != ES1642_STATUS_FRAME_READY))
        {
            status = one;
        }
    }

    return status;
}

/* ========================= 命令发送接口 ========================= */

es1642_status_t ES1642_SendReboot(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_REBOOT,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendReadVersion(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_READ_VERSION,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendReadMac(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_READ_MAC,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendReadAddr(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_READ_ADDR,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendSetAddr(es1642_handle_t *handle,
                                   const uint8_t addr[ES1642_ADDR_LEN])
{
    if (addr == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_SET_ADDR,
                            addr,
                            ES1642_ADDR_LEN);
}

es1642_status_t ES1642_SendReadNetParam(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_READ_NET_PARAM,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendSetNetParam(es1642_handle_t *handle,
                                       uint8_t relay_depth)
{
    uint8_t payload[2];

    payload[0] = relay_depth;
    payload[1] = 0x00U; /* RSV */

    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_SET_NET_PARAM,
                            payload,
                            (uint16_t)sizeof(payload));
}

es1642_status_t ES1642_SendData(es1642_handle_t *handle,
                                const uint8_t dst_addr[ES1642_ADDR_LEN],
                                const uint8_t *user_data,
                                uint16_t user_data_len,
                                uint8_t relay_depth,
                                bool prm)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t data_ctrl;
    uint16_t payload_len;

    if (dst_addr == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if ((user_data_len > 0U) && (user_data == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    payload_len = (uint16_t)(ES1642_SEND_DATA_FIXED_LEN + user_data_len);

    if (payload_len > ES1642_MAX_DATA_LEN)
    {
        return ES1642_STATUS_ERROR_DATA_TOO_LONG;
    }

    data_ctrl = ES1642_MakeTxDataCtrl(relay_depth);

    es1642_put_le16(&payload[0], data_ctrl);
    (void)memcpy(&payload[2], dst_addr, ES1642_ADDR_LEN);
    es1642_put_le16(&payload[8], user_data_len);

    if (user_data_len > 0U)
    {
        (void)memcpy(&payload[10], user_data, user_data_len);
    }

    return ES1642_SendFrame(handle,
                            ES1642_MakeSendDataCtrlByte(prm),
                            ES1642_CMD_SEND_DATA,
                            payload,
                            payload_len);
}

es1642_status_t ES1642_SendStartSearch(es1642_handle_t *handle,
                                       uint8_t depth,
                                       es1642_search_rule_t rule,
                                       const uint8_t *attribute,
                                       uint8_t attribute_len)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t data_ctrl;
    uint16_t payload_len;

    if ((attribute_len > 0U) && (attribute == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    payload_len = (uint16_t)(3U + attribute_len);

    if (payload_len > ES1642_MAX_DATA_LEN)
    {
        return ES1642_STATUS_ERROR_DATA_TOO_LONG;
    }

    data_ctrl = ES1642_MakeSearchCtrl(depth, rule);

    es1642_put_le16(&payload[0], data_ctrl);
    payload[2] = attribute_len;

    if (attribute_len > 0U)
    {
        (void)memcpy(&payload[3], attribute, attribute_len);
    }

    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_START_SEARCH,
                            payload,
                            payload_len);
}

es1642_status_t ES1642_SendStopSearch(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_STOP_SEARCH,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendSearchReply(es1642_handle_t *handle,
                                       const uint8_t src_addr[ES1642_ADDR_LEN],
                                       uint8_t task_id,
                                       bool participate,
                                       const uint8_t *attribute,
                                       uint8_t attribute_len)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t data_ctrl;
    uint16_t payload_len;

    if (src_addr == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (!participate)
    {
        attribute = NULL;
        attribute_len = 0U;
    }
    else if ((attribute_len > 0U) && (attribute == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    payload_len = (uint16_t)(10U + attribute_len);

    if (payload_len > ES1642_MAX_DATA_LEN)
    {
        return ES1642_STATUS_ERROR_DATA_TOO_LONG;
    }

    data_ctrl = ES1642_MakeSearchReplyCtrl(participate);

    es1642_put_le16(&payload[0], data_ctrl);
    (void)memcpy(&payload[2], src_addr, ES1642_ADDR_LEN);
    payload[8] = task_id;
    payload[9] = attribute_len;

    if (attribute_len > 0U)
    {
        (void)memcpy(&payload[10], attribute, attribute_len);
    }

    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceReplyCtrl(),
                            ES1642_CMD_REPLY_SEARCH,
                            payload,
                            payload_len);
}

es1642_status_t ES1642_SendSetPsk(es1642_handle_t *handle,
                                  const uint8_t dst_addr[ES1642_ADDR_LEN],
                                  const uint8_t *new_psk,
                                  uint8_t new_psk_len)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t payload_len;

    if (dst_addr == NULL)
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if ((new_psk_len > 0U) && (new_psk == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    payload_len = (uint16_t)(10U + new_psk_len);

    if (payload_len > ES1642_MAX_DATA_LEN)
    {
        return ES1642_STATUS_ERROR_DATA_TOO_LONG;
    }

    /* Data Ctrl 固定 0x0044 */
    es1642_put_le16(&payload[0], 0x0044U);
    (void)memcpy(&payload[2], dst_addr, ES1642_ADDR_LEN);
    payload[8] = 0x00U;              /* Old Psk Len 固定为 0 */
    payload[9] = new_psk_len;        /* New Psk Len */

    if (new_psk_len > 0U)
    {
        (void)memcpy(&payload[10], new_psk, new_psk_len);
    }

    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceRequestCtrl(),
                            ES1642_CMD_SET_PSK,
                            payload,
                            payload_len);
}

es1642_status_t ES1642_SendAckEmpty(es1642_handle_t *handle, uint8_t cmd)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceReplyCtrl(),
                            cmd,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendException(es1642_handle_t *handle,
                                     uint8_t cmd,
                                     uint8_t exception_code)
{
    return ES1642_SendFrame(handle,
                            ES1642_MakeDeviceExceptionCtrl(),
                            cmd,
                            &exception_code,
                            1U);
}

es1642_status_t ES1642_SendRemoteReadVersion(es1642_handle_t *handle,
                                             const uint8_t dst_addr[ES1642_ADDR_LEN])
{
    return es1642_send_remote_common(handle, ES1642_CMD_REMOTE_READ_VERSION, dst_addr);
}

es1642_status_t ES1642_SendRemoteReadMac(es1642_handle_t *handle,
                                         const uint8_t dst_addr[ES1642_ADDR_LEN])
{
    return es1642_send_remote_common(handle, ES1642_CMD_REMOTE_READ_MAC, dst_addr);
}

es1642_status_t ES1642_SendRemoteReadNetParam(es1642_handle_t *handle,
                                              const uint8_t dst_addr[ES1642_ADDR_LEN])
{
    return es1642_send_remote_common(handle, ES1642_CMD_REMOTE_READ_NET_PARAM, dst_addr);
}

/* ========================= 命令解码接口 ========================= */

es1642_status_t ES1642_DecodeEmptyResponse(const es1642_frame_t *frame, uint8_t expect_cmd)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, expect_cmd);

    if (status != ES1642_STATUS_OK)
    {
        return status;
    }

    return (frame->data_len == 0U) ? ES1642_STATUS_OK : ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
}

es1642_status_t ES1642_DecodeRebootResponse(const es1642_frame_t *frame,
                                            uint8_t *state,
                                            uint8_t *rsv)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REBOOT);

    if ((status != ES1642_STATUS_OK) || (state == NULL) || (rsv == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 2U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    *state = frame->data[0];
    *rsv = frame->data[1];

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeVersion(const es1642_frame_t *frame,
                                     es1642_version_t *version)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_READ_VERSION);

    if ((status != ES1642_STATUS_OK) || (version == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 7U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    es1642_parse_version_bytes(frame->data, version);
    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeMac(const es1642_frame_t *frame,
                                 uint8_t mac[ES1642_ADDR_LEN])
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_READ_MAC);

    if ((status != ES1642_STATUS_OK) || (mac == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != ES1642_ADDR_LEN)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(mac, frame->data, ES1642_ADDR_LEN);
    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeAddr(const es1642_frame_t *frame,
                                  uint8_t addr[ES1642_ADDR_LEN])
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_READ_ADDR);

    if ((status != ES1642_STATUS_OK) || (addr == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != ES1642_ADDR_LEN)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(addr, frame->data, ES1642_ADDR_LEN);
    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeNetParam(const es1642_frame_t *frame,
                                      es1642_net_param_t *net_param)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_READ_NET_PARAM);

    if ((status != ES1642_STATUS_OK) || (net_param == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 7U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    net_param->relay_depth = frame->data[0];
    (void)memcpy(net_param->network_key, &frame->data[1], ES1642_LOCAL_NET_KEY_LEN);
    net_param->rsv1 = frame->data[5];
    net_param->rsv2 = frame->data[6];

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeRecvData(const es1642_frame_t *frame,
                                      es1642_recv_data_t *recv_data)
{
    uint32_t raw_data_ctrl;
    uint16_t user_data_len;
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_RECV_DATA);

    if ((status != ES1642_STATUS_OK) || (recv_data == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len < ES1642_RECV_DATA_FIXED_LEN)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    raw_data_ctrl = es1642_get_le24(&frame->data[0]);
    user_data_len = es1642_get_le16(&frame->data[9]);

    if (frame->data_len != (uint16_t)(ES1642_RECV_DATA_FIXED_LEN + user_data_len))
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    recv_data->raw_data_ctrl = raw_data_ctrl;
    recv_data->relay_depth = (uint8_t)((raw_data_ctrl >> 8) & 0x0FU);
    recv_data->rssi = es1642_sign_extend_9bit((uint16_t)((raw_data_ctrl >> 15) & 0x01FFU));
    (void)memcpy(recv_data->src_addr, &frame->data[3], ES1642_ADDR_LEN);
    recv_data->user_data_len = user_data_len;
    recv_data->user_data = (user_data_len > 0U) ? &frame->data[11] : NULL;

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeSearchResult(const es1642_frame_t *frame,
                                          es1642_search_result_t *result)
{
    uint8_t attribute_len;
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REPORT_SEARCH_RESULT);

    if ((status != ES1642_STATUS_OK) || (result == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len < 9U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    attribute_len = frame->data[8];

    if (frame->data_len != (uint16_t)(9U + attribute_len))
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(result->dev_addr, &frame->data[0], ES1642_ADDR_LEN);
    result->raw_dev_ctrl = es1642_get_le16(&frame->data[6]);
    result->net_state = (uint8_t)((result->raw_dev_ctrl >> 4) & 0x0FU);
    result->attribute_len = attribute_len;
    result->attribute = (attribute_len > 0U) ? &frame->data[9] : NULL;

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeSearchNotify(const es1642_frame_t *frame,
                                          es1642_search_notify_t *notify)
{
    uint8_t attribute_len;
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_NOTIFY_SEARCH);

    if ((status != ES1642_STATUS_OK) || (notify == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len < 10U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    attribute_len = frame->data[9];

    if (frame->data_len != (uint16_t)(10U + attribute_len))
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    notify->raw_data_ctrl = es1642_get_le16(&frame->data[0]);
    (void)memcpy(notify->src_addr, &frame->data[2], ES1642_ADDR_LEN);
    notify->task_id = frame->data[8];
    notify->attribute_len = attribute_len;
    notify->attribute = (attribute_len > 0U) ? &frame->data[10] : NULL;

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeSearchReply(const es1642_frame_t *frame,
                                         es1642_search_reply_t *reply)
{
    uint8_t attribute_len;
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REPLY_SEARCH);

    if ((status != ES1642_STATUS_OK) || (reply == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len < 10U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    attribute_len = frame->data[9];

    if (frame->data_len != (uint16_t)(10U + attribute_len))
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    reply->raw_data_ctrl = es1642_get_le16(&frame->data[0]);
    reply->participate = (((reply->raw_data_ctrl >> 8) & 0x01U) != 0U);
    (void)memcpy(reply->src_addr, &frame->data[2], ES1642_ADDR_LEN);
    reply->task_id = frame->data[8];
    reply->attribute_len = attribute_len;
    reply->attribute = (attribute_len > 0U) ? &frame->data[10] : NULL;

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodePskNotify(const es1642_frame_t *frame,
                                       es1642_psk_notify_t *notify)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_NOTIFY_PSK);

    if ((status != ES1642_STATUS_OK) || (notify == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 8U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    notify->raw_data_ctrl = es1642_get_le16(&frame->data[0]);
    (void)memcpy(notify->src_addr, &frame->data[2], ES1642_ADDR_LEN);
    notify->op = (uint8_t)((notify->raw_data_ctrl >> 12) & 0x03U);

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodePskResult(const es1642_frame_t *frame,
                                       es1642_psk_result_t *result)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REPORT_PSK_RESULT);

    if ((status != ES1642_STATUS_OK) || (result == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 9U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    result->raw_data_ctrl = es1642_get_le16(&frame->data[0]);
    (void)memcpy(result->src_addr, &frame->data[2], ES1642_ADDR_LEN);
    result->state = frame->data[8];

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeRemoteVersion(const es1642_frame_t *frame,
                                           es1642_remote_version_t *version)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REMOTE_READ_VERSION);

    if ((status != ES1642_STATUS_OK) || (version == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 13U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(version->src_addr, &frame->data[0], ES1642_ADDR_LEN);
    es1642_parse_version_bytes(&frame->data[6], &version->version);

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeRemoteMac(const es1642_frame_t *frame,
                                       es1642_remote_mac_t *mac)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REMOTE_READ_MAC);

    if ((status != ES1642_STATUS_OK) || (mac == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 12U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(mac->src_addr, &frame->data[0], ES1642_ADDR_LEN);
    (void)memcpy(mac->mac, &frame->data[6], ES1642_ADDR_LEN);

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeRemoteNetParam(const es1642_frame_t *frame,
                                            es1642_remote_net_param_t *net_param)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_REMOTE_READ_NET_PARAM);

    if ((status != ES1642_STATUS_OK) || (net_param == NULL))
    {
        return (status != ES1642_STATUS_OK) ? status : ES1642_STATUS_ERROR_PARAM;
    }

    if (frame->data_len != 13U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(net_param->src_addr, &frame->data[0], ES1642_ADDR_LEN);
    net_param->net_param.relay_depth = frame->data[6];
    (void)memcpy(net_param->net_param.network_key, &frame->data[7], ES1642_LOCAL_NET_KEY_LEN);
    net_param->net_param.rsv1 = frame->data[11];
    net_param->net_param.rsv2 = frame->data[12];

    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeLocalException(const es1642_frame_t *frame,
                                            uint8_t *exception_code)
{
    if ((frame == NULL) || (exception_code == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (!frame->is_exception)
    {
        return ES1642_STATUS_ERROR_NOT_EXCEPTION_FRAME;
    }

    if (frame->data_len != 1U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    *exception_code = frame->data[0];
    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeRemoteException(const es1642_frame_t *frame,
                                             uint8_t src_addr[ES1642_ADDR_LEN],
                                             uint8_t *exception_code)
{
    if ((frame == NULL) || (src_addr == NULL) || (exception_code == NULL))
    {
        return ES1642_STATUS_ERROR_PARAM;
    }

    if (!frame->is_exception)
    {
        return ES1642_STATUS_ERROR_NOT_EXCEPTION_FRAME;
    }

    if (frame->data_len != 7U)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(src_addr, &frame->data[0], ES1642_ADDR_LEN);
    *exception_code = frame->data[6];

    return ES1642_STATUS_OK;
}

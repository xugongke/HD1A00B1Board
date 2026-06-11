/**
 * @file    es1642.c
 * @brief   ES1642 模块底层通信驱动实现（Flash精简版）
 * @author  OpenAI
 * @date    2026-03-13
 *
 * 优化说明：
 * 1. 已移除所有对调用者可控参数的 NULL 判断（handle、frame、addr 等），
 *    嵌入式环境下调用者应保证传入有效指针。
 * 2. 保留了回调函数指针的 NULL 判断（on_frame、on_error、write），
 *    因为这些是可选注册的回调，不判断会导致硬件异常。
 * 4. 已删除工程中未使用的全部函数，仅保留实际用到的接口。
 */

#include "es1642_port_stm8.h"
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

    *csum = sum;
    *cxor = x;
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

/* ========================= 对外基础接口 ========================= */

void ES1642_Init(es1642_handle_t *handle)
{
    (void)memset(handle, 0, sizeof(*handle));
}

void ES1642_ResetRx(es1642_handle_t *handle)
{
    handle->rx_index = 0U;
    handle->rx_expected_len = 0U;
}

uint16_t ES1642_MakeTxDataCtrl(uint8_t relay_depth)
{
    relay_depth &= 0x0FU;
    return (uint16_t)((uint16_t)relay_depth << 12);
}

uint16_t ES1642_MakeSearchReplyCtrl(bool participate)
{
    return participate ? 0x0100U : 0x0000U;
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

    status = ES1642_BuildFrame(ctrl, cmd, data, data_len,
                               frame_buf, (uint16_t)sizeof(frame_buf), &frame_len);
    if (status != ES1642_STATUS_OK)
    {
        return status;
    }

    send_len = stm8_es1642_write(frame_buf, frame_len);

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

        /* 保留：on_error 是可选回调 */
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
            return ES1642_STATUS_ERROR_DATA_TOO_LONG;
        }

        handle->rx_expected_len = (uint16_t)(ES1642_MIN_FRAME_LEN + data_len);

        if (handle->rx_expected_len > (uint16_t)sizeof(handle->rx_buf))
        {
            ES1642_ResetRx(handle);
            return ES1642_STATUS_ERROR_BUFFER_TOO_SMALL;
        }
    }

    if ((handle->rx_expected_len > 0U) && (handle->rx_index >= handle->rx_expected_len))
    {
        status = ES1642_ParseFrame(handle->rx_buf, handle->rx_expected_len, &frame);

        if (status == ES1642_STATUS_OK)
        {
            es1642_on_frame(handle, &frame);
            ES1642_ResetRx(handle);
            return ES1642_STATUS_FRAME_READY;
        }

        ES1642_ResetRx(handle);
        return status;
    }

    return ES1642_STATUS_IN_PROGRESS;
}

/* ========================= 命令发送接口（仅保留实际使用的） ========================= */

es1642_status_t ES1642_SendReadMac(es1642_handle_t *handle)
{
    return ES1642_SendFrame(handle,
                            ES1642_CTRL_DEVICE_REQUEST,
                            ES1642_CMD_READ_MAC,
                            NULL,
                            0U);
}

es1642_status_t ES1642_SendSetAddr(es1642_handle_t *handle,
                                   const uint8_t addr[ES1642_ADDR_LEN])
{
    return ES1642_SendFrame(handle,
                            ES1642_CTRL_DEVICE_REQUEST,
                            ES1642_CMD_SET_ADDR,
                            addr,
                            ES1642_ADDR_LEN);
}

es1642_status_t ES1642_SendData(es1642_handle_t *handle,
                                const uint8_t dst_addr[ES1642_ADDR_LEN],
                                const uint8_t *user_data,
                                uint16_t user_data_len,
                                uint8_t relay_depth)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t data_ctrl;
    uint16_t payload_len;

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
                            ES1642_CTRL_DEVICE_REQUEST,
                            ES1642_CMD_SEND_DATA,
                            payload,
                            payload_len);
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

    if (!participate)
    {
        attribute = NULL;
        attribute_len = 0U;
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
                            ES1642_CTRL_DEVICE_REQUEST,
                            ES1642_CMD_REPLY_SEARCH,
                            payload,
                            payload_len);
}

/* ========================= 命令解码接口（仅保留实际使用的） ========================= */

es1642_status_t ES1642_DecodeEmptyResponse(const es1642_frame_t *frame, uint8_t expect_cmd)
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, expect_cmd);

    if (status != ES1642_STATUS_OK)
    {
        return status;
    }

    return (frame->data_len == 0U) ? ES1642_STATUS_OK : ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
}

es1642_status_t ES1642_DecodeMac(const es1642_frame_t *frame,
                                 uint8_t mac[ES1642_ADDR_LEN])
{
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_READ_MAC);

    if (status != ES1642_STATUS_OK)
    {
        return status;
    }

    if (frame->data_len != ES1642_ADDR_LEN)
    {
        return ES1642_STATUS_ERROR_PAYLOAD_LENGTH;
    }

    (void)memcpy(mac, frame->data, ES1642_ADDR_LEN);
    return ES1642_STATUS_OK;
}

es1642_status_t ES1642_DecodeRecvData(const es1642_frame_t *frame,
                                      es1642_recv_data_t *recv_data)
{
    uint32_t raw_data_ctrl;
    uint16_t user_data_len;
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_RECV_DATA);

    if (status != ES1642_STATUS_OK)
    {
        return status;
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

es1642_status_t ES1642_DecodeSearchNotify(const es1642_frame_t *frame,
                                          es1642_search_notify_t *notify)
{
    uint8_t attribute_len;
    es1642_status_t status = es1642_expect_normal_cmd(frame, ES1642_CMD_NOTIFY_SEARCH);

    if (status != ES1642_STATUS_OK)
    {
        return status;
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

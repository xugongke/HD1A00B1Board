/**
 * @file    es1642.c
 * @brief   ES1642 载波通信协议驱动 - 精简版 (热水器从机)
 *
 * ES1642芯片简介:
 *   ES1642是一颗电力线载波(PLC)通信芯片, 通过UART与MCU交互
 *   MCU发送指令帧给ES1642, ES1642将数据调制到电力线上传输
 *   ES1642从电力线上解调数据后, 通过UART返回给MCU
 *
 * 协议帧格式 (小端序):
 *   ┌──────┬──────┬──────┬──────┬──────┬──────────┬──────┬──────┐
 *   │ HEAD │ LEN_L│ LEN_H│ CTRL │ CMD  │ DATA[0..N]│ CSUM │ CXOR │
 *   │ 0x79 │  变长  │      │      │      │   可选     │ 校验和│异或  │
 *   └──────┴──────┴──────┴──────┴──────┴──────────┴──────┴──────┘
 *   - HEAD: 固定帧头 0x79
 *   - LEN:  数据长度 (2字节小端), 仅DATA部分的长度
 *   - CTRL:  控制字节, 包含PRM(主/从)和RESPOND(正常/异常)标志
 *   - CMD:   指令字 (如0x14=发送数据, 0x15=接收数据)
 *   - DATA:  可选的数据负载
 *   - CSUM:  校验和 (从LEN到DATA的所有字节累加和)
 *   - CXOR:  异或校验 (从LEN到DATA的所有字节异或值)
 *
 * 热水器从机实际使用的通信流程:
 *   1. 上电后调用ES1642_SendReadMac()读取芯片MAC地址
 *   2. 调用ES1642_SendSetAddr()设置本地通信地址
 *   3. 主循环中调用ES1642_InputByte()逐字节接收数据
 *   4. 收到完整帧后通过回调on_frame()通知应用层
 *   5. 应用层解析指令, 执行加热控制, 调用ES1642_SendData()上报状态
 */

#include "es1642.h"
#include <string.h>

/* ========================= 内部工具函数 ========================= */

/* 将16位值写入缓冲区 (小端序: 低字节在前) */
static void es1642_put_le16(uint8_t *buf, uint16_t value)
{
    buf[0] = (uint8_t)(value & 0xFFU);
    buf[1] = (uint8_t)((value >> 8) & 0xFFU);
}

/* 从缓冲区读取16位值 (小端序) */
static uint16_t es1642_get_le16(const uint8_t *buf)
{
    return (uint16_t)((uint16_t)buf[0] | ((uint16_t)buf[1] << 8));
}

/*
 * es1642_calc_checksum - 计算校验和与异或校验
 * @param buf  待计算的数据缓冲区 (从LEN开始)
 * @param len  数据长度
 * @param csum 输出: 累加和校验 (所有字节相加, 取低8位)
 * @param cxor 输出: 异或校验 (所有字节异或)
 *
 * 这两个校验用于接收端验证帧完整性, 双重校验降低漏检概率
 */
static void es1642_calc_checksum(const uint8_t *buf, uint16_t len, uint8_t *csum, uint8_t *cxor)
{
    uint16_t i;
    uint8_t sum = 0U, x = 0U;
    for (i = 0U; i < len; ++i) { sum += buf[i]; x ^= buf[i]; }
    if (csum) { *csum = sum; }
    if (cxor) { *cxor = x; }
}

/*
 * es1642_expect_normal - 验证帧是否为指定指令的正常响应
 * @param f   已解析的帧
 * @param cmd 期望的指令字
 * @return OK=匹配, CMD_MISMATCH=指令不匹配, FRAME_IS_EXCEPTION=异常帧
 */
static es1642_status_t es1642_expect_normal(const es1642_frame_t *f, uint8_t cmd)
{
    if (f->cmd != cmd) { return ES1642_STATUS_ERROR_CMD_MISMATCH; }
    if (f->is_exception) { return ES1642_STATUS_ERROR_FRAME_IS_EXCEPTION; }
    return ES1642_STATUS_OK;
}

/* ========================= 初始化 / 复位 ========================= */

/*
 * ES1642_Init - 初始化ES1642句柄
 * @param h    句柄指针
 * @param port 端口配置 (write函数, 回调函数, 用户参数)
 * 清零接收缓冲区, 复制端口配置
 */
void ES1642_Init(es1642_handle_t *h, const es1642_port_t *port)
{
    (void)memset(h, 0, sizeof(*h));
    if (port) { h->port = *port; }
}

/*
 * ES1642_ResetRx - 复位接收状态机
 * 丢弃当前正在接收的帧, 重新开始等待帧头
 * 在帧解析错误或超时后调用
 */
void ES1642_ResetRx(es1642_handle_t *h)
{
    h->rx_index = 0U; h->rx_expected_len = 0U;
}

/* ========================= Ctrl控制字节辅助 ========================= */

/*
 * CTRL字节格式:
 *   bit7-6: 保留
 *   bit5:   PRM (Primary Request Master) - 1=主动请求, 0=被动响应
 *   bit4:   RESPOND - 1=异常响应帧
 *   bit3-0: 设备类型标识
 *
 * 热水器从机使用两种CTRL值:
 *   DEVICE_REQUEST (0x58) = 从机主动发请求 (PRM=1)
 *   DEVICE_REPLY   (0x18) = 从机被动应答   (PRM=0)
 */
/* SendData时的CTRL: prm=true用请求帧, prm=false用应答帧 */
uint8_t ES1642_MakeSendDataCtrlByte(bool prm)
{
    return prm ? ES1642_CTRL_DEVICE_REQUEST : ES1642_CTRL_DEVICE_REPLY;
}

/* ========================= 发送帧 ========================= */

/*
 * ES1642_SendFrame - 构建并发送一个完整的ES1642协议帧
 *
 * 组帧过程:
 *   1. 组装帧头 HEAD(0x79) + LEN(2字节) + CTRL + CMD + DATA
 *   2. 计算校验: CSUM和CXOR (覆盖 LEN+CTRL+CMD+DATA)
 *   3. 追加CSUM和CXOR到帧尾
 *   4. 通过port.write()发送完整帧
 *
 * @param h        句柄
 * @param ctrl     控制字节
 * @param cmd      指令字
 * @param data     负载数据 (可为NULL)
 * @param data_len 负载长度
 * @return OK=发送成功, 其他=失败
 */
es1642_status_t ES1642_SendFrame(es1642_handle_t *h, uint8_t ctrl, uint8_t cmd,
                                 const uint8_t *data, uint16_t data_len)
{
    uint8_t buf[ES1642_MAX_FRAME_LEN];
    uint16_t total;
    uint8_t csum, cxor;
    int32_t sent;

    if (data_len > ES1642_MAX_DATA_LEN) { return ES1642_STATUS_ERROR_DATA_TOO_LONG; }

    total = (uint16_t)(ES1642_MIN_FRAME_LEN + data_len);

    buf[0] = ES1642_FRAME_HEAD;
    es1642_put_le16(&buf[1], data_len);
    buf[3] = ctrl;
    buf[4] = cmd;
    if (data_len > 0U) { (void)memcpy(&buf[5], data, data_len); }

    es1642_calc_checksum(&buf[1], (uint16_t)(data_len + 4U), &csum, &cxor);
    buf[5U + data_len] = csum;
    buf[6U + data_len] = cxor;

    sent = h->port.write(buf, total, h->port.user_arg);
    return (sent == (int32_t)total) ? ES1642_STATUS_OK : ES1642_STATUS_ERROR_TX_FAIL;
}

/* ========================= 解析帧 ========================= */

/*
 * ES1642_ParseFrame - 解析一个完整的接收帧
 *
 * 解析步骤:
 *   1. 检查帧长 ≥ 7字节
 *   2. 验证帧头 == 0x79
 *   3. 读取数据长度, 验证总长度匹配
 *   4. 计算并验证CSUM和CXOR校验
 *   5. 填充es1642_frame_t结构体
 *
 * @param raw  接收到的原始帧数据
 * @param flen 帧长度
 * @param f    输出: 解析后的帧结构
 * @return OK=解析成功, 其他=错误类型
 */
static es1642_status_t es1642_parse_frame(const uint8_t *raw, uint16_t flen, es1642_frame_t *f)
{
    uint16_t dlen;
    uint8_t csum, cxor;

    if (flen < ES1642_MIN_FRAME_LEN) { return ES1642_STATUS_ERROR_BAD_LENGTH; }
    if (raw[0] != ES1642_FRAME_HEAD) { return ES1642_STATUS_ERROR_BAD_HEAD; }

    /* 读取数据长度并验证 */
    dlen = es1642_get_le16(&raw[1]);
    if (dlen > ES1642_MAX_DATA_LEN) { return ES1642_STATUS_ERROR_DATA_TOO_LONG; }
    if (flen != (uint16_t)(ES1642_MIN_FRAME_LEN + dlen)) { return ES1642_STATUS_ERROR_BAD_LENGTH; }

    /* 校验和验证 */
    es1642_calc_checksum(&raw[1], (uint16_t)(dlen + 4U), &csum, &cxor);
    if ((csum != raw[5U + dlen]) || (cxor != raw[6U + dlen])) { return ES1642_STATUS_ERROR_CHECKSUM; }

    /* 填充解析结果 */
    f->header = raw[0];
    f->data_len = dlen;
    f->ctrl = raw[3];
    f->cmd = raw[4];
    f->data = (dlen > 0U) ? &raw[5] : NULL;
    f->csum = raw[5U + dlen];
    f->cxor = raw[6U + dlen];
    f->prm = ((raw[3] & ES1642_CTRL_BIT_PRM) != 0U);       /* PRM标志 */
    f->is_exception = ((raw[3] & ES1642_CTRL_BIT_RESPOND) != 0U); /* 异常标志 */
    f->exception_code = (f->is_exception && (dlen > 0U)) ? raw[4U + dlen] : 0xFFU;
    return ES1642_STATUS_OK;
}

/* ========================= 逐字节接收状态机 ========================= */

/*
 * ES1642_InputByte - 输入一个接收字节到状态机
 *
 * 接收状态机流程:
 *   ┌─────────────────────────────────────────────┐
 *   │ 状态0: 等待帧头                              │
 *   │   收到0x79 → 进入状态1, 存入rx_buf[0]        │
 *   │   其他字节 → 丢弃, 继续等待                  │
 *   ├─────────────────────────────────────────────┤
 *   │ 状态1~2: 接收长度字节 (小端)                 │
 *   │   收满2字节后计算期望帧总长度                 │
 *   │   长度超限 → 丢弃, 复位                      │
 *   ├─────────────────────────────────────────────┤
 *   │ 状态3~N: 接收剩余字节 (CTRL+CMD+DATA+CSUM+CXOR) │
 *   │   收满后调用ParseFrame解析                    │
 *   │   解析成功 → 调用on_frame回调通知应用层       │
 *   │   解析失败 → 调用on_error回调                 │
 *   │   复位状态机, 准备接收下一帧                  │
 *   └─────────────────────────────────────────────┘
 *
 * 调用方式: 在UART接收中断中逐字节调用此函数
 *
 * @param h    句柄
 * @param byte 接收到的字节
 * @return FRAME_READY=完整帧已就绪, IN_PROGRESS=接收中, 其他=错误
 */
es1642_status_t ES1642_InputByte(es1642_handle_t *h, uint8_t byte)
{
    es1642_frame_t frame;
    es1642_status_t st;

    /* 状态0: 等待帧头 0x79 */
    if (h->rx_index == 0U)
    {
        if (byte != ES1642_FRAME_HEAD) { return ES1642_STATUS_IN_PROGRESS; }
        h->rx_buf[0] = byte;
        h->rx_index = 1U;
        h->rx_expected_len = 0U;
        return ES1642_STATUS_IN_PROGRESS;
    }

    /* 缓冲区溢出保护 */
    if (h->rx_index >= sizeof(h->rx_buf)) { ES1642_ResetRx(h); return ES1642_STATUS_ERROR_BUFFER_TOO_SMALL; }

    /* 存入字节 */
    h->rx_buf[h->rx_index++] = byte;

    /* 收到第3字节时: 已收到 HEAD+LEN_L+LEN_H, 可以计算期望帧长度 */
    if (h->rx_index == 3U)
    {
        uint16_t dl = es1642_get_le16(&h->rx_buf[1]);
        if (dl > ES1642_MAX_DATA_LEN) { ES1642_ResetRx(h); return ES1642_STATUS_ERROR_DATA_TOO_LONG; }
        h->rx_expected_len = (uint16_t)(ES1642_MIN_FRAME_LEN + dl);
        if (h->rx_expected_len > sizeof(h->rx_buf)) { ES1642_ResetRx(h); return ES1642_STATUS_ERROR_BUFFER_TOO_SMALL; }
    }

    /* 检查是否收满完整帧 */
    if ((h->rx_expected_len > 0U) && (h->rx_index >= h->rx_expected_len))
    {
        /* 解析帧 */
        st = es1642_parse_frame(h->rx_buf, h->rx_expected_len, &frame);
        if (st == ES1642_STATUS_OK)
        {
            /* 解析成功: 通过回调通知应用层 */
            if (h->port.on_frame) { h->port.on_frame(h, &frame, h->port.user_arg); }
            ES1642_ResetRx(h);
            return ES1642_STATUS_FRAME_READY;
        }
        /* 解析失败 */
        ES1642_ResetRx(h);
        return st;
    }
    return ES1642_STATUS_IN_PROGRESS;
}

/* ========================= 发送数据 ========================= */

/*
 * ES1642_SendData - 通过载波发送数据到指定地址
 *
 * SendData帧负载(DATA部分)格式:
 *   ┌──────┬──────┬──────────────┬──────┬──────────────┐
 *   │CTRL_L│CTRL_H│ DST_ADDR[6]  │ULEN_L│ USER_DATA[0..N]│
 *   │ 2字节 │      │   6字节      │ 2字节 │   可变长度     │
 *   └──────┴──────┴──────────────┴──────┴──────────────┘
 *   - CTRL: 控制信息 (包含中继深度等)
 *   - DST_ADDR: 目标设备地址 (6字节)
 *   - ULEN: 用户数据长度 (2字节小端)
 *   - USER_DATA: 实际的用户数据
 *
 * @param h     句柄
 * @param dst   目标地址 (6字节)
 * @param udata 用户数据
 * @param ulen  用户数据长度
 * @param relay 中继深度 (0=直连)
 * @param prm   true=主动请求, false=被动应答
 */
es1642_status_t ES1642_SendData(es1642_handle_t *h,
                                const uint8_t dst[ES1642_ADDR_LEN],
                                const uint8_t *udata, uint16_t ulen,
                                uint8_t relay, bool prm)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t plen;

    plen = (uint16_t)(ES1642_SEND_DATA_FIXED_LEN + ulen);
    if (plen > ES1642_MAX_DATA_LEN) { return ES1642_STATUS_ERROR_DATA_TOO_LONG; }

    es1642_put_le16(&payload[0], (uint16_t)((uint16_t)(relay & 0x0FU) << 12));
    (void)memcpy(&payload[2], dst, ES1642_ADDR_LEN);
    es1642_put_le16(&payload[8], ulen);
    if (ulen > 0U) { (void)memcpy(&payload[10], udata, ulen); }

    return ES1642_SendFrame(h, ES1642_MakeSendDataCtrlByte(prm), ES1642_CMD_SEND_DATA, payload, plen);
}

/* ========================= 解析接收数据 ========================= */

/*
 * ES1642_DecodeRecvData - 解析收到的数据帧 (CMD=0x15)
 *
 * RecvData帧负载格式:
 *   ┌──────┬──────┬──────┬──────────────┬──────┬──────────────┐
 *   │CTRL_0│CTRL_1│CTRL_2│ SRC_ADDR[6]  │ULEN_L│ USER_DATA[0..N]│
 *   │ 3字节 │      │      │   6字节      │ 2字节 │   可变长度     │
 *   └──────┴──────┴──────┴──────────────┴──────┴──────────────┘
 *   - CTRL: 3字节控制信息 (含中继深度, RSSI等)
 *   - SRC_ADDR: 源设备地址 (6字节)
 *   - ULEN: 用户数据长度 (2字节小端)
 *   - USER_DATA: 实际的用户数据
 *
 * @param f  已解析的帧 (cmd应为0x15)
 * @param rd 输出: 解码后的接收数据结构
 */
es1642_status_t ES1642_DecodeRecvData(const es1642_frame_t *f, es1642_recv_data_t *rd)
{
    uint16_t ulen;
    es1642_status_t st = es1642_expect_normal(f, ES1642_CMD_RECV_DATA);
    if ((st != ES1642_STATUS_OK) || (rd == NULL))
        return (st != ES1642_STATUS_OK) ? st : ES1642_STATUS_ERROR_PARAM;
    if (f->data_len < ES1642_RECV_DATA_FIXED_LEN) { return ES1642_STATUS_ERROR_PAYLOAD_LENGTH; }

    ulen = es1642_get_le16(&f->data[9]);
    if (f->data_len != (uint16_t)(ES1642_RECV_DATA_FIXED_LEN + ulen)) { return ES1642_STATUS_ERROR_PAYLOAD_LENGTH; }

    rd->raw_data_ctrl = (uint32_t)f->data[0] | ((uint32_t)f->data[1] << 8) | ((uint32_t)f->data[2] << 16);
    rd->relay_depth = (uint8_t)((rd->raw_data_ctrl >> 8) & 0x0FU);  /* 中继深度 */
    rd->rssi = 0;                                                     /* RSSI (保留) */
    (void)memcpy(rd->src_addr, &f->data[3], ES1642_ADDR_LEN);        /* 源地址 */
    rd->user_data_len = ulen;                                          /* 用户数据长度 */
    rd->user_data = (ulen > 0U) ? &f->data[11] : NULL;               /* 用户数据指针 */
    return ES1642_STATUS_OK;
}

/* ========================= 地址/MAC管理 ========================= */

/*
 * ES1642_SendSetAddr - 设置ES1642芯片的通信地址
 * @param h    句柄
 * @param addr 6字节地址
 * 上电后必须调用一次, 设置本机地址后才能正常通信
 */
es1642_status_t ES1642_SendSetAddr(es1642_handle_t *h, const uint8_t addr[ES1642_ADDR_LEN])
{
    return ES1642_SendFrame(h, ES1642_CTRL_DEVICE_REQUEST, ES1642_CMD_SET_ADDR, addr, ES1642_ADDR_LEN);
}

es1642_status_t ES1642_SendReadMac(es1642_handle_t *h)
{
    return ES1642_SendFrame(h, ES1642_CTRL_DEVICE_REQUEST, ES1642_CMD_READ_MAC, NULL, 0U);
}

/* 验证空响应 (无数据负载的响应帧) */
es1642_status_t ES1642_DecodeEmptyResponse(const es1642_frame_t *f, uint8_t cmd)
{
    return es1642_expect_normal(f, cmd);
}

/*
 * ES1642_DecodeMac - 从ReadMac响应帧中提取MAC地址
 * @param f   响应帧 (cmd应为0x03)
 * @param mac 输出: 6字节MAC地址
 */
es1642_status_t ES1642_DecodeMac(const es1642_frame_t *f, uint8_t mac[ES1642_ADDR_LEN])
{
    es1642_status_t st = es1642_expect_normal(f, ES1642_CMD_READ_MAC);
    if (st != ES1642_STATUS_OK) { return st; }
    if (f->data_len < ES1642_ADDR_LEN) { return ES1642_STATUS_ERROR_PAYLOAD_LENGTH; }
    (void)memcpy(mac, f->data, ES1642_ADDR_LEN);
    return ES1642_STATUS_OK;
}

/*
 * ES1642_DecodeSearchNotify - 解析搜索通知帧 (CMD=0x1A)
 */
es1642_status_t ES1642_DecodeSearchNotify(const es1642_frame_t *f, es1642_search_notify_t *n)
{
    es1642_status_t st = es1642_expect_normal(f, ES1642_CMD_NOTIFY_SEARCH);
    if ((st != ES1642_STATUS_OK) || (n == NULL))
        return (st != ES1642_STATUS_OK) ? st : ES1642_STATUS_ERROR_PARAM;
    if (f->data_len < 10U) { return ES1642_STATUS_ERROR_PAYLOAD_LENGTH; }

    n->raw_data_ctrl = (uint16_t)f->data[0] | ((uint16_t)f->data[1] << 8);
    (void)memcpy(n->src_addr, &f->data[2], ES1642_ADDR_LEN);
    n->task_id = f->data[8];
    n->attribute_len = f->data[9];
    n->attribute = (n->attribute_len > 0U && f->data_len > 10U) ? &f->data[10] : NULL;
    return ES1642_STATUS_OK;
}

/*
 * ES1642_SendSearchReply - 回复搜索响应 (CMD=0x1B)
 */
es1642_status_t ES1642_SendSearchReply(es1642_handle_t *h,
                                       const uint8_t src[ES1642_ADDR_LEN],
                                       uint8_t task_id, bool participate,
                                       const uint8_t *attr, uint8_t attr_len)
{
    uint8_t payload[ES1642_MAX_DATA_LEN];
    uint16_t plen;

    plen = (uint16_t)(2U + ES1642_ADDR_LEN + 1U + 1U + attr_len);
    if (plen > ES1642_MAX_DATA_LEN) { return ES1642_STATUS_ERROR_DATA_TOO_LONG; }

    payload[0] = participate ? 0x01U : 0x00U;
    payload[1] = 0x00U;
    (void)memcpy(&payload[2], src, ES1642_ADDR_LEN);
    payload[8] = task_id;
    payload[9] = attr_len;
    if ((attr_len > 0U) && (attr)) { (void)memcpy(&payload[10], attr, attr_len); }

    return ES1642_SendFrame(h, ES1642_CTRL_DEVICE_REPLY, ES1642_CMD_REPLY_SEARCH, payload, plen);
}

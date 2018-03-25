#ifndef CAN_H
#define	CAN_H

#include <stdint.h>

#include "net/canbus.h"

#define CAN_RX_QUEUE_SIZE	8
#define CAN_TX_QUEUE_SIZE	8

#define CAN_MODE_NORMAL		0
#define CAN_MODE_LISTEN		1
#define CAN_MODE_LOOPBACK	2

// hw independent functions

void can_init(uint32_t baudrate, uint8_t mode);
void can_deinit(void);
uint8_t can_recv(struct can_frame *frame);
uint8_t can_send(struct can_frame *frame);

uint8_t can_get_from_tx_queue(struct can_frame *frame);
uint8_t can_put_to_rx_queue(struct can_frame *frame);
void can_stop_tx(void);

// functions need to be implement in app layer

void can_send_callback(struct can_frame *frame);

// functions need to be implemented in hw layer

void can_close(void);
void can_open_normal(uint32_t baudrate);
void can_open_listen(uint32_t baudrate);
void can_open_loopback(uint32_t baudrate);

uint8_t can_get_status(void);
void can_start_tx(void);

void can_disable_rx_isr(void);
void can_enable_rx_isr(void);
void can_disable_tx_isr(void);
void can_enable_tx_isr(void);

inline void can_rx_isr(void);
inline void can_tx_isr(void);

#endif	/* CAN_H */


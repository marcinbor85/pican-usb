/* 
 * File:   slcan.h
 * Author: mborowicz
 *
 * Created on 24 marca 2018, 17:09
 */

#ifndef SLCAN_H
#define	SLCAN_H

#include <stdint.h>

#include "canbus.h"

#define SLCAN_MODE_NORMAL	0
#define SLCAN_MODE_LISTEN	1
#define SLCAN_MODE_LOOPBACK	2

#define SLCAN_BAUDRATE_0	10000UL
#define SLCAN_BAUDRATE_1	20000UL
#define SLCAN_BAUDRATE_2	50000UL
#define SLCAN_BAUDRATE_3	100000UL
#define SLCAN_BAUDRATE_4	125000UL
#define SLCAN_BAUDRATE_5	250000UL
#define SLCAN_BAUDRATE_6	500000UL
#define SLCAN_BAUDRATE_7	800000UL
#define SLCAN_BAUDRATE_8	1000000UL

#define SLCAN_BUFFER_SIZE	32

#define SLCAN_END_LINE_BYTE	0x0D
#define SLCAN_ERROR_BYTE	0x07

struct slcan_interface {
	uint8_t (*recv_frame)(struct can_frame *);
	uint8_t (*open)(uint32_t, uint8_t);
	uint8_t (*close)(void);
	uint8_t (*get_status)(void);
	void (*send_byte)(uint8_t);
	uint8_t *unique_serial;
	uint8_t *firmware_version;
	uint8_t *hardware_version;
};

struct slcan_object {
	const struct slcan_interface *iface;
	uint32_t baudrate;
	uint8_t buf[SLCAN_BUFFER_SIZE];
	uint8_t size;
	uint8_t std_tx_cntr;
	uint8_t ext_tx_cntr;
};

void slcan_init(struct slcan_object *slcan, const struct slcan_interface *iface);
void slcan_parse(struct slcan_object *slcan, uint8_t b);
void slcan_send_frame(struct slcan_object *slcan, struct can_frame *frame);
void slcan_tx_service(struct slcan_object *slcan);
void slcan_tx_acknowledge(struct slcan_object *slcan, struct can_frame *frame);

#endif	/* SLCAN_H */


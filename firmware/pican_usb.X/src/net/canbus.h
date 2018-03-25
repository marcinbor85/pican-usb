/* 
 * File:   canbus.h
 * Author: mborowicz
 *
 * Created on 25 marca 2018, 14:57
 */

#ifndef CANBUS_H
#define	CANBUS_H

#include <stdint.h>

#define CAN_FRAME_DATA_LENGTH	8

struct can_frame {
	uint32_t id; 
	uint8_t data[CAN_FRAME_DATA_LENGTH];
	uint8_t dlc;
	uint8_t extended;
	uint8_t remote;	
};

#endif	/* CANBUS_H */


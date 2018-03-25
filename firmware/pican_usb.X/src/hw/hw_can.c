#include "hal/can.h"
#include "hw.h"

#include <string.h>
#include <xc.h>

#define CAN_MODULE_MODE_CONFIG		0x04
#define CAN_MODULE_MODE_NORMAL		0x00
#define CAN_MODULE_MODE_LISTEN		0x03
#define CAN_MODULE_MODE_LOOPBACK	0x02
#define CAN_MODULE_MODE_DISABLE		0x01

#define READ_BUFFER(frame, buf, exid) { \
	frame.extended = buf##SIDLbits.exid; \
	frame.remote = buf##DLCbits.RXRTR; \
	if (frame.extended == 0) { \
		frame.id = (uint32_t)((uint32_t)buf##SIDH << 3) | \
			   (uint32_t)((uint32_t)buf##SIDLbits.SID); \
	} else { \
		frame.id = (uint32_t)((uint32_t)buf##SIDH << 21) | \
			   (uint32_t)((uint32_t)buf##SIDLbits.SID << 18) | \
			   (uint32_t)((uint32_t)buf##SIDLbits.EID << 16) | \
			   (uint32_t)((uint32_t)buf##EIDH << 8) | \
			   (uint32_t)((uint32_t)buf##EIDL); \
	} \
	frame.dlc = buf##DLCbits.DLC; \
	if (frame.remote == 0) { \
		frame.data[0] = buf##D0; \
		frame.data[1] = buf##D1; \
		frame.data[2] = buf##D2; \
		frame.data[3] = buf##D3; \
		frame.data[4] = buf##D4; \
		frame.data[5] = buf##D5; \
		frame.data[6] = buf##D6; \
		frame.data[7] = buf##D7; \
	} \
}

#define WRITE_BUFFER(frame, buf, exid) { \
	buf##SIDLbits.exid = frame.extended; \
	buf##DLCbits.TXRTR = frame.remote; \
	if (frame.extended == 0) { \
		buf##SIDLbits.SID = frame.id; \
		buf##SIDH = frame.id >> 3; \
	} else { \
		buf##EIDL = frame.id; \
		buf##EIDH = frame.id >> 8; \
		buf##SIDLbits.EID = frame.id >> 16; \
		buf##SIDLbits.SID = frame.id >> 18; \
		buf##SIDH = frame.id >> 21; \
	} \
	buf##DLCbits.DLC = frame.dlc; \
	if (frame.remote == 0) { \
		buf##D0 = frame.data[0]; \
		buf##D1 = frame.data[1]; \
		buf##D2 = frame.data[2]; \
		buf##D3 = frame.data[3]; \
		buf##D4 = frame.data[4]; \
		buf##D5 = frame.data[5]; \
		buf##D6 = frame.data[6]; \
		buf##D7 = frame.data[7]; \
	} \
	buf##CONbits.TXREQ = 1; \
}

static struct can_frame tx_frame;
static uint8_t start_tx_flag;

static void set_mode(uint8_t mode)
{
	CANCONbits.REQOP = mode;
	while (CANSTATbits.OPMODE != mode) {};
}

static void config_baudrate(uint32_t baudrate)
{
	CIOCON = 0x00;

	BRGCON2bits.SEG2PHTS = 1;
	BRGCON2bits.SAM = 0;
	
	BRGCON1bits.SJW = 1; // sjw = 2Tq
	BRGCON1bits.BRP = ((HW_SYS_FREQ / baudrate) / (2 * 16)) - 1;
	BRGCON2bits.SEG1PH = 7; // phase1 = 8Tq
	BRGCON2bits.PRSEG = 0; // propagation = 1Tq
	BRGCON3bits.SEG2PH = 5; // phase2 = 6Tq;
}

void can_close(void)
{
	start_tx_flag = 0;
	
	TXBIE = 0x00;
	BIE0 = 0x00;
	PIE5bits.TXBnIE = 0;
	PIE5bits.RXBnIE = 0;
	
	set_mode(CAN_MODULE_MODE_DISABLE);
}

static void configure(uint32_t baudrate, uint8_t mode)
{
	uint8_t state;
	
	start_tx_flag = 0;
	
	TXBIE = 0x00;
	BIE0 = 0x00;
	PIE5bits.TXBnIE = 0;
	PIE5bits.RXBnIE = 0;
	
	state = (uint8_t)GIE;
	
	GIE = 0;
	PPSLOCK = 0x55;
	PPSLOCK = 0xAA;
	PPSLOCK = 0x00; // unlock PPS

	RB4PPS = 0x33;
	CANRXPPS = 0x0B;
	
	PPSLOCK = 0x55;
	PPSLOCK = 0xAA;
	PPSLOCK = 0x01; // lock   PPS
	GIE = state;
	
	TRISBbits.TRISB4 = 0; //TX
	TRISBbits.TRISB3 = 1; //RX
	
	set_mode(CAN_MODULE_MODE_CONFIG);
	
	ECANCONbits.MDSEL = 2; // fifo mode
	
	config_baudrate(baudrate);
	
	BSEL0 = 0x00;
	
	RXB0CON = 0x00;
	RXB1CON = 0x00;
	B0CON = 0x00;
	B1CON = 0x00;
	B2CON = 0x00;
	B3CON = 0x00;
	B4CON = 0x00;
	B5CON = 0x00;
	
	RXM0SIDH = 0x00;
	RXM0SIDL = 0x00;
	RXM0EIDH = 0x00;
	RXM0EIDL = 0x00;
	
	RXFCON0 = 0x01;
	RXFCON1 = 0x00;
	
	RXFBCON0 = 0x00;
	RXFBCON1 = 0x00;
	RXFBCON2 = 0x00;
	RXFBCON3 = 0x00;
	RXFBCON4 = 0x00;
	RXFBCON5 = 0x00;
	RXFBCON6 = 0x00;
	RXFBCON7 = 0x00;
	
	set_mode(mode);

	PIR5bits.TXBnIF = 0;
	PIE5bits.TXBnIE = 1;
	TXBIE = 0x04;
	
	PIR5bits.RXBnIF = 0;
	PIE5bits.RXBnIE = 1;
	BIE0 = 0xFF;
}

void can_open_normal(uint32_t baudrate)
{
	configure(baudrate, CAN_MODULE_MODE_NORMAL);
}

void can_open_listen(uint32_t baudrate)
{
	configure(baudrate, CAN_MODULE_MODE_LISTEN);
}

void can_open_loopback(uint32_t baudrate)
{
	configure(baudrate, CAN_MODULE_MODE_LOOPBACK);
}

void can_start_tx(void)
{
	start_tx_flag = 1;
	TXB0CONbits.TXBIF = 1;
}

uint8_t can_get_status(void)
{
	uint8_t ret = 0;
	
	if (COMSTATbits.TXBO != 0)
		ret |= (1 << 7);
	if ((COMSTATbits.TXBP != 0) || (COMSTATbits.RXBP != 0))
		ret |= (1 << 5);
	
	return ret;
}

void can_disable_tx_isr(void)
{
	PIE5bits.TXBnIE = 0;
}

void can_enable_tx_isr(void)
{
	PIE5bits.TXBnIE = 1;
}

void can_disable_rx_isr(void)
{
	PIE5bits.RXBnIE = 0;
}

void can_enable_rx_isr(void)
{
	PIE5bits.RXBnIE = 1;
}

inline void can_rx_isr(void)
{	
	struct can_frame frame;
	
	switch (CANCONbits.FP) {
	case 0:
		if (RXB0CONbits.RXFUL != 0) {
			READ_BUFFER(frame, RXB0, EXID);
			can_put_to_rx_queue(&frame);
			RXB0CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 1:
		if (RXB1CONbits.RXFUL != 0) {
			READ_BUFFER(frame, RXB1, EXID);		
			can_put_to_rx_queue(&frame);
			RXB1CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 2:
		if (B0CONbits.RXFUL != 0) {
			READ_BUFFER(frame, B0, EXIDE);
			can_put_to_rx_queue(&frame);
			B0CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 3:
		if (B1CONbits.RXFUL != 0) {
			READ_BUFFER(frame, B1, EXIDE);
			can_put_to_rx_queue(&frame);
			B1CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 4:
		if (B2CONbits.RXFUL != 0) {
			READ_BUFFER(frame, B2, EXIDE);
			can_put_to_rx_queue(&frame);
			B2CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 5:
		if (B3CONbits.RXFUL != 0) {
			READ_BUFFER(frame, B3, EXIDE);
			can_put_to_rx_queue(&frame);
			B3CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 6:
		if (B4CONbits.RXFUL != 0) {
			READ_BUFFER(frame, B4, EXIDE);
			can_put_to_rx_queue(&frame);
			B4CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	case 7:
		if (B5CONbits.RXFUL != 0) {
			READ_BUFFER(frame, B5, EXIDE);
			can_put_to_rx_queue(&frame);
			B5CONbits.RXFUL = 0;
			PIR5bits.RXBnIF = 0;
		}
		break;
	}
}

inline void can_tx_isr(void)
{	
	if (TXB0CONbits.TXBIF != 0) {
		TXB0CONbits.TXBIF = 0;
		PIR5bits.TXBnIF = 0;
		
		if (start_tx_flag == 0)
			can_send_callback(&tx_frame);
		
		if (can_get_from_tx_queue(&tx_frame) != 0) {
			WRITE_BUFFER(tx_frame, TXB0, EXIDE);
		} else {
			can_stop_tx();
		}
		
		if (start_tx_flag != 0)
			start_tx_flag = 0;
	}
}

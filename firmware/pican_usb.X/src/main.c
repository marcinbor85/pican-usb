#include "hw/hw.h"

#include <stdint.h>

#include "hal/tick.h"
#include "hal/leds.h"
#include "hal/can.h"

#include "hw/hw_ft245.h"

#include "net/ft245.h"
#include "net/slcan.h"

static uint8_t open_flag = 0;
static uint8_t std_ack_cntr = 0;
static uint8_t ext_ack_cntr = 0;
static uint8_t flash_flag = 0;
static uint8_t flash_state = 0;

static uint32_t last_tick = 0;
static uint32_t flash_tick = 0;

static struct slcan_object slcan;

static const uint8_t unique_serial[] = "FFFF";
static const uint8_t firmware_version[] = "0100";
static const uint8_t hardware_version[] = "0100";

static uint8_t recv_frame(struct can_frame *frame)
{
	if (open_flag == 0)
		return 1;
	if (can_send(frame) == 0)
		return 1;
	return 0;
}

static uint8_t open(uint32_t baudrate, uint8_t mode)
{
	if (open_flag != 0)
		return 1;
	
	switch (mode) {
	case SLCAN_MODE_NORMAL:
		can_init(baudrate, CAN_MODE_NORMAL);
		break;
	case SLCAN_MODE_LISTEN:
		can_init(baudrate, CAN_MODE_LISTEN);
		break;
	case SLCAN_MODE_LOOPBACK:
		can_init(baudrate, CAN_MODE_LOOPBACK);
		break;
	}
	open_flag = 1;
	return 0;
}

static uint8_t close(void)
{
	if (open_flag == 0)
		return 1;
	
	can_deinit();
	open_flag = 0;
	return 0;
}

static uint8_t get_status(void)
{
	return can_get_status();
}

static void send_byte(uint8_t b)
{
	while (ft245_put_byte(&ft245, b) == 0) {};
}

static struct slcan_interface slcan_iface = {
	recv_frame,
	open,
	close,
	get_status,
	send_byte,
	(uint8_t*)unique_serial,
	(uint8_t*)firmware_version,
	(uint8_t*)hardware_version
};

void can_send_callback(struct can_frame *frame)
{
	flash_flag = 1;
	slcan_tx_acknowledge(&slcan, frame);
}

static void clear_watchdog(void)
{
	CLRWDT();
}

static void leds_service(void)
{
	if (tick_get_value() - last_tick >= ((open_flag == 0) ? 500UL : 100UL)) {
		last_tick = tick_get_value();
		leds_toggle(LEDS_TYPE_OK);
	}

	switch (flash_state) {
	case 0:
		if (flash_flag == 1) {
			flash_flag = 0;
			flash_state = 1;
		}
		break;
	case 1:
		flash_tick = tick_get_value();
		leds_set(LEDS_TYPE_RXTX, 1);
		flash_state = 2;
		break;
	case 2:
		if (tick_get_value() - flash_tick >= 50UL) {
			flash_tick = tick_get_value();
			leds_set(LEDS_TYPE_RXTX, 0);
			flash_state = 3;
		}
		break;
	case 3:
		if (tick_get_value() - flash_tick >= 50UL) {
			if (flash_flag != 0) {
				flash_flag = 0;
				flash_state = 1;
			} else {
				leds_set(LEDS_TYPE_RXTX, 0);
				flash_state = 0;
			}
		}
		break;
	}
}

static void app_service(void)
{
	uint8_t b;
	struct can_frame frame;
	
	if (ft245_get_byte(&ft245, &b) != 0) {
		slcan_parse(&slcan, b);
	}

	if (open_flag != 0) {
		if (can_recv(&frame) != 0) {
			flash_flag = 1;
			slcan_send_frame(&slcan, &frame);
		}
		can_disable_tx_isr();
		slcan_tx_service(&slcan);
		can_enable_tx_isr();
	}
}

void main(void)
{	
	INTCON0bits.GIE = 0;
	CLRWDT();
	
	OSCCON1 = 0x20;
	while (OSCCON3bits.ORDY == 0) {};
	
	ANSELA = 0;
	ANSELB = 0;
	ANSELC = 0;
	
	tick_init();
	leds_init();
	
	ft245_init(&ft245);
	slcan_init(&slcan, &slcan_iface);

	INTCON0bits.GIE = 1;
	
	tick_delay(500, clear_watchdog);
	ft245_start();
	tick_delay(500, clear_watchdog);
	
	while (ft245_is_enumerated() == 0) {};

	leds_set(LEDS_TYPE_OK, 1);
	leds_set(LEDS_TYPE_RXTX, 0);
		
	while (1) {
		leds_service();
		app_service();
		
		if (ft245_is_enumerated() != 0)
			CLRWDT();
	}
}


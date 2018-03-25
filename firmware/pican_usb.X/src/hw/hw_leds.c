#include "hal/leds.h"

#include "hw.h"

#define LEDS_OK_TRIS	TRISBbits.TRISB0
#define LEDS_OK_LAT	LATBbits.LATB0

#define LEDS_RXTX_TRIS	TRISBbits.TRISB1
#define LEDS_RXTX_LAT	LATBbits.LATB1

void leds_init(void)
{
	LEDS_OK_TRIS = 0;
	LEDS_RXTX_TRIS = 0;
}

void leds_set(uint8_t t, uint8_t s)
{
	switch (t) {
	case LEDS_TYPE_OK:
		LEDS_OK_LAT = s;
		break;
	case LEDS_TYPE_RXTX:
		LEDS_RXTX_LAT = s;
		break;
	}
}

void leds_toggle(uint8_t t)
{
	switch (t) {
	case LEDS_TYPE_OK:
		LEDS_OK_LAT ^= 1;
		break;
	case LEDS_TYPE_RXTX:
		LEDS_RXTX_LAT ^= 1;
		break;
	}
}
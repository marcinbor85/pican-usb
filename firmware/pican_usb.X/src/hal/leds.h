#ifndef LEDS_H
#define	LEDS_H

#include <stdint.h>

#define LEDS_TYPE_OK		0
#define LEDS_TYPE_RXTX		1

// hw independent functions

// functions need to be implemented in hw layer

void leds_init(void);
void leds_set(uint8_t t, uint8_t s);
void leds_toggle(uint8_t t);

#endif	/* LEDS_H */


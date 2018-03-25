#include "hal/tick.h"

#include "hw.h"

#define TICK_PERIOD		0.001
#define TICK_TMR0_PERIOD	(uint8_t)((HW_FCY / 128) * TICK_PERIOD)

static uint32_t tick = 0;

void tick_init(void)
{
	T0CON0 = 0;
	T0CON1 = 0x47; // :128
	PR0 = TICK_TMR0_PERIOD;

	tick = 0;

	PIR3bits.TMR0IF = 0;
	PIE3bits.TMR0IE = 1;

	T0CON0bits.EN = 1;
}

uint32_t tick_get_value(void)
{
	uint32_t ret;
	PIE3bits.TMR0IE = 0;
	ret = tick;
	PIE3bits.TMR0IE = 1;
	return ret;
}

inline void tick_isr(void)
{
	tick++;
	PIR3bits.TMR0IF = 0;
}

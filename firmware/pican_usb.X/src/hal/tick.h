#ifndef TICK_H
#define	TICK_H

#include <stdint.h>

// hw independent functions

void tick_delay(uint32_t d, void (*loop)(void));

// functions need to be implemented in hw layer

uint32_t tick_get_value(void);
void tick_init(void);
inline void tick_isr(void);

#endif
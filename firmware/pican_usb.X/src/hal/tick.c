#include "tick.h"

#include <stddef.h>

void tick_delay(uint32_t d, void (*loop)(void))
{
	uint32_t last_tick = tick_get_value();
	while (tick_get_value() - last_tick < d) {
		if (loop != NULL)
			loop();
	}
}


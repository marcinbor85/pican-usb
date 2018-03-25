#ifndef HW_FT245_H
#define	HW_FT245_H

#include "net/ft245.h"

extern const struct ft245_interface ft245;

uint8_t ft245_is_enumerated(void);
void ft245_start(void);

#endif	/* HW_FT245_H */


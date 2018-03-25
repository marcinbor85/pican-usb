#include <xc.h>

#include "hal/tick.h"
#include "hal/can.h"

#define IVT_TABLE_BASE_ADR	0x0020

void __interrupt(irq(IRQ_TMR0), base(IVT_TABLE_BASE_ADR), high_priority) TMR0_ISR(char src)
{
	tick_isr();
}

void __interrupt(irq(IRQ_RXB1IF), base(IVT_TABLE_BASE_ADR), high_priority) CANRX_ISR(char src)
{
	can_rx_isr();
}

void __interrupt(irq(IRQ_TXB2IF), base(IVT_TABLE_BASE_ADR), high_priority) CANTX_ISR(char src)
{
	can_tx_isr();
}

void __interrupt(irq(default), base(IVT_TABLE_BASE_ADR), high_priority) DEFAULT_ISR(char src)
{
	while(1) {};
}
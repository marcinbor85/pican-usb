#include "hw_ft245.h"

#include "hw.h"

#define FT245_DATA_TRIS		TRISC
#define FT245_DATA_LAT		LATC
#define FT245_DATA_PORT		PORTC

#define FT245_RXF_TRIS		TRISAbits.TRISA0
#define FT245_RXF_PORT		PORTAbits.RA0
#define FT245_RXF_WPU		WPUAbits.WPUA0

#define FT245_TXE_TRIS		TRISAbits.TRISA1
#define FT245_TXE_PORT		PORTAbits.RA1
#define FT245_TXE_WPU		WPUAbits.WPUA1

#define FT245_WR_TRIS		TRISAbits.TRISA2
#define FT245_WR_LAT		LATAbits.LA2

#define FT245_RD_TRIS		TRISAbits.TRISA3
#define FT245_RD_LAT		LATAbits.LA3

#define FT245_PWREN_TRIS	TRISAbits.TRISA4
#define FT245_PWREN_PORT	PORTAbits.RA4

#define FT245_RESET_TRIS	TRISAbits.TRISA5
#define FT245_RESET_LAT		LATAbits.LA5

uint8_t ft245_is_enumerated(void)
{
	return (FT245_PWREN_PORT == 0) ? 1U : 0;
}

void ft245_start(void)
{
	FT245_RESET_LAT = 1;
}

static void init(void)
{
	FT245_PWREN_TRIS = 1;
	
	FT245_RESET_LAT = 0;
	FT245_RESET_TRIS = 0;
	
	FT245_DATA_TRIS = 0xFF;
	
	FT245_RXF_WPU = 1;
	FT245_RXF_TRIS = 1;
	FT245_TXE_WPU = 1;
	FT245_TXE_TRIS = 1;
	
	FT245_RD_LAT = 1;
	FT245_RD_TRIS = 0;
	FT245_WR_LAT = 0;
	FT245_WR_TRIS = 0;
}

static void set_port(uint8_t b)
{
	FT245_DATA_LAT = b;
}

static uint8_t get_port(void)
{
	return FT245_DATA_PORT;
}

static void config_port_input(void)
{
	FT245_DATA_TRIS = 0xFF;
}

static void config_port_output(void)
{
	FT245_DATA_TRIS = 0x00;
}

static uint8_t is_tx_empty(void)
{
	return (FT245_TXE_PORT == 0) ? 1U : 0;
}

static uint8_t is_rx_full(void)
{
	return (FT245_RXF_PORT == 0) ? 1U : 0;
}

static void set_read(uint8_t s)
{
	FT245_RD_LAT = s;
}

static void set_write(uint8_t s)
{
	FT245_WR_LAT = s;
}
	
const struct ft245_interface ft245 = {
	init,
	set_port,
	get_port,
	config_port_input,
	config_port_output,
	is_tx_empty,
	is_rx_full,
	set_read,
	set_write
};

#include <stdio.h>
#include "Types.h"

#define PORTB		(*(volatile u8  *) 0x38)
#define PORT		(*(volatile Reg *) 0x38)
#define PORTA		(*(volatile u8  *) 0x3B)


#define PORTB_Bit0	PORT.Bit.Bit0
#define PORTB_Bit1	PORT.Bit.Bit1
#define PORTB_Bit2	PORT.Bit.Bit2
#define PORTB_Bit3	PORT.Bit.Bit3
#define PORTB_Bit4	PORT.Bit.Bit4
#define PORTB_Bit5	PORT.Bit.Bit5
#define PORTB_Bit6	PORT.Bit.Bit6
#define PORTB_Bit7	PORT.Bit.Bit7



	typedef union
	{
			u8 PORTS;
			struct
			{
			u8 Bit0:1 ;
			u8 Bit1:1 ;
			u8 Bit2:1 ;
			u8 Bit3:1 ;
			u8 Bit4:1 ;
			u8 Bit5:1 ;
			u8 Bit6:1 ;
			u8 Bit7:1 ;
			}Bit;
	}Reg;
unsigned char  __attribute__((section (".7madh"))) x;
u8 Data=5;
u8 Data1;
u8 Data2;
u8 Bss,Bss1;
u8 const gg=4;
static u8 ffff=10;

int Hmadh (void);


int main (void)
{
	(*(volatile u8 *)0x800065)=9;
	PORTB_Bit0 = 0;
	PORTB_Bit1 = 0;
	PORTB_Bit2 = 1;
	PORTB_Bit3 = 1;
	while(1);
	return 0;
}

int Hmadh (void)
{
	(*(volatile u8 *)0x800065)=9;
	PORTB_Bit0 = 1;
	PORTB_Bit1 = 1;
	PORTB_Bit2 = 0;
	PORTB_Bit3 = 0;
	while(1);
	return 0;
}

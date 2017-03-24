.section .vectors
__Vectors:
jmp 	Init_Data_start 	; Reset Handler
jmp 	Init_Data_start		; IRQ0 Handler
jmp 	Init_Data_start		; IRQ1 Handler
jmp 	Init_Data_start		; IRQ2 Handler
jmp 	Init_Data_start		; Timer2 Compare Handler
jmp 	Init_Data_start		; Timer2 Overflow Handler
jmp 	Init_Data_start		; Timer1 Capture Handler
jmp 	Init_Data_start		; Timer1 CompareA Handler
jmp 	Init_Data_start		; Timer1 CompareB Handler
jmp 	Init_Data_start		; Timer1 Overflow Handler
jmp 	Init_Data_start		; Timer0 Compare Handler
jmp 	Init_Data_start		; Timer0 Overflow Handler
jmp 	Init_Data_start		; SPI Transfer Complete Handler
jmp 	Init_Data_start		; USART RX Complete Handler
jmp 	Init_Data_start		; UDR Empty Handler
jmp 	Init_Data_start		; USART TX Complete Handler
jmp 	Init_Data_start		; ADC Conversion Complete Handler
jmp 	Init_Data_start		; EEPROM Ready Handler
jmp 	Init_Data_start		; Analog Comparator Handler
jmp 	Init_Data_start		; Two-wire Serial Interface Handler
jmp 	Init_Data_start		; Store Program Memory Ready Handler
init_stack:
		out 0x3f,r1
		;;ramStart -> 0060
		;;@@ Initialize the stack pointer
		ldi R16,lo8(0x085f);R16=0X08 ramend=0x085f
		OUT 0x3e,R16	    ;;SPH =THE high byte of address
		LDI R16,hi8(0x085f); R16=0X5F
		OUT 0x3d,R16	    ;;SPL =THE low byte of address
Init_Data_start:
        ;;@@ Copy data to RAM. 
        
		ldi   r17,hi8(__data_start) ; take high byte of ram start  put it in r17
        ldi   r26,lo8(__data_start); put address of data start in r26 (low x)
        ldi   r27,hi8(__data_start) ; take high byte of ram start  put it in r27
		ldi   r30,lo8(__data_load_start); put __data_load_start in r30 (low z)
		ldi   r31,hi8(__data_load_start); put __data_load_start in r30 (high z)
		
		;;@@ Handle data_size == 0
        ldi   r18,data_size ; put data_size in r18
        clr   r16 ; clear r16
		cp    r18, r16;compare r16 with r18 if zero go to init bss else go to Address_Compare
		breq  init_bss
		rjmp Address_Compare
Data_copy:
        lpm   r0 , z+;(ROM)Loads one byte pointed to by the Z-register into the destination register
		st    x+ , r0;copy r0 to what x point to 
Address_Compare:
		cpi r26, __data_end; comapre r26 with address of __data_end if equale go to init_bss else go to Do_Clear_Bss
		cpc r27, r17;
		brne Data_copy
init_bss:
		
		ldi   r26,lo8(__data_end)  ; put address of __data_end in r26 (low x)
		ldi   r17,hi8(__data_end) ; take high byte of __data_end  put it in r17
        ldi   r27,hi8(__data_end) ; take high byte of __data_end  put it in r27
		ldi   r19,0 ; put here number that you want to intialzie variable that unintialzied  
		rjmp  Clear_Bss
Do_Clear_Bss:

		st  x+ , r19 ;copy r19 to what x point to then make post increment 
Clear_Bss:		        
		;;@@ Handle bss_size == 0
        cpi r26, __bss_end; comapre r26 with address of __bss_end if equale go to main else go to Do_Clear_Bss
		cpc r27, r17
		brne Do_Clear_Bss
		call   Hmadh ; call name of entery point(fuction name) 
		jmp   stop
stop:  
	cli ;Global Interrupt Disable
	rjmp     stop; jump to stop
		
		


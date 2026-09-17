;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <fcntl.h>
;
;#include "FreeRTOS.h"
;#include "task.h"
;
;char *ucHeapStack = (char *)0x0200;
	data
	xdef	_~ucHeapStack
_~ucHeapStack:
	dl	$200
	ends
;
;volatile char* debug_char = (volatile char *) 0xfffff0;
	data
	xdef	_~debug_char
_~debug_char:
	dl	$FFFFF0
	ends
;volatile char* debug_hex  = (volatile char *) 0xfffff1;
	data
	xdef	_~debug_hex
_~debug_hex:
	dl	$FFFFF1
	ends
;volatile char* debug_reset  = (volatile char *) 0xfffff2;
	data
	xdef	_~debug_reset
_~debug_reset:
	dl	$FFFFF2
	ends
;
;const char *ansi_white = "\033[0m";
	data
	xdef	_~ansi_white
_~ansi_white:
	dl	L1+0
	ends
	data
L1:
	db	$1B,$5B,$30,$6D,$00
	ends
;const char *ansi_red = "\033[31m";
	data
	xdef	_~ansi_red
_~ansi_red:
	dl	L2+0
	ends
	data
L2:
	db	$1B,$5B,$33,$31,$6D,$00
	ends
;const char *ansi_yellow = "\033[33;1m";
	data
	xdef	_~ansi_yellow
_~ansi_yellow:
	dl	L3+0
	ends
	data
L3:
	db	$1B,$5B,$33,$33,$3B,$31,$6D,$00
	ends
;const char *ansi_clrhome = "\033[2J\033[H";
	data
	xdef	_~ansi_clrhome
_~ansi_clrhome:
	dl	L4+0
	ends
	data
L4:
	db	$1B,$5B,$32,$4A,$1B,$5B,$48,$00
	ends
;
;const char parm[] = "parameter 98429";
	data
	xdef	_~parm
_~parm:
	db	$70,$61,$72,$61,$6D,$65,$74,$65,$72,$20
	db	$39,$38,$34,$32,$39,$0
	ends
;
;const HeapRegion_t xHeapRegions[] = 
	data
	xdef	_~xHeapRegions
_~xHeapRegions:
;{
;    /* Region 1: Internes schnelles RAM (z.B. ab 0x20000000, Größe 64 KB) */
;    { ( uint8_t * ) 0x020000, 0xffff }, 
	dl	$20000,$FFFF
;    
;    /* Region 2: Zweiter RAM-Block oder CCM-RAM (z.B. ab 0x30000000, Größe 128 KB) */
;    { ( uint8_t * ) 0x030000, 0xffff }, 
	dl	$30000,$FFFF
;    
;    /* Region 3: Externes schnelles SDRAM (z.B. ab 0xD0000000, Größe 1 MB) */
;    { ( uint8_t * ) 0x040000, 0xffff }, 
	dl	$40000,$FFFF
;    
;    /* Array-Terminierung: MUSS immer als letztes Element stehen! */
;    { NULL, 0 } 
	dl	$0,$0
;};
	ends
;
;#asm
;	;wdm 7
;	clc
;	xce
;	rep #$30
;	lda #$efff
;	tcs
;	phk
;	plb
;	jmp _~main
;#endasm
	asmstart
	;wdm 7
	clc
	xce
	rep #$30
	lda #$efff
	tcs
	phk
	plb
	jmp _~main
	asmend
;
;#include "wdc_misc.h"
	data
	xdef	_~far_heap_start
_~far_heap_start:
	dl	$10000
	ends
	data
	xdef	_~far_heap_end
_~far_heap_end:
	dl	$2FFFF
	ends
	data
	xdef	_~heap_start
_~heap_start:
	dl	$30000
	ends
	data
	xdef	_~heap_end
_~heap_end:
	dl	$3FFFF
	ends
	asmstart
	jmp startup
	jml ($dffc)
	
startup
	clc
	xce
	rep #$30
	lda #$efff
	tcs
	jmp _~main
	asmend
	code
	xdef	_~debug
	func
_~debug:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
format_0	set	5
args_1	set	0
strbuf_1	set	4
	pea	#<$100
	jsr	_~malloc
	sta	<L7+strbuf_1
	stx	<L7+strbuf_1+2
	clc
	tdc
	adc	#<L6+format_0+4
	sta	<L7+args_1
	lda	#$0
	sta	<L7+args_1+2
	pha
	pei	<L7+args_1
	pei	<L6+format_0+2
	pei	<L6+format_0
	pei	<L7+strbuf_1+2
	pei	<L7+strbuf_1
	jsr	_~vsprintf
	pei	<L7+strbuf_1+2
	pei	<L7+strbuf_1
	jsr	_~strlen
	pha
	pei	<L7+strbuf_1+2
	pei	<L7+strbuf_1
	pea	#<$0
	jsr	_~write
	pei	<L7+strbuf_1+2
	pei	<L7+strbuf_1
	jsr	_~free
	phx
	ldx	<L6+3
	lda	<L6+1
	sta	<L6+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L6+2
	adc	<1,s
	tcs
	rts
L6	equ	8
L7	equ	1
	ends
	efunc
	code
	xdef	_~unlink
	func
_~unlink:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
pchar_0	set	3
	pei	<L9+pchar_0+2
	pei	<L9+pchar_0
	pea	#^L5
	pea	#<L5
	pea	#10
	jsr	_~debug
	lda	#$1
	tay
	lda	<L9+1
	sta	<L9+1+4
	pld
	tsc
	clc
	adc	#L9+4
	tcs
	tya
	rts
L9	equ	0
L10	equ	1
	ends
	efunc
	data
L5:
	db	$75,$6E,$6C,$69,$6E,$6B,$20,$63,$61,$6C,$6C,$65,$64,$20,$6E
	db	$61,$6D,$65,$3A,$20,$25,$73,$0A,$00
	ends
	code
	xdef	_~print_str
	func
_~print_str:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
str_0	set	3
	bra	L10001
L20001:
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<L13+str_0]
	sta	[<R0]
	rep	#$20
	longa	on
	inc	<L13+str_0
	bne	L10001
	inc	<L13+str_0+2
L10001:
	lda	[<L13+str_0]
	and	#$ff
	bne	L20001
	lda	<L13+1
	sta	<L13+1+4
	pld
	tsc
	clc
	adc	#L13+4
	tcs
	rts
L13	equ	4
L14	equ	5
	ends
	efunc
	code
	xdef	_~write
	func
_~write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
fd_0	set	3
buf_0	set	5
size_0	set	9
p_1	set	0
ansi_1	set	4
	lda	<L18+buf_0
	sta	<L19+p_1
	lda	<L18+buf_0+2
	sta	<L19+p_1+2
	lda	<L18+fd_0
	xref	_~~swt
	jsr	_~~swt
	dw	2
	dw	0
	dw	L10005-1
	dw	2
	dw	L10006-1
	dw	L10007-1
L10005:
	lda	|_~ansi_yellow
	sta	<L19+ansi_1
	lda	|_~ansi_yellow+2
L20002:
	sta	<L19+ansi_1+2
L10004:
	pei	<L19+ansi_1+2
	pei	<L19+ansi_1
	jsr	_~print_str
	bra	L10011
L10006:
	lda	|_~ansi_red
	sta	<L19+ansi_1
	lda	|_~ansi_red+2
	bra	L20002
L10007:
	stz	<L19+ansi_1
	stz	<L19+ansi_1+2
	bra	L10004
L10010:
	lda	<L18+fd_0
	bmi	L20
	dea
	dea
	dea
	bpl	L10012
L20:
	sep	#$20
	longa	off
	lda	[<L19+p_1]
	cmp	#<$a
	rep	#$20
	longa	on
	bne	L10012
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$d
	sta	[<R0]
	rep	#$20
	longa	on
L10012:
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<L19+p_1]
	sta	[<R0]
	rep	#$20
	longa	on
	inc	<L19+p_1
	bne	L10008
	inc	<L19+p_1+2
L10008:
	dec	<L18+size_0
L10011:
	lda	#$0
	cmp	<L18+size_0
	bcc	L10010
	lda	<L19+ansi_1
	ora	<L19+ansi_1+2
	beq	L10013
	lda	|_~ansi_white+2
	pha
	lda	|_~ansi_white
	pha
	jsr	_~print_str
L10013:
	lda	<L18+size_0
	tay
	lda	<L18+1
	sta	<L18+1+8
	pld
	tsc
	clc
	adc	#L18+8
	tcs
	tya
	rts
L18	equ	12
L19	equ	5
	ends
	efunc
	code
	xdef	_~read
	func
_~read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
fd_0	set	3
buf_0	set	5
size_0	set	9
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	rep	#$20
	longa	on
	and	#$ff
	tay
	lda	<L26+1
	sta	<L26+1+8
	pld
	tsc
	clc
	adc	#L26+8
	tcs
	tya
	rts
L26	equ	4
L27	equ	5
	ends
	efunc
	code
	xdef	_~close
	func
_~close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
fd_0	set	3
	lda	#$1
	tay
	lda	<L29+1
	sta	<L29+1+2
	pld
	tsc
	clc
	adc	#L29+2
	tcs
	tya
	rts
L29	equ	0
L30	equ	1
	ends
	efunc
	code
	xdef	_~open
	func
_~open:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
_name_0	set	3
_mode_0	set	7
	pei	<L32+_mode_0
	pei	<L32+_name_0+2
	pei	<L32+_name_0
	pea	#^L12
	pea	#<L12
	pea	#12
	jsr	_~debug
	lda	#$1
	tay
	lda	<L32+1
	sta	<L32+1+6
	pld
	tsc
	clc
	adc	#L32+6
	tcs
	tya
	rts
L32	equ	0
L33	equ	1
	ends
	efunc
	data
L12:
	db	$6F,$70,$65,$6E,$20,$63,$61,$6C,$6C,$65,$64,$20,$6E,$61,$6D
	db	$65,$3A,$25,$73,$2C,$20,$6D,$6F,$64,$65,$3A,$25,$64,$0A,$00
	ends
	code
	xdef	_~isatty
	func
_~isatty:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L36
	tcs
	phd
	tcd
fd_0	set	3
	pei	<L36+fd_0
	pea	#^L35
	pea	#<L35
	pea	#8
	jsr	_~debug
	lda	#$1
	tay
	lda	<L36+1
	sta	<L36+1+2
	pld
	tsc
	clc
	adc	#L36+2
	tcs
	tya
	rts
L36	equ	0
L37	equ	1
	ends
	efunc
	data
L35:
	db	$69,$73,$61,$74,$74,$79,$20,$63,$61,$6C,$6C,$65,$64,$20,$66
	db	$64,$3A,$25,$64,$0A,$00
	ends
	code
	xdef	_~lseek
	func
_~lseek:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
fd_0	set	3
offset_0	set	5
whence_0	set	9
	pei	<L40+whence_0
	pei	<L40+offset_0+2
	pei	<L40+offset_0
	pei	<L40+fd_0
	pea	#^L39
	pea	#<L39
	pea	#14
	jsr	_~debug
	lda	#$0
	tax
	ina
	tay
	lda	<L40+1
	sta	<L40+1+8
	pld
	tsc
	clc
	adc	#L40+8
	tcs
	tya
	rts
L40	equ	0
L41	equ	1
	ends
	efunc
	data
L39:
	db	$6C,$73,$65,$65,$6B,$20,$63,$61,$6C,$6C,$65,$64,$20,$66,$64
	db	$3A,$25,$64,$2C,$20,$6F,$66,$66,$73,$65,$74,$3A,$25,$64,$2C
	db	$20,$77,$68,$65,$6E,$63,$65,$3A,$25,$64,$0A,$00
	ends
;
;void vApplicationStackOverflowHook( TaskHandle_t xTask,
;                                        char * pcTaskName ) {
	code
	xdef	_~vApplicationStackOverflowHook
	func
_~vApplicationStackOverflowHook:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
xTask_0	set	3
pcTaskName_0	set	7
;
;}
	lda	<L44+1
	sta	<L44+1+8
	pld
	tsc
	clc
	adc	#L44+8
	tcs
	rts
L44	equ	0
L45	equ	1
	ends
	efunc
;
;void printHeapStats() {
	code
	xdef	_~printHeapStats
	func
_~printHeapStats:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L47
	tcs
	phd
	tcd
;	HeapStats_t pxHeapStats;
;	
;	vPortGetHeapStats(&pxHeapStats);
pxHeapStats_1	set	0
	pea	#0
	clc
	tdc
	adc	#<L48+pxHeapStats_1
	pha
	jsr	_~vPortGetHeapStats
;	printf("\n");
	pea	#^L43
	pea	#<L43
	pea	#6
	jsr	_~printf
;	printf("xAvailableHeapSpaceInBytes:%p\n", (void *)pxHeapStats.xAvailableHeapSpaceInBytes);
	pei	<L48+pxHeapStats_1+2
	pei	<L48+pxHeapStats_1
	pea	#^L43+2
	pea	#<L43+2
	pea	#10
	jsr	_~printf
;	printf("xSizeOfLargestFreeBlockInBytes:%04X\n", pxHeapStats.xSizeOfLargestFreeBlockInBytes);
	pei	<L48+pxHeapStats_1+6
	pei	<L48+pxHeapStats_1+4
	pea	#^L43+33
	pea	#<L43+33
	pea	#10
	jsr	_~printf
;	printf("xSizeOfSmallestFreeBlockInBytes:%04X\n", pxHeapStats.xSizeOfSmallestFreeBlockInBytes);
	pei	<L48+pxHeapStats_1+10
	pei	<L48+pxHeapStats_1+8
	pea	#^L43+70
	pea	#<L43+70
	pea	#10
	jsr	_~printf
;	printf("xNumberOfFreeBlocks:%04X\n", pxHeapStats.xNumberOfFreeBlocks);
	pei	<L48+pxHeapStats_1+14
	pei	<L48+pxHeapStats_1+12
	pea	#^L43+108
	pea	#<L43+108
	pea	#10
	jsr	_~printf
;	printf("xMinimumEverFreeBytesRemaining:%p\n", (void *)pxHeapStats.xMinimumEverFreeBytesRemaining);
	pei	<L48+pxHeapStats_1+18
	pei	<L48+pxHeapStats_1+16
	pea	#^L43+134
	pea	#<L43+134
	pea	#10
	jsr	_~printf
;	printf("xNumberOfSuccessfulAllocations:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulAllocations);
	pei	<L48+pxHeapStats_1+22
	pei	<L48+pxHeapStats_1+20
	pea	#^L43+169
	pea	#<L43+169
	pea	#10
	jsr	_~printf
;	printf("xNumberOfSuccessfulFrees:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulFrees);
	pei	<L48+pxHeapStats_1+26
	pei	<L48+pxHeapStats_1+24
	pea	#^L43+204
	pea	#<L43+204
	pea	#10
	jsr	_~printf
;}
	pld
	tsc
	clc
	adc	#L47
	tcs
	rts
L47	equ	28
L48	equ	1
	ends
	efunc
	data
L43:
	db	$0A,$00,$78,$41,$76,$61,$69,$6C,$61,$62,$6C,$65,$48,$65,$61
	db	$70,$53,$70,$61,$63,$65,$49,$6E,$42,$79,$74,$65,$73,$3A,$25
	db	$70,$0A,$00,$78,$53,$69,$7A,$65,$4F,$66,$4C,$61,$72,$67,$65
	db	$73,$74,$46,$72,$65,$65,$42,$6C,$6F,$63,$6B,$49,$6E,$42,$79
	db	$74,$65,$73,$3A,$25,$30,$34,$58,$0A,$00,$78,$53,$69,$7A,$65
	db	$4F,$66,$53,$6D,$61,$6C,$6C,$65,$73,$74,$46,$72,$65,$65,$42
	db	$6C,$6F,$63,$6B,$49,$6E,$42,$79,$74,$65,$73,$3A,$25,$30,$34
	db	$58,$0A,$00,$78,$4E,$75,$6D,$62,$65,$72,$4F,$66,$46,$72,$65
	db	$65,$42,$6C,$6F,$63,$6B,$73,$3A,$25,$30,$34,$58,$0A,$00,$78
	db	$4D,$69,$6E,$69,$6D,$75,$6D,$45,$76,$65,$72,$46,$72,$65,$65
	db	$42,$79,$74,$65,$73,$52,$65,$6D,$61,$69,$6E,$69,$6E,$67,$3A
	db	$25,$70,$0A,$00,$78,$4E,$75,$6D,$62,$65,$72,$4F,$66,$53,$75
	db	$63,$63,$65,$73,$73,$66,$75,$6C,$41,$6C,$6C,$6F,$63,$61,$74
	db	$69,$6F,$6E,$73,$3A,$25,$70,$0A,$00,$78,$4E,$75,$6D,$62,$65
	db	$72,$4F,$66,$53,$75,$63,$63,$65,$73,$73,$66,$75,$6C,$46,$72
	db	$65,$65,$73,$3A,$25,$70,$0A,$00
	ends
;
;void shellTask( void *pvParameters )
;{
	code
	xdef	_~shellTask
	func
_~shellTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L51
	tcs
	phd
	tcd
pvParameters_0	set	3
;	char c = ' ';
;	char *p = (char *) pvParameters;
;	TaskStatus_t tStat;
;	char *dffa = (char *)0xdffa;
;	
;	
;	while(*p) {
c_1	set	0
p_1	set	1
tStat_1	set	5
dffa_1	set	31
	sep	#$20
	longa	off
	lda	#$20
	sta	<L52+c_1
	rep	#$20
	longa	on
	lda	<L51+pvParameters_0
	sta	<L52+p_1
	lda	<L51+pvParameters_0+2
	sta	<L52+p_1+2
	lda	#$dffa
	sta	<L52+dffa_1
	lda	#$0
	sta	<L52+dffa_1+2
	bra	L10014
L20004:
;		*debug_char = *p;
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<L52+p_1]
	sta	[<R0]
	rep	#$20
	longa	on
;		p++;
	inc	<L52+p_1
	bne	L10014
	inc	<L52+p_1+2
;	}
L10014:
	lda	[<L52+p_1]
	and	#$ff
	bne	L20004
;
;	for (c = 0; c < 6; c++) {
	sep	#$20
	longa	off
	stz	<L52+c_1
	rep	#$20
	longa	on
	bra	L10019
L10018:
;		*debug_hex = *(dffa+c);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	lda	<L52+c_1
	and	#$ff
	tay
	sep	#$20
	longa	off
	lda	[<L52+dffa_1],Y
	sta	[<R0]
;	}
	inc	<L52+c_1
	rep	#$20
	longa	on
L10019:
	sep	#$20
	longa	off
	lda	<L52+c_1
	cmp	#<$6
	rep	#$20
	longa	on
	bcc	L10018
;	
;	for(;;) {
;
;	}
L10020:
	bra	L10020
;
;	//vTaskGetInfo(NULL, &tStat, pdFALSE, eInvalid);
;	
;	//printf("task name: %s\n", tStat.pcTaskName);
;}
L51	equ	43
L52	equ	9
	ends
	efunc
;
;int main (int argc, char ** argv) {
	code
	xdef	_~main
	func
_~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L56
	tcs
	phd
	tcd
argc_0	set	3
argv_0	set	5
;	
;	BaseType_t rc;
;	HeapRegion_t reg;
;	HeapRegion_t *pxHeapReg;
;	TaskHandle_t * pxCreatedTask;
;	char *p;
;	int i;
;
;	//asm wdm 7;
;	
;	pxHeapReg = (HeapRegion_t *)pvPortMallocStack(sizeof(reg) * 100);
rc_1	set	0
reg_1	set	2
pxHeapReg_1	set	10
pxCreatedTask_1	set	14
p_1	set	18
i_1	set	22
	pea	#<$320
	jsr	_~pvPortMallocStack
	sta	<L57+pxHeapReg_1
	stx	<L57+pxHeapReg_1+2
;	printf("pxHeapReg:%p %u\n", pxHeapReg, sizeof(reg) * 100);
	pea	#<$320
	pei	<L57+pxHeapReg_1+2
	pei	<L57+pxHeapReg_1
	pea	#^L50
	pea	#<L50
	pea	#12
	jsr	_~printf
;	
;	//asm wdm 6;
;	
;	reg.xSizeInBytes = 0x010000;
	lda	#$0
	sta	<L57+reg_1+4
	ina
	sta	<L57+reg_1+6
;	
;	for(i = 0; i < 99; i++) {
	stz	<L57+i_1
L10025:
;		reg.pucStartAddress = (char *)((i+2) * 0x010000U);
	lda	#$2
	clc
	adc	<L57+i_1
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L58
	dey
L58:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$10
	xref	_~~lasl
	jsr	_~~lasl
	stx	<R0+2
	sta	<L57+reg_1
	lda	<R0+2
	sta	<L57+reg_1+2
;		pxHeapReg[i] = reg;
	clc
	tdc
	adc	#<L57+reg_1
	sta	<R0
	lda	#$0
	pha
	pei	<R0
	tay
	lda	<L57+i_1
	bpl	L59
	dey
L59:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L57+pxHeapReg_1
	clc
	adc	<R0
	sta	<R2
	lda	<L57+pxHeapReg_1+2
	adc	<R0+2
	pha
	pei	<R2
	lda	#$8
	xref	_~~fmov
	jsr	_~~fmov
;		
;	}
	inc	<L57+i_1
	sec
	lda	<L57+i_1
	sbc	#<$63
	bvs	L60
	eor	#$8000
L60:
	bpl	L10025
;	reg.pucStartAddress = NULL;
	stz	<L57+reg_1
	stz	<L57+reg_1+2
;	reg.xSizeInBytes = 0;
	stz	<L57+reg_1+4
	stz	<L57+reg_1+6
;	pxHeapReg[i] = reg;
	clc
	tdc
	adc	#<L57+reg_1
	sta	<R0
	lda	#$0
	pha
	pei	<R0
	tay
	lda	<L57+i_1
	bpl	L62
	dey
L62:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L57+pxHeapReg_1
	clc
	adc	<R0
	sta	<R2
	lda	<L57+pxHeapReg_1+2
	adc	<R0+2
	pha
	pei	<R2
	lda	#$8
	xref	_~~fmov
	jsr	_~~fmov
;
;	
;	printf("*** RTOS main \n");
	pea	#^L50+17
	pea	#<L50+17
	pea	#6
	jsr	_~printf
;	printf("*** RTOS vPortHeapResetState \n");
	pea	#^L50+33
	pea	#<L50+33
	pea	#6
	jsr	_~printf
;	vPortHeapResetState();
	jsr	_~vPortHeapResetState
;
;	printf("*** RTOS vPortDefineHeapRegions \n");
	pea	#^L50+64
	pea	#<L50+64
	pea	#6
	jsr	_~printf
;	vPortDefineHeapRegions( pxHeapReg );
	pei	<L57+pxHeapReg_1+2
	pei	<L57+pxHeapReg_1
	jsr	_~vPortDefineHeapRegions
;	
;	vPortFreeStack(pxHeapReg);
	pei	<L57+pxHeapReg_1+2
	pei	<L57+pxHeapReg_1
	jsr	_~vPortFreeStack
;	
;	printHeapStats();
	jsr	_~printHeapStats
;
;	
;	
;	rc = xTaskCreate( shellTask, "SHELL", 512, (void *)parm, 0, &pxCreatedTask);
	pea	#0
	clc
	tdc
	adc	#<L57+pxCreatedTask_1
	pha
	pea	#<$0
	lda	#<_~parm
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#<$200
	pea	#^L50+98
	pea	#<L50+98
	lda	#<_~shellTask
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	jsr	_~xTaskCreate
	sta	<L57+rc_1
;	
;	printf("task create rc: %d\n", rc);
	pha
	pea	#^L50+104
	pea	#<L50+104
	pea	#8
	jsr	_~printf
;	
;	
;	if (rc != pdPASS) {
	lda	<L57+rc_1
	cmp	#<$1
	beq	L10026
;		printf("shell could not be created rc: %d\n", rc);
	pei	<L57+rc_1
	pea	#^L50+124
	pea	#<L50+124
	pea	#8
	jsr	_~printf
;		return pdPASS;
	lda	#$1
L64:
	tay
	lda	<L56+1
	sta	<L56+1+6
	pld
	tsc
	clc
	adc	#L56+6
	tcs
	tya
	rts
;	}
;
;	/* Start the scheduler so the tasks start executing. */
;
;	vTaskStartScheduler();
L10026:
	jsr	_~vTaskStartScheduler
;
;	/* If all is well then main() will never reach here as the scheduler will
;	now be running the tasks. If main() does reach here then it is likely that
;	there was insufficient heap memory available for the idle task to be created.
;	Chapter 2 provides more information on heap memory management. */
;	printf("Error starting RTOS scheduler\n");
	pea	#^L50+159
	pea	#<L50+159
	pea	#6
	jsr	_~printf
;
;	return pdFAIL;
	lda	#$0
	bra	L64
;
;
;/*	
;
;	
;	
;	
;
;#asm
;;	WDM 0
;#endasm
;	
;	for (;;) {
;		p = pvPortMalloc(0x2000);
;		printf("%p\n", p);
;		if (p == NULL) break;
;	}
;
;	printHeapStats();
;
;
;#asm
;	WDM 8
;#endasm
;	for (;;) {}
;*/	
;}
L56	equ	36
L57	equ	13
	ends
	efunc
	data
L50:
	db	$70,$78,$48,$65,$61,$70,$52,$65,$67,$3A,$25,$70,$20,$25,$75
	db	$0A,$00,$2A,$2A,$2A,$20,$52,$54,$4F,$53,$20,$6D,$61,$69,$6E
	db	$20,$0A,$00,$2A,$2A,$2A,$20,$52,$54,$4F,$53,$20,$76,$50,$6F
	db	$72,$74,$48,$65,$61,$70,$52,$65,$73,$65,$74,$53,$74,$61,$74
	db	$65,$20,$0A,$00,$2A,$2A,$2A,$20,$52,$54,$4F,$53,$20,$76,$50
	db	$6F,$72,$74,$44,$65,$66,$69,$6E,$65,$48,$65,$61,$70,$52,$65
	db	$67,$69,$6F,$6E,$73,$20,$0A,$00,$53,$48,$45,$4C,$4C,$00,$74
	db	$61,$73,$6B,$20,$63,$72,$65,$61,$74,$65,$20,$72,$63,$3A,$20
	db	$25,$64,$0A,$00,$73,$68,$65,$6C,$6C,$20,$63,$6F,$75,$6C,$64
	db	$20,$6E,$6F,$74,$20,$62,$65,$20,$63,$72,$65,$61,$74,$65,$64
	db	$20,$72,$63,$3A,$20,$25,$64,$0A,$00,$45,$72,$72,$6F,$72,$20
	db	$73,$74,$61,$72,$74,$69,$6E,$67,$20,$52,$54,$4F,$53,$20,$73
	db	$63,$68,$65,$64,$75,$6C,$65,$72,$0A,$00
	ends
;
	xref	_~strlen
	xref	_~vTaskStartScheduler
	xref	_~xTaskCreate
	xref	_~vPortHeapResetState
	xref	_~vPortFreeStack
	xref	_~pvPortMallocStack
	xref	_~vPortGetHeapStats
	xref	_~vPortDefineHeapRegions
	xref	_~malloc
	xref	_~free
	xref	_~vsprintf
	xref	_~printf

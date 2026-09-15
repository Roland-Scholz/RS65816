;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include "FreeRTOS.h"
;#include "task.h"
;
;char *ucHeapStack = (char *)0xdfff;
	data
	xdef	_~ucHeapStack
_~ucHeapStack:
	dl	$DFFF
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
	sbc	#L2
	tcs
	phd
	tcd
xTask_0	set	3
pcTaskName_0	set	7
;
;}
	lda	<L2+1
	sta	<L2+1+8
	pld
	tsc
	clc
	adc	#L2+8
	tcs
	rts
L2	equ	0
L3	equ	1
	ends
	efunc
;

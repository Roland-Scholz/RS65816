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
;#include "ff.h"
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
;typedef struct taskParm {
;	char *taskName;
;	char dataBank;
;	void *taskAddr;
;	TickType_t tickDelay;
;} taskParm_t;
;
;typedef union {
;	void *ptr;
;	struct {
;		unsigned int addr;
;		char bank;
;		char dummy;
;	} parts;
;} ptrParts_t;
;
;FATFS FatFs;		/* FatFs work area needed for each volume */
;FIL Fil;			/* File object needed for each open file */
;
;#asm
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
;//#include "wdc_misc.h"
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
	sbc	#L6
	tcs
	phd
	tcd
xTask_0	set	3
pcTaskName_0	set	7
;
;}
	lda	<L6+1
	sta	<L6+1+8
	pld
	tsc
	clc
	adc	#L6+8
	tcs
	rts
L6	equ	0
L7	equ	1
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
	sbc	#L9
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
	adc	#<L10+pxHeapStats_1
	pha
	jsr	_~vPortGetHeapStats
;	printf("\n");
	pea	#^L5
	pea	#<L5
	pea	#6
	jsr	_~printf
;	printf("xAvailableHeapSpaceInBytes:%p\n", (void *)pxHeapStats.xAvailableHeapSpaceInBytes);
	pei	<L10+pxHeapStats_1+2
	pei	<L10+pxHeapStats_1
	pea	#^L5+2
	pea	#<L5+2
	pea	#10
	jsr	_~printf
;	printf("xSizeOfLargestFreeBlockInBytes:%04x\n", pxHeapStats.xSizeOfLargestFreeBlockInBytes);
	pei	<L10+pxHeapStats_1+6
	pei	<L10+pxHeapStats_1+4
	pea	#^L5+33
	pea	#<L5+33
	pea	#10
	jsr	_~printf
;	printf("xSizeOfSmallestFreeBlockInBytes:%04x\n", pxHeapStats.xSizeOfSmallestFreeBlockInBytes);
	pei	<L10+pxHeapStats_1+10
	pei	<L10+pxHeapStats_1+8
	pea	#^L5+70
	pea	#<L5+70
	pea	#10
	jsr	_~printf
;	printf("xNumberOfFreeBlocks:%04x\n", pxHeapStats.xNumberOfFreeBlocks);
	pei	<L10+pxHeapStats_1+14
	pei	<L10+pxHeapStats_1+12
	pea	#^L5+108
	pea	#<L5+108
	pea	#10
	jsr	_~printf
;	printf("xMinimumEverFreeBytesRemaining:%p\n", (void *)pxHeapStats.xMinimumEverFreeBytesRemaining);
	pei	<L10+pxHeapStats_1+18
	pei	<L10+pxHeapStats_1+16
	pea	#^L5+134
	pea	#<L5+134
	pea	#10
	jsr	_~printf
;	printf("xNumberOfSuccessfulAllocations:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulAllocations);
	pei	<L10+pxHeapStats_1+22
	pei	<L10+pxHeapStats_1+20
	pea	#^L5+169
	pea	#<L5+169
	pea	#10
	jsr	_~printf
;	printf("xNumberOfSuccessfulFrees:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulFrees);
	pei	<L10+pxHeapStats_1+26
	pei	<L10+pxHeapStats_1+24
	pea	#^L5+204
	pea	#<L5+204
	pea	#10
	jsr	_~printf
;}
	pld
	tsc
	clc
	adc	#L9
	tcs
	rts
L9	equ	28
L10	equ	1
	ends
	efunc
	data
L5:
	db	$0A,$00,$78,$41,$76,$61,$69,$6C,$61,$62,$6C,$65,$48,$65,$61
	db	$70,$53,$70,$61,$63,$65,$49,$6E,$42,$79,$74,$65,$73,$3A,$25
	db	$70,$0A,$00,$78,$53,$69,$7A,$65,$4F,$66,$4C,$61,$72,$67,$65
	db	$73,$74,$46,$72,$65,$65,$42,$6C,$6F,$63,$6B,$49,$6E,$42,$79
	db	$74,$65,$73,$3A,$25,$30,$34,$78,$0A,$00,$78,$53,$69,$7A,$65
	db	$4F,$66,$53,$6D,$61,$6C,$6C,$65,$73,$74,$46,$72,$65,$65,$42
	db	$6C,$6F,$63,$6B,$49,$6E,$42,$79,$74,$65,$73,$3A,$25,$30,$34
	db	$78,$0A,$00,$78,$4E,$75,$6D,$62,$65,$72,$4F,$66,$46,$72,$65
	db	$65,$42,$6C,$6F,$63,$6B,$73,$3A,$25,$30,$34,$78,$0A,$00,$78
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
	sbc	#L13
	tcs
	phd
	tcd
pvParameters_0	set	3
;	taskParm_t *taskParm = (taskParm_t *) pvParameters;
;	char dataBank;
;	unsigned int stackptr, direct;
;	UINT bw;
;	FRESULT fr;
;
;	#asm
taskParm_1	set	0
dataBank_1	set	4
stackptr_1	set	5
direct_1	set	7
bw_1	set	9
fr_1	set	11
	lda	<L13+pvParameters_0
	sta	<L14+taskParm_1
	lda	<L13+pvParameters_0+2
	sta	<L14+taskParm_1+2
;	sep #$20
;	phb
;	pla
;	sta %%dataBank
;	rep #$20
;	tsc
;	sta %%stackptr;
;	tdc
;	sta %%direct;
;	#endasm
	asmstart
	sep #$20
	phb
	pla
	sta <L14+dataBank_1
	rep #$20
	tsc
	sta <L14+stackptr_1;
	tdc
	sta <L14+direct_1;
	asmend
;	
;	printf("%s DB:%02X\n", taskParm->taskName, dataBank);
	lda	<L14+dataBank_1
	and	#$ff
	pha
	ldy	#$2
	lda	[<L14+taskParm_1],Y
	pha
	lda	[<L14+taskParm_1]
	pha
	pea	#^L12
	pea	#<L12
	pea	#12
	jsr	_~printf
;
;//	vTaskDelay(taskParm->tickDelay);
;
;
;
;	f_mount(&FatFs, "", 0);		/* Give a work area to the default drive */
	pea	#<$0
	pea	#^L12+12
	pea	#<L12+12
	lda	#<_~FatFs
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~f_mount
;
;	fr = f_open(&Fil, "newfile.txt", FA_WRITE | FA_CREATE_ALWAYS);	/* Create a file */
	pea	#<$a
	pea	#^L12+13
	pea	#<L12+13
	lda	#<_~Fil
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~f_open
	sta	<L14+fr_1
;	if (fr == FR_OK) {
	lda	<L14+fr_1
	bne	L10001
;		f_write(&Fil, "It works!\r\n", 11, &bw);	/* Write data to the file */
	pea	#0
	clc
	tdc
	adc	#<L14+bw_1
	pha
	pea	#<$b
	pea	#^L12+25
	pea	#<L12+25
	lda	#<_~Fil
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~f_write
;		fr = f_close(&Fil);							/* Close the file */
	lda	#<_~Fil
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~f_close
	sta	<L14+fr_1
;		if (fr == FR_OK && bw == 11) {		/* Lights green LED if data written well */
	lda	<L14+fr_1
	bne	L10001
	lda	<L14+bw_1
	cmp	#<$b
	bne	L10001
;			//DDRB |= 0x10; PORTB |= 0x10;	/* Set PB4 high */
;			printf("OK!\n");
	pea	#^L12+37
	pea	#<L12+37
	pea	#6
	jsr	_~printf
;		}
;	}
;
;	printf("task ended\n");
L10001:
	pea	#^L12+42
	pea	#<L12+42
	pea	#6
	jsr	_~printf
;	for(;;)
;		;
L10003:
	bra	L10003
;
;}
L13	equ	17
L14	equ	5
	ends
	efunc
	data
L12:
	db	$25,$73,$20,$44,$42,$3A,$25,$30,$32,$58,$0A,$00,$00,$6E,$65
	db	$77,$66,$69,$6C,$65,$2E,$74,$78,$74,$00,$49,$74,$20,$77,$6F
	db	$72,$6B,$73,$21,$0D,$0A,$00,$4F,$4B,$21,$0A,$00,$74,$61,$73
	db	$6B,$20,$65,$6E,$64,$65,$64,$0A,$00
	ends
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
	sbc	#L19
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
;	taskParm_t taskParm_1, taskParm_2, taskParm_3;
;	ptrParts_t pp;
;	
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
taskParm_1_1	set	18
taskParm_2_1	set	31
taskParm_3_1	set	44
pp_1	set	57
p_1	set	61
i_1	set	65
	pea	#<$320
	jsr	_~pvPortMallocStack
	sta	<L20+pxHeapReg_1
	stx	<L20+pxHeapReg_1+2
;	printf("pxHeapReg:%p %u\n", pxHeapReg, sizeof(reg) * 100);
	pea	#<$320
	pei	<L20+pxHeapReg_1+2
	pei	<L20+pxHeapReg_1
	pea	#^L18
	pea	#<L18
	pea	#12
	jsr	_~printf
;	
;	//asm wdm 6;
;	
;	reg.xSizeInBytes = 0x010000;
	lda	#$0
	sta	<L20+reg_1+4
	ina
	sta	<L20+reg_1+6
;	
;	for(i = 0; i < 99; i++) {
	stz	<L20+i_1
L10008:
;		reg.pucStartAddress = (char *)((i+2) * 0x010000U);
	lda	#$2
	clc
	adc	<L20+i_1
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L21
	dey
L21:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$10
	xref	_~~lasl
	jsr	_~~lasl
	stx	<R0+2
	sta	<L20+reg_1
	lda	<R0+2
	sta	<L20+reg_1+2
;		pxHeapReg[i] = reg;
	clc
	tdc
	adc	#<L20+reg_1
	sta	<R0
	lda	#$0
	pha
	pei	<R0
	tay
	lda	<L20+i_1
	bpl	L22
	dey
L22:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L20+pxHeapReg_1
	clc
	adc	<R0
	sta	<R2
	lda	<L20+pxHeapReg_1+2
	adc	<R0+2
	pha
	pei	<R2
	lda	#$8
	xref	_~~fmov
	jsr	_~~fmov
;		
;	}
	inc	<L20+i_1
	sec
	lda	<L20+i_1
	sbc	#<$63
	bvs	L23
	eor	#$8000
L23:
	bpl	L10008
;	reg.pucStartAddress = NULL;
	stz	<L20+reg_1
	stz	<L20+reg_1+2
;	reg.xSizeInBytes = 0;
	stz	<L20+reg_1+4
	stz	<L20+reg_1+6
;	pxHeapReg[i] = reg;
	clc
	tdc
	adc	#<L20+reg_1
	sta	<R0
	lda	#$0
	pha
	pei	<R0
	tay
	lda	<L20+i_1
	bpl	L25
	dey
L25:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L20+pxHeapReg_1
	clc
	adc	<R0
	sta	<R2
	lda	<L20+pxHeapReg_1+2
	adc	<R0+2
	pha
	pei	<R2
	lda	#$8
	xref	_~~fmov
	jsr	_~~fmov
;
;	
;	printf("*** RTOS main \n");
	pea	#^L18+17
	pea	#<L18+17
	pea	#6
	jsr	_~printf
;	printf("*** RTOS vPortHeapResetState \n");
	pea	#^L18+33
	pea	#<L18+33
	pea	#6
	jsr	_~printf
;	vPortHeapResetState();
	jsr	_~vPortHeapResetState
;
;	printf("*** RTOS vPortDefineHeapRegions \n");
	pea	#^L18+64
	pea	#<L18+64
	pea	#6
	jsr	_~printf
;	vPortDefineHeapRegions( pxHeapReg );
	pei	<L20+pxHeapReg_1+2
	pei	<L20+pxHeapReg_1
	jsr	_~vPortDefineHeapRegions
;	
;	vPortFreeStack(pxHeapReg);
	pei	<L20+pxHeapReg_1+2
	pei	<L20+pxHeapReg_1
	jsr	_~vPortFreeStack
;	
;	printHeapStats();
	jsr	_~printHeapStats
;	
;	pp.ptr = shellTask;
	lda	#<_~shellTask
	sta	<L20+pp_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L20+pp_1+2
;	taskParm_1.dataBank = pp.parts.bank;
	sep	#$20
	longa	off
	sta	<L20+taskParm_1_1+4
;	taskParm_2.dataBank = pp.parts.bank;
	lda	<L20+pp_1+2
	sta	<L20+taskParm_2_1+4
;	taskParm_3.dataBank = pp.parts.bank;
	lda	<L20+pp_1+2
	sta	<L20+taskParm_3_1+4
	rep	#$20
	longa	on
;	
;	taskParm_1.taskName = "task1";
	lda	#<L18+98
	sta	<L20+taskParm_1_1
	lda	#^L18+98
	sta	<L20+taskParm_1_1+2
;	taskParm_1.taskAddr = shellTask;
	lda	#<_~shellTask
	sta	<L20+taskParm_1_1+5
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L20+taskParm_1_1+7
;	taskParm_1.tickDelay = 10;
	lda	#$a
	sta	<L20+taskParm_1_1+9
	lda	#$0
	sta	<L20+taskParm_1_1+11
;	
;	taskParm_2.taskName = "2";
	lda	#<L18+104
	sta	<L20+taskParm_2_1
	lda	#^L18+104
	sta	<L20+taskParm_2_1+2
;	taskParm_2.taskAddr = shellTask;
	lda	#<_~shellTask
	sta	<L20+taskParm_2_1+5
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L20+taskParm_2_1+7
;	taskParm_2.tickDelay = 5;
	lda	#$5
	sta	<L20+taskParm_2_1+9
	lda	#$0
	sta	<L20+taskParm_2_1+11
;
;	taskParm_3.taskName = "3";
	lda	#<L18+106
	sta	<L20+taskParm_3_1
	lda	#^L18+106
	sta	<L20+taskParm_3_1+2
;	taskParm_3.taskAddr = shellTask;
	lda	#<_~shellTask
	sta	<L20+taskParm_3_1+5
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L20+taskParm_3_1+7
;	taskParm_3.tickDelay = 1;
	lda	#$1
	sta	<L20+taskParm_3_1+9
	dea
	sta	<L20+taskParm_3_1+11
;	
;	rc = xTaskCreate( taskParm_1.taskAddr, "Task1", 512, (void *) &taskParm_1, 0, NULL);	
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L20+taskParm_1_1
	pha
	pea	#<$200
	pea	#^L18+108
	pea	#<L18+108
	pei	<L20+taskParm_1_1+7
	pei	<L20+taskParm_1_1+5
	jsr	_~xTaskCreate
	sta	<L20+rc_1
;	printf("task create rc: %d\n", rc);
	pha
	pea	#^L18+114
	pea	#<L18+114
	pea	#8
	jsr	_~printf
;	/*
;	rc = xTaskCreate( taskParm_2.taskAddr, "Task2", 512, (void *) &taskParm_2, 0, NULL);	
;	printf("task create rc: %d\n", rc);
;	rc = xTaskCreate( taskParm_3.taskAddr, "Task3", 512, (void *) &taskParm_3, 0, NULL);	
;	printf("task create rc: %d\n", rc);
;	*/
;	
;	if (rc != pdPASS) {
	lda	<L20+rc_1
	cmp	#<$1
	beq	L10009
;		printf("shell could not be created rc: %d\n", rc);
	pei	<L20+rc_1
	pea	#^L18+134
	pea	#<L18+134
	pea	#8
	jsr	_~printf
;		return pdPASS;
	lda	#$1
L27:
	tay
	lda	<L19+1
	sta	<L19+1+6
	pld
	tsc
	clc
	adc	#L19+6
	tcs
	tya
	rts
;	}
;
;	/* Start the scheduler so the tasks start executing. */
;
;	vTaskStartScheduler();
L10009:
	jsr	_~vTaskStartScheduler
;
;	/* If all is well then main() will never reach here as the scheduler will
;	now be running the tasks. If main() does reach here then it is likely that
;	there was insufficient heap memory available for the idle task to be created.
;	Chapter 2 provides more information on heap memory management. */
;	printf("Error starting RTOS scheduler\n");
	pea	#^L18+169
	pea	#<L18+169
	pea	#6
	jsr	_~printf
;
;	return pdFAIL;
	lda	#$0
	bra	L27
;
;
;/*	
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
L19	equ	79
L20	equ	13
	ends
	efunc
	data
L18:
	db	$70,$78,$48,$65,$61,$70,$52,$65,$67,$3A,$25,$70,$20,$25,$75
	db	$0A,$00,$2A,$2A,$2A,$20,$52,$54,$4F,$53,$20,$6D,$61,$69,$6E
	db	$20,$0A,$00,$2A,$2A,$2A,$20,$52,$54,$4F,$53,$20,$76,$50,$6F
	db	$72,$74,$48,$65,$61,$70,$52,$65,$73,$65,$74,$53,$74,$61,$74
	db	$65,$20,$0A,$00,$2A,$2A,$2A,$20,$52,$54,$4F,$53,$20,$76,$50
	db	$6F,$72,$74,$44,$65,$66,$69,$6E,$65,$48,$65,$61,$70,$52,$65
	db	$67,$69,$6F,$6E,$73,$20,$0A,$00,$74,$61,$73,$6B,$31,$00,$32
	db	$00,$33,$00,$54,$61,$73,$6B,$31,$00,$74,$61,$73,$6B,$20,$63
	db	$72,$65,$61,$74,$65,$20,$72,$63,$3A,$20,$25,$64,$0A,$00,$73
	db	$68,$65,$6C,$6C,$20,$63,$6F,$75,$6C,$64,$20,$6E,$6F,$74,$20
	db	$62,$65,$20,$63,$72,$65,$61,$74,$65,$64,$20,$72,$63,$3A,$20
	db	$25,$64,$0A,$00,$45,$72,$72,$6F,$72,$20,$73,$74,$61,$72,$74
	db	$69,$6E,$67,$20,$52,$54,$4F,$53,$20,$73,$63,$68,$65,$64,$75
	db	$6C,$65,$72,$0A,$00
	ends
;
	xref	_~f_mount
	xref	_~f_write
	xref	_~f_close
	xref	_~f_open
	xref	_~vTaskStartScheduler
	xref	_~xTaskCreate
	xref	_~vPortHeapResetState
	xref	_~vPortFreeStack
	xref	_~pvPortMallocStack
	xref	_~vPortGetHeapStats
	xref	_~vPortDefineHeapRegions
	xref	_~printf
	udata
	xdef	_~Fil
_~Fil
	ds	556
	ends
	udata
	xdef	_~FatFs
_~FatFs
	ds	564
	ends

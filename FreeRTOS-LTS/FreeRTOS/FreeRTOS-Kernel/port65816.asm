;----------------------------------------------------------------------------------
;	void outbyte(int c);
;----------------------------------------------------------------------------------
;	module	outbyte
;	include homebrewWDC.inc
;	code
;	xdef	_~outbyte
;	func
;	
;_~outbyte:
;
;
;s_character	set 4
;	sep	#M
;	longa	off
;	
;	IF PLATFORM=0
;chrout1:
;	lda	#64
;	and	>LSR0
;	beq	chrout1
;	lda	s_character,s	
;	sta	>THR0
;	ENDIF
;	
;	IF PLATFORM=1
;	lda	#4
;outbyte1:
;	bit	SB+STATA
;	beq	outbyte1
;	
;	lda	s_character,s
;	sta	SB+TRANSA
;	ENDIF
;
;	plx	;pop return addr
;	pla	;pop bank
;
;	ply	;pop argument
;	
;	pha	;push bank
;	phx	;push return addr
;	rep	#M
;	
;	rts
;
;	ends
;	efunc
;	endmod


;----------------------------------------------------------------------------------
;       void vPortEndScheduler( void )
;----------------------------------------------------------------------------------
	module	vPortEndScheduler
	code
	xdef	_~vPortEndScheduler
	
	func

_~vPortEndScheduler:

	rts
	
	ends
	efunc
	endmod
	
	
;----------------------------------------------------------------------------------
;       portBASE_TYPE xPortStartScheduler( void )
;----------------------------------------------------------------------------------
	module	xPortStartScheduler
	code
	xdef	_~xPortStartScheduler
	xref	_~pxCurrentTCB
	xref	_~prvSetupTimerInterrupt
	func

_~xPortStartScheduler:

	jsr	_~prvSetupTimerInterrupt

	lda	_~pxCurrentTCB+2
	pha
	lda	_~pxCurrentTCB
	pha
	tsc
	tcd
	lda	[$1]

	tcs
	
	plb
	pld
	ply
	plx
	pla
	rti
	
	ends
	efunc
	endmod

;----------------------------------------------------------------------------------
; Stack-Layout:
;
;	13	Program-Bank
;	12	PC-hi
;	11	PC-lo
;	10	Flags
;	9	A-hi
;	8	A-lo
;	7	X-hi
;	6	X-lo
;	5	Y-hi
;	4	Y-lo
;	3	D-hi
;	2	D-lo
;	1	Data-Bank
;
;----------------------------------------------------------------------------------
;       static void prvSetupTimerInterrupt( void )
;----------------------------------------------------------------------------------
	module	prvSetupTimerInterrupt
	code
	xdef	_~prvSetupTimerInterrupt
	xref	_~vPortYieldFromTick
	func
	
_~prvSetupTimerInterrupt:
	;wdm 7

	lda #$0642			;wdm 6
	sta >$dffa
	
	sep #$20
	longa off
	lda #$5c
	sta >$dffc
	lda	#^_~vPortYieldFromTick
	sta	>$dfff			; populate bank of JML() instruction
	
	rep #$20
	longa on
	lda	#<_~vPortYieldFromTick	
	sta	>$dffd			; populate lo/hi of JML() instruction

	;wdm 6	
	rts
		
	ends
	efunc
	endmod
	
;
;	include "homebrewWDC.inc"
;	
;_~prvSetupTimerInterrupt:
;
;	lda	#JMLOP			; point IRQ-vec to JML instruction
;	sta	>IRQVEC
;	
;	lda	#_~vPortYieldFromTick	
;	sta	>JMLADR			; populate lo/hi of JML instruction
;	
;
;	IF PLATFORM=0
;	lda	>CONST5MS		;8.333333Mhz / 200Hz
;	sta	>TIMERLO
;	
;	sep	#M
;	longa	off
;
;	lda	#$5C			;JML opcode
;	sta	>JMLOP
;	lda	#^_~vPortYieldFromTick	; populate bank of JML instruction
;	sta	>JMLADR+2
;	
;	lda	#3
;	sta	>TIMERST
;	
;;	lda	#$ff
;;	sta	>ColBorder
;	
;	rep	#M
;	longa	on
;	ENDIF
;	
;	IF PLATFORM=1
;	sep	#M
;	longa	off
;	
;	lda	#<9216	;3686400 / 2 = 1843200; 1843200Hz / 200Hz (5ms) = 9216; 36864
;	sta	SB+CNTLSB
;	lda	#>9216
;	sta	SB+CNTMSB
;		
;	lda	#8
;	sta	SB+IMR
;		
;	rep	#M
;	longa	on
;	ENDIF
;	
;	rts
;		
;	ends
;	efunc
;	endmod


;----------------------------------------------------------------------------------
;       pxNewTCB->pxTopOfStack = _~pxPortInitialiseStack( pxTopOfStack, pxTaskCode, pvParameters );
;
; X-reg: pxNewTCB hi (always 0 as stack in in bank 00)
; A-reg: pxNewTCB lo
;----------------------------------------------------------------------------------
	module	pxPortInitialiseStack
	code
	xdef	_~pxPortInitialiseStack
	func

	;include	"homebrewWDC.inc"

_~pxPortInitialiseStack:
s_pvParameters	set 11		;12, 13, 14
s_pxTaskCode	set 7		;8 , 9, 10
s_pxTopOfStack	set 3		;4, 5, 6
return_adr_hi	set 2
return_adr_lo	set 1

M		 equ $20		; Accu 8/16-bit
IX		 equ $10		; Index 8/16-bit

	tsc
	phd
	tcd
	
	sec
	lda	<s_pxTopOfStack
	sbc	#19
	sta	<s_pxTopOfStack

	ldy	#11
	lda	<s_pxTaskCode
	sta	[s_pxTopOfStack],y
	
	dey
	lda	#0
	tax
	
	sep	#M
	longa	off
	
istack0:
	sta	[s_pxTopOfStack],y
	dey	
	bne	istack0

	ldy	#13
	lda	<s_pxTaskCode+2
	sta	[s_pxTopOfStack],y
		
	ldy	#1										; data bank = program bank
	sta	[s_pxTopOfStack],y
	
	rep	#M
	longa	on

	ldy	#16
	lda	<s_pvParameters
	sta	[s_pxTopOfStack],y
	ldy	#18
	lda	<s_pvParameters+2
	sta	[s_pxTopOfStack],y
	
	lda <s_pvParameters
	ora <s_pvParameters+2
	beq noParms
	
	sep #M
	longa off
	ldy #4
	lda [<s_pvParameters],y
	sta $fffff1
	ldy	#1										; store data bank
	sta	[s_pxTopOfStack],y
	rep #M
	longa on

noParms:	
	lda	<1
	sta	<13

	ldy	<s_pxTopOfStack
	
	pld
	
	clc
	tsc
	adc	#12
	tcs
	
	tya

	rts

;	plb		offset 	1
;	pld			2
;	ply			4
;	plx			6
;	pla			8
;	status			10
;	return addr lo/hi	11
;	return addr bank	13
;
;	pvParameters_lo		16
;	pvParameters_hi		17
;	pvParameters_bank	18
;	pvParameters_dummy	19
	
;txt:	.byte "IStack: %04X %04X %04X", 10, 0

	ends
	efunc
	endmod
	
	
;----------------------------------------------------------------------------------
;	void vPortYield( void )
;----------------------------------------------------------------------------------
	module	vPortYield
	code
	xdef	_~vPortYield
	xref	_~vTaskSwitchContext
	xref	_~pxCurrentTCB
	func
	
	;include	"homebrewWDC.inc"
M		 equ $20		; Accu 8/16-bit
IX		 equ $10		; Index 8/16-bit	

_~vPortYield:

	php
	sei
	cld

;	rep	#M+IX
;	longa	on
;	longi	on
	
	sta	saveAccu
	stx	saveX

	sep	#M
	longa	off
	
	pla			;pop status
	plx			;pop RTS-Addr
	inx			;add 1
	phx			;push return addr for RTI
	pha			;push status
	
	rep	#M
	longa	on

	lda	saveAccu
	pha
	ldx	saveX
	phx
	phy
	phd
	phb	
	
	lda	_~pxCurrentTCB+2		;store new stack value in pxCurrentTCB
	pha
	lda	_~pxCurrentTCB
	pha
	tsc
	tcd
	clc
	adc	#4	
	sta	[$1]
	
	jsr	_~vTaskSwitchContext

	lda	_~pxCurrentTCB+2
	pha
	lda	_~pxCurrentTCB
	pha	
	tsc
	tcd
	lda	[$1]
	tcs
	
	plb
	pld
	ply
	plx
	pla	
	rti
	
saveAccu:
	.word 0
saveX:
	.word 0
	
	ends
	efunc
	endmod
;----------------------------------------------------------------------------------
;	vPortYieldFromTick;
;----------------------------------------------------------------------------------
	module	vPortYieldFromTick
	code
	xdef	_~vPortYieldFromTick
	xref	_~xTaskIncrementTick
	xref	_~vTaskSwitchContext
	xref	_~pxCurrentTCB
	func

	;include "homebrewWDC.inc"
M		 equ $20		; Accu 8/16-bit
IX		 equ $10		; Index 8/16-bit

_~vPortYieldFromTick:

	longa	on
	longi	on
	rep	#M+IX
	
	pha
	phx
	phy
	phd
	phb
	
	;cld
		
;	phk			;data bank = program bank ($01)
;	plb
	
;	sep #M
;	longa off	
;	
;	lda #'i'
;	sta $fffff0
;	lda	_~pxCurrentTCB+2
;	sta $fffff1
;	lda	_~pxCurrentTCB+1
;	sta $fffff1
;	lda	_~pxCurrentTCB
;	sta $fffff1
;
;	rep #M
;	longa on
	
	lda	_~pxCurrentTCB+2
	pha
	lda	_~pxCurrentTCB
	pha
	tsc
	tcd
	clc
	adc	#4	
	sta	[$1]

	jsr	_~xTaskIncrementTick
	beq noswitch
;	pha
	jsr	_~vTaskSwitchContext
;	pla
	
noswitch:
;	sep #M
;	longa off
;	xba
;	sta $fffff1
;	xba
;	sta $fffff1
;	lda #':'
;	sta $fffff0		
;	lda	_~pxCurrentTCB+2
;	sta $fffff1
;	lda	_~pxCurrentTCB+1
;	sta $fffff1
;	lda	_~pxCurrentTCB
;	sta $fffff1
;
;	wdm 7
	
;	rep #M
;	longa on

	lda	_~pxCurrentTCB+2
	pha
	lda	_~pxCurrentTCB
	pha	
	tsc
	tcd
	lda	[$1]
	tcs

	
	plb
	pld
	ply
	plx
	pla
	
	wdm 6
	rti

	ends
	efunc
	endmod
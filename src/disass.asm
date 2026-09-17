;----------------------------------------------------------------------------------
;	void vPortYield( void )
;----------------------------------------------------------------------------------
		module	disass
		code
		xdef	_~disass
		func
;
;
;
		tsc
		phd
		tcd

memptr		equ 3
returnadr	equ 1
debug_char	equ $fffff0
debug_hex	equ $fffff1
;
;
;

_~disass:	
		tsc
		phd
		tcd

		sep #$30
		longa off
		longi off
		
		lda #'*'
		sta >debug_char

		jsr	jnewline
		lda	#20
		sta	disline
disass1:	jsr	DISSone
		dec	disline
		bne	disass1
		
		jsr	jgetupper
		cmp	#'X'
		bne	_~disass
	
		rep #$30
		
		lda <returnadr
		sta <memptr
		pld
		pla
		rts		
;
;		
;
DISSone:	JSR	printadr

		JSR 	fetchbyte
		STA	opcode
		JSR	PUTHEXC

		JSR	getOpMode
		
		ldy	#0		;print 1-3 hex-bytes depending
		ldx	oplen		;on number of bytes needed per opcode
		dex
DISSone1:	cpx	#0
		beq	DISSone2
		dex
		lda	(memptr),y
		jsr	PUTHEXC	
		jmp	DISSone3	
DISSone2:	jsr	printSpace3	;print 3 spaces instead of hex-value + space
DISSone3:	iny
		cpy	#2
		bne	DISSone1

		jsr	printSpace3
		
		JSR	printmem	;print mnemonic	

		LDA	#>(DISSend-1)	;push common return addressing
		PHA			;so each subroutine can return via RTS
		LDA	#<(DISSend-1)
		PHA
	
		LDA	opmode
		ASL
		TAX
		LDA	modetab+1,x
		PHA
		LDA	modetab,x
		PHA
		RTS

DISSend:	JMP	jnewline

getOpMode:	LDA	opcode
		LSR
		LSR
		LSR
		LSR
		STA	opnum
		TAX
		
		LDA	opcode
		AND	#$0F
		BNE	getOpMode1
	
		LDA	OPMODE00,x
		STA	opmode
		TAX
		LDY	#0
		BEQ	getOpModeImpl1

getOpMode1:	LDY	#16*3
		CMP	#8
		BEQ	getOpModeImpl
		LDY	#32*3
		CMP	#10
		BEQ	getOpModeImpl

		LDA	opcode

		LDY	#OPTEXTJMP-OPTEXT00
		LDX	#10
		CMP	#$6C		; JMP()
		BEQ	getOpLen1

		LDY	#OPTEXTLDX-OPTEXT00
		LDX	#2
		CMP	#$A2		; LDX #
		BEQ	getOpLen1

		LDY	#48*3
		LSR
		ROR	opnum
		LSR
		ROR	opnum
		AND	#7
		TAX

		STY	opoffset
		LDA	opcode
		ASL
		ROL
		ROL
		ROL
		ASL	opnum
		ROL
		ASL	opnum
		ROL
		AND	#$1F	
		TAY
		;JSR	PUTHEX
		CLC
		LDA	OPCODE1,y
		ADC	opoffset
		TAY
		
getOpLen1:	STY	opoffset

getOpLen2:	STX	opmode
		LDA	oplentab,x
		STA	oplen
		RTS

	
getOpModeImpl:	LDX	#8
getOpModeImpl1:	STY	opoffset
		LDA	opnum
		ASL
		ADC	opnum
		ADC	opoffset
		STA	opoffset
		JMP	getOpLen2		
		
modetab:	.WORD	printZpix-1
		.WORD	printDollHex-1
		.WORD	printImm-1
		.WORD	printAbs-1
		.WORD	printZpiy-1
		.WORD	printZpX-1
		.WORD	printAbsY-1
		.WORD	printAbsX-1
		.WORD	printImpl-1
		.WORD	printRel-1
		.WORD	printInd-1
;

printZpix:	JSR	printCDollHex
		JSR	printCX
		JMP	printCC

printDoll:
		LDA	#'$'
		JSR	jchrout
		JMP	fetchbyte

printCDollHex:
		JSR	printC
printDollHex:
		JSR	printDoll
		JMP	jprinthex

printImm:
		LDA	#'#'
		JSR	jchrout
		JMP	printDollHex

printAbs:
		JSR	printDoll
		PHA
		JSR	fetchbyte
		JSR	jprinthex
		PLA
		JMP	jprinthex
	
printZpiy:
		JSR	printCDollHex
		JSR	printCC
		JMP	printCY

printZpX:
		JSR	printDollHex
		LDA	#','
		JSR	jchrout
		LDA	opcode
		CMP	#$B6			; LDX,y
		BEQ	printY
		CMP	#$96			; STX,y
		BEQ	printY
		BNE	printX

printAbsY:
		JSR	printAbs
printCY:
		LDA	#','
		JSR	jchrout
printY:
		LDA	#'Y'
		JMP	jchrout

	
printAbsX:
		JSR	printAbs
printCX:
		LDA	#','
		JSR	jchrout
printX:
		LDA	#'X'
		JMP	jchrout


printImpl:
		RTS


printC:		LDA	#'('
		JMP	jchrout

printCC:	LDA	#')'
		JMP	jchrout


printRel:
		JSR	printDoll
		tay
		BMI	printRelNeg
	
		CLC
		ADC	memptr
		PHA
		LDA	memptr+1
		ADC	#0
printRel1:
		JSR	jprinthex	
		PLA
		JMP	jprinthex

printRelNeg:
		CLC
		ADC	memptr
		PHA
	
		LDA	memptr+1
		SBC	#0
		JMP	printRel1

printInd:
		JSR	printC
		JSR	printAbs
		JMP	printCC

;
;
;	
printadr:	LDA	memptr+1
		JSR	jprinthex
		LDA	memptr
		JSR	jprinthex
		LDA	#':'
		JSR	jchrout
		JMP	jspace
;
;
;
printmem:	
		LDY	#3
		LDX	opoffset
printmem1:
		LDA	OPTEXT00,x
		JSR	jchrout
		INX
		DEY
		BNE	printmem1

printSpace3:
		ldx	#3
printSpace3a:	jsr	jspace
		dex
		bne	printSpace3a
		rts

PUTHEXC:	JSR 	jprinthex
		JMP 	jspace
		
fetchbyte:	LDY	#0
		LDA	(memptr),y
;		PHA
incptr:
		INC	memptr
		BNE	incptr1
		INC	memptr+1
incptr1:;	PLA
		RTS
				
;bbb addressing mode 
;000 (zero page,X) 
;001 zero page 
;010 #immediate 
;011 absolute 
;100 (zero page),Y 
;101 zero page,X 
;110 absolute,Y 
;111 absolute,X 

OPCODE1:	.BYTE	0,1*3,2*3,0		; ORA, ASL
		.BYTE	3*3,4*3,5*3,0		; BIT, AND, ROL
		.BYTE	6*3,7*3,8*3,0		; JMP, EOR, LSR
		.BYTE	6*3,9*3,10*3,0		; JMP(), ADC, ROR
		.BYTE	11*3,12*3,13*3,0	; STY, STA, STX
		.BYTE	14*3,15*3,16*3,0	; LDY, LDA, LDX
		.BYTE	17*3,18*3,19*3,0	; CPY, CMP, DEC
		.BYTE	20*3,21*3,22*3,0	; CPX, SBC, INC



OPMODE00:	.BYTE	8
		.BYTE	9
		.BYTE	3
		.BYTE	9
		.BYTE	8
		.BYTE	9
		.BYTE	8
		.BYTE	9
		.BYTE	8
		.BYTE	9
		.BYTE	2
		.BYTE	9
		.BYTE	2
		.BYTE	9
		.BYTE	2
		.BYTE	9

oplentab:		
		.BYTE	2,2,2,3,2,2,3,3,1,2,3
;	0	(zp,x)
;	1	zp
;	2	#
;	3	abs
;	4	(zp),y
;	5	zp,x
;	6	abs,y
;	7	abs,x
;	8	impl
;	9	rel
;	10	(.)

OPTEXT00:	.BYTE	"BRK"
		.BYTE	"BPL"
		.BYTE	"JSR"
		.BYTE	"BMI"
		.BYTE	"RTI"
		.BYTE	"BVC"
		.BYTE	"RTS"
		.BYTE	"BVS"
		.BYTE	"???"
		.BYTE	"BCC"
		.BYTE	"LDY"
		.BYTE	"BCS"
		.BYTE	"CPY"
		.BYTE	"BNE"
		.BYTE	"CPX"
		.BYTE	"BEQ"

OPTEXT08:
		.BYTE	"PHP"
		.BYTE	"CLC"
		.BYTE	"PLP"
		.BYTE	"SEC"
		.BYTE	"PHA"
		.BYTE	"CLI"
		.BYTE	"PLA"
		.BYTE	"SEI"
		.BYTE	"DEY"
		.BYTE	"TYA"
		.BYTE	"TAY"
		.BYTE	"CLV"
		.BYTE	"INY"
		.BYTE	"CLD"
		.BYTE	"INX"
		.BYTE	"SED"

OPTEXT0A:
		.BYTE	"ASL"
		.BYTE	"???"
		.BYTE	"ROL"
		.BYTE	"???"
		.BYTE	"LSR"
		.BYTE	"???"
		.BYTE	"ROR"
		.BYTE	"???"
		.BYTE	"TXA"
		.BYTE	"TXS"
		.BYTE	"TAX"
		.BYTE	"TSX"
		.BYTE	"DEX"
		.BYTE	"???"
		.BYTE	"NOP"
		.BYTE	"???"
	
OPTEXT1:
		.BYTE	"???"
		.BYTE	"ORA"
		.BYTE	"ASL"
		.BYTE	"BIT"
		.BYTE	"AND"
		.BYTE	"ROL"
OPTEXTJMP:
		.BYTE	"JMP"
		.BYTE	"EOR"
		.BYTE	"LSR"
		.BYTE	"ADC"
		.BYTE	"ROR"
		.BYTE	"STY"
		.BYTE	"STA"
		.BYTE	"STX"
		.BYTE	"LDY"
		.BYTE	"LDA"
OPTEXTLDX:
		.BYTE	"LDX"
		.BYTE	"CPY"
		.BYTE	"CMP"
		.BYTE	"DEC"
		.BYTE	"CPX"
		.BYTE	"SBC"
		.BYTE	"INC"
	
opcode	.byte 0
opoffset	.byte 0
oplen	.byte 0
opmode	.byte 0
opnum	.byte 0
disline	.byte 0

jnewline:
		pha
		lda #13
		sta >debug_char
		lda #10
jnewline1
		sta >debug_char
		pla
		rts

jspace	pha
		lda #32
		bne jnewline1
		
jchrout	sta >debug_char
		rts

jprinthex
		sta >debug_hex
		rts

jgetupper
		lda >debug_char
		cmp #'a'
		bcc jupperex
		cmp #'z'+1
		bcs jupperex
		sbc #31
jupperex
		rts
		
	ends
	efunc
	endmod

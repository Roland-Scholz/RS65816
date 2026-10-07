		INCLUDE ..\src\equations.asm

		XDEF 	kernel
		XDEF	space
		XDEF	chrout
		XDEF	printhex
		XDEF	chrin
		XDEF	newline
			
		XREF	disass8
		XREF	disass16

		CODE
		
;----------------------------------------------------------------------------
; Start of Kernel
;----------------------------------------------------------------------------
kernel		sei
		rep	#CARRY+DECIMAL_FLAG		
		xce					;switch to native mode

		A16
		lda	#$cfff				;stack to $1ff
		tcs	
		lda	#0
		tcd					;direct to 0
		
		A8					;acc 	8-bit
		I16					;index 16-bit
		pha
		plb					;databank = 0


		ldx	#$02ff
kernel1		stz	$0,x
		dex
		bpl	kernel1
		
		lda	#$54				;MVN
		sta	MOVENEG		
		lda	#$60		
		sta	MOVERTS				;RTS

menu
menustart:	
		ldx	#MSGSTART
		jsr	print
		
menuadr:	jsr	newline
		lda	#'F'
		jsr	chrout
		php
		pla
		jsr	printhex
		jsr	space
		lda	#'B'
		jsr	chrout
		phb
		pla
		jsr	printhex
		jsr	space
		lda	#'K'
		jsr	chrout
		phk
		pla
		jsr	printhex
		jsr	space
		lda	#'D'
		jsr	chrout
		tdc
		xba
		jsr	printhex
		xba
		jsr	printhex
		jsr	space
		lda	#'S'
		jsr	chrout
		tsc
		xba
		jsr	printhex
		xba
		jsr	printhex
		jsr	space

		lda	<memptr+2
		jsr	printhex
		lda	#':'
		jsr	chrout
		lda	<memptr+1
		jsr	printhex
		lda	<memptr
		jsr	printhex
		lda	#'>'
		jsr	chrout
		jsr	space
	
menuloop:	jsr	getupper
		ldx	#menuvec-menukey-1
			
menuloop1:	cmp	menukey,x
		beq	menufound
		dex	
		bpl	menuloop1
		jmp	menuadr
menufound:	lda	#0
		xba
		txa	
		asl	
		tax	
		jsr	(menuvec,x)
		jmp	menuadr

;----------------------------------------------------------------------------
; Menu routines
;----------------------------------------------------------------------------
setdatabank:	lda	<memptr+2
		jsr	printhex
		lda	#':'
		jsr	chrout
		jsr	space
		jsr	inputhex
		sta	<memptr+2
		rts
;
;
;
changemem:	lda	[memptr]
		jsr	printhex
		lda	#':'
		jsr	chrout
		jsr	space
		jsr	inputhex
		sta	[memptr]
		rts
;
;
;
hexdownload:	ldx	#MSGDOWNL
		jsr	print
		
		I8
download:	jsr	chrin		; wait for leading ":"
		cmp	#':'
		bne	download
	
		lda	#0
		sta	<chksum

		jsr	gethex		; number of bytes in line
		tax	
		jsr	getadr		; addess in ptr
		jsr	gethex		; record-type 0=data record
		bne	download1
			
		tay			; Acc zero
download2:	jsr	gethex		; read byte
		sta	(ptr),y		; store at address
		iny	
		dex			; decement length
		bne	download2	; line not completely read
	
		jsr	gethex		; line finished
		lda	<chksum		; read checksum
		beq	download	; checksum OK, next line
		jsr	debug		; print debug
		jmp	download	; read next line
	
download1:	jsr	gethex
		jmp	kernel
	
debug:		wdm	7
		jmp	debug
		
;		lda	<ptr+1
;		jsr	printhex
;		lda	<ptr
;		jsr	printhex
;		jsr	space
;		lda	<chksum
;		jsr	printhex
;		jmp	newline

		longi	on
		
MSGDOWNL:	.byte	"downloading...",EOL,0
;
;
;
copymem:	ldx	#msgcopy1
		jsr	print
	
		jsr	enteradr
		cmp	#'x'
		beq	copyend
		
		ldx	#msgfill2
		jsr	print
	
		jsr	inputhex
		sta	ptr+1
		jsr	inputhex
		sta	ptr
		
		ldx	#msgcopy2
		jsr	print

		jsr	inputhex
		sta	TEMP+1
		jsr	inputhex
		sta	TEMP
		
		lda	memptr+2
		sta	MOVEBNK
		sta	MOVEBNK+1
		
		A16
		sec
		lda	ptr
		sbc	memptr
		bcc	copymem2
			
		ldx	memptr
		ldy	TEMP	
		phb	
		jsr	MOVENEG
		plb	
			
copymem2:	A8		
copyend:	rts
;
; Routine to fill memory with prior user interaction
; fills from: memptr to: ptr
; 
fillmem:	
		ldx	#msgfill1
		jsr	print
	
		jsr	enteradr
		cmp	#'x'
		beq	fillend
	
		ldx	#msgfill2
		jsr	print
	
		jsr	inputhex
		sta	<ptr+1
		jsr	inputhex
		sta	<ptr
	
		ldx	#msgfill3
		jsr	print
	
		jsr	inputhex
		sta	[memptr]
		lda	<memptr+2
		sta	MOVEBNK
		sta	MOVEBNK+1
		
		A16
		sec
		lda	<ptr
		sbc	<memptr
		bcc	fillend		
		beq	fillend
		dea

		ldx	memptr
		txy
		iny
		phb
		jsr	MOVENEG
		plb
fillend:	A8
		rts
		
msgfill1:	.byte	"fill from: ", 0
msgfill2:	.byte	" to ", 0
msgfill3:	.byte	" with: ",0

msgcopy1:	.byte	"copy from: ", 0
msgcopy2:	.byte	" dest: ", 0
;
;
;
gotoadr:	lda 	#$22		;JSL opcode
		sta	JSLOP
		lda	#$60
		sta	JSLRTS
		
		lda	<memptr
		sta	JSLADR
		lda	<memptr+1
		sta	JSLADR+1
		lda	<memptr+2
		sta	JSLADR+2

		;wdm	6
		jmp	JSLOP	
;
;
;		
memdump:
		jsr	newline
		ldx	#16
memdump3:	jsr	memdump16
		dex	
		bne	memdump3
		rts	
			
memdump16:	lda	<memptr+2
		jsr	printhex
		lda	#':'
		jsr	chrout
			
		lda	<memptr+1
		jsr	printhex
		lda	<memptr
		jsr	printhex
			
		jsr	space
	
		ldy	#0
memdump1:	cpy 	#8
		bne	memdump7
		jsr 	space
		jsr	space
memdump7:	lda	[memptr],y
		jsr	printhex
		jsr	space
		iny	
		cpy	#16
		bne	memdump1
			
		jsr	space
		lda	#'|'
		jsr	chrout
	
		ldy	#0
memdump5:	lda	[memptr],y
		bmi	memdump4
;		cmp	#TABU		; if >= TABU
;		bcs	memdump4	; print space
		cmp	#32		; if < space, print space
		bcs	memdump2
memdump4:	lda	#' '
memdump2:	jsr	chrout
		iny	
		cpy	#16
		bne	memdump5
	
		lda	#'|'
		jsr	chrout
	
		clc
		tya	
		adc	<memptr
		sta	<memptr
		bcc	memdump8
		inc	<memptr+1
		bne	memdump8
		inc	<memptr+2
memdump8:	jmp	newline
;
;
;
setaddress:
		ldx	#MSGADDR
		jsr	print
		jmp	enteradr

MSGADDR:	.byte	"address: ",0
;
;
;
prthelp:	pla	
		pla	
		jmp	menu
;
;
;		
enteradr:	ldx	#0
		stx	<memptr
		lda	#4
		sta	ADRCNT
		
enteradrC:	jsr	chrin
		cmp	#EOL
		beq	enteradrEnd
	
		cmp	#'x'
		beq	enteradrEnd
	
enteradrD:	jsr	chrout
		cmp	#':'
		bcs	enteradrE
		cmp	#'0'
		bcc	enteradrC
	
		and	#%00001111
		bcs	enteradrF
	
enteradrE:	cmp	#'g'
		bcs	enteradrC
		cmp	#'a'
		bcc	enteradrC
	
		sbc	#'7'
enteradrF:	asl
		asl
		asl
		asl
		ldx	#4
enteradrG:	asl
		rol	<memptr
		rol	<memptr+1
		dex
		bne	enteradrG

		dec	ADRCNT
		bne	enteradrC
enteradrEnd:	rts
;----------------------------------------------------------------------------
; Print routines
;----------------------------------------------------------------------------
newline:	pha	
		lda	#EOL
		bne	space1
	
space:		pha	
		lda	#32
	
space1:		jsr	chrout
		pla	
		rts	

printhex:	pha	
		pha	
		lsr	
		lsr	
		lsr	
		lsr	
		jsr	printnibble
		pla	
		and	#15
		jsr	printnibble
		pla	
		rts	
	
printnibble:	clc	
		adc	#48
		cmp	#58
		bcc	printnibble1
		adc	#6
printnibble1:	jmp	chrout
	

print:		pha	
		phx
		
print2:		lda	$0,x
		beq	print1
		jsr	chrout
		inx
		bra	print2
		
print1:		plx
		pla
		rts
		

;----------------------------------------------------------------------------
; Input routines
;----------------------------------------------------------------------------
inputhex:	jsr	inputnibble
		asl	
		asl	
		asl	
		asl	
		sta	<gethex_A
		jsr	inputnibble
		;clc	
		ora	<gethex_A
		sta	<gethex_A
		rts	
	
inputnibble:	jsr	getupper
		jsr	chrout
		sec	
		sbc	#48
		cmp	#10
		bcc	inputnibble1
		sbc	#7
inputnibble1:	rts
;
;
;		
getupper:	jsr	chrin
		cmp	#97
		bcc	getupperex	
		cmp	#123
		bcs	getupperex
		sbc	#31
getupperex	rts	
;
;
;	
getadr:		jsr	gethex
		sta	<ptr+1		
		jsr	gethex
		sta	<ptr
		rts	
;
;
;	
gethex:		jsr	getnibble
		asl	
		asl	
		asl	
		asl	
		sta	<gethex_A
		jsr	getnibble
		ora	<gethex_A
		sta	<gethex_A
	
		clc	
		adc	<chksum
		sta	<chksum
		lda	<gethex_A
		rts	
	
getnibble:	jsr	getupper
		sec	
		sbc	#48
		cmp	#10
		bcc	getnibble1
		sbc	#7
getnibble1:	rts	

;----------------------------------------------------------------------------
; reads a byte from chrin in ACC and serbyte
;----------------------------------------------------------------------------
chrin		lda	>IO0+STATA
		and	#1
		beq	chrin
		lda	>IO0+RECA
		sta	<serbyte
		rts

;----------------------------------------------------------------------------
; writes acc to chrout
;----------------------------------------------------------------------------	
chrout		pha
		lda	>IO0+STATA
		and	#4
		beq	chrout
		pla
		sta	>IO0+TRANSA
		rts
		
;----------------------------------------------------------------------------
; wait 19200 baud
;----------------------------------------------------------------------------	
;rs232baud2	ldy	#29		
;		bne	rs232baud1
;rs232baud	ldy	#58				; 2	2 + 58*5 -1 + 6 = 297
;rs232baud1	dey					; 2
;		bne	rs232baud1			; 3
;		rts					; 6
		
;----------------------------------------------------------------------------
; Kernel messages
;----------------------------------------------------------------------------	
menukey:	.byte	"?BCDFGKLMNST"

menuvec:	.word	prthelp
		.word	setdatabank
		.word	changemem
		.word	hexdownload
		.word	fillmem
		.word	gotoadr
		.word	disass16	;disass16
		.word	disass8		;disass8
		.word	memdump
		.word	setaddress
		.word	prthelp		;setbreak
		.word	copymem		;copymem

MSGSTART:	.byte	EOL, EOL
		.byte	"*** 65816 - 6Mhz Homebrew by R. Scholz", EOL, EOL
		.byte	"? - This help list", EOL
		.byte	"B - Set data bank", EOL
		.byte	"C - Change byte", EOL
		.byte	"D - Download Intel-Hex file", EOL
		.byte	"F - Fill memory", EOL
		.byte	"G - Goto address", EOL
		.byte	"K - Disassemble 16", EOL
		.byte	"L - Disassemble 8", EOL
		.byte	"M - Memory dump", EOL
		.byte	"N - New address", EOL
		.byte 	"S - Set breakpoint", EOL
		.byte	"T - Transfer memory", EOL
		.byte	0

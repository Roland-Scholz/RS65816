;----------------------------------------------------------------------------
; Equations
;----------------------------------------------------------------------------
NEGATIVE	equ	$80
OVERFLOW	equ	$40		; 
ACC		equ	$20		; Accu 8/16-bit
M		equ	$20
IX		equ	$10		; Index 8/16-bit
DECIMAL_FLAG	equ	$08		; Decimal Flag
INTDIS		equ	$04		; IRQ disable
ZERO		equ	$02		; zero flag
CARRY		equ	$01		; Carry

;ioout		equ	$D800
;ioin		equ	$D900

EOL		equ	$0d


;----------------------------------------------------------------------------
; Direct-page definitions
;----------------------------------------------------------------------------
		PAGE0
serbyte		equ	$00				;1-byte serin accumulator
ptr		equ	$01				;2-byte general pointer
memptr		equ	$03				;3-byte memory pointer
gethex_A	equ	$06
chksum		equ	$07
PREG		equ	$08
PCREG		equ	memptr				;PROGRAM COUNTER
PCREGH		equ	memptr+1
PCREGB		equ	memptr+2
OPCREG		equ	$0c				;OLD PROGRAM COUNTER VALUE
OPCREGH		equ	$0d
OPCREGB		equ	$0e
CODE		equ	$0f				;CURRENT CODE TO BE TRACED
OPRNDL		equ	$10				;OPERANDS OF CURRENT
OPRNDH		equ	$11				;INSTRUCTION
OPRNDB		equ	$12
TEMP		equ	$13				;TEMPORARY
TEMPH		equ	$14
TEMPB		equ	$15
ADDRMODE	equ	$16				;ADDRESS MODE OF CURRENT OPCODE
MNX		equ	$17				;MNEMONIC INDEX		
OPLEN		equ	$19
NCODE		equ	$20
				
MOVENEG		equ	$0200				;4-byte MVP + operands + RTS
MOVEBNK		equ	$0201
MOVERTS		equ	$0203				;RTS
ADRCNT		equ	$0204
JSLOP		equ	$0205				;1-byte JSL-opcode
JSLADR		equ	$0206				;3-byte JSL address
JSLRTS		equ	$0209				;1-byte RTS-opcode

;--------------------------------------------------------------
; Homebrew MC68681 double serial card
;--------------------------------------------------------------
IO0		 equ $FFE000

MODEA		 equ 0
STATA		 equ 1
CLOCKA		 equ 1
COMMA		 equ 2
RECA		 equ 3
TRANSA		 equ 3
IPCHANGE	 equ 4
AUXCTRL		 equ 4
ISR		 equ 5
IMR		 equ 5
CNTMSB		 equ 6
CNTLSB		 equ 7
MODEB		 equ 8
STATB		 equ 9
CLOCKB		 equ 9
COMMB		 equ 10
RECB		 equ 11
TRANSB		 equ 11
IVR		 equ 12
INPORT		 equ 13
OPCTRL		 equ 13
STRTCNT		 equ 14
OPSET		 equ 14
STOPCNT		 equ 15
OPRES		 equ 15

;----------------------------------------------------------------------------
; Macro definitions
;----------------------------------------------------------------------------
A8I8		MACRO
		sep	#ACC+IX
		longa	off
		longi	off
		ENDM
		
A8		MACRO
		sep	#ACC
		longa	off
		ENDM

I8		MACRO
		sep	#IX
		longi	off
		ENDM

A16I16		MACRO
		rep	#ACC+IX
		longa	on
		longi	on
		ENDM
		
A16		MACRO
		rep	#ACC
		longa	on
		ENDM

I16		MACRO
		rep	#IX
		longi	on
		ENDM

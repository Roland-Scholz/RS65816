;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <ctype.h>
;#include "monitor.h"
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
;const char * stars = "**************************************";
	data
	xdef	_~stars
_~stars:
	dl	L5+0
	ends
	data
L5:
	db	$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
	db	$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
	db	$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
	ends
;
;static char *ptr = NULL;
	data
_~ptr:
	dl	$0
	ends
;
;void print_welcome() {
	code
	xdef	_~print_welcome
	func
_~print_welcome:
	longa	on
	longi	on
;	printf("\n");
	pea	#^L6
	pea	#<L6
	pea	#6
	jsr	_~printf
;    printf("%s\n", stars);
	lda	|_~stars+2
	pha
	lda	|_~stars
	pha
	pea	#^L6+2
	pea	#<L6+2
	pea	#10
	jsr	_~printf
;	printf("* 65816 Monitor (c) by R. Scholz     *\n");
	pea	#^L6+6
	pea	#<L6+6
	pea	#6
	jsr	_~printf
;    printf("%s\n\n", stars);
	lda	|_~stars+2
	pha
	lda	|_~stars
	pha
	pea	#^L6+46
	pea	#<L6+46
	pea	#10
	jsr	_~printf
;	
;	printf("a - set address\n");
	pea	#^L6+51
	pea	#<L6+51
	pea	#6
	jsr	_~printf
;	printf("b - set bank\n");
	pea	#^L6+68
	pea	#<L6+68
	pea	#6
	jsr	_~printf
;	printf("c - change memory\n");
	pea	#^L6+82
	pea	#<L6+82
	pea	#6
	jsr	_~printf
;	printf("d - dump  memory\n");
	pea	#^L6+101
	pea	#<L6+101
	pea	#6
	jsr	_~printf
;	printf("l - disassemble memory a8\n");
	pea	#^L6+119
	pea	#<L6+119
	pea	#6
	jsr	_~printf
;	printf("m - disassemble memory a16\n");
	pea	#^L6+146
	pea	#<L6+146
	pea	#6
	jsr	_~printf
;	printf("r - RTOS 0x01:0000\n");
	pea	#^L6+174
	pea	#<L6+174
	pea	#6
	jsr	_~printf
;	printf("x - exit emulator\n");
	pea	#^L6+194
	pea	#<L6+194
	pea	#6
	jsr	_~printf
;	printf("z - reset\n");	
	pea	#^L6+213
	pea	#<L6+213
	pea	#6
	jsr	_~printf
;	printf("? - this message\n");
	pea	#^L6+224
	pea	#<L6+224
	pea	#6
	jsr	_~printf
;}
	rts
L7	equ	0
L8	equ	1
	ends
	efunc
	data
L6:
	db	$0A,$00,$25,$73,$0A,$00,$2A,$20,$36,$35,$38,$31,$36,$20,$4D
	db	$6F,$6E,$69,$74,$6F,$72,$20,$28,$63,$29,$20,$62,$79,$20,$52
	db	$2E,$20,$53,$63,$68,$6F,$6C,$7A,$20,$20,$20,$20,$20,$2A,$0A
	db	$00,$25,$73,$0A,$0A,$00,$61,$20,$2D,$20,$73,$65,$74,$20,$61
	db	$64,$64,$72,$65,$73,$73,$0A,$00,$62,$20,$2D,$20,$73,$65,$74
	db	$20,$62,$61,$6E,$6B,$0A,$00,$63,$20,$2D,$20,$63,$68,$61,$6E
	db	$67,$65,$20,$6D,$65,$6D,$6F,$72,$79,$0A,$00,$64,$20,$2D,$20
	db	$64,$75,$6D,$70,$20,$20,$6D,$65,$6D,$6F,$72,$79,$0A,$00,$6C
	db	$20,$2D,$20,$64,$69,$73,$61,$73,$73,$65,$6D,$62,$6C,$65,$20
	db	$6D,$65,$6D,$6F,$72,$79,$20,$61,$38,$0A,$00,$6D,$20,$2D,$20
	db	$64,$69,$73,$61,$73,$73,$65,$6D,$62,$6C,$65,$20,$6D,$65,$6D
	db	$6F,$72,$79,$20,$61,$31,$36,$0A,$00,$72,$20,$2D,$20,$52,$54
	db	$4F,$53,$20,$30,$78,$30,$31,$3A,$30,$30,$30,$30,$0A,$00,$78
	db	$20,$2D,$20,$65,$78,$69,$74,$20,$65,$6D,$75,$6C,$61,$74,$6F
	db	$72,$0A,$00,$7A,$20,$2D,$20,$72,$65,$73,$65,$74,$0A,$00,$3F
	db	$20,$2D,$20,$74,$68,$69,$73,$20,$6D,$65,$73,$73,$61,$67,$65
	db	$0A,$00
	ends
;
;char charin() {
	code
	xdef	_~charin
	func
_~charin:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
;	return *debug_char;
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
	pld
	tsc
	clc
	adc	#L11
	tcs
	tya
	rts
;}
L11	equ	4
L12	equ	5
	ends
	efunc
;
;char getnibble() {
	code
	xdef	_~getnibble
	func
_~getnibble:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L14
	tcs
	phd
	tcd
;	char c, b;
;	
;	for(;;) {
c_1	set	0
b_1	set	1
L10003:
;		c = charin();
	jsr	_~charin
	sep	#$20
	longa	off
	sta	<L15+c_1
;		if (c >= '0' && c <= '9') {
	cmp	#<$30
	rep	#$20
	longa	on
	bcc	L10004
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L15+c_1
	rep	#$20
	longa	on
	bcc	L10004
;			b = c - '0';
	lda	<L15+c_1
	and	#$ff
	clc
	adc	#$ffd0
	sep	#$20
	longa	off
	sta	<L15+b_1
	rep	#$20
	longa	on
;			break;
L10002:
;	
;	printf("%c", c);
	lda	<L15+c_1
	and	#$ff
	pha
	pea	#^L10
	pea	#<L10
	pea	#8
	jsr	_~printf
;	fflush(stdout);
	lda	#<_~_iob+20
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~fflush
;	
;	return b;
	lda	<L15+b_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L14
	tcs
	tya
	rts
;		}
;		if (c >= 'a' && c <= 'f') {
L10004:
	sep	#$20
	longa	off
	lda	<L15+c_1
	cmp	#<$61
	rep	#$20
	longa	on
	bcc	L10003
	sep	#$20
	longa	off
	lda	#$66
	cmp	<L15+c_1
	rep	#$20
	longa	on
	bcc	L10003
;			b = c - 'a' + 10;
	lda	<L15+c_1
	and	#$ff
	clc
	adc	#$ffa9
	sep	#$20
	longa	off
	sta	<L15+b_1
	rep	#$20
	longa	on
;			break;
	bra	L10002
;		}
;	}
;
;}
L14	equ	10
L15	equ	9
	ends
	efunc
	data
L10:
	db	$25,$63,$00
	ends
;
;char getbyte() {
	code
	xdef	_~getbyte
	func
_~getbyte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
	tcs
	phd
	tcd
;	char c;
;
;	c = getnibble() << 4;
c_1	set	0
	jsr	_~getnibble
	sep	#$20
	longa	off
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<L23+c_1
	rep	#$20
	longa	on
;	c += getnibble();
	jsr	_~getnibble
	sep	#$20
	longa	off
	clc
	adc	<L23+c_1
	sta	<L23+c_1
	rep	#$20
	longa	on
;	
;	return c;
	lda	<L23+c_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L22
	tcs
	tya
	rts
;}
L22	equ	5
L23	equ	5
	ends
	efunc
;
;void print_adr(char *p) {
	code
	xdef	_~print_adr
	func
_~print_adr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L25
	tcs
	phd
	tcd
p_0	set	3
;	unsigned long l = (unsigned long)p;
;	
;    printf("%02x:%04x", (char)(l >> 16), (unsigned int)(l & 0xffff));
l_1	set	0
	lda	<L25+p_0
	sta	<L26+l_1
	lda	<L25+p_0+2
	sta	<L26+l_1+2
	lda	<L26+l_1
	sta	<R0
	stz	<R0+2
	pei	<R0
	pei	<L26+l_1+2
	pei	<L26+l_1
	lda	#$10
	xref	_~~llsr
	jsr	_~~llsr
	stx	<R1+2
	and	#$ff
	pha
	pea	#^L21
	pea	#<L21
	pea	#10
	jsr	_~printf
;}
	lda	<L25+1
	sta	<L25+1+4
	pld
	tsc
	clc
	adc	#L25+4
	tcs
	rts
L25	equ	12
L26	equ	9
	ends
	efunc
	data
L21:
	db	$25,$30,$32,$78,$3A,$25,$30,$34,$78,$00
	ends
;
;void print_prompt() {
	code
	xdef	_~print_prompt
	func
_~print_prompt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
;	unsigned int stackptr = 0;
;	unsigned int direct = 0;
;	char db = 0;
;	char flags = 0;
;	char program_bank;
;
;#ifdef __WDC__
;	#asm
stackptr_1	set	0
direct_1	set	2
db_1	set	4
flags_1	set	5
program_bank_1	set	6
	stz	<L30+stackptr_1
	stz	<L30+direct_1
	sep	#$20
	longa	off
	stz	<L30+db_1
	stz	<L30+flags_1
	rep	#$20
	longa	on
;	php
;	sep #$20
;	pla
;	sta %%flags
;	phb
;	pla
;	sta %%db
;	rep #$20
;	tsc
;	sta %%stackptr;
;	tdc
;	sta %%direct;
;	#endasm
	asmstart
	php
	sep #$20
	pla
	sta <L30+flags_1
	phb
	pla
	sta <L30+db_1
	rep #$20
	tsc
	sta <L30+stackptr_1;
	tdc
	sta <L30+direct_1;
	asmend
;#endif
;#ifdef __CALYPSI__
;__asm (
; " php \n"
; " sep #32 \n"
; " pla \n"
; " sta 2,s \n"
; " phb \n"
; " pla \n"
; " sta 1,s \n"
; " rep #32 \n"
; " tsx \n"
; " phd \n"
; " ply \n"
;);
;
;#endif
;
;	printf("S:%04x D:%04x DB:%02X F:%02X ", stackptr, direct, db, flags);
	lda	<L30+flags_1
	and	#$ff
	pha
	lda	<L30+db_1
	and	#$ff
	pha
	pei	<L30+direct_1
	pei	<L30+stackptr_1
	pea	#^L28
	pea	#<L28
	pea	#14
	jsr	_~printf
;	print_adr(ptr);	
	lda	|_~ptr+2
	pha
	lda	|_~ptr
	pha
	jsr	_~print_adr
;	printf(">");
	pea	#^L28+30
	pea	#<L28+30
	pea	#6
	jsr	_~printf
;	fflush(stdout);
	lda	#<_~_iob+20
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~fflush
;}
	pld
	tsc
	clc
	adc	#L29
	tcs
	rts
L29	equ	11
L30	equ	5
	ends
	efunc
	data
L28:
	db	$53,$3A,$25,$30,$34,$78,$20,$44,$3A,$25,$30,$34,$78,$20,$44
	db	$42,$3A,$25,$30,$32,$58,$20,$46,$3A,$25,$30,$32,$58,$20,$00
	db	$3E,$00
	ends
;
;void dump_memory() {
	code
	xdef	_~dump_memory
	func
_~dump_memory:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L33
	tcs
	phd
	tcd
;	int i, j;
;	char c;
;	
;	printf("\n");
i_1	set	0
j_1	set	2
c_1	set	4
	pea	#^L32
	pea	#<L32
	pea	#6
	jsr	_~printf
;	printf("	00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f\n");
	pea	#^L32+2
	pea	#<L32+2
	pea	#6
	jsr	_~printf
;	//printf("	------------------------------------------------\n");
;	
;	for(i = 0; i < 16; i++) {
	stz	<L34+i_1
L10008:
;		print_adr(ptr);
	lda	|_~ptr+2
	pha
	lda	|_~ptr
	pha
	jsr	_~print_adr
;		for(j = 0; j < 16; j++) {
	stz	<L34+j_1
L10011:
;			if (j == 8)
;				printf(" ");
	lda	<L34+j_1
	cmp	#<$8
	bne	L10012
	pea	#^L32+53
	pea	#<L32+53
	pea	#6
	jsr	_~printf
;			printf(" %02X", ptr[j]);
L10012:
	lda	|_~ptr
	sta	<R0
	lda	|_~ptr+2
	sta	<R0+2
	ldy	<L34+j_1
	lda	[<R0],Y
	and	#$ff
	pha
	pea	#^L32+55
	pea	#<L32+55
	pea	#8
	jsr	_~printf
;		}
	inc	<L34+j_1
	sec
	lda	<L34+j_1
	sbc	#<$10
	bvs	L36
	eor	#$8000
L36:
	bpl	L10011
;		
;		printf("  |");
	pea	#^L32+61
	pea	#<L32+61
	pea	#6
	jsr	_~printf
;		for(j = 0; j < 16; j++) {
	stz	<L34+j_1
L10015:
;			c = ptr[j];
	lda	|_~ptr
	sta	<R0
	lda	|_~ptr+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L34+j_1
	lda	[<R0],Y
	sta	<L34+c_1
;			if (c < 32 || c >126)
;				c = '.';
	cmp	#<$20
	rep	#$20
	longa	on
	bcc	L38
	sep	#$20
	longa	off
	lda	#$7e
	cmp	<L34+c_1
	rep	#$20
	longa	on
	bcs	L10016
L38:
	sep	#$20
	longa	off
	lda	#$2e
	sta	<L34+c_1
	rep	#$20
	longa	on
;			printf("%c", c);
L10016:
	lda	<L34+c_1
	and	#$ff
	pha
	pea	#^L32+65
	pea	#<L32+65
	pea	#8
	jsr	_~printf
;		}
	inc	<L34+j_1
	sec
	lda	<L34+j_1
	sbc	#<$10
	bvs	L41
	eor	#$8000
L41:
	bpl	L10015
;		printf("|\n");
	pea	#^L32+68
	pea	#<L32+68
	pea	#6
	jsr	_~printf
;		ptr += 16;
	lda	#$10
	clc
	adc	|_~ptr
	sta	|_~ptr
	bcc	L10006
	inc	|_~ptr+2
;	}
L10006:
	inc	<L34+i_1
	sec
	lda	<L34+i_1
	sbc	#<$10
	bvs	L44
	eor	#$8000
L44:
	bmi	*+5
	brl	L10008
;}
	pld
	tsc
	clc
	adc	#L33
	tcs
	rts
L33	equ	9
L34	equ	5
	ends
	efunc
	data
L32:
	db	$0A,$00,$09,$30,$30,$20,$30,$31,$20,$30,$32,$20,$30,$33,$20
	db	$30,$34,$20,$30,$35,$20,$30,$36,$20,$30,$37,$20,$20,$30,$38
	db	$20,$30,$39,$20,$30,$61,$20,$30,$62,$20,$30,$63,$20,$30,$64
	db	$20,$30,$65,$20,$30,$66,$0A,$00,$20,$00,$20,$25,$30,$32,$58
	db	$00,$20,$20,$7C,$00,$25,$63,$00,$7C,$0A,$00
	ends
;
;void set_bank() {
	code
	xdef	_~set_bank
	func
_~set_bank:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L48
	tcs
	phd
	tcd
;	char *p;
;	
;	printf("bank:");
p_1	set	0
	pea	#^L47
	pea	#<L47
	pea	#6
	jsr	_~printf
;	fflush(stdout);
	lda	#<_~_iob+20
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~fflush
;	
;	p = (char *)&ptr;
	lda	#<_~ptr
	sta	<L49+p_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L49+p_1+2
;	
;	p[2] = getbyte();
	jsr	_~getbyte
	sep	#$20
	longa	off
	ldy	#$2
	sta	[<L49+p_1],Y
	rep	#$20
	longa	on
;}
	pld
	tsc
	clc
	adc	#L48
	tcs
	rts
L48	equ	8
L49	equ	5
	ends
	efunc
	data
L47:
	db	$62,$61,$6E,$6B,$3A,$00
	ends
;
;void set_addr() {
	code
	xdef	_~set_addr
	func
_~set_addr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
;	char *p;
;	
;	printf("addr:");
p_1	set	0
	pea	#^L51
	pea	#<L51
	pea	#6
	jsr	_~printf
;	fflush(stdout);
	lda	#<_~_iob+20
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~fflush
;	
;	p = (char *)&ptr;
	lda	#<_~ptr
	sta	<L53+p_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L53+p_1+2
;	p[1] = getbyte();
	jsr	_~getbyte
	sep	#$20
	longa	off
	ldy	#$1
	sta	[<L53+p_1],Y
	rep	#$20
	longa	on
;	p[0] = getbyte();
	jsr	_~getbyte
	sep	#$20
	longa	off
	sta	[<L53+p_1]
	rep	#$20
	longa	on
;}
	pld
	tsc
	clc
	adc	#L52
	tcs
	rts
L52	equ	8
L53	equ	5
	ends
	efunc
	data
L51:
	db	$61,$64,$64,$72,$3A,$00
	ends
;
;void do_function(char c) {
	code
	xdef	_~do_function
	func
_~do_function:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L56
	tcs
	phd
	tcd
c_0	set	3
;	char b;
;	
;	if (isalpha(c))
b_1	set	0
;		printf("%c ", c);
	lda	<L56+c_0
	and	#$ff
	tax
	sep	#$20
	longa	off
	lda	|_~_ctype+1,X
	and	#<$3
	rep	#$20
	longa	on
	beq	L10017
	lda	<L56+c_0
	and	#$ff
	pha
	pea	#^L55
	pea	#<L55
	pea	#8
	jsr	_~printf
;	
;	switch (c) {
L10017:
	lda	<L56+c_0
	and	#$ff
	xref	_~~swt
	jsr	_~~swt
	dw	10
	dw	63
	dw	L10028-1
	dw	97
	dw	L10020-1
	dw	98
	dw	L10021-1
	dw	99
	dw	L10019-1
	dw	100
	dw	L10023-1
	dw	108
	dw	L10019-1
	dw	109
	dw	L10019-1
	dw	114
	dw	L10026-1
	dw	120
	dw	L10029-1
	dw	122
	dw	L10027-1
	dw	L10019-1
;	case 'a':
L10020:
;		set_addr();
	jsr	_~set_addr
;		break;
L10019:
;	
;	printf("\n");
	pea	#^L55+4
	pea	#<L55+4
	pea	#6
	jsr	_~printf
;}
	lda	<L56+1
	sta	<L56+1+2
	pld
	tsc
	clc
	adc	#L56+2
	tcs
	rts
;	case 'b':
L10021:
;		set_bank();
	jsr	_~set_bank
;		break;
	bra	L10019
;	case 'c':
;		break;
;	case 'd':
L10023:
;		dump_memory();
	jsr	_~dump_memory
;		break;
	bra	L10019
;	case 'l':
;		break;
;	case 'm':
;		break;
;	case 'r':
L10026:
;#asm
;		JML $010000
;#endasm
	asmstart
		JML $010000
L20000:
	asmend
;		break;
	bra	L10019
;	case 'z':
L10027:
;		b = *debug_reset;
	lda	|_~debug_reset
	sta	<R0
	lda	|_~debug_reset+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L57+b_1
	rep	#$20
	longa	on
;		break;
	bra	L10019
;	case '?':
L10028:
;		print_welcome();
	jsr	_~print_welcome
;		break;
	bra	L10019
;	case 'x':
L10029:
;#asm
;		wdm 0
;#endasm
	asmstart
		wdm 0
;		break;
	bra	L20000
;	default:	
;		break;
;	}
L56	equ	5
L57	equ	5
	ends
	efunc
	data
L55:
	db	$25,$63,$20,$00,$0A,$00
	ends
;
;void monitor() {
	code
	xdef	_~monitor
	func
_~monitor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L61
	tcs
	phd
	tcd
;    print_welcome();
	jsr	_~print_welcome
;	
;    for(;;) {
L10033:
;        print_prompt();
	jsr	_~print_prompt
;        do_function(charin());
	jsr	_~charin
	pha
	jsr	_~do_function
;    }
	bra	L10033
;}
L61	equ	0
L62	equ	1
	ends
	efunc
;
	xref	_~printf
	xref	_~fflush
	xref	_~_ctype
	xref	_~_iob

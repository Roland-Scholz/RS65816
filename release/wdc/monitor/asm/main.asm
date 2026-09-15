;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <fcntl.h>
;#include "monitor.h"
;
;#ifdef __WDC__
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
	sbc	#L2
	tcs
	phd
	tcd
format_0	set	5
args_1	set	0
strbuf_1	set	4
	pea	#<$100
	jsr	_~malloc
	sta	<L3+strbuf_1
	stx	<L3+strbuf_1+2
	clc
	tdc
	adc	#<L2+format_0+4
	sta	<L3+args_1
	lda	#$0
	sta	<L3+args_1+2
	pha
	pei	<L3+args_1
	pei	<L2+format_0+2
	pei	<L2+format_0
	pei	<L3+strbuf_1+2
	pei	<L3+strbuf_1
	jsr	_~vsprintf
	pei	<L3+strbuf_1+2
	pei	<L3+strbuf_1
	jsr	_~strlen
	pha
	pei	<L3+strbuf_1+2
	pei	<L3+strbuf_1
	pea	#<$0
	jsr	_~write
	pei	<L3+strbuf_1+2
	pei	<L3+strbuf_1
	jsr	_~free
	phx
	ldx	<L2+3
	lda	<L2+1
	sta	<L2+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L2+2
	adc	<1,s
	tcs
	rts
L2	equ	8
L3	equ	1
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
	sbc	#L5
	tcs
	phd
	tcd
pchar_0	set	3
	pei	<L5+pchar_0+2
	pei	<L5+pchar_0
	pea	#^L1
	pea	#<L1
	pea	#10
	jsr	_~debug
	lda	#$1
	tay
	lda	<L5+1
	sta	<L5+1+4
	pld
	tsc
	clc
	adc	#L5+4
	tcs
	tya
	rts
L5	equ	0
L6	equ	1
	ends
	efunc
	data
L1:
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
	sbc	#L9
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
	lda	[<L9+str_0]
	sta	[<R0]
	rep	#$20
	longa	on
	inc	<L9+str_0
	bne	L10001
	inc	<L9+str_0+2
L10001:
	lda	[<L9+str_0]
	and	#$ff
	bne	L20001
	lda	<L9+1
	sta	<L9+1+4
	pld
	tsc
	clc
	adc	#L9+4
	tcs
	rts
L9	equ	4
L10	equ	5
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
	sbc	#L14
	tcs
	phd
	tcd
fd_0	set	3
buf_0	set	5
size_0	set	9
p_1	set	0
ansi_1	set	4
	lda	<L14+buf_0
	sta	<L15+p_1
	lda	<L14+buf_0+2
	sta	<L15+p_1+2
	lda	<L14+fd_0
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
	sta	<L15+ansi_1
	lda	|_~ansi_yellow+2
L20002:
	sta	<L15+ansi_1+2
L10004:
	pei	<L15+ansi_1+2
	pei	<L15+ansi_1
	jsr	_~print_str
	bra	L10011
L10006:
	lda	|_~ansi_red
	sta	<L15+ansi_1
	lda	|_~ansi_red+2
	bra	L20002
L10007:
	stz	<L15+ansi_1
	stz	<L15+ansi_1+2
	bra	L10004
L10010:
	lda	<L14+fd_0
	bmi	L16
	dea
	dea
	dea
	bpl	L10012
L16:
	sep	#$20
	longa	off
	lda	[<L15+p_1]
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
	lda	[<L15+p_1]
	sta	[<R0]
	rep	#$20
	longa	on
	inc	<L15+p_1
	bne	L10008
	inc	<L15+p_1+2
L10008:
	dec	<L14+size_0
L10011:
	lda	#$0
	cmp	<L14+size_0
	bcc	L10010
	lda	<L15+ansi_1
	ora	<L15+ansi_1+2
	beq	L10013
	lda	|_~ansi_white+2
	pha
	lda	|_~ansi_white
	pha
	jsr	_~print_str
L10013:
	lda	<L14+size_0
	tay
	lda	<L14+1
	sta	<L14+1+8
	pld
	tsc
	clc
	adc	#L14+8
	tcs
	tya
	rts
L14	equ	12
L15	equ	5
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
	sbc	#L22
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
	lda	<L22+1
	sta	<L22+1+8
	pld
	tsc
	clc
	adc	#L22+8
	tcs
	tya
	rts
L22	equ	4
L23	equ	5
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
	sbc	#L25
	tcs
	phd
	tcd
fd_0	set	3
	lda	#$1
	tay
	lda	<L25+1
	sta	<L25+1+2
	pld
	tsc
	clc
	adc	#L25+2
	tcs
	tya
	rts
L25	equ	0
L26	equ	1
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
	sbc	#L28
	tcs
	phd
	tcd
_name_0	set	3
_mode_0	set	7
	pei	<L28+_mode_0
	pei	<L28+_name_0+2
	pei	<L28+_name_0
	pea	#^L8
	pea	#<L8
	pea	#12
	jsr	_~debug
	lda	#$1
	tay
	lda	<L28+1
	sta	<L28+1+6
	pld
	tsc
	clc
	adc	#L28+6
	tcs
	tya
	rts
L28	equ	0
L29	equ	1
	ends
	efunc
	data
L8:
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
	sbc	#L32
	tcs
	phd
	tcd
fd_0	set	3
	pei	<L32+fd_0
	pea	#^L31
	pea	#<L31
	pea	#8
	jsr	_~debug
	lda	#$1
	tay
	lda	<L32+1
	sta	<L32+1+2
	pld
	tsc
	clc
	adc	#L32+2
	tcs
	tya
	rts
L32	equ	0
L33	equ	1
	ends
	efunc
	data
L31:
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
	sbc	#L36
	tcs
	phd
	tcd
fd_0	set	3
offset_0	set	5
whence_0	set	9
	pei	<L36+whence_0
	pei	<L36+offset_0+2
	pei	<L36+offset_0
	pei	<L36+fd_0
	pea	#^L35
	pea	#<L35
	pea	#14
	jsr	_~debug
	lda	#$0
	tax
	ina
	tay
	lda	<L36+1
	sta	<L36+1+8
	pld
	tsc
	clc
	adc	#L36+8
	tcs
	tya
	rts
L36	equ	0
L37	equ	1
	ends
	efunc
	data
L35:
	db	$6C,$73,$65,$65,$6B,$20,$63,$61,$6C,$6C,$65,$64,$20,$66,$64
	db	$3A,$25,$64,$2C,$20,$6F,$66,$66,$73,$65,$74,$3A,$25,$64,$2C
	db	$20,$77,$68,$65,$6E,$63,$65,$3A,$25,$64,$0A,$00
	ends
;#endif
;
;#ifdef __CALYPSI__
;#include "calypsi_misc.h"
;#endif
;
;int main (int argc, char** argv) {
	code
	xdef	_~main
	func
_~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
argc_0	set	3
argv_0	set	5
;
;	void *p = (void *)0xff;
;	/*
;	setvbuf(stdout, NULL, _IONBF, 0);
;	setvbuf(stderr, NULL, _IONBF, 0);
;	setvbuf(stdin, NULL, _IONBF, 0);
;	*/
;	/*
;	fprintf(stderr, "Hallo Welt mit WDC nach stderr!\n");
;    fprintf(stdout, "Hallo Welt mit WDC nach stdout!\n");
;
;	printf("heap_start: %p\n", heap_start);
;    printf("size char: %d \n", sizeof(char));
;    printf("size int: %d \n", sizeof(int));
;    printf("size short: %d \n", sizeof(short));
;    printf("size size_t: %d \n", sizeof(size_t));
;    printf("size long: %d \n", sizeof(long));
;    printf("size char*: %d \n", sizeof(char*));
;*/
;	monitor();
p_1	set	0
	lda	#$ff
	sta	<L41+p_1
	lda	#$0
	sta	<L41+p_1+2
	jsr	_~monitor
;	
;    return 0;
	lda	#$0
	tay
	lda	<L40+1
	sta	<L40+1+6
	pld
	tsc
	clc
	adc	#L40+6
	tcs
	tya
	rts
;}
L40	equ	4
L41	equ	1
	ends
	efunc
;
	xref	_~strlen
	xref	_~monitor
	xref	_~malloc
	xref	_~free
	xref	_~vsprintf
	xref	_~ansi_yellow
	xref	_~ansi_red
	xref	_~ansi_white
	xref	_~debug_char

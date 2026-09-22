;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*
;	Copyright 2001, 2002 Georges Menie (www.menie.org)
;	stdarg version contributed by Christian Ettinger
;
;    This program is free software; you can redistribute it and/or modify
;    it under the terms of the GNU Lesser General Public License as published by
;    the Free Software Foundation; either version 2 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU Lesser General Public License for more details.
;
;    You should have received a copy of the GNU Lesser General Public License
;    along with this program; if not, write to the Free Software
;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;*/
;
;/*
;	putchar is the only external dependency for this file,
;	if you have a working putchar, leave it commented out.
;	If not, uncomment the define below and
;	replace outbyte(c) by your own function call.
;*/
;
;//#include <stdlib.h>
;#include <stdarg.h>
;
;static void printchar(char **str, int c)
;{
	code
	func
_~printchar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
str_0	set	3
c_0	set	7
;	extern void putchar(int c);
;	
;	if (str) {
	lda	<L2+str_0
	ora	<L2+str_0+2
	beq	L10001
;		**str = c;
	lda	[<L2+str_0]
	sta	<R0
	ldy	#$2
	lda	[<L2+str_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L2+c_0
	sta	[<R0]
	rep	#$20
	longa	on
;		++(*str);
	lda	#$1
	clc
	adc	[<L2+str_0]
	sta	[<L2+str_0]
	lda	#$0
	adc	[<L2+str_0],Y
	sta	[<L2+str_0],Y
;	}
;	else {
	bra	L5
L10001:
;		//(void)putchar(c);
;		*(char*)0xfffff0 = c;
	sep	#$20
	longa	off
	lda	<L2+c_0
	sta	>16777200
	rep	#$20
	longa	on
;	}
;}
L5:
	lda	<L2+1
	sta	<L2+1+6
	pld
	tsc
	clc
	adc	#L2+6
	tcs
	rts
L2	equ	4
L3	equ	5
	ends
	efunc
;
;#define PAD_RIGHT 1
;#define PAD_ZERO 2
;
;static int prints(char **out, const char *string, int width, int pad)
;{
	code
	func
_~prints:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
out_0	set	3
string_0	set	7
width_0	set	11
pad_0	set	13
;	int pc = 0, padchar = ' ';
;	int len = 0;
;	const char *ptr;
;	
;	if (width > 0) {
pc_1	set	0
padchar_1	set	2
len_1	set	4
ptr_1	set	6
	stz	<L7+pc_1
	lda	#$20
	sta	<L7+padchar_1
	stz	<L7+len_1
	sec
	lda	#$0
	sbc	<L6+width_0
	bvs	L8
	eor	#$8000
L8:
	bmi	L10003
;		for (ptr = string; *ptr; ++ptr) ++len;
	lda	<L6+string_0
	sta	<L7+ptr_1
	lda	<L6+string_0+2
	sta	<L7+ptr_1+2
	bra	L10007
L10006:
	inc	<L7+len_1
	inc	<L7+ptr_1
	bne	L10007
	inc	<L7+ptr_1+2
L10007:
	lda	[<L7+ptr_1]
	and	#$ff
	bne	L10006
;		if (len >= width) width = 0;
	sec
	lda	<L7+len_1
	sbc	<L6+width_0
	bvs	L12
	eor	#$8000
L12:
	bpl	L10008
	stz	<L6+width_0
;		else width -= len;
	bra	L10009
L10008:
	sec
	lda	<L6+width_0
	sbc	<L7+len_1
	sta	<L6+width_0
L10009:
;		if (pad & PAD_ZERO) padchar = '0';
	lda	<L6+pad_0
	and	#<$2
	beq	L10003
	lda	#$30
	sta	<L7+padchar_1
;	}
;	if (!(pad & PAD_RIGHT)) {
L10003:
	lda	<L6+pad_0
	and	#<$1
	beq	L10015
	bra	L10019
;		for ( ; width > 0; --width) {
L10014:
;			printchar (out, padchar);
	pei	<L7+padchar_1
	pei	<L6+out_0+2
	pei	<L6+out_0
	jsr	_~printchar
;			++pc;
	inc	<L7+pc_1
;		}
	dec	<L6+width_0
L10015:
	sec
	lda	#$0
	sbc	<L6+width_0
	bvs	L16
	eor	#$8000
L16:
	bmi	L10019
	bra	L10014
;	}
;	for ( ; *string ; ++string) {
L10018:
;		printchar (out, *string);
	lda	[<L6+string_0]
	and	#$ff
	pha
	pei	<L6+out_0+2
	pei	<L6+out_0
	jsr	_~printchar
;		++pc;
	inc	<L7+pc_1
;	}
	inc	<L6+string_0
	bne	L10019
	inc	<L6+string_0+2
L10019:
	lda	[<L6+string_0]
	and	#$ff
	beq	L10023
	bra	L10018
;	for ( ; width > 0; --width) {
L10022:
;		printchar (out, padchar);
	pei	<L7+padchar_1
	pei	<L6+out_0+2
	pei	<L6+out_0
	jsr	_~printchar
;		++pc;
	inc	<L7+pc_1
;	}
	dec	<L6+width_0
L10023:
	sec
	lda	#$0
	sbc	<L6+width_0
	bvs	L20
	eor	#$8000
L20:
	bpl	L10022
;
;	return pc;
	lda	<L7+pc_1
	tay
	lda	<L6+1
	sta	<L6+1+12
	pld
	tsc
	clc
	adc	#L6+12
	tcs
	tya
	rts
;}
L6	equ	10
L7	equ	1
	ends
	efunc
;
;/* the following should be enough for 32 bit int */
;#define PRINT_BUF_LEN 12
;
;static int printi(char **out, long i, int b, int sg, int width, int pad, int letbase)
;{
	code
	func
_~printi:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
out_0	set	3
i_0	set	7
b_0	set	11
sg_0	set	13
width_0	set	15
pad_0	set	17
letbase_0	set	19
;	char print_buf[PRINT_BUF_LEN];
;	register char *s;
;	register int t, neg = 0, pc = 0;
;	/*register*/ unsigned long u = i;
;
;	if (i == 0) {
print_buf_1	set	0
s_1	set	12
t_1	set	16
neg_1	set	18
pc_1	set	20
u_1	set	22
	stz	<L24+neg_1
	stz	<L24+pc_1
	lda	<L23+i_0
	sta	<L24+u_1
	lda	<L23+i_0+2
	sta	<L24+u_1+2
	lda	<L23+i_0
	ora	<L23+i_0+2
	bne	L10024
;		print_buf[0] = '0';
	sep	#$20
	longa	off
	lda	#$30
	sta	<L24+print_buf_1
;		print_buf[1] = '\0';
	stz	<L24+print_buf_1+1
	rep	#$20
	longa	on
;		return prints (out, print_buf, width, pad);
	pei	<L23+pad_0
	pei	<L23+width_0
	pea	#0
	clc
	tdc
	adc	#<L24+print_buf_1
	pha
	pei	<L23+out_0+2
	pei	<L23+out_0
	jsr	_~prints
L26:
	tay
	lda	<L23+1
	sta	<L23+1+18
	pld
	tsc
	clc
	adc	#L23+18
	tcs
	tya
	rts
;	}
;
;	if (sg && b == 10 && i < 0) {
L10024:
	lda	<L23+sg_0
	beq	L10025
	lda	<L23+b_0
	cmp	#<$a
	bne	L10025
	lda	<L23+i_0+2
	bpl	L10025
;		neg = 1;
	lda	#$1
	sta	<L24+neg_1
;		u = -i;
	sec
	dea
	sbc	<L23+i_0
	sta	<L24+u_1
	lda	#$0
	sbc	<L23+i_0+2
	sta	<L24+u_1+2
;	}
;
;	s = print_buf + PRINT_BUF_LEN-1;
L10025:
	clc
	tdc
	adc	#<L24+print_buf_1+11
	sta	<L24+s_1
	lda	#$0
	sta	<L24+s_1+2
;	*s = '\0';
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L24+s_1]
	rep	#$20
	longa	on
;
;	while (u) {
	bra	L10026
L20001:
;		t = u % b;
	ldy	#$0
	lda	<L23+b_0
	bpl	L31
	dey
L31:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L24+u_1+2
	pei	<L24+u_1
	xref	_~~lumd
	jsr	_~~lumd
	stx	<R0+2
	sta	<L24+t_1
;		if( t >= 10 )
;			t += letbase - '0' - 10;
	sec
	sbc	#<$a
	bvs	L32
	eor	#$8000
L32:
	bpl	L10028
	lda	<L24+t_1
	clc
	adc	<L23+letbase_0
	clc
	adc	#$ffc6
	sta	<L24+t_1
;		*--s = t + '0';
L10028:
	lda	<L24+s_1
	bne	L34
	dec	<L24+s_1+2
L34:
	dec	<L24+s_1
	lda	#$30
	clc
	adc	<L24+t_1
	sep	#$20
	longa	off
	sta	[<L24+s_1]
	rep	#$20
	longa	on
;		u /= b;
	ldy	#$0
	lda	<L23+b_0
	bpl	L35
	dey
L35:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L24+u_1+2
	pei	<L24+u_1
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L24+u_1
	stx	<L24+u_1+2
;	}
L10026:
	lda	<L24+u_1
	ora	<L24+u_1+2
	bne	L20001
;
;	if (neg) {
	lda	<L24+neg_1
	beq	L10029
;		if( width && (pad & PAD_ZERO) ) {
	lda	<L23+width_0
	beq	L10030
	lda	<L23+pad_0
	and	#<$2
	beq	L10030
;			printchar (out, '-');
	pea	#<$2d
	pei	<L23+out_0+2
	pei	<L23+out_0
	jsr	_~printchar
;			++pc;
	inc	<L24+pc_1
;			--width;
	dec	<L23+width_0
;		}
;		else {
	bra	L10029
L10030:
;			*--s = '-';
	lda	<L24+s_1
	bne	L39
	dec	<L24+s_1+2
L39:
	dec	<L24+s_1
	sep	#$20
	longa	off
	lda	#$2d
	sta	[<L24+s_1]
	rep	#$20
	longa	on
;		}
;	}
;
;	return pc + prints (out, s, width, pad);
L10029:
	pei	<L23+pad_0
	pei	<L23+width_0
	pei	<L24+s_1+2
	pei	<L24+s_1
	pei	<L23+out_0+2
	pei	<L23+out_0
	jsr	_~prints
	lda	<R0
	clc
	adc	<L24+pc_1
	brl	L26
;}
L23	equ	30
L24	equ	5
	ends
	efunc
;
;static int print( char **out, const char *format, va_list args )
;{
	code
	func
_~print:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
out_0	set	3
format_0	set	7
args_0	set	11
;	int width, pad;
;	int pc = 0;
;	unsigned int lo;
;	char scr[2];
;
;	for (; *format != 0; ++format) {
width_1	set	0
pad_1	set	2
pc_1	set	4
lo_1	set	6
scr_1	set	8
	stz	<L41+pc_1
	brl	L10035
L10034:
;		if (*format == '%') {
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$25
	rep	#$20
	longa	on
	beq	*+5
	brl	L10037
;			++format;
	inc	<L40+format_0
	bne	L43
	inc	<L40+format_0+2
L43:
;			width = pad = 0;
	stz	<L41+pad_1
	stz	<L41+width_1
;			if (*format == '\0') break;
	lda	[<L40+format_0]
	and	#$ff
	bne	*+5
	brl	L10033
;			if (*format == '%') goto out;
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$25
	rep	#$20
	longa	on
	bne	*+5
	brl	L10037
;			if (*format == '-') {
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$2d
	rep	#$20
	longa	on
	bne	L10039
;				++format;
	inc	<L40+format_0
	bne	L47
	inc	<L40+format_0+2
L47:
;				pad = PAD_RIGHT;
	lda	#$1
	sta	<L41+pad_1
;			}
;			while (*format == '0') {
	bra	L10039
L20003:
;				++format;
	inc	<L40+format_0
	bne	L49
	inc	<L40+format_0+2
L49:
;				pad |= PAD_ZERO;
	lda	#$2
	tsb	<L41+pad_1
;			}
L10039:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$30
	rep	#$20
	longa	on
	beq	L20003
;			for ( ; *format >= '0' && *format <= '9'; ++format) {
	bra	L10044
L10043:
;				width *= 10;
	lda	<L41+width_1
	asl	A
	asl	A
	adc	<L41+width_1
	asl	A
	sta	<L41+width_1
;				width += *format - '0';
	lda	[<L40+format_0]
	and	#$ff
	clc
	adc	<L41+width_1
	clc
	adc	#$ffd0
	sta	<L41+width_1
;			}
	inc	<L40+format_0
	bne	L10044
	inc	<L40+format_0+2
L10044:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcc	L10042
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<L40+format_0]
	rep	#$20
	longa	on
	bcs	L10043
L10042:
;			if( *format == 's' ) {
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$73
	rep	#$20
	longa	on
	beq	*+5
	brl	L10045
;				register char *s = (char *)va_arg( args, long );
;				pc += prints (out, s?s:"(null)", width, pad);
s_2	set	10
	lda	#$4
	clc
	adc	<L40+args_0
	sta	<L40+args_0
	bcc	L55
	inc	<L40+args_0+2
L55:
	lda	#$fffc
	clc
	adc	<L40+args_0
	sta	<R0
	lda	#$ffff
	adc	<L40+args_0+2
	sta	<R0+2
	lda	[<R0]
	sta	<L41+s_2
	ldy	#$2
	lda	[<R0],Y
	sta	<L41+s_2+2
	pei	<L41+pad_1
	pei	<L41+width_1
	lda	<L41+s_2
	ora	<L41+s_2+2
	beq	L56
	ldx	<L41+s_2+2
	lda	<L41+s_2
	bra	L58
L56:
	lda	#^L1
	tax
	lda	#<L1
L58:
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
L20078:
	pei	<L40+out_0+2
	pei	<L40+out_0
	jsr	_~prints
	bra	L20008
L20065:
;				pc += printi (out, va_arg( args, int), 10, 1, width, pad, 'a');
	pea	#<$61
	pei	<L41+pad_1
	pei	<L41+width_1
	pea	#<$1
	pea	#<$a
	lda	#$2
	clc
	adc	<L40+args_0
	sta	<L40+args_0
	bcc	L60
	inc	<L40+args_0+2
L60:
	lda	#$fffe
	clc
	adc	<L40+args_0
	sta	<R0
	lda	#$ffff
	adc	<L40+args_0+2
	sta	<R0+2
	ldy	#$0
	lda	[<R0]
	bpl	L61
	dey
L61:
	sta	<R0
	sty	<R0+2
L20031:
	pei	<R0+2
	pei	<R0
	pei	<L40+out_0+2
	pei	<L40+out_0
	jsr	_~printi
;				continue;
L20008:
	clc
	adc	<L41+pc_1
	sta	<L41+pc_1
;				continue;
	brl	L10032
;			}
;			if( *format == 'd' ) {
L10045:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$64
	rep	#$20
	longa	on
	beq	L20065
;			}
;			if( *format == 'x' ) {
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$78
	rep	#$20
	longa	on
	bne	L10047
;				pc += printi (out, va_arg( args, unsigned int), 16, 0, width, pad, 'a');
	pea	#<$61
L20075:
	pei	<L41+pad_1
	pei	<L41+width_1
	pea	#<$0
	pea	#<$10
L20071:
	lda	#$2
	clc
	adc	<L40+args_0
	sta	<L40+args_0
	bcc	L63
	inc	<L40+args_0+2
L63:
	lda	#$fffe
	clc
	adc	<L40+args_0
	sta	<R0
	lda	#$ffff
	adc	<L40+args_0+2
	sta	<R0+2
	lda	[<R0]
L20063:
	sta	<R0
	stz	<R0+2
;				continue;
	bra	L20031
;			}
;			if( *format == 'X' ) {
L10047:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$58
	rep	#$20
	longa	on
	bne	L10048
;				pc += printi (out, va_arg( args, unsigned int), 16, 0, width, pad, 'A');
	pea	#<$41
	bra	L20075
;				continue;
;			}
;			if( *format == 'u' ) {
L10048:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$75
	rep	#$20
	longa	on
	bne	L10049
;				pc += printi (out, va_arg( args, unsigned int), 10, 0, width, pad, 'a');
	pea	#<$61
	pei	<L41+pad_1
	pei	<L41+width_1
	pea	#<$0
	pea	#<$a
	bra	L20071
;				continue;
;			}
;			if( *format == 'p' ) {
L10049:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$70
	rep	#$20
	longa	on
	bne	L10050
;				width = 4;
	lda	#$4
	sta	<L41+width_1
;				pad  = PAD_ZERO;
	dea
	dea
	sta	<L41+pad_1
;				lo = va_arg( args, unsigned int);
	clc
	adc	<L40+args_0
	sta	<L40+args_0
	bcc	L69
	inc	<L40+args_0+2
L69:
	lda	#$fffe
	clc
	adc	<L40+args_0
	sta	<R0
	lda	#$ffff
	adc	<L40+args_0+2
	sta	<R0+2
	lda	[<R0]
	sta	<L41+lo_1
;				pc += printi (out, va_arg( args, unsigned int), 16, 0, width, pad, 'a');
	pea	#<$61
	pei	<L41+pad_1
	pei	<L41+width_1
	pea	#<$0
	pea	#<$10
	lda	#$2
	clc
	adc	<L40+args_0
	sta	<L40+args_0
	bcc	L70
	inc	<L40+args_0+2
L70:
	lda	#$fffe
	clc
	adc	<L40+args_0
	sta	<R0
	lda	#$ffff
	adc	<L40+args_0+2
	sta	<R0+2
	lda	[<R0]
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L40+out_0+2
	pei	<L40+out_0
	jsr	_~printi
	clc
	adc	<L41+pc_1
	sta	<L41+pc_1
;				pc += printi (out, lo, 16, 0, width, pad, 'a');
	pea	#<$61
	pei	<L41+pad_1
	pei	<L41+width_1
	pea	#<$0
	pea	#<$10
	lda	<L41+lo_1
;				continue;
	brl	L20063
;			}
;			if( *format == 'c' ) {
L10050:
	sep	#$20
	longa	off
	lda	[<L40+format_0]
	cmp	#<$63
	rep	#$20
	longa	on
	bne	L10032
;				/* char are converted to int then pushed on the stack */
;				scr[0] = (char)va_arg( args, int );
	lda	#$2
	clc
	adc	<L40+args_0
	sta	<L40+args_0
	bcc	L72
	inc	<L40+args_0+2
L72:
	lda	#$fffe
	clc
	adc	<L40+args_0
	sta	<R0
	lda	#$ffff
	adc	<L40+args_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L41+scr_1
;				scr[1] = '\0';
	stz	<L41+scr_1+1
	rep	#$20
	longa	on
;				pc += prints (out, scr, width, pad);
	pei	<L41+pad_1
	pei	<L41+width_1
	pea	#0
	clc
	tdc
	adc	#<L41+scr_1
	pha
	brl	L20078
;				continue;
;			}
;		}
;		else {
;		out:
L10037:
;			printchar (out, *format);
	lda	[<L40+format_0]
	and	#$ff
	pha
	pei	<L40+out_0+2
	pei	<L40+out_0
	jsr	_~printchar
;			++pc;
	inc	<L41+pc_1
;		}
;	}
L10032:
	inc	<L40+format_0
	bne	L10035
	inc	<L40+format_0+2
L10035:
	lda	[<L40+format_0]
	and	#$ff
	beq	*+5
	brl	L10034
L10033:
;	if (out) **out = '\0';
	lda	<L40+out_0
	ora	<L40+out_0+2
	beq	L10053
	lda	[<L40+out_0]
	sta	<R0
	ldy	#$2
	lda	[<L40+out_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	sta	[<R0]
	rep	#$20
	longa	on
;	va_end( args );
L10053:
;	
;	return pc;
	lda	<L41+pc_1
	tay
	lda	<L40+1
	sta	<L40+1+12
	pld
	tsc
	clc
	adc	#L40+12
	tcs
	tya
	rts
;}
L40	equ	22
L41	equ	9
	ends
	efunc
	data
L1:
	db	$28,$6E,$75,$6C,$6C,$29,$00
	ends
;
;int printf(const char *format, ...)
;{	
	code
	xdef	_~printf
	func
_~printf:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L78
	tcs
	phd
	tcd
format_0	set	5
;        va_list args;
;        
;        va_start( args, format );
args_1	set	0
	clc
	tdc
	adc	#<L78+format_0+4
	sta	<L79+args_1
	lda	#$0
	sta	<L79+args_1+2
;        return print( 0, format, args );
	pha
	pei	<L79+args_1
	pei	<L78+format_0+2
	pei	<L78+format_0
	pea	#^$0
	pea	#<$0
	jsr	_~print
	tay
	phx
	ldx	<L78+3
	lda	<L78+1
	sta	<L78+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L78+2
	adc	<1,s
	tcs
	tya
	rts
;}
L78	equ	4
L79	equ	1
	ends
	efunc
;
;int sprintf(char *out, const char *format, ...)
;{
	code
	xdef	_~sprintf
	func
_~sprintf:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L81
	tcs
	phd
	tcd
out_0	set	5
format_0	set	9
;        va_list args;
;        
;        va_start( args, format );
args_1	set	0
	clc
	tdc
	adc	#<L81+format_0+4
	sta	<L82+args_1
	lda	#$0
	sta	<L82+args_1+2
;        return print( &out, format, args );
	pha
	pei	<L82+args_1
	pei	<L81+format_0+2
	pei	<L81+format_0
	pea	#0
	clc
	tdc
	adc	#<L81+out_0
	pha
	jsr	_~print
	tay
	phx
	ldx	<L81+3
	lda	<L81+1
	sta	<L81+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L81+2
	adc	<1,s
	tcs
	tya
	rts
;}
L81	equ	4
L82	equ	1
	ends
	efunc
;
;
;int snprintf( char *buf, unsigned int count, const char *format, ... )
;{
	code
	xdef	_~snprintf
	func
_~snprintf:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L84
	tcs
	phd
	tcd
buf_0	set	5
count_0	set	9
format_0	set	11
;        va_list args;
;        
;        ( void ) count;
args_1	set	0
;        
;        va_start( args, format );
	clc
	tdc
	adc	#<L84+format_0+4
	sta	<L85+args_1
	lda	#$0
	sta	<L85+args_1+2
;        return print( &buf, format, args );
	pha
	pei	<L85+args_1
	pei	<L84+format_0+2
	pei	<L84+format_0
	pea	#0
	clc
	tdc
	adc	#<L84+buf_0
	pha
	jsr	_~print
	tay
	phx
	ldx	<L84+3
	lda	<L84+1
	sta	<L84+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L84+2
	adc	<1,s
	tcs
	tya
	rts
;}
L84	equ	4
L85	equ	1
	ends
	efunc
;
;
;#ifdef TEST_PRINTF
;int main(void)
;{
;	char *ptr = "Hello world!";
;	char *np = 0;
;	int i = 5;
;	unsigned int bs = sizeof(int)*8;
;	int mi;
;	char buf[80];
;
;	mi = (1 << (bs-1)) + 1;
;	printf("%s\n", ptr);
;	printf("printf test\n");
;	printf("%s is null pointer\n", np);
;	printf("%d = 5\n", i);
;	printf("%d = - max int\n", mi);
;	printf("char %c = 'a'\n", 'a');
;	printf("hex %x = ff\n", 0xff);
;	printf("hex %02x = 00\n", 0);
;	printf("signed %d = unsigned %u = hex %x\n", -3, -3, -3);
;	printf("%d %s(s)%", 0, "message");
;	printf("\n");
;	printf("%d %s(s) with %%\n", 0, "message");
;	sprintf(buf, "justif: \"%-10s\"\n", "left"); printf("%s", buf);
;	sprintf(buf, "justif: \"%10s\"\n", "right"); printf("%s", buf);
;	sprintf(buf, " 3: %04d zero padded\n", 3); printf("%s", buf);
;	sprintf(buf, " 3: %-4d left justif.\n", 3); printf("%s", buf);
;	sprintf(buf, " 3: %4d right justif.\n", 3); printf("%s", buf);
;	sprintf(buf, "-3: %04d zero padded\n", -3); printf("%s", buf);
;	sprintf(buf, "-3: %-4d left justif.\n", -3); printf("%s", buf);
;	sprintf(buf, "-3: %4d right justif.\n", -3); printf("%s", buf);
;
;	return 0;
;}
;
;/*
; * if you compile this file with
; *   gcc -Wall $(YOUR_C_OPTIONS) -DTEST_PRINTF -c printf.c
; * you will get a normal warning:
; *   printf.c:214: warning: spurious trailing `%' in format
; * this line is testing an invalid % at the end of the format string.
; *
; * this should display (on 32bit int machine) :
; *
; * Hello world!
; * printf test
; * (null) is null pointer
; * 5 = 5
; * -2147483647 = - max int
; * char a = 'a'
; * hex ff = ff
; * hex 00 = 00
; * signed -3 = unsigned 4294967293 = hex fffffffd
; * 0 message(s)
; * 0 message(s) with %
; * justif: "left      "
; * justif: "     right"
; *  3: 0003 zero padded
; *  3: 3    left justif.
; *  3:    3 right justif.
; * -3: -003 zero padded
; * -3: -3   left justif.
; * -3:   -3 right justif.
; */
;
;#endif
;
;
;

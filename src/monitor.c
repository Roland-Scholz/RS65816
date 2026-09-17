#include <stdio.h>
#include <ctype.h>
#include "monitor.h"

volatile char* debug_char = (volatile char *) 0xfffff0;
volatile char* debug_hex  = (volatile char *) 0xfffff1;
volatile char* debug_reset  = (volatile char *) 0xfffff2;

const char *ansi_white = "\033[0m";
const char *ansi_red = "\033[31m";
const char *ansi_yellow = "\033[33;1m";
const char *ansi_clrhome = "\033[2J\033[H";

const char * stars = "**************************************";

static char *ptr = NULL;

void print_welcome() {
	printf("\n");
    printf("%s\n", stars);
	printf("* 65816 Monitor (c) by R. Scholz     *\n");
    printf("%s\n\n", stars);
	
	printf("a - set address\n");
	printf("b - set bank\n");
	printf("c - change memory\n");
	printf("d - dump  memory\n");
	printf("l - disassemble memory a8\n");
	printf("m - disassemble memory a16\n");
	printf("r - RTOS 0x01:0000\n");
	printf("x - exit emulator\n");
	printf("z - reset\n");	
	printf("? - this message\n");
}

char charin() {
	return *debug_char;
}

char getnibble() {
	char c, b;
	
	for(;;) {
		c = charin();
		if (c >= '0' && c <= '9') {
			b = c - '0';
			break;
		}
		if (c >= 'a' && c <= 'f') {
			b = c - 'a' + 10;
			break;
		}
	}
	
	printf("%c", c);
	fflush(stdout);
	
	return b;

}

char getbyte() {
	char c;

	c = getnibble() << 4;
	c += getnibble();
	
	return c;
}

void print_adr(char *p) {
	unsigned long l = (unsigned long)p;
	
    printf("%02x:%04x", (char)(l >> 16), (unsigned int)(l & 0xffff));
}

void print_prompt() {
	unsigned int stackptr = 0;
	unsigned int direct = 0;
	char db = 0;
	char flags = 0;
	char program_bank;

#ifdef __WDC__
	#asm
	php
	sep #$20
	pla
	sta %%flags
	phb
	pla
	sta %%db
	rep #$20
	tsc
	sta %%stackptr;
	tdc
	sta %%direct;
	#endasm
#endif
#ifdef __CALYPSI__
__asm (
 " php \n"
 " sep #32 \n"
 " pla \n"
 " sta 2,s \n"
 " phb \n"
 " pla \n"
 " sta 1,s \n"
 " rep #32 \n"
 " tsx \n"
 " phd \n"
 " ply \n"
);

#endif

	printf("S:%04x D:%04x DB:%02X F:%02X ", stackptr, direct, db, flags);
	print_adr(ptr);	
	printf(">");
	fflush(stdout);
}

void dump_memory() {
	int i, j;
	char c;
	
	printf("\n");
	printf("	00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f\n");
	//printf("	------------------------------------------------\n");
	
	for(i = 0; i < 16; i++) {
		print_adr(ptr);
		for(j = 0; j < 16; j++) {
			if (j == 8)
				printf(" ");
			printf(" %02X", ptr[j]);
		}
		
		printf("  |");
		for(j = 0; j < 16; j++) {
			c = ptr[j];
			if (c < 32 || c >126)
				c = '.';
			printf("%c", c);
		}
		printf("|\n");
		ptr += 16;
	}
}

void set_bank() {
	char *p;
	
	printf("bank:");
	fflush(stdout);
	
	p = (char *)&ptr;
	
	p[2] = getbyte();
}

void set_addr() {
	char *p;
	
	printf("addr:");
	fflush(stdout);
	
	p = (char *)&ptr;
	p[1] = getbyte();
	p[0] = getbyte();
}

void do_function(char c) {
	char b;
	unsigned long ulptr;
	
	if (isalpha(c))
		printf("%c ", c);
	
	switch (c) {
	case 'a':
		set_addr();
		break;
	case 'b':
		set_bank();
		break;
	case 'c':
		break;
	case 'd':
		dump_memory();
		break;
	case 'l':
		;break;
	case 'm':
		ulptr = (unsigned long) ptr;
		disass((unsigned int) ulptr);	
		break;
	case 'r':
#asm
		JML $010000
#endasm
		break;
	case 'z':
		b = *debug_reset;
		break;
	case '?':
		print_welcome();
		break;
	case 'x':
#asm
		wdm 0
#endasm
		break;
	default:	
		break;
	}
	
	printf("\n");
}

void monitor() {
    print_welcome();
	
    for(;;) {
        print_prompt();
        do_function(charin());
    }
}

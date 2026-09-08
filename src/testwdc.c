#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

void *far_heap_start = (void *)0x010000;
void *far_heap_end = (void *)0x02ffff;

void *heap_start = (void *)0x030000;
void *heap_end = (void *)0x03ffff;

volatile char* debug_char = (volatile char *) 0xd800;
volatile char* debug_hex  = (volatile char *) 0xd801;

char *ansi_white = "\033[0m";
char *ansi_red = "\033[31m";
char *ansi_yellow = "\033[33;1m";


#asm
	clc
	xce
	rep #$30
	lda #$01ff
	tcs
	jmp _~main
#endasm

void debug(const char *format, ...) {
	va_list args;

	char *strbuf = malloc(256);
	
    va_start(args, format);
    vsprintf(strbuf, format, args);
    va_end(args);
	
	write(0, strbuf, strlen(strbuf));
	free(strbuf);
}

int unlink(const char *pchar) {
	debug("unlink called name: %s\n", pchar);

	return 1;
}

void print_str(char *str) {
	while(*str) {
		*debug_char = *str++;
	}
}

size_t write(int fd, void *buf, size_t size) {
	char *p = (char *)buf;
	char *ansi;
	
	switch (fd) {
		case 0:
			ansi = ansi_yellow;
			break;
		case 2:
			ansi = ansi_red;
			break;
		default:
			ansi = NULL;
			break;
	}
	
	print_str(ansi);
	
	for(;size > 0; size--) {
		*debug_char = *p;
		p++;
	}
	
	if (ansi) print_str(ansi_white);
	
	return size;
}

size_t read(int fd, void *buf, size_t size) {
	return size;
}
int close(int fd) {
	return 1;
}
int open(const char * _name, int _mode) {
	debug("open called name:%s, mode:%d\n", _name, _mode);
	return 1;
}

int isatty(int fd) {
	debug("isatty called fd:%d\n", fd);
	return 1;
}
long lseek(int fd, long offset, int whence) {
	debug("lseek called fd:%d, offset:%d, whence:%d\n", fd, offset, whence);

	return 1;
}


int main (int argc, char** argv) {

	void *p = (void *)0xff;
	
	fprintf(stderr, "Hallo Welt mit WDC nach stderr!\n");
    fprintf(stdout, "Hallo Welt mit WDC nach stdout!\n");

    printf("size char: %d \n", sizeof(char));
    printf("size int: %d \n", sizeof(int));
    printf("size short: %d \n", sizeof(short));
    printf("size size_t: %d \n", sizeof(size_t));
    printf("size long: %d \n", sizeof(long));
    printf("size char*: %d \n", sizeof(char*));
//    printf("size long long: %d \n", sizeof(long long));

	for(;p;) {
		p = farmalloc(0x4000);
		printf("%p\n", p);
	}

	for(;;)
		;
	
    return 0;
}

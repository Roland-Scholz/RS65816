#include <stdio.h>
#include <stdlib.h>

int i = 6;
int j;

int _Stub_close(int fd) {
    return 0;
}

long _Stub_lseek(int fd, long offset, int whence) {
    return 0;
}

void _write(char c) {
    __asm (
        " sep #0x20\n"
        " sta 0xD800\n"
        " rep #0x20"
    ); 
}

void debug_byte(char c) {
    __asm (
        " sep #0x20\n"
        " sta 0xD801\n"
        " rep #0x20"
    ); 
}

void debug_word(unsigned int i) {
	debug_byte(i >> 8);
	debug_byte(i & 0xff);
	_write(' ');
}


size_t _Stub_write(int fd, const void *buf, size_t count) {
	
    char *b = (char *)buf;
	
	//debug_word(count);
	
    for(;count > 0; count--) {
        _write(*b);
		b++;
    }
	return 0;
}


int main (int argc, char** argv) {

	void *p = (void *)0xff;
	
    printf("Hallo Welt mit Calypsi!\n");

    printf("size char: %d \n", sizeof(char));
    printf("size int: %d \n", sizeof(int));
    printf("size short: %d \n", sizeof(short));
    printf("size size_t: %d \n", sizeof(size_t));
    printf("size long: %d \n", sizeof(long));
    printf("size char*: %d \n", sizeof(char*));
    printf("size long long: %d \n", sizeof(long long));

	for(;p;) {
		p = malloc(0x80);
		printf("%p\n", p);
	}

	for(;;)
		;
	
    return 0;
}

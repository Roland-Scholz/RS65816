#include <stdio.h>
#include <stdlib.h>

int i = 6;
int j;




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

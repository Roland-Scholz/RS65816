#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include "monitor.h"

#ifdef __WDC__
#include "wdc_misc.h"
#endif

#ifdef __CALYPSI__
#include "calypsi_misc.h"
#endif

int main (int argc, char** argv) {

	void *p = (void *)0xff;
	/*
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);
	setvbuf(stdin, NULL, _IONBF, 0);
	*/
	/*
	fprintf(stderr, "Hallo Welt mit WDC nach stderr!\n");
    fprintf(stdout, "Hallo Welt mit WDC nach stdout!\n");

	printf("heap_start: %p\n", heap_start);
    printf("size char: %d \n", sizeof(char));
    printf("size int: %d \n", sizeof(int));
    printf("size short: %d \n", sizeof(short));
    printf("size size_t: %d \n", sizeof(size_t));
    printf("size long: %d \n", sizeof(long));
    printf("size char*: %d \n", sizeof(char*));
*/
	monitor();
	
    return 0;
}

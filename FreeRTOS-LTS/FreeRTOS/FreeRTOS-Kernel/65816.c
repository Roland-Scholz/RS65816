#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#include "FreeRTOS.h"
#include "task.h"

char *ucHeapStack = (char *)0x0200;

volatile char* debug_char = (volatile char *) 0xfffff0;
volatile char* debug_hex  = (volatile char *) 0xfffff1;
volatile char* debug_reset  = (volatile char *) 0xfffff2;

const char *ansi_white = "\033[0m";
const char *ansi_red = "\033[31m";
const char *ansi_yellow = "\033[33;1m";
const char *ansi_clrhome = "\033[2J\033[H";

const HeapRegion_t xHeapRegions[] = 
{
    /* Region 1: Internes schnelles RAM (z.B. ab 0x20000000, Größe 64 KB) */
    { ( uint8_t * ) 0x020000, 0xffff }, 
    
    /* Region 2: Zweiter RAM-Block oder CCM-RAM (z.B. ab 0x30000000, Größe 128 KB) */
    { ( uint8_t * ) 0x030000, 0xffff }, 
    
    /* Region 3: Externes schnelles SDRAM (z.B. ab 0xD0000000, Größe 1 MB) */
    { ( uint8_t * ) 0x040000, 0xffff }, 
    
    /* Array-Terminierung: MUSS immer als letztes Element stehen! */
    { NULL, 0 } 
};

#asm
	;wdm 7
	clc
	xce
	rep #$30
	lda #$efff
	tcs
	phk
	plb
	jmp _~main
#endasm

#include "wdc_misc.h"

void vApplicationStackOverflowHook( TaskHandle_t xTask,
                                        char * pcTaskName ) {

}

void printHeapStats() {
	HeapStats_t pxHeapStats;
	
	vPortGetHeapStats(&pxHeapStats);
	printf("\n");
	printf("xAvailableHeapSpaceInBytes:%p\n", (void *)pxHeapStats.xAvailableHeapSpaceInBytes);
	printf("xSizeOfLargestFreeBlockInBytes:%04X\n", pxHeapStats.xSizeOfLargestFreeBlockInBytes);
	printf("xSizeOfSmallestFreeBlockInBytes:%04X\n", pxHeapStats.xSizeOfSmallestFreeBlockInBytes);
	printf("xNumberOfFreeBlocks:%04X\n", pxHeapStats.xNumberOfFreeBlocks);
	printf("xMinimumEverFreeBytesRemaining:%p\n", (void *)pxHeapStats.xMinimumEverFreeBytesRemaining);
	printf("xNumberOfSuccessfulAllocations:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulAllocations);
	printf("xNumberOfSuccessfulFrees:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulFrees);
}

void shellTask( void *pvParameters )
{
	char c = ' ';
	
	for(;;) {
		*debug_char = c;
		c++;
		if (c > 126) c = ' ';
	}
		
}

int main (int argc, char ** argv) {
	
	BaseType_t rc;
	HeapRegion_t reg;
	HeapRegion_t *pxHeapReg;
	char *p;
	int i;

	pxHeapReg = (HeapRegion_t *)pvPortMallocStack(sizeof(reg) * 100);
	printf("pxHeapReg:%p %u\n", pxHeapReg, sizeof(reg) * 100);
	
	reg.xSizeInBytes = 0x010000;
	
	for(i = 0; i < 99; i++) {
		reg.pucStartAddress = (char *)((i+2) * 0x010000U);
		pxHeapReg[i] = reg;
		
	}
	reg.pucStartAddress = NULL;
	reg.xSizeInBytes = 0;
	pxHeapReg[i] = reg;

	
	printf("*** RTOS main \n");
	printf("*** RTOS vPortHeapResetState \n");
	vPortHeapResetState();

	printf("*** RTOS vPortDefineHeapRegions \n");
	vPortDefineHeapRegions( pxHeapReg );
	
	vPortFreeStack(pxHeapReg);
	
	printHeapStats();
	
	rc = xTaskCreate( shellTask, "SHELL", 512, NULL, 0, NULL);
	printf("task create rc: %d\n", rc);
	
	
	if (rc != pdPASS) {
		printf("shell could not be created rc: %d\n", rc);
		return pdPASS;
	}

	/* Start the scheduler so the tasks start executing. */

	vTaskStartScheduler();

	/* If all is well then main() will never reach here as the scheduler will
	now be running the tasks. If main() does reach here then it is likely that
	there was insufficient heap memory available for the idle task to be created.
	Chapter 2 provides more information on heap memory management. */
	printf("Error starting RTOS scheduler\n");

	return pdFAIL;


/*	

	
	
	

#asm
;	WDM 0
#endasm
	
	for (;;) {
		p = pvPortMalloc(0x2000);
		printf("%p\n", p);
		if (p == NULL) break;
	}

	printHeapStats();


#asm
	WDM 8
#endasm
	for (;;) {}
*/	
}
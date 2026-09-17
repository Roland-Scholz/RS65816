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

typedef struct taskParm {
	char * taskName;
	TickType_t tickDelay;
} taskParm_t;


/*
const HeapRegion_t xHeapRegions[] = 
{
    { ( uint8_t * ) 0x020000, 0xffff }, 
    { ( uint8_t * ) 0x030000, 0xffff }, 
    { ( uint8_t * ) 0x040000, 0xffff },    
    { NULL, 0 } 
};
*/

#asm
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
	char *p;
	taskParm_t *taskParm = (taskParm_t *) pvParameters;
	
	for(;;) {
		/*
		for(p = taskParm->taskName; *p; p++) {
			*debug_char = *p;
		}
		*/
		printf("%s ", taskParm->taskName);
		fflush(stdout);
		vTaskDelay(taskParm->tickDelay);
	}

}

int main (int argc, char ** argv) {
	
	BaseType_t rc;
	HeapRegion_t reg;
	HeapRegion_t *pxHeapReg;
	TaskHandle_t * pxCreatedTask;
	taskParm_t taskParm_1, taskParm_2, taskParm_3;
	
	char *p;
	int i;

	//asm wdm 7;
	
	pxHeapReg = (HeapRegion_t *)pvPortMallocStack(sizeof(reg) * 100);
	printf("pxHeapReg:%p %u\n", pxHeapReg, sizeof(reg) * 100);
	
	//asm wdm 6;
	
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
	
	taskParm_1.taskName = "-";
	taskParm_1.tickDelay = 10;
	
	taskParm_2.taskName = "*";
	taskParm_2.tickDelay = 1;

	taskParm_3.taskName = "+";
	taskParm_3.tickDelay = 1;
	
	rc = xTaskCreate( shellTask, "Task1", 512, (void *) &taskParm_1, 0, NULL);	
	printf("task create rc: %d\n", rc);
	rc = xTaskCreate( shellTask, "Task2", 512, (void *) &taskParm_2, 0, NULL);	
	printf("task create rc: %d\n", rc);
	rc = xTaskCreate( shellTask, "Task3", 512, (void *) &taskParm_3, 1, NULL);	
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
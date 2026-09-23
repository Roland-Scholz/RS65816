#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#include "FreeRTOS.h"
#include "task.h"

#include "ff.h"

char *ucHeapStack = (char *)0x0200;

volatile char* debug_char = (volatile char *) 0xfffff0;
volatile char* debug_hex  = (volatile char *) 0xfffff1;
volatile char* debug_reset  = (volatile char *) 0xfffff2;

const char *ansi_white = "\033[0m";
const char *ansi_red = "\033[31m";
const char *ansi_yellow = "\033[33;1m";
const char *ansi_clrhome = "\033[2J\033[H";

typedef struct taskParm {
	char *taskName;
	char dataBank;
	void *taskAddr;
	TickType_t tickDelay;
} taskParm_t;

typedef union {
	void *ptr;
	struct {
		unsigned int addr;
		char bank;
		char dummy;
	} parts;
} ptrParts_t;

FATFS FatFs;		/* FatFs work area needed for each volume */
FIL Fil;			/* File object needed for each open file */

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

//#include "wdc_misc.h"

void vApplicationStackOverflowHook( TaskHandle_t xTask,
                                        char * pcTaskName ) {

}

void printHeapStats() {
	HeapStats_t pxHeapStats;
	
	vPortGetHeapStats(&pxHeapStats);
	printf("\n");
	printf("xAvailableHeapSpaceInBytes:%p\n", (void *)pxHeapStats.xAvailableHeapSpaceInBytes);
	printf("xSizeOfLargestFreeBlockInBytes:%04x\n", pxHeapStats.xSizeOfLargestFreeBlockInBytes);
	printf("xSizeOfSmallestFreeBlockInBytes:%04x\n", pxHeapStats.xSizeOfSmallestFreeBlockInBytes);
	printf("xNumberOfFreeBlocks:%04x\n", pxHeapStats.xNumberOfFreeBlocks);
	printf("xMinimumEverFreeBytesRemaining:%p\n", (void *)pxHeapStats.xMinimumEverFreeBytesRemaining);
	printf("xNumberOfSuccessfulAllocations:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulAllocations);
	printf("xNumberOfSuccessfulFrees:%p\n", (void *)pxHeapStats.xNumberOfSuccessfulFrees);
}

void shellTask( void *pvParameters )
{
	taskParm_t *taskParm = (taskParm_t *) pvParameters;
	char dataBank;
	unsigned int stackptr, direct;
	UINT bw;
	FRESULT fr;

	#asm
	sep #$20
	phb
	pla
	sta %%dataBank
	rep #$20
	tsc
	sta %%stackptr;
	tdc
	sta %%direct;
	#endasm
	
	printf("%s DB:%02X\n", taskParm->taskName, dataBank);

//	vTaskDelay(taskParm->tickDelay);



	f_mount(&FatFs, "", 0);		/* Give a work area to the default drive */

	fr = f_open(&Fil, "newfile.txt", FA_WRITE | FA_CREATE_ALWAYS);	/* Create a file */
	if (fr == FR_OK) {
		f_write(&Fil, "It works!\r\n", 11, &bw);	/* Write data to the file */
		fr = f_close(&Fil);							/* Close the file */
		if (fr == FR_OK && bw == 11) {		/* Lights green LED if data written well */
			//DDRB |= 0x10; PORTB |= 0x10;	/* Set PB4 high */
			printf("OK!\n");
		}
	}

	printf("task ended\n");
	for(;;)
		;

}

int main (int argc, char ** argv) {
	
	BaseType_t rc;
	HeapRegion_t reg;
	HeapRegion_t *pxHeapReg;
	TaskHandle_t * pxCreatedTask;
	taskParm_t taskParm_1, taskParm_2, taskParm_3;
	ptrParts_t pp;
	
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
	
	pp.ptr = shellTask;
	taskParm_1.dataBank = pp.parts.bank;
	taskParm_2.dataBank = pp.parts.bank;
	taskParm_3.dataBank = pp.parts.bank;
	
	taskParm_1.taskName = "task1";
	taskParm_1.taskAddr = shellTask;
	taskParm_1.tickDelay = 10;
	
	taskParm_2.taskName = "2";
	taskParm_2.taskAddr = shellTask;
	taskParm_2.tickDelay = 5;

	taskParm_3.taskName = "3";
	taskParm_3.taskAddr = shellTask;
	taskParm_3.tickDelay = 1;
	
	rc = xTaskCreate( taskParm_1.taskAddr, "Task1", 512, (void *) &taskParm_1, 0, NULL);	
	printf("task create rc: %d\n", rc);
	/*
	rc = xTaskCreate( taskParm_2.taskAddr, "Task2", 512, (void *) &taskParm_2, 0, NULL);	
	printf("task create rc: %d\n", rc);
	rc = xTaskCreate( taskParm_3.taskAddr, "Task3", 512, (void *) &taskParm_3, 0, NULL);	
	printf("task create rc: %d\n", rc);
	*/
	
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
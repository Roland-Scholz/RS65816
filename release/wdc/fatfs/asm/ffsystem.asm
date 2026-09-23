;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*------------------------------------------------------------------------*/
;/* A Sample Code of User Provided OS Dependent Functions for FatFs        */
;/*------------------------------------------------------------------------*/
;
;#include "ff.h"
;
;
;#if FF_USE_LFN == 3	/* Use dynamic memory allocation */
;
;/*------------------------------------------------------------------------*/
;/* Allocate/Free a Memory Block                                           */
;/*------------------------------------------------------------------------*/
;
;#include <stdlib.h>		/* with POSIX API */
;
;
;void* ff_memalloc (	/* Returns pointer to the allocated memory block (null if not enough core) */
;	UINT msize		/* Number of bytes to allocate */
;)
;{
;	return malloc((size_t)msize);	/* Allocate a new memory block */
;}
;
;
;void ff_memfree (
;	void* mblock	/* Pointer to the memory block to free (no effect if null) */
;)
;{
;	free(mblock);	/* Free the memory block */
;}
;
;#endif
;
;
;
;
;#if FF_FS_REENTRANT	/* Mutal exclusion */
;/*------------------------------------------------------------------------*/
;/* Definitions of Mutex                                                   */
;/*------------------------------------------------------------------------*/
;
;#define OS_TYPE	3	/* 0:Win32, 1:uITRON4.0, 2:uC/OS-II, 3:FreeRTOS, 4:CMSIS-RTOS */
;
;
;#if   OS_TYPE == 0	/* Win32 */
;#include <windows.h>
;static HANDLE Mutex[FF_VOLUMES + 1];	/* Table of mutex handle */
;
;#elif OS_TYPE == 1	/* uITRON */
;#include "itron.h"
;#include "kernel.h"
;static mtxid Mutex[FF_VOLUMES + 1];		/* Table of mutex ID */
;
;#elif OS_TYPE == 2	/* uc/OS-II */
;#include "includes.h"
;static OS_EVENT *Mutex[FF_VOLUMES + 1];	/* Table of mutex pinter */
;
;#elif OS_TYPE == 3	/* FreeRTOS */
;#include "FreeRTOS.h"
;#include "semphr.h"
;static SemaphoreHandle_t Mutex[FF_VOLUMES + 1];	/* Table of mutex handle */
;
;#elif OS_TYPE == 4	/* CMSIS-RTOS */
;#include "cmsis_os.h"
;static osMutexId Mutex[FF_VOLUMES + 1];	/* Table of mutex ID */
;
;#endif
;
;
;
;/*------------------------------------------------------------------------*/
;/* Create a Mutex                                                         */
;/*------------------------------------------------------------------------*/
;/* This function is called in f_mount function to create a new mutex
;/  or semaphore for the volume. When a 0 is returned, the f_mount function
;/  fails with FR_INT_ERR.
;*/
;
;int ff_mutex_create (	/* Returns 1:Function succeeded or 0:Could not create the mutex */
;	int vol				/* Mutex ID: Volume mutex (0 to FF_VOLUMES - 1) or system mutex (FF_VOLUMES) */
;)
;{
	code
	xdef	_~ff_mutex_create
	func
_~ff_mutex_create:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
vol_0	set	3
;#if OS_TYPE == 0	/* Win32 */
;	Mutex[vol] = CreateMutex(NULL, FALSE, NULL);
;	return (int)(Mutex[vol] != INVALID_HANDLE_VALUE);
;
;#elif OS_TYPE == 1	/* uITRON */
;	T_CMTX cmtx = {TA_TPRI,1};
;
;	Mutex[vol] = acre_mtx(&cmtx);
;	return (int)(Mutex[vol] > 0);
;
;#elif OS_TYPE == 2	/* uC/OS-II */
;	OS_ERR err;
;
;	Mutex[vol] = OSMutexCreate(0, &err);
;	return (int)(err == OS_NO_ERR);
;
;#elif OS_TYPE == 3	/* FreeRTOS */
;	Mutex[vol] = xSemaphoreCreateMutex();
	lda	<L2+vol_0
	asl	A
	asl	A
	clc
	adc	#<_~Mutex
	sta	<R1
	pea	#<$1
	jsr	_~xQueueCreateMutex
	sta	<R0
	stx	<R0+2
	sta	(<R1)
	lda	<R0+2
	ldy	#$2
	sta	(<R1),Y
;	return (int)(Mutex[vol] != NULL);
	stz	<R0
	lda	<L2+vol_0
	asl	A
	asl	A
	clc
	adc	#<_~Mutex
	sta	<R2
	lda	(<R2)
	ora	(<R2),Y
	beq	L4
	inc	<R0
L4:
	lda	<R0
	tay
	lda	<L2+1
	sta	<L2+1+2
	pld
	tsc
	clc
	adc	#L2+2
	tcs
	tya
	rts
;
;#elif OS_TYPE == 4	/* CMSIS-RTOS */
;	osMutexDef(cmsis_os_mutex);
;
;	Mutex[vol] = osMutexCreate(osMutex(cmsis_os_mutex));
;	return (int)(Mutex[vol] != NULL);
;
;#endif
;}
L2	equ	12
L3	equ	13
	ends
	efunc
;
;
;/*------------------------------------------------------------------------*/
;/* Delete a Mutex                                                         */
;/*------------------------------------------------------------------------*/
;/* This function is called in f_mount function to delete a mutex or
;/  semaphore of the volume created with ff_mutex_create function.
;*/
;
;void ff_mutex_delete (	/* Returns 1:Function succeeded or 0:Could not delete due to an error */
;	int vol				/* Mutex ID: Volume mutex (0 to FF_VOLUMES - 1) or system mutex (FF_VOLUMES) */
;)
;{
	code
	xdef	_~ff_mutex_delete
	func
_~ff_mutex_delete:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
vol_0	set	3
;#if OS_TYPE == 0	/* Win32 */
;	CloseHandle(Mutex[vol]);
;
;#elif OS_TYPE == 1	/* uITRON */
;	del_mtx(Mutex[vol]);
;
;#elif OS_TYPE == 2	/* uC/OS-II */
;	OS_ERR err;
;
;	OSMutexDel(Mutex[vol], OS_DEL_ALWAYS, &err);
;
;#elif OS_TYPE == 3	/* FreeRTOS */
;	vSemaphoreDelete(Mutex[vol]);
	lda	<L7+vol_0
	asl	A
	asl	A
	clc
	adc	#<_~Mutex
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsr	_~vQueueDelete
;
;#elif OS_TYPE == 4	/* CMSIS-RTOS */
;	osMutexDelete(Mutex[vol]);
;
;#endif
;}
	lda	<L7+1
	sta	<L7+1+2
	pld
	tsc
	clc
	adc	#L7+2
	tcs
	rts
L7	equ	8
L8	equ	9
	ends
	efunc
;
;
;/*------------------------------------------------------------------------*/
;/* Request a Grant to Access the Volume                                   */
;/*------------------------------------------------------------------------*/
;/* This function is called on enter file functions to lock the volume.
;/  When a 0 is returned, the file function fails with FR_TIMEOUT.
;*/
;
;int ff_mutex_take (	/* Returns 1:Succeeded or 0:Timeout */
;	int vol			/* Mutex ID: Volume mutex (0 to FF_VOLUMES - 1) or system mutex (FF_VOLUMES) */
;)
;{
	code
	xdef	_~ff_mutex_take
	func
_~ff_mutex_take:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
vol_0	set	3
;#if OS_TYPE == 0	/* Win32 */
;	return (int)(WaitForSingleObject(Mutex[vol], FF_FS_TIMEOUT) == WAIT_OBJECT_0);
;
;#elif OS_TYPE == 1	/* uITRON */
;	return (int)(tloc_mtx(Mutex[vol], FF_FS_TIMEOUT) == E_OK);
;
;#elif OS_TYPE == 2	/* uC/OS-II */
;	OS_ERR err;
;
;	OSMutexPend(Mutex[vol], FF_FS_TIMEOUT, &err));
;	return (int)(err == OS_NO_ERR);
;
;#elif OS_TYPE == 3	/* FreeRTOS */
;	return (int)(xSemaphoreTake(Mutex[vol], FF_FS_TIMEOUT) == pdTRUE);
	stz	<R0
	pea	#^$3e8
	pea	#<$3e8
	lda	<L10+vol_0
	asl	A
	asl	A
	clc
	adc	#<_~Mutex
	sta	<R2
	ldy	#$2
	lda	(<R2),Y
	pha
	lda	(<R2)
	pha
	jsr	_~xQueueSemaphoreTake
	cmp	#<$1
	bne	L12
	inc	<R0
L12:
	lda	<R0
	tay
	lda	<L10+1
	sta	<L10+1+2
	pld
	tsc
	clc
	adc	#L10+2
	tcs
	tya
	rts
;
;#elif OS_TYPE == 4	/* CMSIS-RTOS */
;	return (int)(osMutexWait(Mutex[vol], FF_FS_TIMEOUT) == osOK);
;
;#endif
;}
L10	equ	12
L11	equ	13
	ends
	efunc
;
;
;
;/*------------------------------------------------------------------------*/
;/* Release a Grant to Access the Volume                                   */
;/*------------------------------------------------------------------------*/
;/* This function is called on leave file functions to unlock the volume.
;*/
;
;void ff_mutex_give (
;	int vol			/* Mutex ID: Volume mutex (0 to FF_VOLUMES - 1) or system mutex (FF_VOLUMES) */
;)
;{
	code
	xdef	_~ff_mutex_give
	func
_~ff_mutex_give:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L15
	tcs
	phd
	tcd
vol_0	set	3
;#if OS_TYPE == 0	/* Win32 */
;	ReleaseMutex(Mutex[vol]);
;
;#elif OS_TYPE == 1	/* uITRON */
;	unl_mtx(Mutex[vol]);
;
;#elif OS_TYPE == 2	/* uC/OS-II */
;	OSMutexPost(Mutex[vol]);
;
;#elif OS_TYPE == 3	/* FreeRTOS */
;	xSemaphoreGive(Mutex[vol]);
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	lda	<L15+vol_0
	asl	A
	asl	A
	clc
	adc	#<_~Mutex
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsr	_~xQueueGenericSend
;
;#elif OS_TYPE == 4	/* CMSIS-RTOS */
;	osMutexRelease(Mutex[vol]);
;
;#endif
;}
	lda	<L15+1
	sta	<L15+1+2
	pld
	tsc
	clc
	adc	#L15+2
	tcs
	rts
L15	equ	8
L16	equ	9
	ends
	efunc
;
;#endif	/* FF_FS_REENTRANT */
;
;
	xref	_~xQueueSemaphoreTake
	xref	_~xQueueCreateMutex
	xref	_~vQueueDelete
	xref	_~xQueueGenericSend
	udata
_~Mutex
	ds	8
	ends

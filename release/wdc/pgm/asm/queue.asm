;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*
; * FreeRTOS Kernel V11.3.1
; * Copyright (C) 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
; *
; * SPDX-License-Identifier: MIT
; *
; * Permission is hereby granted, free of charge, to any person obtaining a copy of
; * this software and associated documentation files (the "Software"), to deal in
; * the Software without restriction, including without limitation the rights to
; * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
; * the Software, and to permit persons to whom the Software is furnished to do so,
; * subject to the following conditions:
; *
; * The above copyright notice and this permission notice shall be included in all
; * copies or substantial portions of the Software.
; *
; * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
; * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
; * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
; * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
; * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
; *
; * https://www.FreeRTOS.org
; * https://github.com/FreeRTOS
; *
; */
;
;#include <stdlib.h>
;#include <string.h>
;
;/* Defining MPU_WRAPPERS_INCLUDED_FROM_API_FILE prevents task.h from redefining
; * all the API functions to use the MPU wrappers.  That should only be done when
; * task.h is included from an application file. */
;#define MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;#include "FreeRTOS.h"
;#include "task.h"
;#include "queue.h"
;
;#if ( configUSE_CO_ROUTINES == 1 )
;    #include "croutine.h"
;#endif
;
;/* The MPU ports require MPU_WRAPPERS_INCLUDED_FROM_API_FILE to be defined
; * for the header files above, but not in this file, in order to generate the
; * correct privileged Vs unprivileged linkage and placement. */
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;
;/* Constants used with the cRxLock and cTxLock structure members. */
;#define queueUNLOCKED             ( ( int8_t ) -1 )
;#define queueLOCKED_UNMODIFIED    ( ( int8_t ) 0 )
;#define queueINT8_MAX             ( ( int8_t ) 127 )
;
;/* When the Queue_t structure is used to represent a base queue its pcHead and
; * pcTail members are used as pointers into the queue storage area.  When the
; * Queue_t structure is used to represent a mutex pcHead and pcTail pointers are
; * not necessary, and the pcHead pointer is set to NULL to indicate that the
; * structure instead holds a pointer to the mutex holder (if any).  Map alternative
; * names to the pcHead and structure member to ensure the readability of the code
; * is maintained.  The QueuePointers_t and SemaphoreData_t types are used to form
; * a union as their usage is mutually exclusive dependent on what the queue is
; * being used for. */
;#define uxQueueType               pcHead
;#define queueQUEUE_IS_MUTEX       NULL
;
;typedef struct QueuePointers
;{
;    int8_t * pcTail;     /**< Points to the byte at the end of the queue storage area.  Once more byte is allocated than necessary to store the queue items, this is used as a marker. */
;    int8_t * pcReadFrom; /**< Points to the last place that a queued item was read from when the structure is used as a queue. */
;} QueuePointers_t;
;
;typedef struct SemaphoreData
;{
;    TaskHandle_t xMutexHolder;        /**< The handle of the task that holds the mutex. */
;    UBaseType_t uxRecursiveCallCount; /**< Maintains a count of the number of times a recursive mutex has been recursively 'taken' when the structure is used as a mutex. */
;} SemaphoreData_t;
;
;/* Semaphores do not actually store or copy data, so have an item size of
; * zero. */
;#define queueSEMAPHORE_QUEUE_ITEM_LENGTH    ( ( UBaseType_t ) 0 )
;#define queueMUTEX_GIVE_BLOCK_TIME          ( ( TickType_t ) 0U )
;
;#if ( configUSE_PREEMPTION == 0 )
;
;/* If the cooperative scheduler is being used then a yield should not be
; * performed just because a higher priority task has been woken. */
;    #define queueYIELD_IF_USING_PREEMPTION()
;#else
;    #if ( configNUMBER_OF_CORES == 1 )
;        #define queueYIELD_IF_USING_PREEMPTION()    portYIELD_WITHIN_API()
;    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;        #define queueYIELD_IF_USING_PREEMPTION()    vTaskYieldWithinAPI()
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;#endif
;
;/*
; * Definition of the queue used by the scheduler.
; * Items are queued by copy, not reference.  See the following link for the
; * rationale: https://www.FreeRTOS.org/Embedded-RTOS-Queues.html
; */
;typedef struct QueueDefinition /* The old naming convention is used to prevent breaking kernel aware debuggers. */
;{
;    int8_t * pcHead;           /**< Points to the beginning of the queue storage area. */
;    int8_t * pcWriteTo;        /**< Points to the free next place in the storage area. */
;
;    union
;    {
;        QueuePointers_t xQueue;     /**< Data required exclusively when this structure is used as a queue. */
;        SemaphoreData_t xSemaphore; /**< Data required exclusively when this structure is used as a semaphore. */
;    } u;
;
;    List_t xTasksWaitingToSend;             /**< List of tasks that are blocked waiting to post onto this queue.  Stored in priority order. */
;    List_t xTasksWaitingToReceive;          /**< List of tasks that are blocked waiting to read from this queue.  Stored in priority order. */
;
;    volatile UBaseType_t uxMessagesWaiting; /**< The number of items currently in the queue. */
;    UBaseType_t uxLength;                   /**< The length of the queue defined as the number of items it will hold, not the number of bytes. */
;    UBaseType_t uxItemSize;                 /**< The size of each items that the queue will hold. */
;
;    volatile int8_t cRxLock;                /**< Stores the number of items received from the queue (removed from the queue) while the queue was locked.  Set to queueUNLOCKED when the queue is not locked. */
;    volatile int8_t cTxLock;                /**< Stores the number of items transmitted to the queue (added to the queue) while the queue was locked.  Set to queueUNLOCKED when the queue is not locked. */
;
;    #if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;        uint8_t ucStaticallyAllocated; /**< Set to pdTRUE if the memory used by the queue was statically allocated to ensure no attempt is made to free the memory. */
;    #endif
;
;    #if ( configUSE_QUEUE_SETS == 1 )
;        struct QueueDefinition * pxQueueSetContainer;
;    #endif
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;        UBaseType_t uxQueueNumber;
;        uint8_t ucQueueType;
;    #endif
;} xQUEUE;
;
;/* The old xQUEUE name is maintained above then typedefed to the new Queue_t
; * name below to enable the use of older kernel aware debuggers. */
;typedef xQUEUE Queue_t;
;
;/*-----------------------------------------------------------*/
;
;/*
; * The queue registry is just a means for kernel aware debuggers to locate
; * queue structures.  It has no other purpose so is an optional component.
; */
;#if ( configQUEUE_REGISTRY_SIZE > 0 )
;
;/* The type stored within the queue registry array.  This allows a name
; * to be assigned to each queue making kernel aware debugging a little
; * more user friendly. */
;    typedef struct QUEUE_REGISTRY_ITEM
;    {
;        const char * pcQueueName;
;        QueueHandle_t xHandle;
;    } xQueueRegistryItem;
;
;/* The old xQueueRegistryItem name is maintained above then typedefed to the
; * new xQueueRegistryItem name below to enable the use of older kernel aware
; * debuggers. */
;    typedef xQueueRegistryItem QueueRegistryItem_t;
;
;/* The queue registry is simply an array of QueueRegistryItem_t structures.
; * The pcQueueName member of a structure being NULL is indicative of the
; * array position being vacant. */
;
;/* MISRA Ref 8.4.2 [Declaration shall be visible] */
;/* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-84 */
;/* coverity[misra_c_2012_rule_8_4_violation] */
;    PRIVILEGED_DATA QueueRegistryItem_t xQueueRegistry[ configQUEUE_REGISTRY_SIZE ];
;
;#endif /* configQUEUE_REGISTRY_SIZE */
;
;/*
; * Unlocks a queue locked by a call to prvLockQueue.  Locking a queue does not
; * prevent an ISR from adding or removing items to the queue, but does prevent
; * an ISR from removing tasks from the queue event lists.  If an ISR finds a
; * queue is locked it will instead increment the appropriate queue lock count
; * to indicate that a task may require unblocking.  When the queue in unlocked
; * these lock counts are inspected, and the appropriate action taken.
; */
;static void prvUnlockQueue( Queue_t * const pxQueue ) PRIVILEGED_FUNCTION;
;
;/*
; * Uses a critical section to determine if there is any data in a queue.
; *
; * @return pdTRUE if the queue contains no items, otherwise pdFALSE.
; */
;static BaseType_t prvIsQueueEmpty( const Queue_t * pxQueue ) PRIVILEGED_FUNCTION;
;
;/*
; * Uses a critical section to determine if there is any space in a queue.
; *
; * @return pdTRUE if there is no space, otherwise pdFALSE;
; */
;static BaseType_t prvIsQueueFull( const Queue_t * pxQueue ) PRIVILEGED_FUNCTION;
;
;/*
; * Copies an item into the queue, either at the front of the queue or the
; * back of the queue.
; */
;static BaseType_t prvCopyDataToQueue( Queue_t * const pxQueue,
;                                      const void * pvItemToQueue,
;                                      const BaseType_t xPosition ) PRIVILEGED_FUNCTION;
;
;/*
; * Copies an item out of a queue.
; */
;static void prvCopyDataFromQueue( Queue_t * const pxQueue,
;                                  void * const pvBuffer ) PRIVILEGED_FUNCTION;
;
;#if ( configUSE_QUEUE_SETS == 1 )
;
;/*
; * Checks to see if a queue is a member of a queue set, and if so, notifies
; * the queue set that the queue contains data.
; */
;    static BaseType_t prvNotifyQueueSetContainer( const Queue_t * const pxQueue ) PRIVILEGED_FUNCTION;
;#endif
;
;/*
; * Called after a Queue_t structure has been allocated either statically or
; * dynamically to fill in the structure's members.
; */
;static void prvInitialiseNewQueue( const UBaseType_t uxQueueLength,
;                                   const UBaseType_t uxItemSize,
;                                   uint8_t * pucQueueStorage,
;                                   const uint8_t ucQueueType,
;                                   Queue_t * pxNewQueue ) PRIVILEGED_FUNCTION;
;
;/*
; * Mutexes are a special type of queue.  When a mutex is created, first the
; * queue is created, then prvInitialiseMutex() is called to configure the queue
; * as a mutex.
; */
;#if ( configUSE_MUTEXES == 1 )
;    static void prvInitialiseMutex( Queue_t * pxNewQueue ) PRIVILEGED_FUNCTION;
;#endif
;
;#if ( configUSE_MUTEXES == 1 )
;
;/*
; * If a task waiting for a mutex causes the mutex holder to inherit a
; * priority, but the waiting task times out, then the holder should
; * disinherit the priority - but only down to the highest priority of any
; * other tasks that are waiting for the same mutex.  This function returns
; * that priority.
; */
;    static UBaseType_t prvGetHighestPriorityOfWaitToReceiveList( const Queue_t * const pxQueue ) PRIVILEGED_FUNCTION;
;#endif
;/*-----------------------------------------------------------*/
;
;/*
; * Macro to mark a queue as locked.  Locking a queue prevents an ISR from
; * accessing the queue event lists.
; */
;#define prvLockQueue( pxQueue )                            \
;    taskENTER_CRITICAL();                                  \
;    {                                                      \
;        if( ( pxQueue )->cRxLock == queueUNLOCKED )        \
;        {                                                  \
;            ( pxQueue )->cRxLock = queueLOCKED_UNMODIFIED; \
;        }                                                  \
;        if( ( pxQueue )->cTxLock == queueUNLOCKED )        \
;        {                                                  \
;            ( pxQueue )->cTxLock = queueLOCKED_UNMODIFIED; \
;        }                                                  \
;    }                                                      \
;    taskEXIT_CRITICAL()
;
;/*
; * Macro to increment cTxLock member of the queue data structure. It is
; * capped at the number of tasks in the system as we cannot unblock more
; * tasks than the number of tasks in the system.
; */
;#define prvIncrementQueueTxLock( pxQueue, cTxLock )                           \
;    do {                                                                      \
;        const UBaseType_t uxNumberOfTasks = uxTaskGetNumberOfTasks();         \
;        if( ( UBaseType_t ) ( cTxLock ) < uxNumberOfTasks )                   \
;        {                                                                     \
;            configASSERT( ( cTxLock ) != queueINT8_MAX );                     \
;            ( pxQueue )->cTxLock = ( int8_t ) ( ( cTxLock ) + ( int8_t ) 1 ); \
;        }                                                                     \
;    } while( 0 )
;
;/*
; * Macro to increment cRxLock member of the queue data structure. It is
; * capped at the number of tasks in the system as we cannot unblock more
; * tasks than the number of tasks in the system.
; */
;#define prvIncrementQueueRxLock( pxQueue, cRxLock )                           \
;    do {                                                                      \
;        const UBaseType_t uxNumberOfTasks = uxTaskGetNumberOfTasks();         \
;        if( ( UBaseType_t ) ( cRxLock ) < uxNumberOfTasks )                   \
;        {                                                                     \
;            configASSERT( ( cRxLock ) != queueINT8_MAX );                     \
;            ( pxQueue )->cRxLock = ( int8_t ) ( ( cRxLock ) + ( int8_t ) 1 ); \
;        }                                                                     \
;    } while( 0 )
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueGenericReset( QueueHandle_t xQueue,
;                               BaseType_t xNewQueue )
;{
	code
	xdef	_~xQueueGenericReset
	func
_~xQueueGenericReset:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
xQueue_0	set	3
xNewQueue_0	set	7
;    BaseType_t xReturn = pdPASS;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueGenericReset( xQueue, xNewQueue );
xReturn_1	set	0
pxQueue_1	set	2
	lda	#$1
	sta	<L3+xReturn_1
	lda	<L2+xQueue_0
	sta	<L3+pxQueue_1
	lda	<L2+xQueue_0+2
	sta	<L3+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L3+pxQueue_1
	ora	<L3+pxQueue_1+2
	bne	L10001
L10005:
	bra	L10005
L10001:
;
;    if( ( pxQueue != NULL ) &&
;        ( pxQueue->uxLength >= 1U ) &&
;        /* Check for multiplication overflow. */
;        ( ( SIZE_MAX / pxQueue->uxLength ) >= pxQueue->uxItemSize ) )
;    {
	lda	<L3+pxQueue_1
	ora	<L3+pxQueue_1+2
	bne	*+5
	brl	L10008
	ldy	#$36
	lda	[<L3+pxQueue_1],Y
	cmp	#<$1
	bcs	*+5
	brl	L10008
	iny
	iny
	lda	[<L3+pxQueue_1],Y
	sta	<R0
	stz	<R0+2
	dey
	dey
	lda	[<L3+pxQueue_1],Y
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pea	#^$ffff
	pea	#<$ffff
	xref	_~~ldiv
	jsr	_~~ldiv
	sta	<R1
	stx	<R1+2
	sec
	lda	<R1
	sbc	<R0
	lda	<R1+2
	sbc	<R0+2
	bvs	L7
	eor	#$8000
L7:
	bmi	*+5
	brl	L10008
;        taskENTER_CRITICAL();
;        {
;            pxQueue->u.xQueue.pcTail = pxQueue->pcHead + ( pxQueue->uxLength * pxQueue->uxItemSize );
	ldy	#$38
	lda	[<L3+pxQueue_1],Y
	tax
	dey
	dey
	lda	[<L3+pxQueue_1],Y
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	stz	<R0+2
	lda	[<L3+pxQueue_1]
	clc
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	[<L3+pxQueue_1],Y
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$8
	sta	[<L3+pxQueue_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L3+pxQueue_1],Y
;            pxQueue->uxMessagesWaiting = ( UBaseType_t ) 0U;
	lda	#$0
	ldy	#$34
	sta	[<L3+pxQueue_1],Y
;            pxQueue->pcWriteTo = pxQueue->pcHead;
	lda	[<L3+pxQueue_1]
	ldy	#$4
	sta	[<L3+pxQueue_1],Y
	dey
	dey
	lda	[<L3+pxQueue_1],Y
	ldy	#$6
	sta	[<L3+pxQueue_1],Y
;            pxQueue->u.xQueue.pcReadFrom = pxQueue->pcHead + ( ( pxQueue->uxLength - 1U ) * pxQueue->uxItemSize );
	clc
	lda	#$ffff
	ldy	#$36
	adc	[<L3+pxQueue_1],Y
	sta	<R0
	iny
	iny
	lda	[<L3+pxQueue_1],Y
	tax
	lda	<R0
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	stz	<R0+2
	lda	[<L3+pxQueue_1]
	clc
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	[<L3+pxQueue_1],Y
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$c
	sta	[<L3+pxQueue_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L3+pxQueue_1],Y
;            pxQueue->cRxLock = queueUNLOCKED;
	sep	#$20
	longa	off
	lda	#$ff
	ldy	#$3a
	sta	[<L3+pxQueue_1],Y
;            pxQueue->cTxLock = queueUNLOCKED;
	iny
	sta	[<L3+pxQueue_1],Y
	rep	#$20
	longa	on
;
;            if( xNewQueue == pdFALSE )
;            {
	lda	<L2+xNewQueue_0
	bne	L10012
;                /* If there are tasks blocked waiting to read from the queue, then
;                 * the tasks will remain blocked as after this function exits the queue
;                 * will still be empty.  If there are tasks blocked waiting to write to
;                 * the queue, then one should be unblocked as after this function exits
;                 * it will be possible to write to it. */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;                {
	ldy	#$10
	lda	[<L3+pxQueue_1],Y
	bne	L10
	lda	#$1
	bra	L12
L10:
	lda	#$0
L12:
	tax
	bne	L10021
;                    if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                    {
	lda	#$10
	clc
	adc	<L3+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L3+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10021
;                        queueYIELD_IF_USING_PREEMPTION();
	jsr	_~vPortYield
;                    }
;                    else
;            }
;            else
	bra	L10021
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10012:
;            {
;                /* Ensure the event queues start in the correct state. */
;                vListInitialise( &( pxQueue->xTasksWaitingToSend ) );
	lda	#$10
	clc
	adc	<L3+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L3+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vListInitialise
;                vListInitialise( &( pxQueue->xTasksWaitingToReceive ) );
	lda	#$22
	clc
	adc	<L3+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L3+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vListInitialise
;            }
;        }
;        taskEXIT_CRITICAL();
;    }
;    else
	bra	L10021
L10008:
;    {
;        xReturn = pdFAIL;
	stz	<L3+xReturn_1
;    }
L10021:
;
;    configASSERT( xReturn != pdFAIL );
	lda	<L3+xReturn_1
	bne	L10022
L10026:
	bra	L10026
L10022:
;
;    /* A value is returned for calling semantic consistency with previous
;     * versions. */
;    traceRETURN_xQueueGenericReset( xReturn );
;
;    return xReturn;
	lda	<L3+xReturn_1
	tay
	lda	<L2+1
	sta	<L2+1+6
	pld
	tsc
	clc
	adc	#L2+6
	tcs
	tya
	rts
;}
L2	equ	14
L3	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;    QueueHandle_t xQueueGenericCreateStatic( const UBaseType_t uxQueueLength,
;                                             const UBaseType_t uxItemSize,
;                                             uint8_t * pucQueueStorage,
;                                             StaticQueue_t * pxStaticQueue,
;                                             const uint8_t ucQueueType )
;    {
	code
	xdef	_~xQueueGenericCreateStatic
	func
_~xQueueGenericCreateStatic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
uxQueueLength_0	set	3
uxItemSize_0	set	5
pucQueueStorage_0	set	7
pxStaticQueue_0	set	11
ucQueueType_0	set	15
;        Queue_t * pxNewQueue = NULL;
;
;        traceENTER_xQueueGenericCreateStatic( uxQueueLength, uxItemSize, pucQueueStorage, pxStaticQueue, ucQueueType );
pxNewQueue_1	set	0
	stz	<L18+pxNewQueue_1
	stz	<L18+pxNewQueue_1+2
;
;        /* The StaticQueue_t structure and the queue storage area must be
;         * supplied. */
;        configASSERT( pxStaticQueue );
	lda	<L17+pxStaticQueue_0
	ora	<L17+pxStaticQueue_0+2
	bne	L10029
L10033:
	bra	L10033
L10029:
;
;        if( ( uxQueueLength > ( UBaseType_t ) 0 ) &&
;            ( pxStaticQueue != NULL ) &&
;
;            /* A queue storage area should be provided if the item size is not 0, and
;             * should not be provided if the item size is 0. */
;            ( !( ( pucQueueStorage != NULL ) && ( uxItemSize == 0U ) ) ) &&
;            ( !( ( pucQueueStorage == NULL ) && ( uxItemSize != 0U ) ) ) )
;        {
	lda	#$0
	cmp	<L17+uxQueueLength_0
	bcs	L10036
	lda	<L17+pxStaticQueue_0
	ora	<L17+pxStaticQueue_0+2
	beq	L10036
	lda	<L17+pucQueueStorage_0
	ora	<L17+pucQueueStorage_0+2
	beq	L22
	lda	<L17+uxItemSize_0
	beq	L10036
L22:
	lda	<L17+pucQueueStorage_0
	ora	<L17+pucQueueStorage_0+2
	bne	L25
	lda	<L17+uxItemSize_0
	bne	L10036
L25:
;            #if ( configASSERT_DEFINED == 1 )
;            {
;                /* Sanity check that the size of the structure used to declare a
;                 * variable of type StaticQueue_t or StaticSemaphore_t equals the size of
;                 * the real queue and semaphore structures. */
;                volatile size_t xSize = sizeof( StaticQueue_t );
;
;                /* This assertion cannot be branch covered in unit tests */
;                configASSERT( xSize == sizeof( Queue_t ) ); /* LCOV_EXCL_BR_LINE */
xSize_2	set	4
	lda	#$3d
	sta	<L18+xSize_2
	cmp	#<$3d
	beq	L10037
L10041:
	bra	L10041
L10037:
;                ( void ) xSize;                             /* Prevent unused variable warning when configASSERT() is not defined. */
;            }
;            #endif /* configASSERT_DEFINED */
;
;            /* The address of a statically allocated queue was passed in, use it.
;             * The address of a statically allocated storage area was also passed in
;             * but is already set. */
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            pxNewQueue = ( Queue_t * ) pxStaticQueue;
	lda	<L17+pxStaticQueue_0
	sta	<L18+pxNewQueue_1
	lda	<L17+pxStaticQueue_0+2
	sta	<L18+pxNewQueue_1+2
;
;            #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;            {
;                /* Queues can be allocated either statically or dynamically, so
;                 * note this queue was allocated statically in case the queue is
;                 * later deleted. */
;                pxNewQueue->ucStaticallyAllocated = pdTRUE;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$3c
	sta	[<L18+pxNewQueue_1],Y
	rep	#$20
	longa	on
;            }
;            #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;
;            prvInitialiseNewQueue( uxQueueLength, uxItemSize, pucQueueStorage, ucQueueType, pxNewQueue );
	pei	<L18+pxNewQueue_1+2
	pei	<L18+pxNewQueue_1
	pei	<L17+ucQueueType_0
	pei	<L17+pucQueueStorage_0+2
	pei	<L17+pucQueueStorage_0
	pei	<L17+uxItemSize_0
	pei	<L17+uxQueueLength_0
	jsr	_~prvInitialiseNewQueue
;        }
;        else
L10044:
;
;        traceRETURN_xQueueGenericCreateStatic( pxNewQueue );
;
;        return pxNewQueue;
	ldx	<L18+pxNewQueue_1+2
	lda	<L18+pxNewQueue_1
	tay
	lda	<L17+1
	sta	<L17+1+14
	pld
	tsc
	clc
	adc	#L17+14
	tcs
	tya
	rts
L10036:
;        {
;            configASSERT( pxNewQueue );
	lda	<L18+pxNewQueue_1
	ora	<L18+pxNewQueue_1+2
	bne	L10044
L10049:
	bra	L10049
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L17	equ	6
L18	equ	1
	ends
	efunc
;
;#endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;#if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;    BaseType_t xQueueGenericGetStaticBuffers( QueueHandle_t xQueue,
;                                              uint8_t ** ppucQueueStorage,
;                                              StaticQueue_t ** ppxStaticQueue )
;    {
	code
	xdef	_~xQueueGenericGetStaticBuffers
	func
_~xQueueGenericGetStaticBuffers:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L31
	tcs
	phd
	tcd
xQueue_0	set	3
ppucQueueStorage_0	set	7
ppxStaticQueue_0	set	11
;        BaseType_t xReturn;
;        Queue_t * const pxQueue = xQueue;
;
;        traceENTER_xQueueGenericGetStaticBuffers( xQueue, ppucQueueStorage, ppxStaticQueue );
xReturn_1	set	0
pxQueue_1	set	2
	lda	<L31+xQueue_0
	sta	<L32+pxQueue_1
	lda	<L31+xQueue_0+2
	sta	<L32+pxQueue_1+2
;
;        configASSERT( pxQueue );
	lda	<L32+pxQueue_1
	ora	<L32+pxQueue_1+2
	bne	L10052
L10056:
	bra	L10056
L10052:
;        configASSERT( ppxStaticQueue );
	lda	<L31+ppxStaticQueue_0
	ora	<L31+ppxStaticQueue_0+2
	bne	L10059
L10063:
	bra	L10063
L10059:
;
;        #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;        {
;            /* Check if the queue was statically allocated. */
;            if( pxQueue->ucStaticallyAllocated == ( uint8_t ) pdTRUE )
;            {
	sep	#$20
	longa	off
	ldy	#$3c
	lda	[<L32+pxQueue_1],Y
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10066
;                if( ppucQueueStorage != NULL )
;                {
	lda	<L31+ppucQueueStorage_0
	ora	<L31+ppucQueueStorage_0+2
	beq	L10067
;                    *ppucQueueStorage = ( uint8_t * ) pxQueue->pcHead;
	lda	[<L32+pxQueue_1]
	sta	[<L31+ppucQueueStorage_0]
	ldy	#$2
	lda	[<L32+pxQueue_1],Y
	sta	[<L31+ppucQueueStorage_0],Y
;                }
;
;                /* MISRA Ref 11.3.1 [Misaligned access] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;                /* coverity[misra_c_2012_rule_11_3_violation] */
;                *ppxStaticQueue = ( StaticQueue_t * ) pxQueue;
L10067:
	lda	<L32+pxQueue_1
	sta	[<L31+ppxStaticQueue_0]
	lda	<L32+pxQueue_1+2
	ldy	#$2
	sta	[<L31+ppxStaticQueue_0],Y
;                xReturn = pdTRUE;
	lda	#$1
	sta	<L32+xReturn_1
;            }
;            else
	bra	L10068
L10066:
;            {
;                xReturn = pdFALSE;
	stz	<L32+xReturn_1
;            }
L10068:
;        }
;        #else /* configSUPPORT_DYNAMIC_ALLOCATION */
;        {
;            /* Queue must have been statically allocated. */
;            if( ppucQueueStorage != NULL )
;            {
;                *ppucQueueStorage = ( uint8_t * ) pxQueue->pcHead;
;            }
;
;            *ppxStaticQueue = ( StaticQueue_t * ) pxQueue;
;            xReturn = pdTRUE;
;        }
;        #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;
;        traceRETURN_xQueueGenericGetStaticBuffers( xReturn );
;
;        return xReturn;
	lda	<L32+xReturn_1
	tay
	lda	<L31+1
	sta	<L31+1+12
	pld
	tsc
	clc
	adc	#L31+12
	tcs
	tya
	rts
;    }
L31	equ	6
L32	equ	1
	ends
	efunc
;
;#endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;#if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;
;    QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength,
;                                       const UBaseType_t uxItemSize,
;                                       const uint8_t ucQueueType )
;    {
	code
	xdef	_~xQueueGenericCreate
	func
_~xQueueGenericCreate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L38
	tcs
	phd
	tcd
uxQueueLength_0	set	3
uxItemSize_0	set	5
ucQueueType_0	set	7
;        Queue_t * pxNewQueue = NULL;
;        size_t xQueueSizeInBytes;
;        uint8_t * pucQueueStorage;
;
;        traceENTER_xQueueGenericCreate( uxQueueLength, uxItemSize, ucQueueType );
pxNewQueue_1	set	0
xQueueSizeInBytes_1	set	4
pucQueueStorage_1	set	6
	stz	<L39+pxNewQueue_1
	stz	<L39+pxNewQueue_1+2
;
;        if( ( uxQueueLength > ( UBaseType_t ) 0 ) &&
;            /* Check for multiplication overflow. */
;            ( ( SIZE_MAX / uxQueueLength ) >= uxItemSize ) &&
;            /* Check for addition overflow. */
;            /* MISRA Ref 14.3.1 [Configuration dependent invariant] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-143. */
;            /* coverity[misra_c_2012_rule_14_3_violation] */
;            ( ( SIZE_MAX - sizeof( Queue_t ) ) >= ( size_t ) ( ( size_t ) uxQueueLength * ( size_t ) uxItemSize ) ) )
;        {
	lda	#$0
	cmp	<L38+uxQueueLength_0
	bcc	*+5
	brl	L10069
	lda	<L38+uxItemSize_0
	sta	<R0
	stz	<R0+2
	lda	<L38+uxQueueLength_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pea	#^$ffff
	pea	#<$ffff
	xref	_~~ldiv
	jsr	_~~ldiv
	sta	<R1
	stx	<R1+2
	sec
	lda	<R1
	sbc	<R0
	lda	<R1+2
	sbc	<R0+2
	bvs	L41
	eor	#$8000
L41:
	bpl	L10069
	lda	<L38+uxQueueLength_0
	ldx	<L38+uxItemSize_0
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	stz	<R0+2
	sec
	lda	#$ffc2
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L43
	eor	#$8000
L43:
	bpl	L10069
;            /* Allocate enough space to hold the maximum number of items that
;             * can be in the queue at any time.  It is valid for uxItemSize to be
;             * zero in the case the queue is used as a semaphore. */
;            xQueueSizeInBytes = ( size_t ) ( ( size_t ) uxQueueLength * ( size_t ) uxItemSize );
	lda	<L38+uxQueueLength_0
	ldx	<L38+uxItemSize_0
	xref	_~~mul
	jsr	_~~mul
	sta	<L39+xQueueSizeInBytes_1
	clc
	adc	#$3d
	pha
	jsr	_~pvPortMalloc
	sta	<L39+pxNewQueue_1
	stx	<L39+pxNewQueue_1+2
;
;            if( pxNewQueue != NULL )
;            {
	ora	<L39+pxNewQueue_1+2
	beq	L10072
;                /* Jump past the queue structure to find the location of the queue
;                 * storage area. */
;                pucQueueStorage = ( uint8_t * ) pxNewQueue;
	lda	<L39+pxNewQueue_1
	sta	<L39+pucQueueStorage_1
	lda	<L39+pxNewQueue_1+2
	sta	<L39+pucQueueStorage_1+2
;                pucQueueStorage += sizeof( Queue_t );
	lda	#$3d
	clc
	adc	<L39+pucQueueStorage_1
	sta	<L39+pucQueueStorage_1
	bcc	L46
	inc	<L39+pucQueueStorage_1+2
L46:
;
;                #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;                {
;                    /* Queues can be created either statically or dynamically, so
;                     * note this task was created dynamically in case it is later
;                     * deleted. */
;                    pxNewQueue->ucStaticallyAllocated = pdFALSE;
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$3c
	sta	[<L39+pxNewQueue_1],Y
	rep	#$20
	longa	on
;                }
;                #endif /* configSUPPORT_STATIC_ALLOCATION */
;
;                prvInitialiseNewQueue( uxQueueLength, uxItemSize, pucQueueStorage, ucQueueType, pxNewQueue );
	pei	<L39+pxNewQueue_1+2
	pei	<L39+pxNewQueue_1
	pei	<L38+ucQueueType_0
	pei	<L39+pucQueueStorage_1+2
	pei	<L39+pucQueueStorage_1
	pei	<L38+uxItemSize_0
	pei	<L38+uxQueueLength_0
	jsr	_~prvInitialiseNewQueue
;            }
;            else
L10072:
;
;        traceRETURN_xQueueGenericCreate( pxNewQueue );
;
;        return pxNewQueue;
	ldx	<L39+pxNewQueue_1+2
	lda	<L39+pxNewQueue_1
	tay
	lda	<L38+1
	sta	<L38+1+6
	pld
	tsc
	clc
	adc	#L38+6
	tcs
	tya
	rts
;            {
;                traceQUEUE_CREATE_FAILED( ucQueueType );
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
L10069:
;        {
;            configASSERT( pxNewQueue );
	lda	<L39+pxNewQueue_1
	ora	<L39+pxNewQueue_1+2
	bne	L10072
L10077:
	bra	L10077
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L38	equ	18
L39	equ	9
	ends
	efunc
;
;#endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;static void prvInitialiseNewQueue( const UBaseType_t uxQueueLength,
;                                   const UBaseType_t uxItemSize,
;                                   uint8_t * pucQueueStorage,
;                                   const uint8_t ucQueueType,
;                                   Queue_t * pxNewQueue )
;{
	code
	func
_~prvInitialiseNewQueue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L49
	tcs
	phd
	tcd
uxQueueLength_0	set	3
uxItemSize_0	set	5
pucQueueStorage_0	set	7
ucQueueType_0	set	11
pxNewQueue_0	set	13
;    /* Remove compiler warnings about unused parameters should
;     * configUSE_TRACE_FACILITY not be set to 1. */
;    ( void ) ucQueueType;
;
;    if( uxItemSize == ( UBaseType_t ) 0 )
;    {
	lda	<L49+uxItemSize_0
	bne	L10080
;        /* No RAM was allocated for the queue storage area, but PC head cannot
;         * be set to NULL because NULL is used as a key to say the queue is used as
;         * a mutex.  Therefore just set pcHead to point to the queue as a benign
;         * value that is known to be within the memory map. */
;        pxNewQueue->pcHead = ( int8_t * ) pxNewQueue;
	lda	<L49+pxNewQueue_0
	sta	[<L49+pxNewQueue_0]
	lda	<L49+pxNewQueue_0+2
	bra	L20001
;    }
;    else
L10080:
;    {
;        /* Set the head to the start of the queue storage area. */
;        pxNewQueue->pcHead = ( int8_t * ) pucQueueStorage;
	lda	<L49+pucQueueStorage_0
	sta	[<L49+pxNewQueue_0]
	lda	<L49+pucQueueStorage_0+2
L20001:
	ldy	#$2
	sta	[<L49+pxNewQueue_0],Y
;    }
;
;    /* Initialise the queue members as described where the queue type is
;     * defined. */
;    pxNewQueue->uxLength = uxQueueLength;
	lda	<L49+uxQueueLength_0
	ldy	#$36
	sta	[<L49+pxNewQueue_0],Y
;    pxNewQueue->uxItemSize = uxItemSize;
	lda	<L49+uxItemSize_0
	iny
	iny
	sta	[<L49+pxNewQueue_0],Y
;    ( void ) xQueueGenericReset( pxNewQueue, pdTRUE );
	pea	#<$1
	pei	<L49+pxNewQueue_0+2
	pei	<L49+pxNewQueue_0
	jsr	_~xQueueGenericReset
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;    {
;        pxNewQueue->ucQueueType = ucQueueType;
;    }
;    #endif /* configUSE_TRACE_FACILITY */
;
;    #if ( configUSE_QUEUE_SETS == 1 )
;    {
;        pxNewQueue->pxQueueSetContainer = NULL;
;    }
;    #endif /* configUSE_QUEUE_SETS */
;
;    traceQUEUE_CREATE( pxNewQueue );
;}
	lda	<L49+1
	sta	<L49+1+14
	pld
	tsc
	clc
	adc	#L49+14
	tcs
	rts
L49	equ	4
L50	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_MUTEXES == 1 )
;
;    static void prvInitialiseMutex( Queue_t * pxNewQueue )
;    {
	code
	func
_~prvInitialiseMutex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L53
	tcs
	phd
	tcd
pxNewQueue_0	set	3
;        if( pxNewQueue != NULL )
;        {
	lda	<L53+pxNewQueue_0
	ora	<L53+pxNewQueue_0+2
	beq	L56
;            /* The queue create function will set all the queue structure members
;            * correctly for a generic queue, but this function is creating a
;            * mutex.  Overwrite those members that need to be set differently -
;            * in particular the information required for priority inheritance. */
;            pxNewQueue->u.xSemaphore.xMutexHolder = NULL;
	lda	#$0
	ldy	#$8
	sta	[<L53+pxNewQueue_0],Y
	iny
	iny
	sta	[<L53+pxNewQueue_0],Y
;            pxNewQueue->uxQueueType = queueQUEUE_IS_MUTEX;
	sta	[<L53+pxNewQueue_0]
	ldy	#$2
	sta	[<L53+pxNewQueue_0],Y
;
;            /* In case this is a recursive mutex. */
;            pxNewQueue->u.xSemaphore.uxRecursiveCallCount = 0;
	ldy	#$c
	sta	[<L53+pxNewQueue_0],Y
;
;            traceCREATE_MUTEX( pxNewQueue );
;
;            /* Start with the semaphore in the expected state. */
;            ( void ) xQueueGenericSend( pxNewQueue, NULL, ( TickType_t ) 0U, queueSEND_TO_BACK );
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pei	<L53+pxNewQueue_0+2
	pei	<L53+pxNewQueue_0
	jsr	_~xQueueGenericSend
;        }
;        else
;        {
;            traceCREATE_MUTEX_FAILED();
;        }
;    }
L56:
	lda	<L53+1
	sta	<L53+1+4
	pld
	tsc
	clc
	adc	#L53+4
	tcs
	rts
L53	equ	4
L54	equ	5
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_MUTEXES == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;
;    QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType )
;    {
	code
	xdef	_~xQueueCreateMutex
	func
_~xQueueCreateMutex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L57
	tcs
	phd
	tcd
ucQueueType_0	set	3
;        QueueHandle_t xNewQueue;
;        const UBaseType_t uxMutexLength = ( UBaseType_t ) 1, uxMutexSize = ( UBaseType_t ) 0;
;
;        traceENTER_xQueueCreateMutex( ucQueueType );
xNewQueue_1	set	0
uxMutexLength_1	set	4
uxMutexSize_1	set	6
	lda	#$1
	sta	<L58+uxMutexLength_1
	stz	<L58+uxMutexSize_1
;
;        xNewQueue = xQueueGenericCreate( uxMutexLength, uxMutexSize, ucQueueType );
	pei	<L57+ucQueueType_0
	pea	#<$0
	pea	#<$1
	jsr	_~xQueueGenericCreate
	sta	<L58+xNewQueue_1
	stx	<L58+xNewQueue_1+2
;        prvInitialiseMutex( ( Queue_t * ) xNewQueue );
	pei	<L58+xNewQueue_1+2
	pei	<L58+xNewQueue_1
	jsr	_~prvInitialiseMutex
;
;        traceRETURN_xQueueCreateMutex( xNewQueue );
;
;        return xNewQueue;
	ldx	<L58+xNewQueue_1+2
	lda	<L58+xNewQueue_1
	tay
	lda	<L57+1
	sta	<L57+1+2
	pld
	tsc
	clc
	adc	#L57+2
	tcs
	tya
	rts
;    }
L57	equ	8
L58	equ	1
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_MUTEXES == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;
;    QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType,
;                                           StaticQueue_t * pxStaticQueue )
;    {
	code
	xdef	_~xQueueCreateMutexStatic
	func
_~xQueueCreateMutexStatic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L60
	tcs
	phd
	tcd
ucQueueType_0	set	3
pxStaticQueue_0	set	5
;        QueueHandle_t xNewQueue;
;        const UBaseType_t uxMutexLength = ( UBaseType_t ) 1, uxMutexSize = ( UBaseType_t ) 0;
;
;        traceENTER_xQueueCreateMutexStatic( ucQueueType, pxStaticQueue );
xNewQueue_1	set	0
uxMutexLength_1	set	4
uxMutexSize_1	set	6
	lda	#$1
	sta	<L61+uxMutexLength_1
	stz	<L61+uxMutexSize_1
;
;        /* Prevent compiler warnings about unused parameters if
;         * configUSE_TRACE_FACILITY does not equal 1. */
;        ( void ) ucQueueType;
;
;        xNewQueue = xQueueGenericCreateStatic( uxMutexLength, uxMutexSize, NULL, pxStaticQueue, ucQueueType );
	pei	<L60+ucQueueType_0
	pei	<L60+pxStaticQueue_0+2
	pei	<L60+pxStaticQueue_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#<$1
	jsr	_~xQueueGenericCreateStatic
	sta	<L61+xNewQueue_1
	stx	<L61+xNewQueue_1+2
;        prvInitialiseMutex( ( Queue_t * ) xNewQueue );
	pei	<L61+xNewQueue_1+2
	pei	<L61+xNewQueue_1
	jsr	_~prvInitialiseMutex
;
;        traceRETURN_xQueueCreateMutexStatic( xNewQueue );
;
;        return xNewQueue;
	ldx	<L61+xNewQueue_1+2
	lda	<L61+xNewQueue_1
	tay
	lda	<L60+1
	sta	<L60+1+6
	pld
	tsc
	clc
	adc	#L60+6
	tcs
	tya
	rts
;    }
L60	equ	8
L61	equ	1
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_MUTEXES == 1 ) && ( INCLUDE_xSemaphoreGetMutexHolder == 1 ) )
;
;    TaskHandle_t xQueueGetMutexHolder( QueueHandle_t xSemaphore )
;    {
;        TaskHandle_t pxReturn;
;        Queue_t * const pxSemaphore = ( Queue_t * ) xSemaphore;
;
;        traceENTER_xQueueGetMutexHolder( xSemaphore );
;
;        configASSERT( xSemaphore );
;
;        /* This function is called by xSemaphoreGetMutexHolder(), and should not
;         * be called directly.  Note:  This is a good way of determining if the
;         * calling task is the mutex holder, but not a good way of determining the
;         * identity of the mutex holder, as the holder may change between the
;         * following critical section exiting and the function returning. */
;        taskENTER_CRITICAL();
;        {
;            if( pxSemaphore->uxQueueType == queueQUEUE_IS_MUTEX )
;            {
;                pxReturn = pxSemaphore->u.xSemaphore.xMutexHolder;
;            }
;            else
;            {
;                pxReturn = NULL;
;            }
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_xQueueGetMutexHolder( pxReturn );
;
;        return pxReturn;
;    }
;
;#endif /* if ( ( configUSE_MUTEXES == 1 ) && ( INCLUDE_xSemaphoreGetMutexHolder == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_MUTEXES == 1 ) && ( INCLUDE_xSemaphoreGetMutexHolder == 1 ) )
;
;    TaskHandle_t xQueueGetMutexHolderFromISR( QueueHandle_t xSemaphore )
;    {
;        TaskHandle_t pxReturn;
;
;        traceENTER_xQueueGetMutexHolderFromISR( xSemaphore );
;
;        configASSERT( xSemaphore );
;
;        /* Mutexes cannot be used in interrupt service routines, so the mutex
;         * holder should not change in an ISR, and therefore a critical section is
;         * not required here. */
;        if( ( ( Queue_t * ) xSemaphore )->uxQueueType == queueQUEUE_IS_MUTEX )
;        {
;            pxReturn = ( ( Queue_t * ) xSemaphore )->u.xSemaphore.xMutexHolder;
;        }
;        else
;        {
;            pxReturn = NULL;
;        }
;
;        traceRETURN_xQueueGetMutexHolderFromISR( pxReturn );
;
;        return pxReturn;
;    }
;
;#endif /* if ( ( configUSE_MUTEXES == 1 ) && ( INCLUDE_xSemaphoreGetMutexHolder == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_RECURSIVE_MUTEXES == 1 )
;
;    BaseType_t xQueueGiveMutexRecursive( QueueHandle_t xMutex )
;    {
	code
	xdef	_~xQueueGiveMutexRecursive
	func
_~xQueueGiveMutexRecursive:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L63
	tcs
	phd
	tcd
xMutex_0	set	3
;        BaseType_t xReturn;
;        Queue_t * const pxMutex = ( Queue_t * ) xMutex;
;
;        traceENTER_xQueueGiveMutexRecursive( xMutex );
xReturn_1	set	0
pxMutex_1	set	2
	lda	<L63+xMutex_0
	sta	<L64+pxMutex_1
	lda	<L63+xMutex_0+2
	sta	<L64+pxMutex_1+2
;
;        configASSERT( pxMutex );
	lda	<L64+pxMutex_1
	ora	<L64+pxMutex_1+2
	bne	L10084
L10088:
	bra	L10088
L10084:
;
;        /* If this is the task that holds the mutex then xMutexHolder will not
;         * change outside of this task.  If this task does not hold the mutex then
;         * pxMutexHolder can never coincidentally equal the tasks handle, and as
;         * this is the only condition we are interested in it does not matter if
;         * pxMutexHolder is accessed simultaneously by another task.  Therefore no
;         * mutual exclusion is required to test the pxMutexHolder variable. */
;        if( pxMutex->u.xSemaphore.xMutexHolder == xTaskGetCurrentTaskHandle() )
;        {
	jsr	_~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$8
	cmp	[<L64+pxMutex_1],Y
	bne	L66
	lda	<R0+2
	iny
	iny
	cmp	[<L64+pxMutex_1],Y
L66:
	bne	L10091
;            traceGIVE_MUTEX_RECURSIVE( pxMutex );
;
;            /* uxRecursiveCallCount cannot be zero if xMutexHolder is equal to
;             * the task handle, therefore no underflow check is required.  Also,
;             * uxRecursiveCallCount is only modified by the mutex holder, and as
;             * there can only be one, no mutual exclusion is required to modify the
;             * uxRecursiveCallCount member. */
;            ( pxMutex->u.xSemaphore.uxRecursiveCallCount )--;
	clc
	lda	#$ffff
	ldy	#$c
	adc	[<L64+pxMutex_1],Y
	sta	[<L64+pxMutex_1],Y
;
;            /* Has the recursive call count unwound to 0? */
;            if( pxMutex->u.xSemaphore.uxRecursiveCallCount == ( UBaseType_t ) 0 )
;            {
	lda	[<L64+pxMutex_1],Y
	bne	L10093
;                /* Return the mutex.  This will automatically unblock any other
;                 * task that might be waiting to access the mutex. */
;                ( void ) xQueueGenericSend( pxMutex, NULL, queueMUTEX_GIVE_BLOCK_TIME, queueSEND_TO_BACK );
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pei	<L64+pxMutex_1+2
	pei	<L64+pxMutex_1
	jsr	_~xQueueGenericSend
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10093:
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L64+xReturn_1
;        }
;        else
	bra	L10094
L10091:
;        {
;            /* The mutex cannot be given because the calling task is not the
;             * holder. */
;            xReturn = pdFAIL;
	stz	<L64+xReturn_1
;
;            traceGIVE_MUTEX_RECURSIVE_FAILED( pxMutex );
;        }
L10094:
;
;        traceRETURN_xQueueGiveMutexRecursive( xReturn );
;
;        return xReturn;
	lda	<L64+xReturn_1
	tay
	lda	<L63+1
	sta	<L63+1+4
	pld
	tsc
	clc
	adc	#L63+4
	tcs
	tya
	rts
;    }
L63	equ	10
L64	equ	5
	ends
	efunc
;
;#endif /* configUSE_RECURSIVE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_RECURSIVE_MUTEXES == 1 )
;
;    BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex,
;                                         TickType_t xTicksToWait )
;    {
	code
	xdef	_~xQueueTakeMutexRecursive
	func
_~xQueueTakeMutexRecursive:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L70
	tcs
	phd
	tcd
xMutex_0	set	3
xTicksToWait_0	set	7
;        BaseType_t xReturn;
;        Queue_t * const pxMutex = ( Queue_t * ) xMutex;
;
;        traceENTER_xQueueTakeMutexRecursive( xMutex, xTicksToWait );
xReturn_1	set	0
pxMutex_1	set	2
	lda	<L70+xMutex_0
	sta	<L71+pxMutex_1
	lda	<L70+xMutex_0+2
	sta	<L71+pxMutex_1+2
;
;        configASSERT( pxMutex );
	lda	<L71+pxMutex_1
	ora	<L71+pxMutex_1+2
	bne	L10095
L10099:
	bra	L10099
L10095:
;
;        /* Comments regarding mutual exclusion as per those within
;         * xQueueGiveMutexRecursive(). */
;
;        traceTAKE_MUTEX_RECURSIVE( pxMutex );
;
;        if( pxMutex->u.xSemaphore.xMutexHolder == xTaskGetCurrentTaskHandle() )
;        {
	jsr	_~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$8
	cmp	[<L71+pxMutex_1],Y
	bne	L73
	lda	<R0+2
	iny
	iny
	cmp	[<L71+pxMutex_1],Y
L73:
	bne	L10102
;            ( pxMutex->u.xSemaphore.uxRecursiveCallCount )++;
	ldy	#$c
	lda	[<L71+pxMutex_1],Y
	ina
	sta	[<L71+pxMutex_1],Y
;
;            /* Check if an overflow occurred. */
;            configASSERT( pxMutex->u.xSemaphore.uxRecursiveCallCount );
	lda	[<L71+pxMutex_1],Y
	bne	L10103
L10107:
	bra	L10107
L10103:
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L71+xReturn_1
;        }
;        else
L10110:
;
;        traceRETURN_xQueueTakeMutexRecursive( xReturn );
;
;        return xReturn;
	lda	<L71+xReturn_1
	tay
	lda	<L70+1
	sta	<L70+1+8
	pld
	tsc
	clc
	adc	#L70+8
	tcs
	tya
	rts
L10102:
;        {
;            xReturn = xQueueSemaphoreTake( pxMutex, xTicksToWait );
	pei	<L70+xTicksToWait_0+2
	pei	<L70+xTicksToWait_0
	pei	<L71+pxMutex_1+2
	pei	<L71+pxMutex_1
	jsr	_~xQueueSemaphoreTake
	sta	<L71+xReturn_1
;
;            /* pdPASS will only be returned if the mutex was successfully
;             * obtained.  The calling task may have entered the Blocked state
;             * before reaching here. */
;            if( xReturn != pdFAIL )
;            {
	lda	<L71+xReturn_1
	beq	L10110
;                ( pxMutex->u.xSemaphore.uxRecursiveCallCount )++;
	ldy	#$c
	lda	[<L71+pxMutex_1],Y
	ina
	sta	[<L71+pxMutex_1],Y
;
;                /* Check if an overflow occurred. */
;                configASSERT( pxMutex->u.xSemaphore.uxRecursiveCallCount );
	lda	[<L71+pxMutex_1],Y
	bne	L10110
L10116:
	bra	L10116
;            }
;            else
;            {
;                traceTAKE_MUTEX_RECURSIVE_FAILED( pxMutex );
;            }
;        }
;    }
L70	equ	10
L71	equ	5
	ends
	efunc
;
;#endif /* configUSE_RECURSIVE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_COUNTING_SEMAPHORES == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;
;    QueueHandle_t xQueueCreateCountingSemaphoreStatic( const UBaseType_t uxMaxCount,
;                                                       const UBaseType_t uxInitialCount,
;                                                       StaticQueue_t * pxStaticQueue )
;    {
	code
	xdef	_~xQueueCreateCountingSemaphoreStatic
	func
_~xQueueCreateCountingSemaphoreStatic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L79
	tcs
	phd
	tcd
uxMaxCount_0	set	3
uxInitialCount_0	set	5
pxStaticQueue_0	set	7
;        QueueHandle_t xHandle = NULL;
;
;        traceENTER_xQueueCreateCountingSemaphoreStatic( uxMaxCount, uxInitialCount, pxStaticQueue );
xHandle_1	set	0
	stz	<L80+xHandle_1
	stz	<L80+xHandle_1+2
;
;        if( ( uxMaxCount != 0U ) &&
;            ( uxInitialCount <= uxMaxCount ) )
;        {
	lda	<L79+uxMaxCount_0
	beq	L10120
	lda	<L79+uxMaxCount_0
	cmp	<L79+uxInitialCount_0
	bcc	L10120
;            xHandle = xQueueGenericCreateStatic( uxMaxCount, queueSEMAPHORE_QUEUE_ITEM_LENGTH, NULL, pxStaticQueue, queueQUEUE_TYPE_COUNTING_SEMAPHORE );
	pea	#<$2
	pei	<L79+pxStaticQueue_0+2
	pei	<L79+pxStaticQueue_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pei	<L79+uxMaxCount_0
	jsr	_~xQueueGenericCreateStatic
	sta	<L80+xHandle_1
	stx	<L80+xHandle_1+2
;
;            if( xHandle != NULL )
;            {
	ora	<L80+xHandle_1+2
	beq	L10123
;                ( ( Queue_t * ) xHandle )->uxMessagesWaiting = uxInitialCount;
	lda	<L79+uxInitialCount_0
	ldy	#$34
	sta	[<L80+xHandle_1],Y
;
;                traceCREATE_COUNTING_SEMAPHORE();
;            }
;            else
L10123:
;
;        traceRETURN_xQueueCreateCountingSemaphoreStatic( xHandle );
;
;        return xHandle;
	ldx	<L80+xHandle_1+2
	lda	<L80+xHandle_1
	tay
	lda	<L79+1
	sta	<L79+1+8
	pld
	tsc
	clc
	adc	#L79+8
	tcs
	tya
	rts
;            {
;                traceCREATE_COUNTING_SEMAPHORE_FAILED();
;            }
;        }
;        else
L10120:
;        {
;            configASSERT( xHandle );
	lda	<L80+xHandle_1
	ora	<L80+xHandle_1+2
	bne	L10123
L10128:
	bra	L10128
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L79	equ	4
L80	equ	1
	ends
	efunc
;
;#endif /* ( ( configUSE_COUNTING_SEMAPHORES == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_COUNTING_SEMAPHORES == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;
;    QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount,
;                                                 const UBaseType_t uxInitialCount )
;    {
	code
	xdef	_~xQueueCreateCountingSemaphore
	func
_~xQueueCreateCountingSemaphore:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L86
	tcs
	phd
	tcd
uxMaxCount_0	set	3
uxInitialCount_0	set	5
;        QueueHandle_t xHandle = NULL;
;
;        traceENTER_xQueueCreateCountingSemaphore( uxMaxCount, uxInitialCount );
xHandle_1	set	0
	stz	<L87+xHandle_1
	stz	<L87+xHandle_1+2
;
;        if( ( uxMaxCount != 0U ) &&
;            ( uxInitialCount <= uxMaxCount ) )
;        {
	lda	<L86+uxMaxCount_0
	beq	L10131
	lda	<L86+uxMaxCount_0
	cmp	<L86+uxInitialCount_0
	bcc	L10131
;            xHandle = xQueueGenericCreate( uxMaxCount, queueSEMAPHORE_QUEUE_ITEM_LENGTH, queueQUEUE_TYPE_COUNTING_SEMAPHORE );
	pea	#<$2
	pea	#<$0
	pei	<L86+uxMaxCount_0
	jsr	_~xQueueGenericCreate
	sta	<L87+xHandle_1
	stx	<L87+xHandle_1+2
;
;            if( xHandle != NULL )
;            {
	ora	<L87+xHandle_1+2
	beq	L10134
;                ( ( Queue_t * ) xHandle )->uxMessagesWaiting = uxInitialCount;
	lda	<L86+uxInitialCount_0
	ldy	#$34
	sta	[<L87+xHandle_1],Y
;
;                traceCREATE_COUNTING_SEMAPHORE();
;            }
;            else
L10134:
;
;        traceRETURN_xQueueCreateCountingSemaphore( xHandle );
;
;        return xHandle;
	ldx	<L87+xHandle_1+2
	lda	<L87+xHandle_1
	tay
	lda	<L86+1
	sta	<L86+1+4
	pld
	tsc
	clc
	adc	#L86+4
	tcs
	tya
	rts
;            {
;                traceCREATE_COUNTING_SEMAPHORE_FAILED();
;            }
;        }
;        else
L10131:
;        {
;            configASSERT( xHandle );
	lda	<L87+xHandle_1
	ora	<L87+xHandle_1+2
	bne	L10134
L10139:
	bra	L10139
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L86	equ	4
L87	equ	1
	ends
	efunc
;
;#endif /* ( ( configUSE_COUNTING_SEMAPHORES == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueGenericSend( QueueHandle_t xQueue,
;                              const void * const pvItemToQueue,
;                              TickType_t xTicksToWait,
;                              const BaseType_t xCopyPosition )
;{
	code
	xdef	_~xQueueGenericSend
	func
_~xQueueGenericSend:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L93
	tcs
	phd
	tcd
xQueue_0	set	3
pvItemToQueue_0	set	7
xTicksToWait_0	set	11
xCopyPosition_0	set	15
;    BaseType_t xEntryTimeSet = pdFALSE, xYieldRequired;
;    TimeOut_t xTimeOut;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueGenericSend( xQueue, pvItemToQueue, xTicksToWait, xCopyPosition );
xEntryTimeSet_1	set	0
xYieldRequired_1	set	2
xTimeOut_1	set	4
pxQueue_1	set	10
	stz	<L94+xEntryTimeSet_1
	lda	<L93+xQueue_0
	sta	<L94+pxQueue_1
	lda	<L93+xQueue_0+2
	sta	<L94+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L94+pxQueue_1
	ora	<L94+pxQueue_1+2
	bne	L10142
L10146:
	bra	L10146
L10142:
;    configASSERT( !( ( pvItemToQueue == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
	lda	<L93+pvItemToQueue_0
	ora	<L93+pvItemToQueue_0+2
	bne	L10149
	ldy	#$38
	lda	[<L94+pxQueue_1],Y
	beq	L10149
L10153:
	bra	L10153
L10149:
;    configASSERT( !( ( xCopyPosition == queueOVERWRITE ) && ( pxQueue->uxLength != 1 ) ) );
	lda	<L93+xCopyPosition_0
	cmp	#<$2
	bne	L10156
	ldy	#$36
	lda	[<L94+pxQueue_1],Y
	cmp	#<$1
	beq	L10156
L10160:
	bra	L10160
L10156:
;    #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;    {
;        configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	beq	*+5
	brl	L10174
	lda	<L93+xTicksToWait_0
	ora	<L93+xTicksToWait_0+2
	bne	*+5
	brl	L10174
L10167:
	bra	L10167
;    }
;    #endif
;
;    for( ; ; )
;    {
;        taskENTER_CRITICAL();
L105:
	lda	#$0
L107:
	tax
	bne	L10177
;                        if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                        {
	lda	#$22
	clc
	adc	<L94+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L94+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
L20003:
	beq	L10184
;                            /* The unblocked task has a priority higher than
;                             * our own so yield immediately.  Yes it is ok to do
;                             * this from within the critical section - the kernel
;                             * takes care of that. */
;                            queueYIELD_IF_USING_PREEMPTION();
	jsr	_~vPortYield
;                        }
;                        else
L10184:
;
;                traceRETURN_xQueueGenericSend( pdPASS );
;
;                return pdPASS;
	lda	#$1
L111:
	tay
	lda	<L93+1
	sta	<L93+1+14
	pld
	tsc
	clc
	adc	#L93+14
	tcs
	tya
	rts
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else if( xYieldRequired != pdFALSE )
L10177:
;                    {
	lda	<L94+xYieldRequired_1
	bra	L20003
;                        /* This path is a special case that will only get
;                         * executed if the task was holding multiple mutexes and
;                         * the mutexes were given back in an order that is
;                         * different to that in which they were taken. */
;                        queueYIELD_IF_USING_PREEMPTION();
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                #endif /* configUSE_QUEUE_SETS */
;
;                taskEXIT_CRITICAL();
;            }
;            else
L10176:
;            {
;                if( xTicksToWait == ( TickType_t ) 0 )
;                {
	lda	<L93+xTicksToWait_0
	ora	<L93+xTicksToWait_0+2
	bne	L10186
;                    /* The queue was full and no block time is specified (or
;                     * the block time has expired) so leave now. */
;                    taskEXIT_CRITICAL();
;
;                    /* Return to the original privilege level before exiting
;                     * the function. */
;                    traceQUEUE_SEND_FAILED( pxQueue );
;                    traceRETURN_xQueueGenericSend( errQUEUE_FULL );
;
;                    return errQUEUE_FULL;
L20004:
	lda	#$0
	bra	L111
;                }
;                else if( xEntryTimeSet == pdFALSE )
L10186:
;                {
	lda	<L94+xEntryTimeSet_1
	bne	L10193
;                    /* The queue was full and a block time was specified so
;                     * configure the timeout structure. */
;                    vTaskInternalSetTimeOutState( &xTimeOut );
	pea	#0
	clc
	tdc
	adc	#<L94+xTimeOut_1
	pha
	jsr	_~vTaskInternalSetTimeOutState
;                    xEntryTimeSet = pdTRUE;
	lda	#$1
	sta	<L94+xEntryTimeSet_1
;                }
;                else
;                {
;                    /* Entry time was already set. */
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;        taskEXIT_CRITICAL();
L10193:
;
;        /* Interrupts and other tasks can send to and receive from the queue
;         * now the critical section has been exited. */
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        prvLockQueue( pxQueue );
	sep	#$20
	longa	off
	ldy	#$3a
	lda	[<L94+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10198
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L94+pxQueue_1],Y
	rep	#$20
	longa	on
L10198:
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L94+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10201
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L94+pxQueue_1],Y
	rep	#$20
	longa	on
L10201:
;
;        /* Update the timeout state to see if it has expired yet. */
;        if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE )
;        {
	pea	#0
	clc
	tdc
	adc	#<L93+xTicksToWait_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L94+xTimeOut_1
	pha
	jsr	_~xTaskCheckForTimeOut
	tax
	bne	L10203
;            if( prvIsQueueFull( pxQueue ) != pdFALSE )
;            {
	pei	<L94+pxQueue_1+2
	pei	<L94+pxQueue_1
	jsr	_~prvIsQueueFull
	tax
	beq	L10204
;                traceBLOCKING_ON_QUEUE_SEND( pxQueue );
;                vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToSend ), xTicksToWait );
	pei	<L93+xTicksToWait_0+2
	pei	<L93+xTicksToWait_0
	lda	#$10
	clc
	adc	<L94+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L94+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vTaskPlaceOnEventList
;
;                /* Unlocking the queue means queue events can effect the
;                 * event list. It is possible that interrupts occurring now
;                 * remove this task from the event list again - but as the
;                 * scheduler is suspended the task will go onto the pending
;                 * ready list instead of the actual ready list. */
;                prvUnlockQueue( pxQueue );
	pei	<L94+pxQueue_1+2
	pei	<L94+pxQueue_1
	jsr	_~prvUnlockQueue
;
;                /* Resuming the scheduler will move tasks from the pending
;                 * ready list into the ready list - so it is feasible that this
;                 * task is already in the ready list before it yields - in which
;                 * case the yield will not cause a context switch unless there
;                 * is also a higher priority task in the pending ready list. */
;                if( xTaskResumeAll() == pdFALSE )
;                {
	jsr	_~xTaskResumeAll
	tax
	bne	L10174
;                    taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;                }
;            }
;            else
L10174:
;        {
;            /* Is there room on the queue now?  The running task must be the
;             * highest priority task wanting to access the queue.  If the head item
;             * in the queue is to be overwritten then it does not matter if the
;             * queue is full. */
;            if( ( pxQueue->uxMessagesWaiting < pxQueue->uxLength ) || ( xCopyPosition == queueOVERWRITE ) )
;            {
	ldy	#$34
	lda	[<L94+pxQueue_1],Y
	iny
	iny
	cmp	[<L94+pxQueue_1],Y
	bcc	L102
	lda	<L93+xCopyPosition_0
	cmp	#<$2
	beq	*+5
	brl	L10176
L102:
;                traceQUEUE_SEND( pxQueue );
;
;                #if ( configUSE_QUEUE_SETS == 1 )
;                {
;                    const UBaseType_t uxPreviousMessagesWaiting = pxQueue->uxMessagesWaiting;
;
;                    xYieldRequired = prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
;
;                    if( pxQueue->pxQueueSetContainer != NULL )
;                    {
;                        if( ( xCopyPosition == queueOVERWRITE ) && ( uxPreviousMessagesWaiting != ( UBaseType_t ) 0 ) )
;                        {
;                            /* Do not notify the queue set as an existing item
;                             * was overwritten in the queue so the number of items
;                             * in the queue has not changed. */
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                        else if( prvNotifyQueueSetContainer( pxQueue ) != pdFALSE )
;                        {
;                            /* The queue is a member of a queue set, and posting
;                             * to the queue set caused a higher priority task to
;                             * unblock. A context switch is required. */
;                            queueYIELD_IF_USING_PREEMPTION();
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else
;                    {
;                        /* If there was a task waiting for data to arrive on the
;                         * queue then unblock it now. */
;                        if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                        {
;                            if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                            {
;                                /* The unblocked task has a priority higher than
;                                 * our own so yield immediately.  Yes it is ok to
;                                 * do this from within the critical section - the
;                                 * kernel takes care of that. */
;                                queueYIELD_IF_USING_PREEMPTION();
;                            }
;                            else
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else if( xYieldRequired != pdFALSE )
;                        {
;                            /* This path is a special case that will only get
;                             * executed if the task was holding multiple mutexes
;                             * and the mutexes were given back in an order that is
;                             * different to that in which they were taken. */
;                            queueYIELD_IF_USING_PREEMPTION();
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                }
;                #else /* configUSE_QUEUE_SETS */
;                {
;                    xYieldRequired = prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
	pei	<L93+xCopyPosition_0
	pei	<L93+pvItemToQueue_0+2
	pei	<L93+pvItemToQueue_0
	pei	<L94+pxQueue_1+2
	pei	<L94+pxQueue_1
	jsr	_~prvCopyDataToQueue
	sta	<L94+xYieldRequired_1
;
;                    /* If there was a task waiting for data to arrive on the
;                     * queue then unblock it now. */
;                    if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                    {
	ldy	#$22
	lda	[<L94+pxQueue_1],Y
	beq	*+5
	brl	L105
	lda	#$1
	brl	L107
L10204:
;            {
;                /* Try again. */
;                prvUnlockQueue( pxQueue );
	pei	<L94+pxQueue_1+2
	pei	<L94+pxQueue_1
	jsr	_~prvUnlockQueue
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;        }
;        else
	bra	L10174
L10203:
;        {
;            /* The timeout has expired. */
;            prvUnlockQueue( pxQueue );
	pei	<L94+pxQueue_1+2
	pei	<L94+pxQueue_1
	jsr	_~prvUnlockQueue
;            ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;            traceQUEUE_SEND_FAILED( pxQueue );
;            traceRETURN_xQueueGenericSend( errQUEUE_FULL );
;
;            return errQUEUE_FULL;
	brl	L20004
;        }
;    }
;}
L93	equ	18
L94	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue,
;                                     const void * const pvItemToQueue,
;                                     BaseType_t * const pxHigherPriorityTaskWoken,
;                                     const BaseType_t xCopyPosition )
;{
	code
	xdef	_~xQueueGenericSendFromISR
	func
_~xQueueGenericSendFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L119
	tcs
	phd
	tcd
xQueue_0	set	3
pvItemToQueue_0	set	7
pxHigherPriorityTaskWoken_0	set	11
xCopyPosition_0	set	15
;    BaseType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueGenericSendFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken, xCopyPosition );
xReturn_1	set	0
uxSavedInterruptStatus_1	set	2
pxQueue_1	set	4
	lda	<L119+xQueue_0
	sta	<L120+pxQueue_1
	lda	<L119+xQueue_0+2
	sta	<L120+pxQueue_1+2
;
;    configASSERT( ( pxQueue != NULL ) && !( ( pvItemToQueue == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
	lda	<L120+pxQueue_1
	ora	<L120+pxQueue_1+2
	beq	L10212
	lda	<L119+pvItemToQueue_0
	ora	<L119+pvItemToQueue_0+2
	bne	L10208
	ldy	#$38
	lda	[<L120+pxQueue_1],Y
	beq	L10208
L10212:
	bra	L10212
L10208:
;    configASSERT( ( pxQueue != NULL ) && !( ( xCopyPosition == queueOVERWRITE ) && ( pxQueue->uxLength != 1 ) ) );
	lda	<L120+pxQueue_1
	ora	<L120+pxQueue_1+2
	beq	L10219
	lda	<L119+xCopyPosition_0
	cmp	#<$2
	bne	L10215
	ldy	#$36
	lda	[<L120+pxQueue_1],Y
	cmp	#<$1
	beq	L10215
L10219:
	bra	L10219
L10215:
;
;    /* RTOS ports that support interrupt nesting have the concept of a maximum
;     * system call (or maximum API call) interrupt priority.  Interrupts that are
;     * above the maximum system call priority are kept permanently enabled, even
;     * when the RTOS kernel is in a critical section, but cannot make any calls to
;     * FreeRTOS API functions.  If configASSERT() is defined in FreeRTOSConfig.h
;     * then portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;     * failure if a FreeRTOS API function is called from an interrupt that has been
;     * assigned a priority above the configured maximum system call priority.
;     * Only FreeRTOS functions that end in FromISR can be called from interrupts
;     * that have been assigned a priority at or (logically) below the maximum
;     * system call interrupt priority.  FreeRTOS maintains a separate interrupt
;     * safe API to ensure interrupt entry is as fast and as simple as possible.
;     * More information (albeit Cortex-M specific) is provided on the following
;     * link: https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;    portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;    /* Similar to xQueueGenericSend, except without blocking if there is no room
;     * in the queue.  Also don't directly wake a task that was blocked on a queue
;     * read, instead return a flag to say whether a context switch is required or
;     * not (i.e. has a task with a higher priority than us been woken by this
;     * post). */
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L120+uxSavedInterruptStatus_1
;    {
;        if( ( pxQueue->uxMessagesWaiting < pxQueue->uxLength ) || ( xCopyPosition == queueOVERWRITE ) )
;        {
	ldy	#$34
	lda	[<L120+pxQueue_1],Y
	iny
	iny
	cmp	[<L120+pxQueue_1],Y
	bcc	L129
	lda	<L119+xCopyPosition_0
	cmp	#<$2
	beq	*+5
	brl	L10222
L129:
;            const int8_t cTxLock = pxQueue->cTxLock;
;            const UBaseType_t uxPreviousMessagesWaiting = pxQueue->uxMessagesWaiting;
;
;            traceQUEUE_SEND_FROM_ISR( pxQueue );
cTxLock_2	set	8
uxPreviousMessagesWaiting_2	set	9
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L120+pxQueue_1],Y
	sta	<L120+cTxLock_2
	rep	#$20
	longa	on
	ldy	#$34
	lda	[<L120+pxQueue_1],Y
	sta	<L120+uxPreviousMessagesWaiting_2
;
;            /* Semaphores use xQueueGiveFromISR(), so pxQueue will not be a
;             *  semaphore or mutex.  That means prvCopyDataToQueue() cannot result
;             *  in a task disinheriting a priority and prvCopyDataToQueue() can be
;             *  called here even though the disinherit function does not check if
;             *  the scheduler is suspended before accessing the ready lists. */
;            ( void ) prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
	pei	<L119+xCopyPosition_0
	pei	<L119+pvItemToQueue_0+2
	pei	<L119+pvItemToQueue_0
	pei	<L120+pxQueue_1+2
	pei	<L120+pxQueue_1
	jsr	_~prvCopyDataToQueue
;
;            /* The event list is not altered if the queue is locked.  This will
;             * be done when the queue is unlocked later. */
;            if( cTxLock == queueUNLOCKED )
;            {
	sep	#$20
	longa	off
	lda	<L120+cTxLock_2
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10233
;                #if ( configUSE_QUEUE_SETS == 1 )
;                {
;                    if( pxQueue->pxQueueSetContainer != NULL )
;                    {
;                        if( ( xCopyPosition == queueOVERWRITE ) && ( uxPreviousMessagesWaiting != ( UBaseType_t ) 0 ) )
;                        {
;                            /* Do not notify the queue set as an existing item
;                             * was overwritten in the queue so the number of items
;                             * in the queue has not changed. */
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                        else if( prvNotifyQueueSetContainer( pxQueue ) != pdFALSE )
;                        {
;                            /* The queue is a member of a queue set, and posting
;                             * to the queue set caused a higher priority task to
;                             * unblock.  A context switch is required. */
;                            if( pxHigherPriorityTaskWoken != NULL )
;                            {
;                                *pxHigherPriorityTaskWoken = pdTRUE;
;                            }
;                            else
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else
;                    {
;                        if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                        {
;                            if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                            {
;                                /* The task waiting has a higher priority so
;                                 *  record that a context switch is required. */
;                                if( pxHigherPriorityTaskWoken != NULL )
;                                {
;                                    *pxHigherPriorityTaskWoken = pdTRUE;
;                                }
;                                else
;                                {
;                                    mtCOVERAGE_TEST_MARKER();
;                                }
;                            }
;                            else
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                }
;                #else /* configUSE_QUEUE_SETS */
;                {
;                    if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                    {
	ldy	#$22
	lda	[<L120+pxQueue_1],Y
	bne	L133
	lda	#$1
	bra	L135
L133:
	lda	#$0
L135:
	tax
	bne	L10230
;                        if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                        {
	lda	#$22
	clc
	adc	<L120+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L120+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10230
;                            /* The task waiting has a higher priority so record that a
;                             * context switch is required. */
;                            if( pxHigherPriorityTaskWoken != NULL )
;                            {
	lda	<L119+pxHigherPriorityTaskWoken_0
	ora	<L119+pxHigherPriorityTaskWoken_0+2
	beq	L10230
;                                *pxHigherPriorityTaskWoken = pdTRUE;
	lda	#$1
	sta	[<L119+pxHigherPriorityTaskWoken_0]
;                            }
;                            else
;                    }
;                    else
	bra	L10230
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;
;                    /* Not used in this path. */
;                    ( void ) uxPreviousMessagesWaiting;
;                }
;                #endif /* configUSE_QUEUE_SETS */
;            }
;            else
;            {
;                /* Increment the lock count so the task that unlocks the queue
;                 * knows that data was posted while it was locked. */
;                prvIncrementQueueTxLock( pxQueue, cTxLock );
L10233:
uxNumberOfTasks_3	set	11
	jsr	_~uxTaskGetNumberOfTasks
	sta	<L120+uxNumberOfTasks_3
	lda	<L120+cTxLock_2
	and	#$ff
	bit	#$80
	beq	L139
	ora	#$ff00
L139:
	cmp	<L120+uxNumberOfTasks_3
	bcs	L10230
	sep	#$20
	longa	off
	lda	<L120+cTxLock_2
	cmp	#<$7f
	rep	#$20
	longa	on
	bne	L10235
L10239:
	bra	L10239
L10235:
	sep	#$20
	longa	off
	lda	<L120+cTxLock_2
	ina
	ldy	#$3b
	sta	[<L120+pxQueue_1],Y
	rep	#$20
	longa	on
;            }
L10230:
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L120+xReturn_1
;        }
;        else
	bra	L10242
L10222:
;        {
;            traceQUEUE_SEND_FROM_ISR_FAILED( pxQueue );
;            xReturn = errQUEUE_FULL;
	stz	<L120+xReturn_1
;        }
L10242:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xQueueGenericSendFromISR( xReturn );
;
;    return xReturn;
	lda	<L120+xReturn_1
	tay
	lda	<L119+1
	sta	<L119+1+14
	pld
	tsc
	clc
	adc	#L119+14
	tcs
	tya
	rts
;}
L119	equ	17
L120	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue,
;                              BaseType_t * const pxHigherPriorityTaskWoken )
;{
	code
	xdef	_~xQueueGiveFromISR
	func
_~xQueueGiveFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L143
	tcs
	phd
	tcd
xQueue_0	set	3
pxHigherPriorityTaskWoken_0	set	7
;    BaseType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueGiveFromISR( xQueue, pxHigherPriorityTaskWoken );
xReturn_1	set	0
uxSavedInterruptStatus_1	set	2
pxQueue_1	set	4
	lda	<L143+xQueue_0
	sta	<L144+pxQueue_1
	lda	<L143+xQueue_0+2
	sta	<L144+pxQueue_1+2
;
;    /* Similar to xQueueGenericSendFromISR() but used with semaphores where the
;     * item size is 0.  Don't directly wake a task that was blocked on a queue
;     * read, instead return a flag to say whether a context switch is required or
;     * not (i.e. has a task with a higher priority than us been woken by this
;     * post). */
;
;    /* xQueueGenericSendFromISR() should be used instead of xQueueGiveFromISR()
;     * if the item size is not 0. */
;    configASSERT( ( pxQueue != NULL ) && ( pxQueue->uxItemSize == 0 ) );
	lda	<L144+pxQueue_1
	ora	<L144+pxQueue_1+2
	beq	L10247
	ldy	#$38
	lda	[<L144+pxQueue_1],Y
	beq	L10243
L10247:
	bra	L10247
L10243:
;
;    /* Normally a mutex would not be given from an interrupt, especially if
;     * there is a mutex holder, as priority inheritance makes no sense for an
;     * interrupt, only tasks. */
;    configASSERT( ( pxQueue != NULL ) && !( ( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX ) && ( pxQueue->u.xSemaphore.xMutexHolder != NULL ) ) );
	lda	<L144+pxQueue_1
	ora	<L144+pxQueue_1+2
	beq	L10254
	lda	[<L144+pxQueue_1]
	ldy	#$2
	ora	[<L144+pxQueue_1],Y
	bne	L10250
	ldy	#$8
	lda	[<L144+pxQueue_1],Y
	iny
	iny
	ora	[<L144+pxQueue_1],Y
	beq	L10250
L10254:
	bra	L10254
L10250:
;
;    /* RTOS ports that support interrupt nesting have the concept of a maximum
;     * system call (or maximum API call) interrupt priority.  Interrupts that are
;     * above the maximum system call priority are kept permanently enabled, even
;     * when the RTOS kernel is in a critical section, but cannot make any calls to
;     * FreeRTOS API functions.  If configASSERT() is defined in FreeRTOSConfig.h
;     * then portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;     * failure if a FreeRTOS API function is called from an interrupt that has been
;     * assigned a priority above the configured maximum system call priority.
;     * Only FreeRTOS functions that end in FromISR can be called from interrupts
;     * that have been assigned a priority at or (logically) below the maximum
;     * system call interrupt priority.  FreeRTOS maintains a separate interrupt
;     * safe API to ensure interrupt entry is as fast and as simple as possible.
;     * More information (albeit Cortex-M specific) is provided on the following
;     * link: https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;    portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L144+uxSavedInterruptStatus_1
;    {
;        const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
;
;        /* When the queue is used to implement a semaphore no data is ever
;         * moved through the queue but it is still valid to see if the queue 'has
;         * space'. */
;        if( uxMessagesWaiting < pxQueue->uxLength )
uxMessagesWaiting_2	set	8
	ldy	#$34
	lda	[<L144+pxQueue_1],Y
	sta	<L144+uxMessagesWaiting_2
;        {
	iny
	iny
	cmp	[<L144+pxQueue_1],Y
	bcc	*+5
	brl	L10257
;            const int8_t cTxLock = pxQueue->cTxLock;
;
;            traceQUEUE_SEND_FROM_ISR( pxQueue );
cTxLock_3	set	10
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L144+pxQueue_1],Y
	sta	<L144+cTxLock_3
	rep	#$20
	longa	on
;
;            /* A task can only have an inherited priority if it is a mutex
;             * holder - and if there is a mutex holder then the mutex cannot be
;             * given from an ISR.  As this is the ISR version of the function it
;             * can be assumed there is no mutex holder and no need to determine if
;             * priority disinheritance is needed.  Simply increase the count of
;             * messages (semaphores) available. */
;            pxQueue->uxMessagesWaiting = ( UBaseType_t ) ( uxMessagesWaiting + ( UBaseType_t ) 1 );
	lda	<L144+uxMessagesWaiting_2
	ina
	ldy	#$34
	sta	[<L144+pxQueue_1],Y
;
;            /* The event list is not altered if the queue is locked.  This will
;             * be done when the queue is unlocked later. */
;            if( cTxLock == queueUNLOCKED )
;            {
	sep	#$20
	longa	off
	lda	<L144+cTxLock_3
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10268
;                #if ( configUSE_QUEUE_SETS == 1 )
;                {
;                    if( pxQueue->pxQueueSetContainer != NULL )
;                    {
;                        if( prvNotifyQueueSetContainer( pxQueue ) != pdFALSE )
;                        {
;                            /* The semaphore is a member of a queue set, and
;                             * posting to the queue set caused a higher priority
;                             * task to unblock.  A context switch is required. */
;                            if( pxHigherPriorityTaskWoken != NULL )
;                            {
;                                *pxHigherPriorityTaskWoken = pdTRUE;
;                            }
;                            else
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else
;                    {
;                        if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                        {
;                            if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                            {
;                                /* The task waiting has a higher priority so
;                                 *  record that a context switch is required. */
;                                if( pxHigherPriorityTaskWoken != NULL )
;                                {
;                                    *pxHigherPriorityTaskWoken = pdTRUE;
;                                }
;                                else
;                                {
;                                    mtCOVERAGE_TEST_MARKER();
;                                }
;                            }
;                            else
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                }
;                #else /* configUSE_QUEUE_SETS */
;                {
;                    if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                    {
	ldy	#$22
	lda	[<L144+pxQueue_1],Y
	bne	L154
	lda	#$1
	bra	L156
L154:
	lda	#$0
L156:
	tax
	bne	L10265
;                        if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                        {
	lda	#$22
	clc
	adc	<L144+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L144+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10265
;                            /* The task waiting has a higher priority so record that a
;                             * context switch is required. */
;                            if( pxHigherPriorityTaskWoken != NULL )
;                            {
	lda	<L143+pxHigherPriorityTaskWoken_0
	ora	<L143+pxHigherPriorityTaskWoken_0+2
	beq	L10265
;                                *pxHigherPriorityTaskWoken = pdTRUE;
	lda	#$1
	sta	[<L143+pxHigherPriorityTaskWoken_0]
;                            }
;                            else
;                    }
;                    else
	bra	L10265
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                #endif /* configUSE_QUEUE_SETS */
;            }
;            else
;            {
;                /* Increment the lock count so the task that unlocks the queue
;                 * knows that data was posted while it was locked. */
;                prvIncrementQueueTxLock( pxQueue, cTxLock );
L10268:
uxNumberOfTasks_4	set	11
	jsr	_~uxTaskGetNumberOfTasks
	sta	<L144+uxNumberOfTasks_4
	lda	<L144+cTxLock_3
	and	#$ff
	bit	#$80
	beq	L160
	ora	#$ff00
L160:
	cmp	<L144+uxNumberOfTasks_4
	bcs	L10265
	sep	#$20
	longa	off
	lda	<L144+cTxLock_3
	cmp	#<$7f
	rep	#$20
	longa	on
	bne	L10270
L10274:
	bra	L10274
L10270:
	sep	#$20
	longa	off
	lda	<L144+cTxLock_3
	ina
	ldy	#$3b
	sta	[<L144+pxQueue_1],Y
	rep	#$20
	longa	on
;            }
L10265:
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L144+xReturn_1
;        }
;        else
	bra	L10277
L10257:
;        {
;            traceQUEUE_SEND_FROM_ISR_FAILED( pxQueue );
;            xReturn = errQUEUE_FULL;
	stz	<L144+xReturn_1
;        }
L10277:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xQueueGiveFromISR( xReturn );
;
;    return xReturn;
	lda	<L144+xReturn_1
	tay
	lda	<L143+1
	sta	<L143+1+8
	pld
	tsc
	clc
	adc	#L143+8
	tcs
	tya
	rts
;}
L143	equ	17
L144	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueReceive( QueueHandle_t xQueue,
;                          void * const pvBuffer,
;                          TickType_t xTicksToWait )
;{
	code
	xdef	_~xQueueReceive
	func
_~xQueueReceive:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L164
	tcs
	phd
	tcd
xQueue_0	set	3
pvBuffer_0	set	7
xTicksToWait_0	set	11
;    BaseType_t xEntryTimeSet = pdFALSE;
;    TimeOut_t xTimeOut;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueReceive( xQueue, pvBuffer, xTicksToWait );
xEntryTimeSet_1	set	0
xTimeOut_1	set	2
pxQueue_1	set	8
	stz	<L165+xEntryTimeSet_1
	lda	<L164+xQueue_0
	sta	<L165+pxQueue_1
	lda	<L164+xQueue_0+2
	sta	<L165+pxQueue_1+2
;
;    /* Check the pointer is not NULL. */
;    configASSERT( ( pxQueue ) );
	lda	<L165+pxQueue_1
	ora	<L165+pxQueue_1+2
	bne	L10278
L10282:
	bra	L10282
L10278:
;
;    /* The buffer into which data is received can only be NULL if the data size
;     * is zero (so no data is copied into the buffer). */
;    configASSERT( !( ( ( pvBuffer ) == NULL ) && ( ( pxQueue )->uxItemSize != ( UBaseType_t ) 0U ) ) );
	lda	<L164+pvBuffer_0
	ora	<L164+pvBuffer_0+2
	bne	L10285
	ldy	#$38
	lda	[<L165+pxQueue_1],Y
	beq	L10285
L10289:
	bra	L10289
L10285:
;
;    /* Cannot block if the scheduler is suspended. */
;    #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;    {
;        configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	beq	*+5
	brl	L10303
	lda	<L164+xTicksToWait_0
	ora	<L164+xTicksToWait_0+2
	bne	*+5
	brl	L10303
L10296:
	bra	L10296
;    }
;    #endif
;
;    for( ; ; )
;    {
;        taskENTER_CRITICAL();
L172:
	lda	#$0
L174:
	tax
	bne	L10311
;                    if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                    {
	lda	#$10
	clc
	adc	<L165+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L165+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10311
;                        queueYIELD_IF_USING_PREEMPTION();
	jsr	_~vPortYield
;                    }
;                    else
L10311:
;
;                traceRETURN_xQueueReceive( pdPASS );
;
;                return pdPASS;
	lda	#$1
	brl	L177
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;
;                taskEXIT_CRITICAL();
;            }
;            else
L10305:
;            {
;                if( xTicksToWait == ( TickType_t ) 0 )
;                {
	lda	<L164+xTicksToWait_0
	ora	<L164+xTicksToWait_0+2
	bne	*+5
	brl	L20006
;                }
;                else if( xEntryTimeSet == pdFALSE )
;                {
	lda	<L165+xEntryTimeSet_1
	bne	L10320
;                    /* The queue was empty and a block time was specified so
;                     * configure the timeout structure. */
;                    vTaskInternalSetTimeOutState( &xTimeOut );
	pea	#0
	clc
	tdc
	adc	#<L165+xTimeOut_1
	pha
	jsr	_~vTaskInternalSetTimeOutState
;                    xEntryTimeSet = pdTRUE;
	lda	#$1
	sta	<L165+xEntryTimeSet_1
;                }
;                else
;                {
;                    /* Entry time was already set. */
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;        taskEXIT_CRITICAL();
L10320:
;
;        /* Interrupts and other tasks can send to and receive from the queue
;         * now the critical section has been exited. */
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        prvLockQueue( pxQueue );
	sep	#$20
	longa	off
	ldy	#$3a
	lda	[<L165+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10325
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L165+pxQueue_1],Y
	rep	#$20
	longa	on
L10325:
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L165+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10328
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L165+pxQueue_1],Y
	rep	#$20
	longa	on
L10328:
;
;        /* Update the timeout state to see if it has expired yet. */
;        if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE )
;        {
	pea	#0
	clc
	tdc
	adc	#<L164+xTicksToWait_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L165+xTimeOut_1
	pha
	jsr	_~xTaskCheckForTimeOut
	tax
	bne	L10330
;            /* The timeout has not expired.  If the queue is still empty place
;             * the task on the list of tasks waiting to receive from the queue. */
;            if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
;            {
	pei	<L165+pxQueue_1+2
	pei	<L165+pxQueue_1
	jsr	_~prvIsQueueEmpty
	tax
	beq	L10331
;                traceBLOCKING_ON_QUEUE_RECEIVE( pxQueue );
;                vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToReceive ), xTicksToWait );
	pei	<L164+xTicksToWait_0+2
	pei	<L164+xTicksToWait_0
	lda	#$22
	clc
	adc	<L165+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L165+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vTaskPlaceOnEventList
;                prvUnlockQueue( pxQueue );
	pei	<L165+pxQueue_1+2
	pei	<L165+pxQueue_1
	jsr	_~prvUnlockQueue
;
;                if( xTaskResumeAll() == pdFALSE )
;                {
	jsr	_~xTaskResumeAll
	tax
	bne	L10303
;                    taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;                }
;                else
	bra	L10303
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10331:
;            {
;                /* The queue contains data again.  Loop back to try and read the
;                 * data. */
;                prvUnlockQueue( pxQueue );
	pei	<L165+pxQueue_1+2
	pei	<L165+pxQueue_1
	jsr	_~prvUnlockQueue
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;        }
;        else
;            }
;            else
L10303:
;        {
;            const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
;
;            /* Is there data in the queue now?  To be running the calling task
;             * must be the highest priority task wanting to access the queue. */
;            if( uxMessagesWaiting > ( UBaseType_t ) 0 )
uxMessagesWaiting_2	set	12
	ldy	#$34
	lda	[<L165+pxQueue_1],Y
	sta	<L165+uxMessagesWaiting_2
;            {
	lda	#$0
	cmp	<L165+uxMessagesWaiting_2
	bcc	*+5
	brl	L10305
;                /* Data available, remove one item. */
;                prvCopyDataFromQueue( pxQueue, pvBuffer );
	pei	<L164+pvBuffer_0+2
	pei	<L164+pvBuffer_0
	pei	<L165+pxQueue_1+2
	pei	<L165+pxQueue_1
	jsr	_~prvCopyDataFromQueue
;                traceQUEUE_RECEIVE( pxQueue );
;                pxQueue->uxMessagesWaiting = ( UBaseType_t ) ( uxMessagesWaiting - ( UBaseType_t ) 1 );
	lda	#$ffff
	clc
	adc	<L165+uxMessagesWaiting_2
	ldy	#$34
	sta	[<L165+pxQueue_1],Y
;
;                /* There is now space in the queue, were any tasks waiting to
;                 * post to the queue?  If so, unblock the highest priority waiting
;                 * task. */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;                {
	ldy	#$10
	lda	[<L165+pxQueue_1],Y
	beq	*+5
	brl	L172
	lda	#$1
	brl	L174
L10330:
;        {
;            /* Timed out.  If there is no data in the queue exit, otherwise loop
;             * back and attempt to read the data. */
;            prvUnlockQueue( pxQueue );
	pei	<L165+pxQueue_1+2
	pei	<L165+pxQueue_1
	jsr	_~prvUnlockQueue
;            ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;            if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
;            {
	pei	<L165+pxQueue_1+2
	pei	<L165+pxQueue_1
	jsr	_~prvIsQueueEmpty
	tax
	beq	L10303
;                traceQUEUE_RECEIVE_FAILED( pxQueue );
;                traceRETURN_xQueueReceive( errQUEUE_EMPTY );
;
;                return errQUEUE_EMPTY;
L20006:
;                    /* The queue was empty and no block time is specified (or
;                     * the block time has expired) so leave now. */
;                    taskEXIT_CRITICAL();
;
;                    traceQUEUE_RECEIVE_FAILED( pxQueue );
;                    traceRETURN_xQueueReceive( errQUEUE_EMPTY );
;
;                    return errQUEUE_EMPTY;
	lda	#$0
L177:
	tay
	lda	<L164+1
	sta	<L164+1+12
	pld
	tsc
	clc
	adc	#L164+12
	tcs
	tya
	rts
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;    }
;}
L164	equ	18
L165	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueSemaphoreTake( QueueHandle_t xQueue,
;                                TickType_t xTicksToWait )
;{
	code
	xdef	_~xQueueSemaphoreTake
	func
_~xQueueSemaphoreTake:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L186
	tcs
	phd
	tcd
xQueue_0	set	3
xTicksToWait_0	set	7
;    BaseType_t xEntryTimeSet = pdFALSE;
;    TimeOut_t xTimeOut;
;    Queue_t * const pxQueue = xQueue;
;
;    #if ( configUSE_MUTEXES == 1 )
;        BaseType_t xInheritanceOccurred = pdFALSE;
;    #endif
;
;    traceENTER_xQueueSemaphoreTake( xQueue, xTicksToWait );
xEntryTimeSet_1	set	0
xTimeOut_1	set	2
pxQueue_1	set	8
xInheritanceOccurred_1	set	12
	stz	<L187+xEntryTimeSet_1
	lda	<L186+xQueue_0
	sta	<L187+pxQueue_1
	lda	<L186+xQueue_0+2
	sta	<L187+pxQueue_1+2
	stz	<L187+xInheritanceOccurred_1
;
;    /* Check the queue pointer is not NULL. */
;    configASSERT( ( pxQueue ) );
	lda	<L187+pxQueue_1
	ora	<L187+pxQueue_1+2
	bne	L10337
L10341:
	bra	L10341
L10337:
;
;    /* Check this really is a semaphore, in which case the item size will be
;     * 0. */
;    configASSERT( pxQueue->uxItemSize == 0 );
	ldy	#$38
	lda	[<L187+pxQueue_1],Y
	beq	L10344
L10348:
	bra	L10348
L10344:
;
;    /* Cannot block if the scheduler is suspended. */
;    #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;    {
;        configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	beq	*+5
	brl	L10362
	lda	<L186+xTicksToWait_0
	ora	<L186+xTicksToWait_0+2
	bne	*+5
	brl	L10362
L10355:
	bra	L10355
;    }
;    #endif
;
;    for( ; ; )
;    {
;        taskENTER_CRITICAL();
L194:
	lda	#$0
L196:
	tax
	bne	L10372
;                    if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                    {
	lda	#$10
	clc
	adc	<L187+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L187+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10372
;                        queueYIELD_IF_USING_PREEMPTION();
	jsr	_~vPortYield
;                    }
;                    else
L10372:
;
;                traceRETURN_xQueueSemaphoreTake( pdPASS );
;
;                return pdPASS;
	lda	#$1
	brl	L199
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;
;                taskEXIT_CRITICAL();
;            }
;            else
L10364:
;            {
;                if( xTicksToWait == ( TickType_t ) 0 )
;                {
	lda	<L186+xTicksToWait_0
	ora	<L186+xTicksToWait_0+2
	bne	*+5
	brl	L20008
;                }
;                else if( xEntryTimeSet == pdFALSE )
;                {
	lda	<L187+xEntryTimeSet_1
	bne	L10381
;                    /* The semaphore count was 0 and a block time was specified
;                     * so configure the timeout structure ready to block. */
;                    vTaskInternalSetTimeOutState( &xTimeOut );
	pea	#0
	clc
	tdc
	adc	#<L187+xTimeOut_1
	pha
	jsr	_~vTaskInternalSetTimeOutState
;                    xEntryTimeSet = pdTRUE;
	lda	#$1
	sta	<L187+xEntryTimeSet_1
;                }
;                else
;                {
;                    /* Entry time was already set. */
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;        taskEXIT_CRITICAL();
L10381:
;
;        /* Interrupts and other tasks can give to and take from the semaphore
;         * now the critical section has been exited. */
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        prvLockQueue( pxQueue );
	sep	#$20
	longa	off
	ldy	#$3a
	lda	[<L187+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10386
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L187+pxQueue_1],Y
	rep	#$20
	longa	on
L10386:
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L187+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10389
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L187+pxQueue_1],Y
	rep	#$20
	longa	on
L10389:
;
;        /* Update the timeout state to see if it has expired yet. */
;        if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE )
;        {
	pea	#0
	clc
	tdc
	adc	#<L186+xTicksToWait_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L187+xTimeOut_1
	pha
	jsr	_~xTaskCheckForTimeOut
	tax
	beq	*+5
	brl	L10391
;            /* A block time is specified and not expired.  If the semaphore
;             * count is 0 then enter the Blocked state to wait for a semaphore to
;             * become available.  As semaphores are implemented with queues the
;             * queue being empty is equivalent to the semaphore count being 0. */
;            if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
;            {
	pei	<L187+pxQueue_1+2
	pei	<L187+pxQueue_1
	jsr	_~prvIsQueueEmpty
	tax
	beq	L10392
;                traceBLOCKING_ON_QUEUE_RECEIVE( pxQueue );
;
;                #if ( configUSE_MUTEXES == 1 )
;                {
;                    if( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX )
;                    {
	lda	[<L187+pxQueue_1]
	ldy	#$2
	ora	[<L187+pxQueue_1],Y
	bne	L10400
;                        taskENTER_CRITICAL();
;                        {
;                            xInheritanceOccurred = xTaskPriorityInherit( pxQueue->u.xSemaphore.xMutexHolder );
	ldy	#$a
	lda	[<L187+pxQueue_1],Y
	pha
	dey
	dey
	lda	[<L187+pxQueue_1],Y
	pha
	jsr	_~xTaskPriorityInherit
	sta	<L187+xInheritanceOccurred_1
;                        }
;                        taskEXIT_CRITICAL();
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10400:
;                }
;                #endif /* if ( configUSE_MUTEXES == 1 ) */
;
;                vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToReceive ), xTicksToWait );
	pei	<L186+xTicksToWait_0+2
	pei	<L186+xTicksToWait_0
	lda	#$22
	clc
	adc	<L187+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L187+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vTaskPlaceOnEventList
;                prvUnlockQueue( pxQueue );
	pei	<L187+pxQueue_1+2
	pei	<L187+pxQueue_1
	jsr	_~prvUnlockQueue
;
;                if( xTaskResumeAll() == pdFALSE )
;                {
	jsr	_~xTaskResumeAll
	tax
	bne	L10362
;                    taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;                }
;                else
	bra	L10362
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10392:
;            {
;                /* There was no timeout and the semaphore count was not 0, so
;                 * attempt to take the semaphore again. */
;                prvUnlockQueue( pxQueue );
	pei	<L187+pxQueue_1+2
	pei	<L187+pxQueue_1
	jsr	_~prvUnlockQueue
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;        }
;        else
;            }
;            else
L10362:
;        {
;            /* Semaphores are queues with an item size of 0, and where the
;             * number of messages in the queue is the semaphore's count value. */
;            const UBaseType_t uxSemaphoreCount = pxQueue->uxMessagesWaiting;
;
;            /* Is there data in the queue now?  To be running the calling task
;             * must be the highest priority task wanting to access the queue. */
;            if( uxSemaphoreCount > ( UBaseType_t ) 0 )
uxSemaphoreCount_2	set	14
	ldy	#$34
	lda	[<L187+pxQueue_1],Y
	sta	<L187+uxSemaphoreCount_2
;            {
	lda	#$0
	cmp	<L187+uxSemaphoreCount_2
	bcc	*+5
	brl	L10364
;                traceQUEUE_RECEIVE( pxQueue );
;
;                /* Semaphores are queues with a data size of zero and where the
;                 * messages waiting is the semaphore's count.  Reduce the count. */
;                pxQueue->uxMessagesWaiting = ( UBaseType_t ) ( uxSemaphoreCount - ( UBaseType_t ) 1 );
	lda	#$ffff
	clc
	adc	<L187+uxSemaphoreCount_2
	sta	[<L187+pxQueue_1],Y
;
;                #if ( configUSE_MUTEXES == 1 )
;                {
;                    if( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX )
;                    {
	lda	[<L187+pxQueue_1]
	ldy	#$2
	ora	[<L187+pxQueue_1],Y
	bne	L10366
;                        /* Record the information required to implement
;                         * priority inheritance should it become necessary. */
;                        pxQueue->u.xSemaphore.xMutexHolder = pvTaskIncrementMutexHeldCount();
	jsr	_~pvTaskIncrementMutexHeldCount
	stx	<R0+2
	ldy	#$8
	sta	[<L187+pxQueue_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L187+pxQueue_1],Y
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10366:
;                }
;                #endif /* configUSE_MUTEXES */
;
;                /* Check to see if other tasks are blocked waiting to give the
;                 * semaphore, and if so, unblock the highest priority such task. */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;                {
	ldy	#$10
	lda	[<L187+pxQueue_1],Y
	beq	*+5
	brl	L194
	lda	#$1
	brl	L196
L10391:
;        {
;            /* Timed out. */
;            prvUnlockQueue( pxQueue );
	pei	<L187+pxQueue_1+2
	pei	<L187+pxQueue_1
	jsr	_~prvUnlockQueue
;            ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;            /* If the semaphore count is 0 exit now as the timeout has
;             * expired.  Otherwise return to attempt to take the semaphore that is
;             * known to be available.  As semaphores are implemented by queues the
;             * queue being empty is equivalent to the semaphore count being 0. */
;            if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
;            {
	pei	<L187+pxQueue_1+2
	pei	<L187+pxQueue_1
	jsr	_~prvIsQueueEmpty
	tax
	beq	L10362
;                #if ( configUSE_MUTEXES == 1 )
;                {
;                    /* xInheritanceOccurred could only have be set if
;                     * pxQueue->uxQueueType == queueQUEUE_IS_MUTEX so no need to
;                     * test the mutex type again to check it is actually a mutex. */
;                    if( xInheritanceOccurred != pdFALSE )
;                    {
	lda	<L187+xInheritanceOccurred_1
	beq	L20008
;                        taskENTER_CRITICAL();
;                        {
;                            UBaseType_t uxHighestWaitingPriority;
;
;                            /* This task blocking on the mutex caused another
;                             * task to inherit this task's priority.  Now this task
;                             * has timed out the priority should be disinherited
;                             * again, but only as low as the next highest priority
;                             * task that is waiting for the same mutex. */
;                            uxHighestWaitingPriority = prvGetHighestPriorityOfWaitToReceiveList( pxQueue );
uxHighestWaitingPriority_3	set	14
	pei	<L187+pxQueue_1+2
	pei	<L187+pxQueue_1
	jsr	_~prvGetHighestPriorityOfWaitToReceiveList
	sta	<L187+uxHighestWaitingPriority_3
;
;                            /* vTaskPriorityDisinheritAfterTimeout uses the uxHighestWaitingPriority
;                             * parameter to index pxReadyTasksLists when adding the task holding
;                             * mutex to the ready list for its new priority. Coverity thinks that
;                             * it can result in out-of-bounds access which is not true because
;                             * uxHighestWaitingPriority, as returned by prvGetHighestPriorityOfWaitToReceiveList,
;                             * is capped at ( configMAX_PRIORITIES - 1 ). */
;                            /* coverity[overrun] */
;                            vTaskPriorityDisinheritAfterTimeout( pxQueue->u.xSemaphore.xMutexHolder, uxHighestWaitingPriority );
	pha
	ldy	#$a
	lda	[<L187+pxQueue_1],Y
	pha
	dey
	dey
	lda	[<L187+pxQueue_1],Y
	pha
	jsr	_~vTaskPriorityDisinheritAfterTimeout
;                        }
;                        taskEXIT_CRITICAL();
;                    }
;                }
;                #endif /* configUSE_MUTEXES */
;
;                traceQUEUE_RECEIVE_FAILED( pxQueue );
;                traceRETURN_xQueueSemaphoreTake( errQUEUE_EMPTY );
;
;                return errQUEUE_EMPTY;
L20008:
;                    /* The semaphore count was 0 and no block time is specified
;                     * (or the block time has expired) so exit now. */
;                    taskEXIT_CRITICAL();
;
;                    traceQUEUE_RECEIVE_FAILED( pxQueue );
;                    traceRETURN_xQueueSemaphoreTake( errQUEUE_EMPTY );
;
;                    return errQUEUE_EMPTY;
	lda	#$0
L199:
	tay
	lda	<L186+1
	sta	<L186+1+8
	pld
	tsc
	clc
	adc	#L186+8
	tcs
	tya
	rts
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;    }
;}
L186	equ	20
L187	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueuePeek( QueueHandle_t xQueue,
;                       void * const pvBuffer,
;                       TickType_t xTicksToWait )
;{
	code
	xdef	_~xQueuePeek
	func
_~xQueuePeek:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L210
	tcs
	phd
	tcd
xQueue_0	set	3
pvBuffer_0	set	7
xTicksToWait_0	set	11
;    BaseType_t xEntryTimeSet = pdFALSE;
;    TimeOut_t xTimeOut;
;    int8_t * pcOriginalReadPosition;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueuePeek( xQueue, pvBuffer, xTicksToWait );
xEntryTimeSet_1	set	0
xTimeOut_1	set	2
pcOriginalReadPosition_1	set	8
pxQueue_1	set	12
	stz	<L211+xEntryTimeSet_1
	lda	<L210+xQueue_0
	sta	<L211+pxQueue_1
	lda	<L210+xQueue_0+2
	sta	<L211+pxQueue_1+2
;
;    /* The buffer into which data is received can only be NULL if the data size
;     * is zero (so no data is copied into the buffer. */
;    configASSERT( ( pxQueue != NULL ) && !( ( ( pvBuffer ) == NULL ) && ( ( pxQueue )->uxItemSize != ( UBaseType_t ) 0U ) ) );
	lda	<L211+pxQueue_1
	ora	<L211+pxQueue_1+2
	beq	L10417
	lda	<L210+pvBuffer_0
	ora	<L210+pvBuffer_0+2
	bne	L10413
	ldy	#$38
	lda	[<L211+pxQueue_1],Y
	beq	L10413
L10417:
	bra	L10417
L10413:
;
;    /* Cannot block if the scheduler is suspended. */
;    #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;    {
;        configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	beq	*+5
	brl	L10431
	lda	<L210+xTicksToWait_0
	ora	<L210+xTicksToWait_0+2
	bne	*+5
	brl	L10431
L10424:
	bra	L10424
;    }
;    #endif
;
;    for( ; ; )
;    {
;        taskENTER_CRITICAL();
L219:
	lda	#$0
L221:
	tax
	bne	L10439
;                    if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                    {
	lda	#$22
	clc
	adc	<L211+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L211+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10439
;                        /* The task waiting has a higher priority than this task. */
;                        queueYIELD_IF_USING_PREEMPTION();
	jsr	_~vPortYield
;                    }
;                    else
L10439:
;
;                traceRETURN_xQueuePeek( pdPASS );
;
;                return pdPASS;
	lda	#$1
	brl	L224
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;
;                taskEXIT_CRITICAL();
;            }
;            else
L10433:
;            {
;                if( xTicksToWait == ( TickType_t ) 0 )
;                {
	lda	<L210+xTicksToWait_0
	ora	<L210+xTicksToWait_0+2
	bne	*+5
	brl	L20010
;                }
;                else if( xEntryTimeSet == pdFALSE )
;                {
	lda	<L211+xEntryTimeSet_1
	bne	L10448
;                    /* The queue was empty and a block time was specified so
;                     * configure the timeout structure ready to enter the blocked
;                     * state. */
;                    vTaskInternalSetTimeOutState( &xTimeOut );
	pea	#0
	clc
	tdc
	adc	#<L211+xTimeOut_1
	pha
	jsr	_~vTaskInternalSetTimeOutState
;                    xEntryTimeSet = pdTRUE;
	lda	#$1
	sta	<L211+xEntryTimeSet_1
;                }
;                else
;                {
;                    /* Entry time was already set. */
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;        taskEXIT_CRITICAL();
L10448:
;
;        /* Interrupts and other tasks can send to and receive from the queue
;         * now that the critical section has been exited. */
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        prvLockQueue( pxQueue );
	sep	#$20
	longa	off
	ldy	#$3a
	lda	[<L211+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10453
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L211+pxQueue_1],Y
	rep	#$20
	longa	on
L10453:
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L211+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10456
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L211+pxQueue_1],Y
	rep	#$20
	longa	on
L10456:
;
;        /* Update the timeout state to see if it has expired yet. */
;        if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE )
;        {
	pea	#0
	clc
	tdc
	adc	#<L210+xTicksToWait_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L211+xTimeOut_1
	pha
	jsr	_~xTaskCheckForTimeOut
	tax
	beq	*+5
	brl	L10458
;            /* Timeout has not expired yet, check to see if there is data in the
;            * queue now, and if not enter the Blocked state to wait for data. */
;            if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
;            {
	pei	<L211+pxQueue_1+2
	pei	<L211+pxQueue_1
	jsr	_~prvIsQueueEmpty
	tax
	beq	L10459
;                traceBLOCKING_ON_QUEUE_PEEK( pxQueue );
;                vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToReceive ), xTicksToWait );
	pei	<L210+xTicksToWait_0+2
	pei	<L210+xTicksToWait_0
	lda	#$22
	clc
	adc	<L211+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L211+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vTaskPlaceOnEventList
;                prvUnlockQueue( pxQueue );
	pei	<L211+pxQueue_1+2
	pei	<L211+pxQueue_1
	jsr	_~prvUnlockQueue
;
;                if( xTaskResumeAll() == pdFALSE )
;                {
	jsr	_~xTaskResumeAll
	tax
	bne	L10431
;                    taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;                }
;                else
	bra	L10431
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10459:
;            {
;                /* There is data in the queue now, so don't enter the blocked
;                 * state, instead return to try and obtain the data. */
;                prvUnlockQueue( pxQueue );
	pei	<L211+pxQueue_1+2
	pei	<L211+pxQueue_1
	jsr	_~prvUnlockQueue
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;        }
;        else
;            }
;            else
L10431:
;        {
;            const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
;
;            /* Is there data in the queue now?  To be running the calling task
;             * must be the highest priority task wanting to access the queue. */
;            if( uxMessagesWaiting > ( UBaseType_t ) 0 )
uxMessagesWaiting_2	set	16
	ldy	#$34
	lda	[<L211+pxQueue_1],Y
	sta	<L211+uxMessagesWaiting_2
;            {
	lda	#$0
	cmp	<L211+uxMessagesWaiting_2
	bcc	*+5
	brl	L10433
;                /* Remember the read position so it can be reset after the data
;                 * is read from the queue as this function is only peeking the
;                 * data, not removing it. */
;                pcOriginalReadPosition = pxQueue->u.xQueue.pcReadFrom;
	ldy	#$c
	lda	[<L211+pxQueue_1],Y
	sta	<L211+pcOriginalReadPosition_1
	iny
	iny
	lda	[<L211+pxQueue_1],Y
	sta	<L211+pcOriginalReadPosition_1+2
;
;                prvCopyDataFromQueue( pxQueue, pvBuffer );
	pei	<L210+pvBuffer_0+2
	pei	<L210+pvBuffer_0
	pei	<L211+pxQueue_1+2
	pei	<L211+pxQueue_1
	jsr	_~prvCopyDataFromQueue
;                traceQUEUE_PEEK( pxQueue );
;
;                /* The data is not being removed, so reset the read pointer. */
;                pxQueue->u.xQueue.pcReadFrom = pcOriginalReadPosition;
	lda	<L211+pcOriginalReadPosition_1
	ldy	#$c
	sta	[<L211+pxQueue_1],Y
	lda	<L211+pcOriginalReadPosition_1+2
	iny
	iny
	sta	[<L211+pxQueue_1],Y
;
;                /* The data is being left in the queue, so see if there are
;                 * any other tasks waiting for the data. */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                {
	ldy	#$22
	lda	[<L211+pxQueue_1],Y
	beq	*+5
	brl	L219
	lda	#$1
	brl	L221
L10458:
;        {
;            /* The timeout has expired.  If there is still no data in the queue
;             * exit, otherwise go back and try to read the data again. */
;            prvUnlockQueue( pxQueue );
	pei	<L211+pxQueue_1+2
	pei	<L211+pxQueue_1
	jsr	_~prvUnlockQueue
;            ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;            if( prvIsQueueEmpty( pxQueue ) != pdFALSE )
;            {
	pei	<L211+pxQueue_1+2
	pei	<L211+pxQueue_1
	jsr	_~prvIsQueueEmpty
	tax
	beq	L10431
;                traceQUEUE_PEEK_FAILED( pxQueue );
;                traceRETURN_xQueuePeek( errQUEUE_EMPTY );
;
;                return errQUEUE_EMPTY;
L20010:
;                    /* The queue was empty and no block time is specified (or
;                     * the block time has expired) so leave now. */
;                    taskEXIT_CRITICAL();
;
;                    traceQUEUE_PEEK_FAILED( pxQueue );
;                    traceRETURN_xQueuePeek( errQUEUE_EMPTY );
;
;                    return errQUEUE_EMPTY;
	lda	#$0
L224:
	tay
	lda	<L210+1
	sta	<L210+1+12
	pld
	tsc
	clc
	adc	#L210+12
	tcs
	tya
	rts
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;    }
;}
L210	equ	22
L211	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue,
;                                 void * const pvBuffer,
;                                 BaseType_t * const pxHigherPriorityTaskWoken )
;{
	code
	xdef	_~xQueueReceiveFromISR
	func
_~xQueueReceiveFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L233
	tcs
	phd
	tcd
xQueue_0	set	3
pvBuffer_0	set	7
pxHigherPriorityTaskWoken_0	set	11
;    BaseType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueReceiveFromISR( xQueue, pvBuffer, pxHigherPriorityTaskWoken );
xReturn_1	set	0
uxSavedInterruptStatus_1	set	2
pxQueue_1	set	4
	lda	<L233+xQueue_0
	sta	<L234+pxQueue_1
	lda	<L233+xQueue_0+2
	sta	<L234+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L234+pxQueue_1
	ora	<L234+pxQueue_1+2
	bne	L10465
L10469:
	bra	L10469
L10465:
;    configASSERT( !( ( pvBuffer == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
	lda	<L233+pvBuffer_0
	ora	<L233+pvBuffer_0+2
	bne	L10472
	ldy	#$38
	lda	[<L234+pxQueue_1],Y
	beq	L10472
L10476:
	bra	L10476
L10472:
;
;    /* RTOS ports that support interrupt nesting have the concept of a maximum
;     * system call (or maximum API call) interrupt priority.  Interrupts that are
;     * above the maximum system call priority are kept permanently enabled, even
;     * when the RTOS kernel is in a critical section, but cannot make any calls to
;     * FreeRTOS API functions.  If configASSERT() is defined in FreeRTOSConfig.h
;     * then portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;     * failure if a FreeRTOS API function is called from an interrupt that has been
;     * assigned a priority above the configured maximum system call priority.
;     * Only FreeRTOS functions that end in FromISR can be called from interrupts
;     * that have been assigned a priority at or (logically) below the maximum
;     * system call interrupt priority.  FreeRTOS maintains a separate interrupt
;     * safe API to ensure interrupt entry is as fast and as simple as possible.
;     * More information (albeit Cortex-M specific) is provided on the following
;     * link: https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;    portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L234+uxSavedInterruptStatus_1
;    {
;        const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
;
;        /* Cannot block in an ISR, so check there is data available. */
;        if( uxMessagesWaiting > ( UBaseType_t ) 0 )
uxMessagesWaiting_2	set	8
	ldy	#$34
	lda	[<L234+pxQueue_1],Y
	sta	<L234+uxMessagesWaiting_2
;        {
	lda	#$0
	cmp	<L234+uxMessagesWaiting_2
	bcc	*+5
	brl	L10479
;            const int8_t cRxLock = pxQueue->cRxLock;
;
;            traceQUEUE_RECEIVE_FROM_ISR( pxQueue );
cRxLock_3	set	10
	sep	#$20
	longa	off
	ldy	#$3a
	lda	[<L234+pxQueue_1],Y
	sta	<L234+cRxLock_3
	rep	#$20
	longa	on
;
;            prvCopyDataFromQueue( pxQueue, pvBuffer );
	pei	<L233+pvBuffer_0+2
	pei	<L233+pvBuffer_0
	pei	<L234+pxQueue_1+2
	pei	<L234+pxQueue_1
	jsr	_~prvCopyDataFromQueue
;            pxQueue->uxMessagesWaiting = ( UBaseType_t ) ( uxMessagesWaiting - ( UBaseType_t ) 1 );
	lda	#$ffff
	clc
	adc	<L234+uxMessagesWaiting_2
	ldy	#$34
	sta	[<L234+pxQueue_1],Y
;
;            /* If the queue is locked the event list will not be modified.
;             * Instead update the lock count so the task that unlocks the queue
;             * will know that an ISR has removed data while the queue was
;             * locked. */
;            if( cRxLock == queueUNLOCKED )
;            {
	sep	#$20
	longa	off
	lda	<L234+cRxLock_3
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10490
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;                {
	ldy	#$10
	lda	[<L234+pxQueue_1],Y
	bne	L240
	lda	#$1
	bra	L242
L240:
	lda	#$0
L242:
	tax
	bne	L10487
;                    if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                    {
	lda	#$10
	clc
	adc	<L234+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L234+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10487
;                        /* The task waiting has a higher priority than us so
;                         * force a context switch. */
;                        if( pxHigherPriorityTaskWoken != NULL )
;                        {
	lda	<L233+pxHigherPriorityTaskWoken_0
	ora	<L233+pxHigherPriorityTaskWoken_0+2
	beq	L10487
;                            *pxHigherPriorityTaskWoken = pdTRUE;
	lda	#$1
	sta	[<L233+pxHigherPriorityTaskWoken_0]
;                        }
;                        else
;                }
;                else
	bra	L10487
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                /* Increment the lock count so the task that unlocks the queue
;                 * knows that data was removed while it was locked. */
;                prvIncrementQueueRxLock( pxQueue, cRxLock );
L10490:
uxNumberOfTasks_4	set	11
	jsr	_~uxTaskGetNumberOfTasks
	sta	<L234+uxNumberOfTasks_4
	lda	<L234+cRxLock_3
	and	#$ff
	bit	#$80
	beq	L246
	ora	#$ff00
L246:
	cmp	<L234+uxNumberOfTasks_4
	bcs	L10487
	sep	#$20
	longa	off
	lda	<L234+cRxLock_3
	cmp	#<$7f
	rep	#$20
	longa	on
	bne	L10492
L10496:
	bra	L10496
L10492:
	sep	#$20
	longa	off
	lda	<L234+cRxLock_3
	ina
	ldy	#$3a
	sta	[<L234+pxQueue_1],Y
	rep	#$20
	longa	on
;            }
L10487:
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L234+xReturn_1
;        }
;        else
	bra	L10499
L10479:
;        {
;            xReturn = pdFAIL;
	stz	<L234+xReturn_1
;            traceQUEUE_RECEIVE_FROM_ISR_FAILED( pxQueue );
;        }
L10499:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xQueueReceiveFromISR( xReturn );
;
;    return xReturn;
	lda	<L234+xReturn_1
	tay
	lda	<L233+1
	sta	<L233+1+12
	pld
	tsc
	clc
	adc	#L233+12
	tcs
	tya
	rts
;}
L233	equ	17
L234	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue,
;                              void * const pvBuffer )
;{
	code
	xdef	_~xQueuePeekFromISR
	func
_~xQueuePeekFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L250
	tcs
	phd
	tcd
xQueue_0	set	3
pvBuffer_0	set	7
;    BaseType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;    int8_t * pcOriginalReadPosition;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueuePeekFromISR( xQueue, pvBuffer );
xReturn_1	set	0
uxSavedInterruptStatus_1	set	2
pcOriginalReadPosition_1	set	4
pxQueue_1	set	8
	lda	<L250+xQueue_0
	sta	<L251+pxQueue_1
	lda	<L250+xQueue_0+2
	sta	<L251+pxQueue_1+2
;
;    configASSERT( ( pxQueue != NULL ) && !( ( pvBuffer == NULL ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) );
	lda	<L251+pxQueue_1
	ora	<L251+pxQueue_1+2
	beq	L10504
	lda	<L250+pvBuffer_0
	ora	<L250+pvBuffer_0+2
	bne	L10500
	ldy	#$38
	lda	[<L251+pxQueue_1],Y
	beq	L10500
L10504:
	bra	L10504
L10500:
;    configASSERT( ( pxQueue != NULL ) && ( pxQueue->uxItemSize != 0 ) ); /* Can't peek a semaphore. */
	lda	<L251+pxQueue_1
	ora	<L251+pxQueue_1+2
	beq	L10511
	ldy	#$38
	lda	[<L251+pxQueue_1],Y
	bne	L10507
L10511:
	bra	L10511
L10507:
;
;    /* RTOS ports that support interrupt nesting have the concept of a maximum
;     * system call (or maximum API call) interrupt priority.  Interrupts that are
;     * above the maximum system call priority are kept permanently enabled, even
;     * when the RTOS kernel is in a critical section, but cannot make any calls to
;     * FreeRTOS API functions.  If configASSERT() is defined in FreeRTOSConfig.h
;     * then portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;     * failure if a FreeRTOS API function is called from an interrupt that has been
;     * assigned a priority above the configured maximum system call priority.
;     * Only FreeRTOS functions that end in FromISR can be called from interrupts
;     * that have been assigned a priority at or (logically) below the maximum
;     * system call interrupt priority.  FreeRTOS maintains a separate interrupt
;     * safe API to ensure interrupt entry is as fast and as simple as possible.
;     * More information (albeit Cortex-M specific) is provided on the following
;     * link: https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;    portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L251+uxSavedInterruptStatus_1
;    {
;        /* Cannot block in an ISR, so check there is data available. */
;        if( pxQueue->uxMessagesWaiting > ( UBaseType_t ) 0 )
;        {
	lda	#$0
	ldy	#$34
	cmp	[<L251+pxQueue_1],Y
	bcs	L10514
;            traceQUEUE_PEEK_FROM_ISR( pxQueue );
;
;            /* Remember the read position so it can be reset as nothing is
;             * actually being removed from the queue. */
;            pcOriginalReadPosition = pxQueue->u.xQueue.pcReadFrom;
	ldy	#$c
	lda	[<L251+pxQueue_1],Y
	sta	<L251+pcOriginalReadPosition_1
	iny
	iny
	lda	[<L251+pxQueue_1],Y
	sta	<L251+pcOriginalReadPosition_1+2
;            prvCopyDataFromQueue( pxQueue, pvBuffer );
	pei	<L250+pvBuffer_0+2
	pei	<L250+pvBuffer_0
	pei	<L251+pxQueue_1+2
	pei	<L251+pxQueue_1
	jsr	_~prvCopyDataFromQueue
;            pxQueue->u.xQueue.pcReadFrom = pcOriginalReadPosition;
	lda	<L251+pcOriginalReadPosition_1
	ldy	#$c
	sta	[<L251+pxQueue_1],Y
	lda	<L251+pcOriginalReadPosition_1+2
	iny
	iny
	sta	[<L251+pxQueue_1],Y
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L251+xReturn_1
;        }
;        else
	bra	L10515
L10514:
;        {
;            xReturn = pdFAIL;
	stz	<L251+xReturn_1
;            traceQUEUE_PEEK_FROM_ISR_FAILED( pxQueue );
;        }
L10515:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xQueuePeekFromISR( xReturn );
;
;    return xReturn;
	lda	<L251+xReturn_1
	tay
	lda	<L250+1
	sta	<L250+1+8
	pld
	tsc
	clc
	adc	#L250+8
	tcs
	tya
	rts
;}
L250	equ	12
L251	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )
;{
	code
	xdef	_~uxQueueMessagesWaiting
	func
_~uxQueueMessagesWaiting:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L261
	tcs
	phd
	tcd
xQueue_0	set	3
;    UBaseType_t uxReturn;
;
;    traceENTER_uxQueueMessagesWaiting( xQueue );
uxReturn_1	set	0
;
;    configASSERT( xQueue );
	lda	<L261+xQueue_0
	ora	<L261+xQueue_0+2
	bne	L10524
L10520:
	bra	L10520
;
;    portBASE_TYPE_ENTER_CRITICAL();
L10524:
;    {
;        uxReturn = ( ( Queue_t * ) xQueue )->uxMessagesWaiting;
	ldy	#$34
	lda	[<L261+xQueue_0],Y
	sta	<L262+uxReturn_1
;    }
;    portBASE_TYPE_EXIT_CRITICAL();
;
;    traceRETURN_uxQueueMessagesWaiting( uxReturn );
;
;    return uxReturn;
	tay
	lda	<L261+1
	sta	<L261+1+4
	pld
	tsc
	clc
	adc	#L261+4
	tcs
	tya
	rts
;}
L261	equ	2
L262	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxQueueSpacesAvailable( const QueueHandle_t xQueue )
;{
	code
	xdef	_~uxQueueSpacesAvailable
	func
_~uxQueueSpacesAvailable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L265
	tcs
	phd
	tcd
xQueue_0	set	3
;    UBaseType_t uxReturn;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_uxQueueSpacesAvailable( xQueue );
uxReturn_1	set	0
pxQueue_1	set	2
	lda	<L265+xQueue_0
	sta	<L266+pxQueue_1
	lda	<L265+xQueue_0+2
	sta	<L266+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L266+pxQueue_1
	ora	<L266+pxQueue_1+2
	bne	L10537
L10533:
	bra	L10533
;
;    portBASE_TYPE_ENTER_CRITICAL();
L10537:
;    {
;        uxReturn = ( UBaseType_t ) ( pxQueue->uxLength - pxQueue->uxMessagesWaiting );
	sec
	ldy	#$36
	lda	[<L266+pxQueue_1],Y
	dey
	dey
	sbc	[<L266+pxQueue_1],Y
	sta	<L266+uxReturn_1
;    }
;    portBASE_TYPE_EXIT_CRITICAL();
;
;    traceRETURN_uxQueueSpacesAvailable( uxReturn );
;
;    return uxReturn;
	tay
	lda	<L265+1
	sta	<L265+1+4
	pld
	tsc
	clc
	adc	#L265+4
	tcs
	tya
	rts
;}
L265	equ	6
L266	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxQueueMessagesWaitingFromISR( const QueueHandle_t xQueue )
;{
	code
	xdef	_~uxQueueMessagesWaitingFromISR
	func
_~uxQueueMessagesWaitingFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L269
	tcs
	phd
	tcd
xQueue_0	set	3
;    UBaseType_t uxReturn;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_uxQueueMessagesWaitingFromISR( xQueue );
uxReturn_1	set	0
pxQueue_1	set	2
	lda	<L269+xQueue_0
	sta	<L270+pxQueue_1
	lda	<L269+xQueue_0+2
	sta	<L270+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L270+pxQueue_1
	ora	<L270+pxQueue_1+2
	bne	L10542
L10546:
	bra	L10546
L10542:
;    uxReturn = pxQueue->uxMessagesWaiting;
	ldy	#$34
	lda	[<L270+pxQueue_1],Y
	sta	<L270+uxReturn_1
;
;    traceRETURN_uxQueueMessagesWaitingFromISR( uxReturn );
;
;    return uxReturn;
	tay
	lda	<L269+1
	sta	<L269+1+4
	pld
	tsc
	clc
	adc	#L269+4
	tcs
	tya
	rts
;}
L269	equ	6
L270	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vQueueDelete( QueueHandle_t xQueue )
;{
	code
	xdef	_~vQueueDelete
	func
_~vQueueDelete:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L273
	tcs
	phd
	tcd
xQueue_0	set	3
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_vQueueDelete( xQueue );
pxQueue_1	set	0
	lda	<L273+xQueue_0
	sta	<L274+pxQueue_1
	lda	<L273+xQueue_0+2
	sta	<L274+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L274+pxQueue_1
	ora	<L274+pxQueue_1+2
	bne	L10549
L10553:
	bra	L10553
L10549:
;    configASSERT( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) );
	ldy	#$10
	lda	[<L274+pxQueue_1],Y
	bne	L276
	lda	#$1
	bra	L278
L276:
	lda	#$0
L278:
	tax
	bne	L10556
L10560:
	bra	L10560
L10556:
;    configASSERT( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) );
	ldy	#$22
	lda	[<L274+pxQueue_1],Y
	bne	L280
	lda	#$1
	bra	L282
L280:
	lda	#$0
L282:
	tax
	bne	L10563
L10567:
	bra	L10567
L10563:
;    traceQUEUE_DELETE( pxQueue );
;
;    #if ( configQUEUE_REGISTRY_SIZE > 0 )
;    {
;        vQueueUnregisterQueue( pxQueue );
;    }
;    #endif
;
;    #if ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 0 ) )
;    {
;        /* The queue can only have been allocated dynamically - free it
;         * again. */
;        vPortFree( pxQueue );
;    }
;    #elif ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;    {
;        /* The queue could have been allocated statically or dynamically, so
;         * check before attempting to free the memory. */
;        if( pxQueue->ucStaticallyAllocated == ( uint8_t ) pdFALSE )
;        {
	ldy	#$3c
	lda	[<L274+pxQueue_1],Y
	and	#$ff
	bne	L285
;            vPortFree( pxQueue );
	pei	<L274+pxQueue_1+2
	pei	<L274+pxQueue_1
	jsr	_~vPortFree
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    #else /* if ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 0 ) ) */
;    {
;        /* The queue must have been statically allocated, so is not going to be
;         * deleted.  Avoid compiler warnings about the unused parameter. */
;        ( void ) pxQueue;
;    }
;    #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;
;    traceRETURN_vQueueDelete();
;}
L285:
	lda	<L273+1
	sta	<L273+1+4
	pld
	tsc
	clc
	adc	#L273+4
	tcs
	rts
L273	equ	4
L274	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    UBaseType_t uxQueueGetQueueNumber( QueueHandle_t xQueue )
;    {
;        traceENTER_uxQueueGetQueueNumber( xQueue );
;
;        traceRETURN_uxQueueGetQueueNumber( ( ( Queue_t * ) xQueue )->uxQueueNumber );
;
;        return ( ( Queue_t * ) xQueue )->uxQueueNumber;
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    void vQueueSetQueueNumber( QueueHandle_t xQueue,
;                               UBaseType_t uxQueueNumber )
;    {
;        traceENTER_vQueueSetQueueNumber( xQueue, uxQueueNumber );
;
;        ( ( Queue_t * ) xQueue )->uxQueueNumber = uxQueueNumber;
;
;        traceRETURN_vQueueSetQueueNumber();
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    uint8_t ucQueueGetQueueType( QueueHandle_t xQueue )
;    {
;        traceENTER_ucQueueGetQueueType( xQueue );
;
;        traceRETURN_ucQueueGetQueueType( ( ( Queue_t * ) xQueue )->ucQueueType );
;
;        return ( ( Queue_t * ) xQueue )->ucQueueType;
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxQueueGetQueueItemSize( QueueHandle_t xQueue ) /* PRIVILEGED_FUNCTION */
;{
	code
	xdef	_~uxQueueGetQueueItemSize
	func
_~uxQueueGetQueueItemSize:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L286
	tcs
	phd
	tcd
xQueue_0	set	3
;    traceENTER_uxQueueGetQueueItemSize( xQueue );
;
;    traceRETURN_uxQueueGetQueueItemSize( ( ( Queue_t * ) xQueue )->uxItemSize );
;
;    return ( ( Queue_t * ) xQueue )->uxItemSize;
	ldy	#$38
	lda	[<L286+xQueue_0],Y
	tay
	lda	<L286+1
	sta	<L286+1+4
	pld
	tsc
	clc
	adc	#L286+4
	tcs
	tya
	rts
;}
L286	equ	0
L287	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxQueueGetQueueLength( QueueHandle_t xQueue ) /* PRIVILEGED_FUNCTION */
;{
	code
	xdef	_~uxQueueGetQueueLength
	func
_~uxQueueGetQueueLength:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L289
	tcs
	phd
	tcd
xQueue_0	set	3
;    traceENTER_uxQueueGetQueueLength( xQueue );
;
;    traceRETURN_uxQueueGetQueueLength( ( ( Queue_t * ) xQueue )->uxLength );
;
;    return ( ( Queue_t * ) xQueue )->uxLength;
	ldy	#$36
	lda	[<L289+xQueue_0],Y
	tay
	lda	<L289+1
	sta	<L289+1+4
	pld
	tsc
	clc
	adc	#L289+4
	tcs
	tya
	rts
;}
L289	equ	0
L290	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_MUTEXES == 1 )
;
;    static UBaseType_t prvGetHighestPriorityOfWaitToReceiveList( const Queue_t * const pxQueue )
;    {
	code
	func
_~prvGetHighestPriorityOfWaitToReceiveList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L292
	tcs
	phd
	tcd
pxQueue_0	set	3
;        UBaseType_t uxHighestPriorityOfWaitingTasks;
;
;        /* If a task waiting for a mutex causes the mutex holder to inherit a
;         * priority, but the waiting task times out, then the holder should
;         * disinherit the priority - but only down to the highest priority of any
;         * other tasks that are waiting for the same mutex.  For this purpose,
;         * return the priority of the highest priority task that is waiting for the
;         * mutex. */
;        if( listCURRENT_LIST_LENGTH( &( pxQueue->xTasksWaitingToReceive ) ) > 0U )
uxHighestPriorityOfWaitingTasks_1	set	0
;        {
	lda	#$0
	ldy	#$22
	cmp	[<L292+pxQueue_0],Y
	bcs	L10572
;            uxHighestPriorityOfWaitingTasks = ( UBaseType_t ) ( ( UBaseType_t ) configMAX_PRIORITIES - ( UBaseType_t ) listGET_ITEM_VALUE_OF_HEAD_ENTRY( &( pxQueue->xTasksWaitingToReceive ) ) );
	ldy	#$2c
	lda	[<L292+pxQueue_0],Y
	sta	<R0
	iny
	iny
	lda	[<L292+pxQueue_0],Y
	sta	<R0+2
	sec
	lda	#$5
	sbc	[<R0]
	sta	<L293+uxHighestPriorityOfWaitingTasks_1
;        }
;        else
	bra	L10573
L10572:
;        {
;            uxHighestPriorityOfWaitingTasks = tskIDLE_PRIORITY;
	stz	<L293+uxHighestPriorityOfWaitingTasks_1
;        }
L10573:
;
;        return uxHighestPriorityOfWaitingTasks;
	lda	<L293+uxHighestPriorityOfWaitingTasks_1
	tay
	lda	<L292+1
	sta	<L292+1+4
	pld
	tsc
	clc
	adc	#L292+4
	tcs
	tya
	rts
;    }
L292	equ	6
L293	equ	5
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;static BaseType_t prvCopyDataToQueue( Queue_t * const pxQueue,
;                                      const void * pvItemToQueue,
;                                      const BaseType_t xPosition )
;{
	code
	func
_~prvCopyDataToQueue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L296
	tcs
	phd
	tcd
pxQueue_0	set	3
pvItemToQueue_0	set	7
xPosition_0	set	11
;    BaseType_t xReturn = pdFALSE;
;    UBaseType_t uxMessagesWaiting;
;
;    /* This function is called from a critical section. */
;
;    uxMessagesWaiting = pxQueue->uxMessagesWaiting;
xReturn_1	set	0
uxMessagesWaiting_1	set	2
	stz	<L297+xReturn_1
	ldy	#$34
	lda	[<L296+pxQueue_0],Y
	sta	<L297+uxMessagesWaiting_1
;
;    if( pxQueue->uxItemSize == ( UBaseType_t ) 0 )
;    {
	ldy	#$38
	lda	[<L296+pxQueue_0],Y
	bne	L10574
;        #if ( configUSE_MUTEXES == 1 )
;        {
;            if( pxQueue->uxQueueType == queueQUEUE_IS_MUTEX )
;            {
	lda	[<L296+pxQueue_0]
	ldy	#$2
	ora	[<L296+pxQueue_0],Y
	bne	L10577
;                /* The mutex is no longer being held. */
;                xReturn = xTaskPriorityDisinherit( pxQueue->u.xSemaphore.xMutexHolder );
	ldy	#$a
	lda	[<L296+pxQueue_0],Y
	pha
	dey
	dey
	lda	[<L296+pxQueue_0],Y
	pha
	jsr	_~xTaskPriorityDisinherit
	sta	<L297+xReturn_1
;                pxQueue->u.xSemaphore.xMutexHolder = NULL;
	lda	#$0
	ldy	#$8
	sta	[<L296+pxQueue_0],Y
	iny
	iny
L20011:
	sta	[<L296+pxQueue_0],Y
;            }
;            else
L10577:
;
;    pxQueue->uxMessagesWaiting = ( UBaseType_t ) ( uxMessagesWaiting + ( UBaseType_t ) 1 );
	lda	<L297+uxMessagesWaiting_1
	ina
	ldy	#$34
	sta	[<L296+pxQueue_0],Y
;
;    return xReturn;
	lda	<L297+xReturn_1
	tay
	lda	<L296+1
	sta	<L296+1+10
	pld
	tsc
	clc
	adc	#L296+10
	tcs
	tya
	rts
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* configUSE_MUTEXES */
;    }
;    else if( xPosition == queueSEND_TO_BACK )
L10574:
;    {
	lda	<L296+xPosition_0
	bne	L10578
;        ( void ) memcpy( ( void * ) pxQueue->pcWriteTo, pvItemToQueue, ( size_t ) pxQueue->uxItemSize );
	ldy	#$38
	lda	[<L296+pxQueue_0],Y
	pha
	pei	<L296+pvItemToQueue_0+2
	pei	<L296+pvItemToQueue_0
	ldy	#$6
	lda	[<L296+pxQueue_0],Y
	pha
	dey
	dey
	lda	[<L296+pxQueue_0],Y
	pha
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;        pxQueue->pcWriteTo += pxQueue->uxItemSize;
	ldy	#$38
	lda	[<L296+pxQueue_0],Y
	sta	<R0
	stz	<R0+2
	lda	#$4
	clc
	adc	<L296+pxQueue_0
	sta	<R1
	lda	#$0
	adc	<L296+pxQueue_0+2
	sta	<R1+2
	lda	[<R1]
	clc
	adc	<R0
	sta	[<R1]
	ldy	#$2
	lda	[<R1],Y
	adc	<R0+2
	sta	[<R1],Y
;
;        if( pxQueue->pcWriteTo >= pxQueue->u.xQueue.pcTail )
;        {
	iny
	iny
	lda	[<L296+pxQueue_0],Y
	ldy	#$8
	cmp	[<L296+pxQueue_0],Y
	dey
	dey
	lda	[<L296+pxQueue_0],Y
	ldy	#$a
	sbc	[<L296+pxQueue_0],Y
	bcc	L10577
;            pxQueue->pcWriteTo = pxQueue->pcHead;
	lda	[<L296+pxQueue_0]
	ldy	#$4
	sta	[<L296+pxQueue_0],Y
	dey
	dey
	lda	[<L296+pxQueue_0],Y
	ldy	#$6
	brl	L20011
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
L10578:
;    {
;        ( void ) memcpy( ( void * ) pxQueue->u.xQueue.pcReadFrom, pvItemToQueue, ( size_t ) pxQueue->uxItemSize );
	ldy	#$38
	lda	[<L296+pxQueue_0],Y
	pha
	pei	<L296+pvItemToQueue_0+2
	pei	<L296+pvItemToQueue_0
	ldy	#$e
	lda	[<L296+pxQueue_0],Y
	pha
	dey
	dey
	lda	[<L296+pxQueue_0],Y
	pha
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;        pxQueue->u.xQueue.pcReadFrom -= pxQueue->uxItemSize;
	ldy	#$38
	lda	[<L296+pxQueue_0],Y
	sta	<R0
	stz	<R0+2
	lda	#$c
	clc
	adc	<L296+pxQueue_0
	sta	<R1
	lda	#$0
	adc	<L296+pxQueue_0+2
	sta	<R1+2
	sec
	lda	[<R1]
	sbc	<R0
	sta	[<R1]
	ldy	#$2
	lda	[<R1],Y
	sbc	<R0+2
	sta	[<R1],Y
;
;        if( pxQueue->u.xQueue.pcReadFrom < pxQueue->pcHead )
;        {
	ldy	#$c
	lda	[<L296+pxQueue_0],Y
	cmp	[<L296+pxQueue_0]
	iny
	iny
	lda	[<L296+pxQueue_0],Y
	ldy	#$2
	sbc	[<L296+pxQueue_0],Y
	bcs	L10583
;            pxQueue->u.xQueue.pcReadFrom = ( pxQueue->u.xQueue.pcTail - pxQueue->uxItemSize );
	ldy	#$38
	lda	[<L296+pxQueue_0],Y
	sta	<R0
	stz	<R0+2
	sec
	ldy	#$8
	lda	[<L296+pxQueue_0],Y
	sbc	<R0
	sta	<R1
	iny
	iny
	lda	[<L296+pxQueue_0],Y
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	iny
	iny
	sta	[<L296+pxQueue_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L296+pxQueue_0],Y
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10583:
;
;        if( xPosition == queueOVERWRITE )
;        {
	lda	<L296+xPosition_0
	cmp	#<$2
	beq	*+5
	brl	L10577
;            if( uxMessagesWaiting > ( UBaseType_t ) 0 )
;            {
	lda	#$0
	cmp	<L297+uxMessagesWaiting_1
	bcc	*+5
	brl	L10577
;                /* An item is not being added but overwritten, so subtract
;                 * one from the recorded number of items in the queue so when
;                 * one is added again below the number of recorded items remains
;                 * correct. */
;                --uxMessagesWaiting;
	dec	<L297+uxMessagesWaiting_1
;            }
;            else
	brl	L10577
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;}
L296	equ	12
L297	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static void prvCopyDataFromQueue( Queue_t * const pxQueue,
;                                  void * const pvBuffer )
;{
	code
	func
_~prvCopyDataFromQueue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L306
	tcs
	phd
	tcd
pxQueue_0	set	3
pvBuffer_0	set	7
;    if( pxQueue->uxItemSize != ( UBaseType_t ) 0 )
;    {
	ldy	#$38
	lda	[<L306+pxQueue_0],Y
	beq	L310
;        pxQueue->u.xQueue.pcReadFrom += pxQueue->uxItemSize;
	lda	[<L306+pxQueue_0],Y
	sta	<R0
	stz	<R0+2
	lda	#$c
	clc
	adc	<L306+pxQueue_0
	sta	<R1
	lda	#$0
	adc	<L306+pxQueue_0+2
	sta	<R1+2
	lda	[<R1]
	clc
	adc	<R0
	sta	[<R1]
	ldy	#$2
	lda	[<R1],Y
	adc	<R0+2
	sta	[<R1],Y
;
;        if( pxQueue->u.xQueue.pcReadFrom >= pxQueue->u.xQueue.pcTail )
;        {
	ldy	#$c
	lda	[<L306+pxQueue_0],Y
	ldy	#$8
	cmp	[<L306+pxQueue_0],Y
	ldy	#$e
	lda	[<L306+pxQueue_0],Y
	ldy	#$a
	sbc	[<L306+pxQueue_0],Y
	bcc	L10590
;            pxQueue->u.xQueue.pcReadFrom = pxQueue->pcHead;
	lda	[<L306+pxQueue_0]
	iny
	iny
	sta	[<L306+pxQueue_0],Y
	ldy	#$2
	lda	[<L306+pxQueue_0],Y
	ldy	#$e
	sta	[<L306+pxQueue_0],Y
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10590:
;
;        ( void ) memcpy( ( void * ) pvBuffer, ( void * ) pxQueue->u.xQueue.pcReadFrom, ( size_t ) pxQueue->uxItemSize );
	ldy	#$38
	lda	[<L306+pxQueue_0],Y
	pha
	ldy	#$e
	lda	[<L306+pxQueue_0],Y
	pha
	dey
	dey
	lda	[<L306+pxQueue_0],Y
	pha
	pei	<L306+pvBuffer_0+2
	pei	<L306+pvBuffer_0
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;    }
;}
L310:
	lda	<L306+1
	sta	<L306+1+8
	pld
	tsc
	clc
	adc	#L306+8
	tcs
	rts
L306	equ	8
L307	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static void prvUnlockQueue( Queue_t * const pxQueue )
;{
	code
	func
_~prvUnlockQueue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L311
	tcs
	phd
	tcd
pxQueue_0	set	3
;    /* THIS FUNCTION MUST BE CALLED WITH THE SCHEDULER SUSPENDED. */
;
;    /* The lock counts contains the number of extra data items placed or
;     * removed from the queue while the queue was locked.  When a queue is
;     * locked items can be added or removed, but the event lists cannot be
;     * updated. */
;    taskENTER_CRITICAL();
;    {
;        int8_t cTxLock = pxQueue->cTxLock;
;
;        /* See if data was added to the queue while it was locked. */
;        while( cTxLock > queueLOCKED_UNMODIFIED )
cTxLock_2	set	0
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L311+pxQueue_0],Y
	sta	<L312+cTxLock_2
	rep	#$20
	longa	on
	bra	L10594
L20013:
;        {
;            /* Data was posted while the queue was locked.  Are any tasks
;             * blocked waiting for data to become available? */
;            #if ( configUSE_QUEUE_SETS == 1 )
;            {
;                if( pxQueue->pxQueueSetContainer != NULL )
;                {
;                    if( prvNotifyQueueSetContainer( pxQueue ) != pdFALSE )
;                    {
;                        /* The queue is a member of a queue set, and posting to
;                         * the queue set caused a higher priority task to unblock.
;                         * A context switch is required. */
;                        vTaskMissedYield();
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    /* Tasks that are removed from the event list will get
;                     * added to the pending ready list as the scheduler is still
;                     * suspended. */
;                    if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                    {
;                        if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                        {
;                            /* The task waiting has a higher priority so record that a
;                             * context switch is required. */
;                            vTaskMissedYield();
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else
;                    {
;                        break;
;                    }
;                }
;            }
;            #else /* configUSE_QUEUE_SETS */
;            {
;                /* Tasks that are removed from the event list will get added to
;                 * the pending ready list as the scheduler is still suspended. */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                {
	ldy	#$22
	lda	[<L311+pxQueue_0],Y
	bne	L315
	lda	#$1
	bra	L317
L315:
	lda	#$0
L317:
	tax
	bne	L10595
;                    if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                    {
	lda	#$22
	clc
	adc	<L311+pxQueue_0
	sta	<R0
	lda	#$0
	adc	<L311+pxQueue_0+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10599
;                        /* The task waiting has a higher priority so record that
;                         * a context switch is required. */
;                        vTaskMissedYield();
	jsr	_~vTaskMissedYield
;                    }
;                    else
L10599:
;            }
;            #endif /* configUSE_QUEUE_SETS */
;
;            --cTxLock;
	sep	#$20
	longa	off
	dec	<L312+cTxLock_2
	rep	#$20
	longa	on
;        }
L10594:
	sep	#$20
	longa	off
	sec
	lda	#$0
	sbc	<L312+cTxLock_2
	rep	#$20
	longa	on
	bvs	L313
	sep	#$20
	longa	off
	eor	#$80
	rep	#$20
	longa	on
L313:
	bpl	L20013
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    break;
;                }
L10595:
;
;        pxQueue->cTxLock = queueUNLOCKED;
	sep	#$20
	longa	off
	lda	#$ff
	ldy	#$3b
	sta	[<L311+pxQueue_0],Y
	rep	#$20
	longa	on
;    }
;    taskEXIT_CRITICAL();
;
;    /* Do the same for the Rx lock. */
;    taskENTER_CRITICAL();
;    {
;        int8_t cRxLock = pxQueue->cRxLock;
;
;        while( cRxLock > queueLOCKED_UNMODIFIED )
cRxLock_3	set	0
	sep	#$20
	longa	off
	dey
	lda	[<L311+pxQueue_0],Y
	sta	<L312+cRxLock_3
	rep	#$20
	longa	on
	bra	L10606
L20015:
;        {
;            if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;            {
	ldy	#$10
	lda	[<L311+pxQueue_0],Y
	bne	L322
	lda	#$1
	bra	L324
L322:
	lda	#$0
L324:
	tax
	bne	L10607
;                if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                {
	lda	#$10
	clc
	adc	<L311+pxQueue_0
	sta	<R0
	lda	#$0
	adc	<L311+pxQueue_0+2
	pha
	pei	<R0
	jsr	_~xTaskRemoveFromEventList
	tax
	beq	L10610
;                    vTaskMissedYield();
	jsr	_~vTaskMissedYield
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10610:
;
;                --cRxLock;
	sep	#$20
	longa	off
	dec	<L312+cRxLock_3
	rep	#$20
	longa	on
;            }
;            else
L10606:
	sep	#$20
	longa	off
	sec
	lda	#$0
	sbc	<L312+cRxLock_3
	rep	#$20
	longa	on
	bvs	L320
	sep	#$20
	longa	off
	eor	#$80
	rep	#$20
	longa	on
L320:
	bpl	L20015
;            {
;                break;
;            }
;        }
L10607:
;
;        pxQueue->cRxLock = queueUNLOCKED;
	sep	#$20
	longa	off
	lda	#$ff
	ldy	#$3a
	sta	[<L311+pxQueue_0],Y
	rep	#$20
	longa	on
;    }
;    taskEXIT_CRITICAL();
;}
	lda	<L311+1
	sta	<L311+1+4
	pld
	tsc
	clc
	adc	#L311+4
	tcs
	rts
L311	equ	5
L312	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static BaseType_t prvIsQueueEmpty( const Queue_t * pxQueue )
;{
	code
	func
_~prvIsQueueEmpty:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L328
	tcs
	phd
	tcd
pxQueue_0	set	3
;    BaseType_t xReturn;
;
;    taskENTER_CRITICAL();
xReturn_1	set	0
;    {
;        if( pxQueue->uxMessagesWaiting == ( UBaseType_t ) 0 )
;        {
	ldy	#$34
	lda	[<L328+pxQueue_0],Y
	bne	L10618
;            xReturn = pdTRUE;
	lda	#$1
	sta	<L329+xReturn_1
;        }
;        else
	bra	L10621
L10618:
;        {
;            xReturn = pdFALSE;
	stz	<L329+xReturn_1
;        }
;    }
;    taskEXIT_CRITICAL();
L10621:
;
;    return xReturn;
	lda	<L329+xReturn_1
	tay
	lda	<L328+1
	sta	<L328+1+4
	pld
	tsc
	clc
	adc	#L328+4
	tcs
	tya
	rts
;}
L328	equ	2
L329	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue )
;{
	code
	xdef	_~xQueueIsQueueEmptyFromISR
	func
_~xQueueIsQueueEmptyFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L332
	tcs
	phd
	tcd
xQueue_0	set	3
;    BaseType_t xReturn;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueIsQueueEmptyFromISR( xQueue );
xReturn_1	set	0
pxQueue_1	set	2
	lda	<L332+xQueue_0
	sta	<L333+pxQueue_1
	lda	<L332+xQueue_0+2
	sta	<L333+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L333+pxQueue_1
	ora	<L333+pxQueue_1+2
	bne	L10623
L10627:
	bra	L10627
L10623:
;
;    if( pxQueue->uxMessagesWaiting == ( UBaseType_t ) 0 )
;    {
	ldy	#$34
	lda	[<L333+pxQueue_1],Y
	bne	L10630
;        xReturn = pdTRUE;
	lda	#$1
	sta	<L333+xReturn_1
;    }
;    else
	bra	L10631
L10630:
;    {
;        xReturn = pdFALSE;
	stz	<L333+xReturn_1
;    }
L10631:
;
;    traceRETURN_xQueueIsQueueEmptyFromISR( xReturn );
;
;    return xReturn;
	lda	<L333+xReturn_1
	tay
	lda	<L332+1
	sta	<L332+1+4
	pld
	tsc
	clc
	adc	#L332+4
	tcs
	tya
	rts
;}
L332	equ	6
L333	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static BaseType_t prvIsQueueFull( const Queue_t * pxQueue )
;{
	code
	func
_~prvIsQueueFull:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L337
	tcs
	phd
	tcd
pxQueue_0	set	3
;    BaseType_t xReturn;
;
;    taskENTER_CRITICAL();
xReturn_1	set	0
;    {
;        if( pxQueue->uxMessagesWaiting == pxQueue->uxLength )
;        {
	ldy	#$34
	lda	[<L337+pxQueue_0],Y
	iny
	iny
	cmp	[<L337+pxQueue_0],Y
	bne	L10635
;            xReturn = pdTRUE;
	lda	#$1
	sta	<L338+xReturn_1
;        }
;        else
	bra	L10638
L10635:
;        {
;            xReturn = pdFALSE;
	stz	<L338+xReturn_1
;        }
;    }
;    taskEXIT_CRITICAL();
L10638:
;
;    return xReturn;
	lda	<L338+xReturn_1
	tay
	lda	<L337+1
	sta	<L337+1+4
	pld
	tsc
	clc
	adc	#L337+4
	tcs
	tya
	rts
;}
L337	equ	2
L338	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue )
;{
	code
	xdef	_~xQueueIsQueueFullFromISR
	func
_~xQueueIsQueueFullFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L341
	tcs
	phd
	tcd
xQueue_0	set	3
;    BaseType_t xReturn;
;    Queue_t * const pxQueue = xQueue;
;
;    traceENTER_xQueueIsQueueFullFromISR( xQueue );
xReturn_1	set	0
pxQueue_1	set	2
	lda	<L341+xQueue_0
	sta	<L342+pxQueue_1
	lda	<L341+xQueue_0+2
	sta	<L342+pxQueue_1+2
;
;    configASSERT( pxQueue );
	lda	<L342+pxQueue_1
	ora	<L342+pxQueue_1+2
	bne	L10640
L10644:
	bra	L10644
L10640:
;
;    if( pxQueue->uxMessagesWaiting == pxQueue->uxLength )
;    {
	ldy	#$34
	lda	[<L342+pxQueue_1],Y
	iny
	iny
	cmp	[<L342+pxQueue_1],Y
	bne	L10647
;        xReturn = pdTRUE;
	lda	#$1
	sta	<L342+xReturn_1
;    }
;    else
	bra	L10648
L10647:
;    {
;        xReturn = pdFALSE;
	stz	<L342+xReturn_1
;    }
L10648:
;
;    traceRETURN_xQueueIsQueueFullFromISR( xReturn );
;
;    return xReturn;
	lda	<L342+xReturn_1
	tay
	lda	<L341+1
	sta	<L341+1+4
	pld
	tsc
	clc
	adc	#L341+4
	tcs
	tya
	rts
;}
L341	equ	6
L342	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_CO_ROUTINES == 1 )
;
;    BaseType_t xQueueCRSend( QueueHandle_t xQueue,
;                             const void * pvItemToQueue,
;                             TickType_t xTicksToWait )
;    {
;        BaseType_t xReturn;
;        Queue_t * const pxQueue = xQueue;
;
;        traceENTER_xQueueCRSend( xQueue, pvItemToQueue, xTicksToWait );
;
;        /* If the queue is already full we may have to block.  A critical section
;         * is required to prevent an interrupt removing something from the queue
;         * between the check to see if the queue is full and blocking on the queue. */
;        portDISABLE_INTERRUPTS();
;        {
;            if( prvIsQueueFull( pxQueue ) != pdFALSE )
;            {
;                /* The queue is full - do we want to block or just leave without
;                 * posting? */
;                if( xTicksToWait > ( TickType_t ) 0 )
;                {
;                    /* As this is called from a coroutine we cannot block directly, but
;                     * return indicating that we need to block. */
;                    vCoRoutineAddToDelayedList( xTicksToWait, &( pxQueue->xTasksWaitingToSend ) );
;                    portENABLE_INTERRUPTS();
;                    return errQUEUE_BLOCKED;
;                }
;                else
;                {
;                    portENABLE_INTERRUPTS();
;                    return errQUEUE_FULL;
;                }
;            }
;        }
;        portENABLE_INTERRUPTS();
;
;        portDISABLE_INTERRUPTS();
;        {
;            if( pxQueue->uxMessagesWaiting < pxQueue->uxLength )
;            {
;                /* There is room in the queue, copy the data into the queue. */
;                prvCopyDataToQueue( pxQueue, pvItemToQueue, queueSEND_TO_BACK );
;                xReturn = pdPASS;
;
;                /* Were any co-routines waiting for data to become available? */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                {
;                    /* In this instance the co-routine could be placed directly
;                     * into the ready list as we are within a critical section.
;                     * Instead the same pending ready list mechanism is used as if
;                     * the event were caused from within an interrupt. */
;                    if( xCoRoutineRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                    {
;                        /* The co-routine waiting has a higher priority so record
;                         * that a yield might be appropriate. */
;                        xReturn = errQUEUE_YIELD;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                xReturn = errQUEUE_FULL;
;            }
;        }
;        portENABLE_INTERRUPTS();
;
;        traceRETURN_xQueueCRSend( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_CO_ROUTINES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_CO_ROUTINES == 1 )
;
;    BaseType_t xQueueCRReceive( QueueHandle_t xQueue,
;                                void * pvBuffer,
;                                TickType_t xTicksToWait )
;    {
;        BaseType_t xReturn;
;        Queue_t * const pxQueue = xQueue;
;
;        traceENTER_xQueueCRReceive( xQueue, pvBuffer, xTicksToWait );
;
;        /* If the queue is already empty we may have to block.  A critical section
;         * is required to prevent an interrupt adding something to the queue
;         * between the check to see if the queue is empty and blocking on the queue. */
;        portDISABLE_INTERRUPTS();
;        {
;            if( pxQueue->uxMessagesWaiting == ( UBaseType_t ) 0 )
;            {
;                /* There are no messages in the queue, do we want to block or just
;                 * leave with nothing? */
;                if( xTicksToWait > ( TickType_t ) 0 )
;                {
;                    /* As this is a co-routine we cannot block directly, but return
;                     * indicating that we need to block. */
;                    vCoRoutineAddToDelayedList( xTicksToWait, &( pxQueue->xTasksWaitingToReceive ) );
;                    portENABLE_INTERRUPTS();
;                    return errQUEUE_BLOCKED;
;                }
;                else
;                {
;                    portENABLE_INTERRUPTS();
;                    return errQUEUE_FULL;
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        portENABLE_INTERRUPTS();
;
;        portDISABLE_INTERRUPTS();
;        {
;            if( pxQueue->uxMessagesWaiting > ( UBaseType_t ) 0 )
;            {
;                /* Data is available from the queue. */
;                pxQueue->u.xQueue.pcReadFrom += pxQueue->uxItemSize;
;
;                if( pxQueue->u.xQueue.pcReadFrom >= pxQueue->u.xQueue.pcTail )
;                {
;                    pxQueue->u.xQueue.pcReadFrom = pxQueue->pcHead;
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;
;                --( pxQueue->uxMessagesWaiting );
;                ( void ) memcpy( ( void * ) pvBuffer, ( void * ) pxQueue->u.xQueue.pcReadFrom, ( unsigned ) pxQueue->uxItemSize );
;
;                xReturn = pdPASS;
;
;                /* Were any co-routines waiting for space to become available? */
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;                {
;                    /* In this instance the co-routine could be placed directly
;                     * into the ready list as we are within a critical section.
;                     * Instead the same pending ready list mechanism is used as if
;                     * the event were caused from within an interrupt. */
;                    if( xCoRoutineRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                    {
;                        xReturn = errQUEUE_YIELD;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                xReturn = pdFAIL;
;            }
;        }
;        portENABLE_INTERRUPTS();
;
;        traceRETURN_xQueueCRReceive( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_CO_ROUTINES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_CO_ROUTINES == 1 )
;
;    BaseType_t xQueueCRSendFromISR( QueueHandle_t xQueue,
;                                    const void * pvItemToQueue,
;                                    BaseType_t xCoRoutinePreviouslyWoken )
;    {
;        Queue_t * const pxQueue = xQueue;
;
;        traceENTER_xQueueCRSendFromISR( xQueue, pvItemToQueue, xCoRoutinePreviouslyWoken );
;
;        /* Cannot block within an ISR so if there is no space on the queue then
;         * exit without doing anything. */
;        if( pxQueue->uxMessagesWaiting < pxQueue->uxLength )
;        {
;            prvCopyDataToQueue( pxQueue, pvItemToQueue, queueSEND_TO_BACK );
;
;            /* We only want to wake one co-routine per ISR, so check that a
;             * co-routine has not already been woken. */
;            if( xCoRoutinePreviouslyWoken == pdFALSE )
;            {
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToReceive ) ) == pdFALSE )
;                {
;                    if( xCoRoutineRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) != pdFALSE )
;                    {
;                        return pdTRUE;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_xQueueCRSendFromISR( xCoRoutinePreviouslyWoken );
;
;        return xCoRoutinePreviouslyWoken;
;    }
;
;#endif /* configUSE_CO_ROUTINES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_CO_ROUTINES == 1 )
;
;    BaseType_t xQueueCRReceiveFromISR( QueueHandle_t xQueue,
;                                       void * pvBuffer,
;                                       BaseType_t * pxCoRoutineWoken )
;    {
;        BaseType_t xReturn;
;        Queue_t * const pxQueue = xQueue;
;
;        traceENTER_xQueueCRReceiveFromISR( xQueue, pvBuffer, pxCoRoutineWoken );
;
;        /* We cannot block from an ISR, so check there is data available. If
;         * not then just leave without doing anything. */
;        if( pxQueue->uxMessagesWaiting > ( UBaseType_t ) 0 )
;        {
;            /* Copy the data from the queue. */
;            pxQueue->u.xQueue.pcReadFrom += pxQueue->uxItemSize;
;
;            if( pxQueue->u.xQueue.pcReadFrom >= pxQueue->u.xQueue.pcTail )
;            {
;                pxQueue->u.xQueue.pcReadFrom = pxQueue->pcHead;
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;
;            --( pxQueue->uxMessagesWaiting );
;            ( void ) memcpy( ( void * ) pvBuffer, ( void * ) pxQueue->u.xQueue.pcReadFrom, ( unsigned ) pxQueue->uxItemSize );
;
;            if( ( *pxCoRoutineWoken ) == pdFALSE )
;            {
;                if( listLIST_IS_EMPTY( &( pxQueue->xTasksWaitingToSend ) ) == pdFALSE )
;                {
;                    if( xCoRoutineRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) != pdFALSE )
;                    {
;                        *pxCoRoutineWoken = pdTRUE;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;
;            xReturn = pdPASS;
;        }
;        else
;        {
;            xReturn = pdFAIL;
;        }
;
;        traceRETURN_xQueueCRReceiveFromISR( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_CO_ROUTINES */
;/*-----------------------------------------------------------*/
;
;#if ( configQUEUE_REGISTRY_SIZE > 0 )
;
;    void vQueueAddToRegistry( QueueHandle_t xQueue,
;                              const char * pcQueueName )
;    {
;        UBaseType_t ux;
;        QueueRegistryItem_t * pxEntryToWrite = NULL;
;
;        traceENTER_vQueueAddToRegistry( xQueue, pcQueueName );
;
;        configASSERT( xQueue );
;
;        if( pcQueueName != NULL )
;        {
;            /* See if there is an empty space in the registry.  A NULL name denotes
;             * a free slot. */
;            for( ux = ( UBaseType_t ) 0U; ux < ( UBaseType_t ) configQUEUE_REGISTRY_SIZE; ux++ )
;            {
;                /* Replace an existing entry if the queue is already in the registry. */
;                if( xQueue == xQueueRegistry[ ux ].xHandle )
;                {
;                    pxEntryToWrite = &( xQueueRegistry[ ux ] );
;                    break;
;                }
;                /* Otherwise, store in the next empty location */
;                else if( ( pxEntryToWrite == NULL ) && ( xQueueRegistry[ ux ].pcQueueName == NULL ) )
;                {
;                    pxEntryToWrite = &( xQueueRegistry[ ux ] );
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;
;        if( pxEntryToWrite != NULL )
;        {
;            /* Store the information on this queue. */
;            pxEntryToWrite->pcQueueName = pcQueueName;
;            pxEntryToWrite->xHandle = xQueue;
;
;            traceQUEUE_REGISTRY_ADD( xQueue, pcQueueName );
;        }
;
;        traceRETURN_vQueueAddToRegistry();
;    }
;
;#endif /* configQUEUE_REGISTRY_SIZE */
;/*-----------------------------------------------------------*/
;
;#if ( configQUEUE_REGISTRY_SIZE > 0 )
;
;    const char * pcQueueGetName( QueueHandle_t xQueue )
;    {
;        UBaseType_t ux;
;        const char * pcReturn = NULL;
;
;        traceENTER_pcQueueGetName( xQueue );
;
;        configASSERT( xQueue );
;
;        /* Note there is nothing here to protect against another task adding or
;         * removing entries from the registry while it is being searched. */
;
;        for( ux = ( UBaseType_t ) 0U; ux < ( UBaseType_t ) configQUEUE_REGISTRY_SIZE; ux++ )
;        {
;            if( xQueueRegistry[ ux ].xHandle == xQueue )
;            {
;                pcReturn = xQueueRegistry[ ux ].pcQueueName;
;                break;
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;
;        traceRETURN_pcQueueGetName( pcReturn );
;
;        return pcReturn;
;    }
;
;#endif /* configQUEUE_REGISTRY_SIZE */
;/*-----------------------------------------------------------*/
;
;#if ( configQUEUE_REGISTRY_SIZE > 0 )
;
;    void vQueueUnregisterQueue( QueueHandle_t xQueue )
;    {
;        UBaseType_t ux;
;
;        traceENTER_vQueueUnregisterQueue( xQueue );
;
;        configASSERT( xQueue );
;
;        /* See if the handle of the queue being unregistered in actually in the
;         * registry. */
;        for( ux = ( UBaseType_t ) 0U; ux < ( UBaseType_t ) configQUEUE_REGISTRY_SIZE; ux++ )
;        {
;            if( xQueueRegistry[ ux ].xHandle == xQueue )
;            {
;                /* Set the name to NULL to show that this slot if free again. */
;                xQueueRegistry[ ux ].pcQueueName = NULL;
;
;                /* Set the handle to NULL to ensure the same queue handle cannot
;                 * appear in the registry twice if it is added, removed, then
;                 * added again. */
;                xQueueRegistry[ ux ].xHandle = ( QueueHandle_t ) 0;
;                break;
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;
;        traceRETURN_vQueueUnregisterQueue();
;    }
;
;#endif /* configQUEUE_REGISTRY_SIZE */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TIMERS == 1 )
;
;    void vQueueWaitForMessageRestricted( QueueHandle_t xQueue,
;                                         TickType_t xTicksToWait,
;                                         const BaseType_t xWaitIndefinitely )
;    {
	code
	xdef	_~vQueueWaitForMessageRestricted
	func
_~vQueueWaitForMessageRestricted:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L346
	tcs
	phd
	tcd
xQueue_0	set	3
xTicksToWait_0	set	7
xWaitIndefinitely_0	set	11
;        Queue_t * const pxQueue = xQueue;
;
;        traceENTER_vQueueWaitForMessageRestricted( xQueue, xTicksToWait, xWaitIndefinitely );
pxQueue_1	set	0
	lda	<L346+xQueue_0
	sta	<L347+pxQueue_1
	lda	<L346+xQueue_0+2
	sta	<L347+pxQueue_1+2
;
;        /* This function should not be called by application code hence the
;         * 'Restricted' in its name.  It is not part of the public API.  It is
;         * designed for use by kernel code, and has special calling requirements.
;         * It can result in vListInsert() being called on a list that can only
;         * possibly ever have one item in it, so the list will be fast, but even
;         * so it should be called with the scheduler locked and not from a critical
;         * section. */
;
;        /* Only do anything if there are no messages in the queue.  This function
;         *  will not actually cause the task to block, just place it on a blocked
;         *  list.  It will not block until the scheduler is unlocked - at which
;         *  time a yield will be performed.  If an item is added to the queue while
;         *  the queue is locked, and the calling task blocks on the queue, then the
;         *  calling task will be immediately unblocked when the queue is unlocked. */
;        prvLockQueue( pxQueue );
	sep	#$20
	longa	off
	ldy	#$3a
	lda	[<L347+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10652
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L347+pxQueue_1],Y
	rep	#$20
	longa	on
L10652:
	sep	#$20
	longa	off
	ldy	#$3b
	lda	[<L347+pxQueue_1],Y
	cmp	#<$ffffffff
	rep	#$20
	longa	on
	bne	L10655
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L347+pxQueue_1],Y
	rep	#$20
	longa	on
L10655:
;
;        if( pxQueue->uxMessagesWaiting == ( UBaseType_t ) 0U )
;        {
	ldy	#$34
	lda	[<L347+pxQueue_1],Y
	bne	L10658
;            /* There is nothing in the queue, block for the specified period. */
;            vTaskPlaceOnEventListRestricted( &( pxQueue->xTasksWaitingToReceive ), xTicksToWait, xWaitIndefinitely );
	pei	<L346+xWaitIndefinitely_0
	pei	<L346+xTicksToWait_0+2
	pei	<L346+xTicksToWait_0
	lda	#$22
	clc
	adc	<L347+pxQueue_1
	sta	<R0
	lda	#$0
	adc	<L347+pxQueue_1+2
	pha
	pei	<R0
	jsr	_~vTaskPlaceOnEventListRestricted
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10658:
;
;        prvUnlockQueue( pxQueue );
	pei	<L347+pxQueue_1+2
	pei	<L347+pxQueue_1
	jsr	_~prvUnlockQueue
;
;        traceRETURN_vQueueWaitForMessageRestricted();
;    }
	lda	<L346+1
	sta	<L346+1+10
	pld
	tsc
	clc
	adc	#L346+10
	tcs
	rts
L346	equ	8
L347	equ	5
	ends
	efunc
;
;#endif /* configUSE_TIMERS */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_QUEUE_SETS == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;
;    QueueSetHandle_t xQueueCreateSet( const UBaseType_t uxEventQueueLength )
;    {
;        QueueSetHandle_t pxQueue;
;
;        traceENTER_xQueueCreateSet( uxEventQueueLength );
;
;        pxQueue = xQueueGenericCreate( uxEventQueueLength, ( UBaseType_t ) sizeof( Queue_t * ), queueQUEUE_TYPE_SET );
;
;        traceRETURN_xQueueCreateSet( pxQueue );
;
;        return pxQueue;
;    }
;
;#endif /* #if ( ( configUSE_QUEUE_SETS == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_QUEUE_SETS == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;
;    QueueSetHandle_t xQueueCreateSetStatic( const UBaseType_t uxEventQueueLength,
;                                            uint8_t * pucQueueStorage,
;                                            StaticQueue_t * pxStaticQueue )
;    {
;        QueueSetHandle_t pxQueue;
;
;        traceENTER_xQueueCreateSetStatic( uxEventQueueLength );
;
;        pxQueue = xQueueGenericCreateStatic( uxEventQueueLength, ( UBaseType_t ) sizeof( Queue_t * ), pucQueueStorage, pxStaticQueue, queueQUEUE_TYPE_SET );
;
;        traceRETURN_xQueueCreateSetStatic( pxQueue );
;
;        return pxQueue;
;    }
;
;#endif /* #if ( ( configUSE_QUEUE_SETS == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_QUEUE_SETS == 1 )
;
;    BaseType_t xQueueAddToSet( QueueSetMemberHandle_t xQueueOrSemaphore,
;                               QueueSetHandle_t xQueueSet )
;    {
;        BaseType_t xReturn;
;
;        traceENTER_xQueueAddToSet( xQueueOrSemaphore, xQueueSet );
;
;        taskENTER_CRITICAL();
;        {
;            if( ( ( Queue_t * ) xQueueSet )->uxItemSize != ( UBaseType_t ) sizeof( Queue_t * ) )
;            {
;                /* The object passed as the queue set is not a queue set. A queue
;                 * set always has an item size of sizeof( Queue_t * ). Reject any
;                 * other object to prevent a type confusion in which
;                 * prvNotifyQueueSetContainer() would later copy uxItemSize bytes
;                 * from a single pointer on the stack. */
;                xReturn = pdFAIL;
;            }
;            else if( ( ( Queue_t * ) xQueueOrSemaphore )->pxQueueSetContainer != NULL )
;            {
;                /* Cannot add a queue/semaphore to more than one queue set. */
;                xReturn = pdFAIL;
;            }
;            else if( ( ( Queue_t * ) xQueueOrSemaphore )->uxMessagesWaiting != ( UBaseType_t ) 0 )
;            {
;                /* Cannot add a queue/semaphore to a queue set if there are already
;                 * items in the queue/semaphore. */
;                xReturn = pdFAIL;
;            }
;            else
;            {
;                ( ( Queue_t * ) xQueueOrSemaphore )->pxQueueSetContainer = xQueueSet;
;                xReturn = pdPASS;
;            }
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_xQueueAddToSet( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_QUEUE_SETS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_QUEUE_SETS == 1 )
;
;    BaseType_t xQueueRemoveFromSet( QueueSetMemberHandle_t xQueueOrSemaphore,
;                                    QueueSetHandle_t xQueueSet )
;    {
;        BaseType_t xReturn;
;        Queue_t * const pxQueueOrSemaphore = ( Queue_t * ) xQueueOrSemaphore;
;
;        traceENTER_xQueueRemoveFromSet( xQueueOrSemaphore, xQueueSet );
;
;        if( pxQueueOrSemaphore->pxQueueSetContainer != xQueueSet )
;        {
;            /* The queue was not a member of the set. */
;            xReturn = pdFAIL;
;        }
;        else if( pxQueueOrSemaphore->uxMessagesWaiting != ( UBaseType_t ) 0 )
;        {
;            /* It is dangerous to remove a queue from a set when the queue is
;             * not empty because the queue set will still hold pending events for
;             * the queue. */
;            xReturn = pdFAIL;
;        }
;        else
;        {
;            taskENTER_CRITICAL();
;            {
;                /* The queue is no longer contained in the set. */
;                pxQueueOrSemaphore->pxQueueSetContainer = NULL;
;            }
;            taskEXIT_CRITICAL();
;            xReturn = pdPASS;
;        }
;
;        traceRETURN_xQueueRemoveFromSet( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_QUEUE_SETS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_QUEUE_SETS == 1 )
;
;    QueueSetMemberHandle_t xQueueSelectFromSet( QueueSetHandle_t xQueueSet,
;                                                TickType_t const xTicksToWait )
;    {
;        QueueSetMemberHandle_t xReturn = NULL;
;
;        traceENTER_xQueueSelectFromSet( xQueueSet, xTicksToWait );
;
;        ( void ) xQueueReceive( ( QueueHandle_t ) xQueueSet, &xReturn, xTicksToWait );
;
;        traceRETURN_xQueueSelectFromSet( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_QUEUE_SETS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_QUEUE_SETS == 1 )
;
;    QueueSetMemberHandle_t xQueueSelectFromSetFromISR( QueueSetHandle_t xQueueSet )
;    {
;        QueueSetMemberHandle_t xReturn = NULL;
;
;        traceENTER_xQueueSelectFromSetFromISR( xQueueSet );
;
;        ( void ) xQueueReceiveFromISR( ( QueueHandle_t ) xQueueSet, &xReturn, NULL );
;
;        traceRETURN_xQueueSelectFromSetFromISR( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_QUEUE_SETS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_QUEUE_SETS == 1 )
;
;    static BaseType_t prvNotifyQueueSetContainer( const Queue_t * const pxQueue )
;    {
;        Queue_t * pxQueueSetContainer = pxQueue->pxQueueSetContainer;
;        BaseType_t xReturn = pdFALSE;
;
;        /* This function must be called form a critical section. */
;
;        /* The following line is not reachable in unit tests because every call
;         * to prvNotifyQueueSetContainer is preceded by a check that
;         * pxQueueSetContainer != NULL */
;        configASSERT( pxQueueSetContainer ); /* LCOV_EXCL_BR_LINE */
;        configASSERT( pxQueueSetContainer->uxMessagesWaiting < pxQueueSetContainer->uxLength );
;
;        /* pxQueue->pxQueueSetContainer is verified to be non-null by caller. */
;        /* coverity[dereference] */
;        if( pxQueueSetContainer->uxMessagesWaiting < pxQueueSetContainer->uxLength )
;        {
;            const int8_t cTxLock = pxQueueSetContainer->cTxLock;
;
;            traceQUEUE_SET_SEND( pxQueueSetContainer );
;
;            /* The data copied is the handle of the queue that contains data. */
;            xReturn = prvCopyDataToQueue( pxQueueSetContainer, &pxQueue, queueSEND_TO_BACK );
;
;            if( cTxLock == queueUNLOCKED )
;            {
;                if( listLIST_IS_EMPTY( &( pxQueueSetContainer->xTasksWaitingToReceive ) ) == pdFALSE )
;                {
;                    if( xTaskRemoveFromEventList( &( pxQueueSetContainer->xTasksWaitingToReceive ) ) != pdFALSE )
;                    {
;                        /* The task waiting has a higher priority. */
;                        xReturn = pdTRUE;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                prvIncrementQueueTxLock( pxQueueSetContainer, cTxLock );
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        return xReturn;
;    }
;
;#endif /* configUSE_QUEUE_SETS */
;
	xref	_~vTaskInternalSetTimeOutState
	xref	_~pvTaskIncrementMutexHeldCount
	xref	_~vTaskPriorityDisinheritAfterTimeout
	xref	_~xTaskPriorityDisinherit
	xref	_~xTaskPriorityInherit
	xref	_~xTaskGetSchedulerState
	xref	_~vTaskMissedYield
	xref	_~xTaskGetCurrentTaskHandle
	xref	_~xTaskRemoveFromEventList
	xref	_~vTaskPlaceOnEventListRestricted
	xref	_~vTaskPlaceOnEventList
	xref	_~xTaskCheckForTimeOut
	xref	_~uxTaskGetNumberOfTasks
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~vListInitialise
	xref	_~vPortFree
	xref	_~pvPortMalloc
	xref	_~vPortYield
	xref	_~memcpy

;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*
; * FreeRTOS Kernel V11.3.1
; * Copyright (C) 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
; * Copyright 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
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
;extern volatile char* debug_char;
;extern volatile char* debug_hex;
;
;static void debug_ptr(void *p) {
	code
	func
_~debug_ptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
p_0	set	3
;	*debug_hex = (char)((unsigned long)p >> 16);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	pei	<L2+p_0+2
	pei	<L2+p_0
	lda	#$10
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R1
	stx	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	[<R0]
	rep	#$20
	longa	on
;	*debug_char = ':';
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$3a
	sta	[<R0]
	rep	#$20
	longa	on
;	*debug_hex = (char)((unsigned long)p >> 8);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	pei	<L2+p_0+2
	pei	<L2+p_0
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R1
	stx	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	[<R0]
	rep	#$20
	longa	on
;	*debug_hex = (char)((unsigned long)p & 0xff);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	lda	<L2+p_0
	and	#<$ff
	sta	<R1
	stz	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	[<R0]
	rep	#$20
	longa	on
;	*debug_char = ' ';
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$20
	sta	[<R0]
	rep	#$20
	longa	on
;}
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	rts
L2	equ	8
L3	equ	9
	ends
	efunc
;
;static void debug_word(unsigned int i) {
	code
	func
_~debug_word:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
i_0	set	3
;	*debug_hex = (char)((unsigned long)i >> 8);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	lda	<L5+i_0
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$8
	xref	_~~llsr
	jsr	_~~llsr
	sta	<R1
	stx	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	[<R0]
	rep	#$20
	longa	on
;	*debug_hex = (char)((unsigned long)i);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	lda	<L5+i_0
	sta	<R1
	stz	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	sta	[<R0]
	rep	#$20
	longa	on
;	*debug_char = ' ';
	lda	|_~debug_char
	sta	<R0
	lda	|_~debug_char+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$20
	sta	[<R0]
	rep	#$20
	longa	on
;}
	lda	<L5+1
	sta	<L5+1+2
	pld
	tsc
	clc
	adc	#L5+2
	tcs
	rts
L5	equ	12
L6	equ	13
	ends
	efunc
;
;/* Standard includes. */
;#include <stdlib.h>
;#include <string.h>
;
;/* Defining MPU_WRAPPERS_INCLUDED_FROM_API_FILE prevents task.h from redefining
; * all the API functions to use the MPU wrappers.  That should only be done when
; * task.h is included from an application file. */
;#define MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;/* FreeRTOS includes. */
;#include "FreeRTOS.h"
;#include "task.h"
;#include "timers.h"
;#include "stack_macros.h"
;
;/* The default definitions are only available for non-MPU ports. The
; * reason is that the stack alignment requirements vary for different
; * architectures.*/
;#if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configKERNEL_PROVIDED_STATIC_MEMORY == 1 ) && ( portUSING_MPU_WRAPPERS != 0 ) )
;    #error configKERNEL_PROVIDED_STATIC_MEMORY cannot be set to 1 when using an MPU port. The vApplicationGet*TaskMemory() functions must be provided manually.
;#endif
;
;/* The MPU ports require MPU_WRAPPERS_INCLUDED_FROM_API_FILE to be defined
; * for the header files above, but not in this file, in order to generate the
; * correct privileged Vs unprivileged linkage and placement. */
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;/* Set configUSE_STATS_FORMATTING_FUNCTIONS to 2 to include the stats formatting
; * functions but without including stdio.h here. */
;#if ( configUSE_STATS_FORMATTING_FUNCTIONS == 1 )
;
;/* At the bottom of this file are two optional functions that can be used
; * to generate human readable text from the raw data generated by the
; * uxTaskGetSystemState() function.  Note the formatting functions are provided
; * for convenience only, and are NOT considered part of the kernel. */
;    #include <stdio.h>
;#endif /* configUSE_STATS_FORMATTING_FUNCTIONS == 1 ) */
;
;#if ( configUSE_PREEMPTION == 0 )
;
;/* If the cooperative scheduler is being used then a yield should not be
; * performed just because a higher priority task has been woken. */
;    #define taskYIELD_TASK_CORE_IF_USING_PREEMPTION( pxTCB )
;    #define taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxTCB )
;#else
;
;    #if ( configNUMBER_OF_CORES == 1 )
;
;/* This macro requests the running task pxTCB to yield. In single core
; * scheduler, a running task always runs on core 0 and portYIELD_WITHIN_API()
; * can be used to request the task running on core 0 to yield. Therefore, pxTCB
; * is not used in this macro. */
;        #define taskYIELD_TASK_CORE_IF_USING_PREEMPTION( pxTCB ) \
;    do {                                                         \
;        ( void ) ( pxTCB );                                      \
;        portYIELD_WITHIN_API();                                  \
;    } while( 0 )
;
;        #define taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxTCB ) \
;    do {                                                        \
;        if( pxCurrentTCB->uxPriority < ( pxTCB )->uxPriority )  \
;        {                                                       \
;            portYIELD_WITHIN_API();                             \
;        }                                                       \
;        else                                                    \
;        {                                                       \
;            mtCOVERAGE_TEST_MARKER();                           \
;        }                                                       \
;    } while( 0 )
;
;    #else /* if ( configNUMBER_OF_CORES == 1 ) */
;
;/* Yield the core on which this task is running. */
;        #define taskYIELD_TASK_CORE_IF_USING_PREEMPTION( pxTCB )    prvYieldCore( ( pxTCB )->xTaskRunState )
;
;/* Yield for the task if a running task has priority lower than this task. */
;        #define taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxTCB )     prvYieldForTask( pxTCB )
;
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;#endif /* if ( configUSE_PREEMPTION == 0 ) */
;
;/* Values that can be assigned to the ucNotifyState member of the TCB. */
;#define taskNOT_WAITING_NOTIFICATION              ( ( uint8_t ) 0 ) /* Must be zero as it is the initialised value. */
;#define taskWAITING_NOTIFICATION                  ( ( uint8_t ) 1 )
;#define taskNOTIFICATION_RECEIVED                 ( ( uint8_t ) 2 )
;
;/*
; * The value used to fill the stack of a task when the task is created.  This
; * is used purely for checking the high water mark for tasks.
; */
;#define tskSTACK_FILL_BYTE                        ( 0xa5U )
;
;/* Bits used to record how a task's stack and TCB were allocated. */
;#define tskDYNAMICALLY_ALLOCATED_STACK_AND_TCB    ( ( uint8_t ) 0 )
;#define tskSTATICALLY_ALLOCATED_STACK_ONLY        ( ( uint8_t ) 1 )
;#define tskSTATICALLY_ALLOCATED_STACK_AND_TCB     ( ( uint8_t ) 2 )
;
;/* If any of the following are set then task stacks are filled with a known
; * value so the high water mark can be determined.  If none of the following are
; * set then don't fill the stack so there is no unnecessary dependency on memset. */
;#if ( ( configCHECK_FOR_STACK_OVERFLOW > 1 ) || ( configUSE_TRACE_FACILITY == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark2 == 1 ) )
;    #define tskSET_NEW_STACKS_TO_KNOWN_VALUE    1
;#else
;    #define tskSET_NEW_STACKS_TO_KNOWN_VALUE    0
;#endif
;
;/*
; * Macros used by vListTask to indicate which state a task is in.
; */
;#define tskRUNNING_CHAR      ( 'X' )
;#define tskBLOCKED_CHAR      ( 'B' )
;#define tskREADY_CHAR        ( 'R' )
;#define tskDELETED_CHAR      ( 'D' )
;#define tskSUSPENDED_CHAR    ( 'S' )
;
;/*
; * Some kernel aware debuggers require the data the debugger needs access to be
; * global, rather than file scope.
; */
;#ifdef portREMOVE_STATIC_QUALIFIER
;    #define STATIC
;#else
;    #define STATIC    static
;#endif
;
;/* The name allocated to the Idle task.  This can be overridden by defining
; * configIDLE_TASK_NAME in FreeRTOSConfig.h. */
;#ifndef configIDLE_TASK_NAME
;    #define configIDLE_TASK_NAME    "IDLE"
;#endif
;
;/* Reserve space for Core ID and null termination. */
;#if ( configNUMBER_OF_CORES > 1 )
;    /* Multi-core systems with up to 9 cores require 1 character for core ID and 1 for null termination. */
;    #if ( configMAX_TASK_NAME_LEN < 2U )
;        #error Minimum required task name length is 2. Please increase configMAX_TASK_NAME_LEN.
;    #endif
;    #define taskRESERVED_TASK_NAME_LENGTH    2U
;
;#else /* if ( configNUMBER_OF_CORES > 1 ) */
;    /* Reserve space for null termination. */
;    #if ( configMAX_TASK_NAME_LEN < 1U )
;        #error Minimum required task name length is 1. Please increase configMAX_TASK_NAME_LEN.
;    #endif
;    #define taskRESERVED_TASK_NAME_LENGTH    1U
;#endif /* if ( ( configNUMBER_OF_CORES > 1 ) */
;
;#if ( configUSE_PORT_OPTIMISED_TASK_SELECTION == 0 )
;
;/* If configUSE_PORT_OPTIMISED_TASK_SELECTION is 0 then task selection is
; * performed in a generic way that is not optimised to any particular
; * microcontroller architecture. */
;
;/* uxTopReadyPriority holds the priority of the highest priority ready
; * state task. */
;    #define taskRECORD_READY_PRIORITY( uxPriority ) \
;    do {                                            \
;        if( ( uxPriority ) > uxTopReadyPriority )   \
;        {                                           \
;            uxTopReadyPriority = ( uxPriority );    \
;        }                                           \
;    } while( 0 ) /* taskRECORD_READY_PRIORITY */
;
;/*-----------------------------------------------------------*/
;
;    #if ( configNUMBER_OF_CORES == 1 )
;        #define taskSELECT_HIGHEST_PRIORITY_TASK()                                       \
;    do {                                                                                 \
;        UBaseType_t uxTopPriority = uxTopReadyPriority;                                  \
;                                                                                         \
;        /* Find the highest priority queue that contains ready tasks. */                 \
;        while( listLIST_IS_EMPTY( &( pxReadyTasksLists[ uxTopPriority ] ) ) != pdFALSE ) \
;        {                                                                                \
;            configASSERT( uxTopPriority );                                               \
;            --uxTopPriority;                                                             \
;        }                                                                                \
;                                                                                         \
;        /* listGET_OWNER_OF_NEXT_ENTRY indexes through the list, so the tasks of \
;         * the  same priority get an equal share of the processor time. */                    \
;        listGET_OWNER_OF_NEXT_ENTRY( pxCurrentTCB, &( pxReadyTasksLists[ uxTopPriority ] ) ); \
;        uxTopReadyPriority = uxTopPriority;                                                   \
;    } while( 0 ) /* taskSELECT_HIGHEST_PRIORITY_TASK */
;    #else /* if ( configNUMBER_OF_CORES == 1 ) */
;
;        #define taskSELECT_HIGHEST_PRIORITY_TASK( xCoreID )    prvSelectHighestPriorityTask( xCoreID )
;
;    #endif /* if ( configNUMBER_OF_CORES == 1 ) */
;
;/*-----------------------------------------------------------*/
;
;/* Define away taskRESET_READY_PRIORITY() and portRESET_READY_PRIORITY() as
; * they are only required when a port optimised method of task selection is
; * being used. */
;    #define taskRESET_READY_PRIORITY( uxPriority )
;    #define portRESET_READY_PRIORITY( uxPriority, uxTopReadyPriority )
;
;#else /* configUSE_PORT_OPTIMISED_TASK_SELECTION */
;
;/* If configUSE_PORT_OPTIMISED_TASK_SELECTION is 1 then task selection is
; * performed in a way that is tailored to the particular microcontroller
; * architecture being used. */
;
;/* A port optimised version is provided.  Call the port defined macros. */
;    #define taskRECORD_READY_PRIORITY( uxPriority )    portRECORD_READY_PRIORITY( ( uxPriority ), uxTopReadyPriority )
;
;/*-----------------------------------------------------------*/
;
;    #define taskSELECT_HIGHEST_PRIORITY_TASK()                                                  \
;    do {                                                                                        \
;        UBaseType_t uxTopPriority;                                                              \
;                                                                                                \
;        /* Find the highest priority list that contains ready tasks. */                         \
;        portGET_HIGHEST_PRIORITY( uxTopPriority, uxTopReadyPriority );                          \
;        configASSERT( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ uxTopPriority ] ) ) > 0 ); \
;        listGET_OWNER_OF_NEXT_ENTRY( pxCurrentTCB, &( pxReadyTasksLists[ uxTopPriority ] ) );   \
;    } while( 0 )
;
;/*-----------------------------------------------------------*/
;
;/* A port optimised version is provided, call it only if the TCB being reset
; * is being referenced from a ready list.  If it is referenced from a delayed
; * or suspended list then it won't be in a ready list. */
;    #define taskRESET_READY_PRIORITY( uxPriority )                                                     \
;    do {                                                                                               \
;        if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ ( uxPriority ) ] ) ) == ( UBaseType_t ) 0 ) \
;        {                                                                                              \
;            portRESET_READY_PRIORITY( ( uxPriority ), ( uxTopReadyPriority ) );                        \
;        }                                                                                              \
;    } while( 0 )
;
;#endif /* configUSE_PORT_OPTIMISED_TASK_SELECTION */
;
;/*-----------------------------------------------------------*/
;
;/* pxDelayedTaskList and pxOverflowDelayedTaskList are switched when the tick
; * count overflows. */
;#define taskSWITCH_DELAYED_LISTS()                                                \
;    do {                                                                          \
;        List_t * pxTemp;                                                          \
;                                                                                  \
;        /* The delayed tasks list should be empty when the lists are switched. */ \
;        configASSERT( ( listLIST_IS_EMPTY( pxDelayedTaskList ) ) );               \
;                                                                                  \
;        pxTemp = pxDelayedTaskList;                                               \
;        pxDelayedTaskList = pxOverflowDelayedTaskList;                            \
;        pxOverflowDelayedTaskList = pxTemp;                                       \
;        xNumOfOverflows = ( BaseType_t ) ( xNumOfOverflows + 1 );                 \
;        prvResetNextTaskUnblockTime();                                            \
;    } while( 0 )
;
;/*-----------------------------------------------------------*/
;
;/*
; * Place the task represented by pxTCB into the appropriate ready list for
; * the task.  It is inserted at the end of the list.
; */
;#define prvAddTaskToReadyList( pxTCB )                                                                     \
;    do {                                                                                                   \
;        traceMOVED_TASK_TO_READY_STATE( pxTCB );                                                           \
;        taskRECORD_READY_PRIORITY( ( pxTCB )->uxPriority );                                                \
;        listINSERT_END( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); \
;        tracePOST_MOVED_TASK_TO_READY_STATE( pxTCB );                                                      \
;    } while( 0 )
;/*-----------------------------------------------------------*/
;
;/*
; * Several functions take a TaskHandle_t parameter that can optionally be NULL,
; * where NULL is used to indicate that the handle of the currently executing
; * task should be used in place of the parameter.  This macro simply checks to
; * see if the parameter is NULL and returns a pointer to the appropriate TCB.
; */
;#define prvGetTCBFromHandle( pxHandle )    ( ( ( pxHandle ) == NULL ) ? pxCurrentTCB : ( pxHandle ) )
;
;/* The item value of the event list item is normally used to hold the priority
; * of the task to which it belongs (coded to allow it to be held in reverse
; * priority order).  However, it is occasionally borrowed for other purposes.  It
; * is important its value is not updated due to a task priority change while it is
; * being used for another purpose.  The following bit definition is used to inform
; * the scheduler that the value should not be changed - in which case it is the
; * responsibility of whichever module is using the value to ensure it gets set back
; * to its original value when it is released. */
;#if ( configTICK_TYPE_WIDTH_IN_BITS == TICK_TYPE_WIDTH_16_BITS )
;    #define taskEVENT_LIST_ITEM_VALUE_IN_USE    ( ( uint16_t ) 0x8000U )
;#elif ( configTICK_TYPE_WIDTH_IN_BITS == TICK_TYPE_WIDTH_32_BITS )
;    #define taskEVENT_LIST_ITEM_VALUE_IN_USE    ( ( uint32_t ) 0x80000000U )
;#elif ( configTICK_TYPE_WIDTH_IN_BITS == TICK_TYPE_WIDTH_64_BITS )
;    #define taskEVENT_LIST_ITEM_VALUE_IN_USE    ( ( uint64_t ) 0x8000000000000000U )
;#endif
;
;/* Indicates that the task is not actively running on any core. */
;#define taskTASK_NOT_RUNNING           ( ( BaseType_t ) ( -1 ) )
;
;/* Indicates that the task is actively running but scheduled to yield. */
;#define taskTASK_SCHEDULED_TO_YIELD    ( ( BaseType_t ) ( -2 ) )
;
;/* Returns pdTRUE if the task is actively running and not scheduled to yield. */
;#if ( configNUMBER_OF_CORES == 1 )
;    #define taskTASK_IS_RUNNING( pxTCB )                          ( ( ( pxTCB ) == pxCurrentTCB ) ? ( pdTRUE ) : ( pdFALSE ) )
;    #define taskTASK_IS_RUNNING_OR_SCHEDULED_TO_YIELD( pxTCB )    ( ( ( pxTCB ) == pxCurrentTCB ) ? ( pdTRUE ) : ( pdFALSE ) )
;#else
;    #define taskTASK_IS_RUNNING( pxTCB )                          ( ( ( ( pxTCB )->xTaskRunState >= ( BaseType_t ) 0 ) && ( ( pxTCB )->xTaskRunState < ( BaseType_t ) configNUMBER_OF_CORES ) ) ? ( pdTRUE ) : ( pdFALSE ) )
;    #define taskTASK_IS_RUNNING_OR_SCHEDULED_TO_YIELD( pxTCB )    ( ( ( pxTCB )->xTaskRunState != taskTASK_NOT_RUNNING ) ? ( pdTRUE ) : ( pdFALSE ) )
;#endif
;
;/* Indicates that the task is an Idle task. */
;#define taskATTRIBUTE_IS_IDLE    ( UBaseType_t ) ( 1U << 0U )
;
;#if ( ( configNUMBER_OF_CORES > 1 ) && ( portCRITICAL_NESTING_IN_TCB == 1 ) )
;    #define portGET_CRITICAL_NESTING_COUNT( xCoreID )          ( pxCurrentTCBs[ ( xCoreID ) ]->uxCriticalNesting )
;    #define portSET_CRITICAL_NESTING_COUNT( xCoreID, x )       ( pxCurrentTCBs[ ( xCoreID ) ]->uxCriticalNesting = ( x ) )
;    #define portINCREMENT_CRITICAL_NESTING_COUNT( xCoreID )    ( pxCurrentTCBs[ ( xCoreID ) ]->uxCriticalNesting++ )
;    #define portDECREMENT_CRITICAL_NESTING_COUNT( xCoreID )    ( pxCurrentTCBs[ ( xCoreID ) ]->uxCriticalNesting-- )
;#endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( portCRITICAL_NESTING_IN_TCB == 1 ) ) */
;
;#define taskBITS_PER_BYTE    ( ( size_t ) 8 )
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;/* Yields the given core. This must be called from a critical section and xCoreID
; * must be valid. This macro is not required in single core since there is only
; * one core to yield. */
;    #define prvYieldCore( xCoreID )                                                          \
;    do {                                                                                     \
;        if( ( xCoreID ) == ( BaseType_t ) portGET_CORE_ID() )                                \
;        {                                                                                    \
;            /* Pending a yield for this core since it is in the critical section. */         \
;            xYieldPendings[ ( xCoreID ) ] = pdTRUE;                                          \
;        }                                                                                    \
;        else                                                                                 \
;        {                                                                                    \
;            /* Request other core to yield if it is not requested before. */                 \
;            if( pxCurrentTCBs[ ( xCoreID ) ]->xTaskRunState != taskTASK_SCHEDULED_TO_YIELD ) \
;            {                                                                                \
;                portYIELD_CORE( xCoreID );                                                   \
;                pxCurrentTCBs[ ( xCoreID ) ]->xTaskRunState = taskTASK_SCHEDULED_TO_YIELD;   \
;            }                                                                                \
;        }                                                                                    \
;    } while( 0 )
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;/*-----------------------------------------------------------*/
;
;/*
; * Task control block.  A task control block (TCB) is allocated for each task,
; * and stores task state information, including a pointer to the task's context
; * (the task's run time environment, including register values)
; */
;typedef struct tskTaskControlBlock       /* The old naming convention is used to prevent breaking kernel aware debuggers. */
;{
;    volatile StackType_t * pxTopOfStack; /**< Points to the location of the last item placed on the tasks stack.  THIS MUST BE THE FIRST MEMBER OF THE TCB STRUCT. */
;
;    #if ( portUSING_MPU_WRAPPERS == 1 )
;        xMPU_SETTINGS xMPUSettings; /**< The MPU settings are defined as part of the port layer.  THIS MUST BE THE SECOND MEMBER OF THE TCB STRUCT. */
;    #endif
;
;    #if ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 )
;        UBaseType_t uxCoreAffinityMask; /**< Used to link the task to certain cores.  UBaseType_t must have greater than or equal to the number of bits as configNUMBER_OF_CORES. */
;    #endif
;
;    ListItem_t xStateListItem;                  /**< The list that the state list item of a task is reference from denotes the state of that task (Ready, Blocked, Suspended ). */
;    ListItem_t xEventListItem;                  /**< Used to reference a task from an event list. */
;    UBaseType_t uxPriority;                     /**< The priority of the task.  0 is the lowest priority. */
;    StackType_t * pxStack;                      /**< Points to the start of the stack. */
;    #if ( configNUMBER_OF_CORES > 1 )
;        volatile BaseType_t xTaskRunState;      /**< Used to identify the core the task is running on, if the task is running. Otherwise, identifies the task's state - not running or yielding. */
;        UBaseType_t uxTaskAttributes;           /**< Task's attributes - currently used to identify the idle tasks. */
;    #endif
;    char pcTaskName[ configMAX_TASK_NAME_LEN ]; /**< Descriptive name given to the task when created.  Facilitates debugging only. */
;
;    #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;        BaseType_t xPreemptionDisable; /**< Used to prevent the task from being preempted. */
;    #endif
;
;    #if ( ( portSTACK_GROWTH > 0 ) || ( configRECORD_STACK_HIGH_ADDRESS == 1 ) )
;        StackType_t * pxEndOfStack; /**< Points to the highest valid address for the stack. */
;    #endif
;
;    #if ( portCRITICAL_NESTING_IN_TCB == 1 )
;        UBaseType_t uxCriticalNesting; /**< Holds the critical section nesting depth for ports that do not maintain their own count in the port layer. */
;    #endif
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;        UBaseType_t uxTCBNumber;  /**< Stores a number that increments each time a TCB is created.  It allows debuggers to determine when a task has been deleted and then recreated. */
;        UBaseType_t uxTaskNumber; /**< Stores a number specifically for use by third party trace code. */
;    #endif
;
;    #if ( configUSE_MUTEXES == 1 )
;        UBaseType_t uxBasePriority; /**< The priority last assigned to the task - used by the priority inheritance mechanism. */
;        UBaseType_t uxMutexesHeld;
;    #endif
;
;    #if ( configUSE_APPLICATION_TASK_TAG == 1 )
;        TaskHookFunction_t pxTaskTag;
;    #endif
;
;    #if ( configNUM_THREAD_LOCAL_STORAGE_POINTERS > 0 )
;        void * pvThreadLocalStoragePointers[ configNUM_THREAD_LOCAL_STORAGE_POINTERS ];
;    #endif
;
;    #if ( configGENERATE_RUN_TIME_STATS == 1 )
;        configRUN_TIME_COUNTER_TYPE ulRunTimeCounter; /**< Stores the amount of time the task has spent in the Running state. */
;    #endif
;
;    #if ( configUSE_C_RUNTIME_TLS_SUPPORT == 1 )
;        configTLS_BLOCK_TYPE xTLSBlock; /**< Memory block used as Thread Local Storage (TLS) Block for the task. */
;    #endif
;
;    #if ( configUSE_TASK_NOTIFICATIONS == 1 )
;        volatile uint32_t ulNotifiedValue[ configTASK_NOTIFICATION_ARRAY_ENTRIES ];
;        volatile uint8_t ucNotifyState[ configTASK_NOTIFICATION_ARRAY_ENTRIES ];
;    #endif
;
;    /* See the comments in FreeRTOS.h with the definition of
;     * tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE. */
;    #if ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE != 0 )
;        uint8_t ucStaticallyAllocated; /**< Set to pdTRUE if the task is a statically allocated to ensure no attempt is made to free the memory. */
;    #endif
;
;    #if ( INCLUDE_xTaskAbortDelay == 1 )
;        uint8_t ucDelayAborted;
;    #endif
;
;    #if ( configUSE_POSIX_ERRNO == 1 )
;        int iTaskErrno;
;    #endif
;} tskTCB;
;
;/* The old tskTCB name is maintained above then typedefed to the new TCB_t name
; * below to enable the use of older kernel aware debuggers. */
;typedef tskTCB TCB_t;
;
;#if ( configNUMBER_OF_CORES == 1 )
;    /* MISRA Ref 8.4.1 [Declaration shall be visible] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-84 */
;    /* coverity[misra_c_2012_rule_8_4_violation] */
;    portDONT_DISCARD PRIVILEGED_DATA TCB_t * volatile pxCurrentTCB = NULL;
	data
	xdef	_~pxCurrentTCB
_~pxCurrentTCB:
	dl	$0
	ends
;#else
;    /* MISRA Ref 8.4.1 [Declaration shall be visible] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-84 */
;    /* coverity[misra_c_2012_rule_8_4_violation] */
;    portDONT_DISCARD PRIVILEGED_DATA TCB_t * volatile pxCurrentTCBs[ configNUMBER_OF_CORES ];
;    #define pxCurrentTCB    xTaskGetCurrentTaskHandle()
;#endif
;
;/* Lists for ready and blocked tasks. --------------------
; * xDelayedTaskList1 and xDelayedTaskList2 could be moved to function scope but
; * doing so breaks some kernel aware debuggers and debuggers that rely on removing
; * the static qualifier. */
;PRIVILEGED_DATA STATIC List_t pxReadyTasksLists[ configMAX_PRIORITIES ]; /**< Prioritised ready tasks. */
;PRIVILEGED_DATA STATIC List_t xDelayedTaskList1;                         /**< Delayed tasks. */
;PRIVILEGED_DATA STATIC List_t xDelayedTaskList2;                         /**< Delayed tasks (two lists are used - one for delays that have overflowed the current tick count. */
;PRIVILEGED_DATA STATIC List_t * volatile pxDelayedTaskList;              /**< Points to the delayed task list currently being used. */
;PRIVILEGED_DATA STATIC List_t * volatile pxOverflowDelayedTaskList;      /**< Points to the delayed task list currently being used to hold tasks that have overflowed the current tick count. */
;PRIVILEGED_DATA STATIC List_t xPendingReadyList;                         /**< Tasks that have been readied while the scheduler was suspended.  They will be moved to the ready list when the scheduler is resumed. */
;
;#if ( INCLUDE_vTaskDelete == 1 )
;
;    PRIVILEGED_DATA STATIC List_t xTasksWaitingTermination; /**< Tasks that have been deleted - but their memory not yet freed. */
;    PRIVILEGED_DATA STATIC volatile UBaseType_t uxDeletedTasksWaitingCleanUp = ( UBaseType_t ) 0U;
	data
_~uxDeletedTasksWaitingCleanUp:
	dw	$0
	ends
;
;#endif
;
;#if ( INCLUDE_vTaskSuspend == 1 )
;
;    PRIVILEGED_DATA STATIC List_t xSuspendedTaskList; /**< Tasks that are currently suspended. */
;
;#endif
;
;/* Global POSIX errno. Its value is changed upon context switching to match
; * the errno of the currently running task. */
;#if ( configUSE_POSIX_ERRNO == 1 )
;    int FreeRTOS_errno = 0;
;#endif
;
;/* Other file private variables. --------------------------------*/
;PRIVILEGED_DATA STATIC volatile UBaseType_t uxCurrentNumberOfTasks = ( UBaseType_t ) 0U;
	data
_~uxCurrentNumberOfTasks:
	dw	$0
	ends
;PRIVILEGED_DATA STATIC volatile TickType_t xTickCount = ( TickType_t ) configINITIAL_TICK_COUNT;
	data
_~xTickCount:
	dl	$0
	ends
;PRIVILEGED_DATA STATIC volatile UBaseType_t uxTopReadyPriority = tskIDLE_PRIORITY;
	data
_~uxTopReadyPriority:
	dw	$0
	ends
;PRIVILEGED_DATA STATIC volatile BaseType_t xSchedulerRunning = pdFALSE;
	data
_~xSchedulerRunning:
	dw	$0
	ends
;PRIVILEGED_DATA STATIC volatile TickType_t xPendedTicks = ( TickType_t ) 0U;
	data
_~xPendedTicks:
	dl	$0
	ends
;PRIVILEGED_DATA STATIC volatile BaseType_t xYieldPendings[ configNUMBER_OF_CORES ] = { pdFALSE };
	data
_~xYieldPendings:
	dw	$0
	ends
;PRIVILEGED_DATA STATIC volatile BaseType_t xNumOfOverflows = ( BaseType_t ) 0;
	data
_~xNumOfOverflows:
	dw	$0
	ends
;PRIVILEGED_DATA STATIC UBaseType_t uxTaskNumber = ( UBaseType_t ) 0U;
	data
_~uxTaskNumber:
	dw	$0
	ends
;PRIVILEGED_DATA STATIC volatile TickType_t xNextTaskUnblockTime = ( TickType_t ) 0U; /* Initialised to portMAX_DELAY before the scheduler starts. */
	data
_~xNextTaskUnblockTime:
	dl	$0
	ends
;PRIVILEGED_DATA STATIC TaskHandle_t xIdleTaskHandles[ configNUMBER_OF_CORES ];       /**< Holds the handles of the idle tasks.  The idle tasks are created automatically when the scheduler is started. */
;
;/* Improve support for OpenOCD. The kernel tracks Ready tasks via priority lists.
; * For tracking the state of remote threads, OpenOCD uses uxTopUsedPriority
; * to determine the number of priority lists to read back from the remote target. */
;STATIC const volatile UBaseType_t uxTopUsedPriority = configMAX_PRIORITIES - 1U;
	data
_~uxTopUsedPriority:
	dw	$4
	ends
;
;/* Context switches are held pending while the scheduler is suspended.  Also,
; * interrupts must not manipulate the xStateListItem of a TCB, or any of the
; * lists the xStateListItem can be referenced from, if the scheduler is suspended.
; * If an interrupt needs to unblock a task while the scheduler is suspended then it
; * moves the task's event list item into the xPendingReadyList, ready for the
; * kernel to move the task from the pending ready list into the real ready list
; * when the scheduler is unsuspended.  The pending ready list itself can only be
; * accessed from a critical section.
; *
; * Updates to uxSchedulerSuspended must be protected by both the task lock and the ISR lock
; * and must not be done from an ISR. Reads must be protected by either lock and may be done
; * from either an ISR or a task. */
;PRIVILEGED_DATA STATIC volatile UBaseType_t uxSchedulerSuspended = ( UBaseType_t ) 0U;
	data
_~uxSchedulerSuspended:
	dw	$0
	ends
;
;#if ( configGENERATE_RUN_TIME_STATS == 1 )
;
;/* Do not move these variables to function scope as doing so prevents the
; * code working with debuggers that need to remove the static qualifier. */
;PRIVILEGED_DATA STATIC configRUN_TIME_COUNTER_TYPE ulTaskSwitchedInTime[ configNUMBER_OF_CORES ] = { 0U };    /**< Holds the value of a timer/counter the last time a task was switched in. */
;PRIVILEGED_DATA STATIC volatile configRUN_TIME_COUNTER_TYPE ulTotalRunTime[ configNUMBER_OF_CORES ] = { 0U }; /**< Holds the total amount of execution time as defined by the run time counter clock. */
;
;#endif
;
;/*-----------------------------------------------------------*/
;
;/* File private functions. --------------------------------*/
;
;/*
; * Creates the idle tasks during scheduler start.
; */
;STATIC BaseType_t prvCreateIdleTasks( void );
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;/*
; * Checks to see if another task moved the current task out of the ready
; * list while it was waiting to enter a critical section and yields, if so.
; */
;    STATIC void prvCheckForRunStateChange( void );
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;/*
; * Yields a core, or cores if multiple priorities are not allowed to run
; * simultaneously, to allow the task pxTCB to run.
; */
;    STATIC void prvYieldForTask( const TCB_t * pxTCB );
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;/*
; * Selects the highest priority available task for the given core.
; */
;    STATIC void prvSelectHighestPriorityTask( BaseType_t xCoreID );
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;/**
; * Utility task that simply returns pdTRUE if the task referenced by xTask is
; * currently in the Suspended state, or pdFALSE if the task referenced by xTask
; * is in any other state.
; */
;#if ( INCLUDE_vTaskSuspend == 1 )
;
;    STATIC BaseType_t prvTaskIsTaskSuspended( const TaskHandle_t xTask ) PRIVILEGED_FUNCTION;
;
;#endif /* INCLUDE_vTaskSuspend */
;
;/*
; * Utility to ready all the lists used by the scheduler.  This is called
; * automatically upon the creation of the first task.
; */
;STATIC void prvInitialiseTaskLists( void ) PRIVILEGED_FUNCTION;
;
;/*
; * The idle task, which as all tasks is implemented as a never ending loop.
; * The idle task is automatically created and added to the ready lists upon
; * creation of the first user task.
; *
; * In the FreeRTOS SMP, configNUMBER_OF_CORES - 1 passive idle tasks are also
; * created to ensure that each core has an idle task to run when no other
; * task is available to run.
; *
; * The portTASK_FUNCTION_PROTO() macro is used to allow port/compiler specific
; * language extensions.  The equivalent prototype for these functions are:
; *
; * void prvIdleTask( void *pvParameters );
; * void prvPassiveIdleTask( void *pvParameters );
; *
; */
;STATIC portTASK_FUNCTION_PROTO( prvIdleTask,
;                                pvParameters ) PRIVILEGED_FUNCTION;
;#if ( configNUMBER_OF_CORES > 1 )
;    STATIC portTASK_FUNCTION_PROTO( prvPassiveIdleTask,
;                                    pvParameters ) PRIVILEGED_FUNCTION;
;#endif
;
;/*
; * Utility to free all memory allocated by the scheduler to hold a TCB,
; * including the stack pointed to by the TCB.
; *
; * This does not free memory allocated by the task itself (i.e. memory
; * allocated by calls to pvPortMalloc from within the tasks application code).
; */
;#if ( INCLUDE_vTaskDelete == 1 )
;
;    STATIC void prvDeleteTCB( TCB_t * pxTCB ) PRIVILEGED_FUNCTION;
;
;#endif
;
;/*
; * Used only by the idle task.  This checks to see if anything has been placed
; * in the list of tasks waiting to be deleted.  If so the task is cleaned up
; * and its TCB deleted.
; */
;STATIC void prvCheckTasksWaitingTermination( void ) PRIVILEGED_FUNCTION;
;
;/*
; * The currently executing task is entering the Blocked state.  Add the task to
; * either the current or the overflow delayed task list.
; */
;STATIC void prvAddCurrentTaskToDelayedList( TickType_t xTicksToWait,
;                                            const BaseType_t xCanBlockIndefinitely ) PRIVILEGED_FUNCTION;
;
;/*
; * Searches pxList for a task with name pcNameToQuery - returning a handle to
; * the task if it is found, or NULL if the task is not found.
; */
;#if ( INCLUDE_xTaskGetHandle == 1 )
;
;    STATIC TCB_t * prvSearchForNameWithinSingleList( List_t * pxList,
;                                                     const char pcNameToQuery[] ) PRIVILEGED_FUNCTION;
;
;#endif
;
;/*
; * When a task is created, the stack of the task is filled with a known value.
; * This function determines the 'high water mark' of the task stack by
; * determining how much of the stack remains at the original preset value.
; */
;#if ( ( configUSE_TRACE_FACILITY == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark2 == 1 ) )
;
;    STATIC configSTACK_DEPTH_TYPE prvTaskCheckFreeStackSpace( const uint8_t * pucStackByte ) PRIVILEGED_FUNCTION;
;
;#endif
;
;/*
; * Return the amount of time, in ticks, that will pass before the kernel will
; * next move a task from the Blocked state to the Running state or before the
; * tick count overflows (whichever is earlier).
; *
; * This conditional compilation should use inequality to 0, not equality to 1.
; * This is to ensure portSUPPRESS_TICKS_AND_SLEEP() can be called when user
; * defined low power mode implementations require configUSE_TICKLESS_IDLE to be
; * set to a value other than 1.
; */
;#if ( configUSE_TICKLESS_IDLE != 0 )
;
;    STATIC TickType_t prvGetExpectedIdleTime( void ) PRIVILEGED_FUNCTION;
;
;#endif
;
;/*
; * Set xNextTaskUnblockTime to the time at which the next Blocked state task
; * will exit the Blocked state.
; */
;STATIC void prvResetNextTaskUnblockTime( void ) PRIVILEGED_FUNCTION;
;
;#if ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 )
;
;/*
; * Helper function used to pad task names with spaces when printing out
; * human readable tables of task information.
; */
;    static char * prvWriteNameToBuffer( char * pcBuffer,
;                                        const char * pcTaskName ) PRIVILEGED_FUNCTION;
;
;#endif
;
;/*
; * Called after a Task_t structure has been allocated either statically or
; * dynamically to fill in the structure's members.
; */
;STATIC void prvInitialiseNewTask( TaskFunction_t pxTaskCode,
;                                  const char * const pcName,
;                                  const configSTACK_DEPTH_TYPE uxStackDepth,
;                                  void * const pvParameters,
;                                  UBaseType_t uxPriority,
;                                  TaskHandle_t * const pxCreatedTask,
;                                  TCB_t * pxNewTCB,
;                                  const MemoryRegion_t * const xRegions ) PRIVILEGED_FUNCTION;
;
;/*
; * Called after a new task has been created and initialised to place the task
; * under the control of the scheduler.
; */
;STATIC void prvAddNewTaskToReadyList( TCB_t * pxNewTCB ) PRIVILEGED_FUNCTION;
;
;/*
; * Create a task with static buffer for both TCB and stack. Returns a handle to
; * the task if it is created successfully. Otherwise, returns NULL.
; */
;#if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;    STATIC TCB_t * prvCreateStaticTask( TaskFunction_t pxTaskCode,
;                                        const char * const pcName,
;                                        const configSTACK_DEPTH_TYPE uxStackDepth,
;                                        void * const pvParameters,
;                                        UBaseType_t uxPriority,
;                                        StackType_t * const puxStackBuffer,
;                                        StaticTask_t * const pxTaskBuffer,
;                                        TaskHandle_t * const pxCreatedTask ) PRIVILEGED_FUNCTION;
;#endif /* #if ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;
;/*
; * Create a restricted task with static buffer for both TCB and stack. Returns
; * a handle to the task if it is created successfully. Otherwise, returns NULL.
; */
;#if ( ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;    STATIC TCB_t * prvCreateRestrictedStaticTask( const TaskParameters_t * const pxTaskDefinition,
;                                                  TaskHandle_t * const pxCreatedTask ) PRIVILEGED_FUNCTION;
;#endif /* #if ( ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) ) */
;
;/*
; * Create a restricted task with static buffer for task stack and allocated buffer
; * for TCB. Returns a handle to the task if it is created successfully. Otherwise,
; * returns NULL.
; */
;#if ( ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;    STATIC TCB_t * prvCreateRestrictedTask( const TaskParameters_t * const pxTaskDefinition,
;                                            TaskHandle_t * const pxCreatedTask ) PRIVILEGED_FUNCTION;
;#endif /* #if ( ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) ) */
;
;/*
; * Create a task with allocated buffer for both TCB and stack. Returns a handle to
; * the task if it is created successfully. Otherwise, returns NULL.
; */
;#if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;    STATIC TCB_t * prvCreateTask( TaskFunction_t pxTaskCode,
;                                  const char * const pcName,
;                                  const configSTACK_DEPTH_TYPE uxStackDepth,
;                                  void * const pvParameters,
;                                  UBaseType_t uxPriority,
;                                  TaskHandle_t * const pxCreatedTask ) PRIVILEGED_FUNCTION;
;#endif /* #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) */
;
;/*
; * freertos_tasks_c_additions_init() should only be called if the user definable
; * macro FREERTOS_TASKS_C_ADDITIONS_INIT() is defined, as that is the only macro
; * called by the function.
; */
;#ifdef FREERTOS_TASKS_C_ADDITIONS_INIT
;
;    STATIC void freertos_tasks_c_additions_init( void ) PRIVILEGED_FUNCTION;
;
;#endif
;
;#if ( configUSE_PASSIVE_IDLE_HOOK == 1 )
;    extern void vApplicationPassiveIdleHook( void );
;#endif /* #if ( configUSE_PASSIVE_IDLE_HOOK == 1 ) */
;
;#if ( ( configUSE_TRACE_FACILITY == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) )
;
;/*
; * Convert the snprintf return value to the number of characters
; * written. The following are the possible cases:
; *
; * 1. The buffer supplied to snprintf is large enough to hold the
; *    generated string. The return value in this case is the number
; *    of characters actually written, not counting the terminating
; *    null character.
; * 2. The buffer supplied to snprintf is NOT large enough to hold
; *    the generated string. The return value in this case is the
; *    number of characters that would have been written if the
; *    buffer had been sufficiently large, not counting the
; *    terminating null character.
; * 3. Encoding error. The return value in this case is a negative
; *    number.
; *
; * From 1 and 2 above ==> Only when the return value is non-negative
; * and less than the supplied buffer length, the string has been
; * completely written.
; */
;    STATIC size_t prvSnprintfReturnValueToCharsWritten( int iSnprintfReturnValue,
;                                                        size_t n );
;
;#endif /* #if ( ( configUSE_TRACE_FACILITY == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;    STATIC void prvCheckForRunStateChange( void )
;    {
;        UBaseType_t uxPrevCriticalNesting;
;        const TCB_t * pxThisTCB;
;        BaseType_t xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;        /* This must only be called from within a task. */
;        portASSERT_IF_IN_ISR();
;
;        /* This function is always called with interrupts disabled
;         * so this is safe. */
;        pxThisTCB = pxCurrentTCBs[ xCoreID ];
;
;        while( pxThisTCB->xTaskRunState == taskTASK_SCHEDULED_TO_YIELD )
;        {
;            /* We are only here if we just entered a critical section
;            * or if we just suspended the scheduler, and another task
;            * has requested that we yield.
;            *
;            * This is slightly complicated since we need to save and restore
;            * the suspension and critical nesting counts, as well as release
;            * and reacquire the correct locks. And then, do it all over again
;            * if our state changed again during the reacquisition. */
;            uxPrevCriticalNesting = portGET_CRITICAL_NESTING_COUNT( xCoreID );
;
;            if( uxPrevCriticalNesting > 0U )
;            {
;                portSET_CRITICAL_NESTING_COUNT( xCoreID, 0U );
;                portRELEASE_ISR_LOCK( xCoreID );
;            }
;            else
;            {
;                /* The scheduler is suspended. uxSchedulerSuspended is updated
;                 * only when the task is not requested to yield. */
;                mtCOVERAGE_TEST_MARKER();
;            }
;
;            portRELEASE_TASK_LOCK( xCoreID );
;            portMEMORY_BARRIER();
;            configASSERT( pxThisTCB->xTaskRunState == taskTASK_SCHEDULED_TO_YIELD );
;
;            portENABLE_INTERRUPTS();
;
;            /* Enabling interrupts should cause this core to immediately service
;             * the pending interrupt and yield. After servicing the pending interrupt,
;             * the task needs to re-evaluate its run state within this loop, as
;             * other cores may have requested this task to yield, potentially altering
;             * its run state. */
;
;            portDISABLE_INTERRUPTS();
;
;            xCoreID = ( BaseType_t ) portGET_CORE_ID();
;            portGET_TASK_LOCK( xCoreID );
;            portGET_ISR_LOCK( xCoreID );
;
;            portSET_CRITICAL_NESTING_COUNT( xCoreID, uxPrevCriticalNesting );
;
;            if( uxPrevCriticalNesting == 0U )
;            {
;                portRELEASE_ISR_LOCK( xCoreID );
;            }
;        }
;    }
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;    STATIC void prvYieldForTask( const TCB_t * pxTCB )
;    {
;        BaseType_t xLowestPriorityToPreempt;
;        BaseType_t xCurrentCoreTaskPriority;
;        BaseType_t xLowestPriorityCore = ( BaseType_t ) -1;
;        BaseType_t xCoreID;
;        const BaseType_t xCurrentCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;        #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;            BaseType_t xYieldCount = 0;
;        #endif /* #if ( configRUN_MULTIPLE_PRIORITIES == 0 ) */
;
;        /* This must be called from a critical section. */
;        configASSERT( portGET_CRITICAL_NESTING_COUNT( xCurrentCoreID ) > 0U );
;
;        #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;
;            /* No task should yield for this one if it is a lower priority
;             * than priority level of currently ready tasks. */
;            if( pxTCB->uxPriority >= uxTopReadyPriority )
;        #else
;            /* Yield is not required for a task which is already running. */
;            if( taskTASK_IS_RUNNING( pxTCB ) == pdFALSE )
;        #endif
;        {
;            xLowestPriorityToPreempt = ( BaseType_t ) pxTCB->uxPriority;
;
;            /* xLowestPriorityToPreempt will be decremented to -1 if the priority of pxTCB
;             * is 0. This is ok as we will give system idle tasks a priority of -1 below. */
;            --xLowestPriorityToPreempt;
;
;            for( xCoreID = ( BaseType_t ) 0; xCoreID < ( BaseType_t ) configNUMBER_OF_CORES; xCoreID++ )
;            {
;                xCurrentCoreTaskPriority = ( BaseType_t ) pxCurrentTCBs[ xCoreID ]->uxPriority;
;
;                /* System idle tasks are being assigned a priority of tskIDLE_PRIORITY - 1 here. */
;                if( ( pxCurrentTCBs[ xCoreID ]->uxTaskAttributes & taskATTRIBUTE_IS_IDLE ) != 0U )
;                {
;                    xCurrentCoreTaskPriority = ( BaseType_t ) ( xCurrentCoreTaskPriority - 1 );
;                }
;
;                if( ( taskTASK_IS_RUNNING( pxCurrentTCBs[ xCoreID ] ) != pdFALSE ) && ( xYieldPendings[ xCoreID ] == pdFALSE ) )
;                {
;                    #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;                        if( taskTASK_IS_RUNNING( pxTCB ) == pdFALSE )
;                    #endif
;                    {
;                        if( xCurrentCoreTaskPriority <= xLowestPriorityToPreempt )
;                        {
;                            #if ( configUSE_CORE_AFFINITY == 1 )
;                                if( ( pxTCB->uxCoreAffinityMask & ( ( UBaseType_t ) 1U << ( UBaseType_t ) xCoreID ) ) != 0U )
;                            #endif
;                            {
;                                #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;                                    if( pxCurrentTCBs[ xCoreID ]->xPreemptionDisable == pdFALSE )
;                                #endif
;                                {
;                                    xLowestPriorityToPreempt = xCurrentCoreTaskPriority;
;                                    xLowestPriorityCore = xCoreID;
;                                }
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;
;                    #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;                    {
;                        /* Yield all currently running non-idle tasks with a priority lower than
;                         * the task that needs to run. */
;                        if( ( xCurrentCoreTaskPriority > ( ( BaseType_t ) tskIDLE_PRIORITY - 1 ) ) &&
;                            ( xCurrentCoreTaskPriority < ( BaseType_t ) pxTCB->uxPriority ) )
;                        {
;                            prvYieldCore( xCoreID );
;                            xYieldCount++;
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    #endif /* #if ( configRUN_MULTIPLE_PRIORITIES == 0 ) */
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;
;            #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;                if( ( xYieldCount == 0 ) && ( xLowestPriorityCore >= 0 ) )
;            #else /* #if ( configRUN_MULTIPLE_PRIORITIES == 0 ) */
;                if( xLowestPriorityCore >= 0 )
;            #endif /* #if ( configRUN_MULTIPLE_PRIORITIES == 0 ) */
;            {
;                prvYieldCore( xLowestPriorityCore );
;            }
;
;            #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;                /* Verify that the calling core always yields to higher priority tasks. */
;                if( ( ( pxCurrentTCBs[ xCurrentCoreID ]->uxTaskAttributes & taskATTRIBUTE_IS_IDLE ) == 0U ) &&
;                    ( pxTCB->uxPriority > pxCurrentTCBs[ xCurrentCoreID ]->uxPriority ) )
;                {
;                    configASSERT( ( xYieldPendings[ xCurrentCoreID ] == pdTRUE ) ||
;                                  ( taskTASK_IS_RUNNING( pxCurrentTCBs[ xCurrentCoreID ] ) == pdFALSE ) );
;                }
;            #endif
;        }
;    }
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;    STATIC void prvSelectHighestPriorityTask( BaseType_t xCoreID )
;    {
;        UBaseType_t uxCurrentPriority = uxTopReadyPriority;
;        BaseType_t xTaskScheduled = pdFALSE;
;        BaseType_t xDecrementTopPriority = pdTRUE;
;        TCB_t * pxTCB = NULL;
;
;        #if ( configUSE_CORE_AFFINITY == 1 )
;            const TCB_t * pxPreviousTCB = NULL;
;        #endif
;        #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;            BaseType_t xPriorityDropped = pdFALSE;
;        #endif
;
;        /* This function should be called when scheduler is running. */
;        configASSERT( xSchedulerRunning == pdTRUE );
;
;        /* A new task is created and a running task with the same priority yields
;         * itself to run the new task. When a running task yields itself, it is still
;         * in the ready list. This running task will be selected before the new task
;         * since the new task is always added to the end of the ready list.
;         * The other problem is that the running task still in the same position of
;         * the ready list when it yields itself. It is possible that it will be selected
;         * earlier then other tasks which waits longer than this task.
;         *
;         * To fix these problems, the running task should be put to the end of the
;         * ready list before searching for the ready task in the ready list. */
;        if( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ pxCurrentTCBs[ xCoreID ]->uxPriority ] ),
;                                     &pxCurrentTCBs[ xCoreID ]->xStateListItem ) == pdTRUE )
;        {
;            ( void ) uxListRemove( &pxCurrentTCBs[ xCoreID ]->xStateListItem );
;            vListInsertEnd( &( pxReadyTasksLists[ pxCurrentTCBs[ xCoreID ]->uxPriority ] ),
;                            &pxCurrentTCBs[ xCoreID ]->xStateListItem );
;        }
;
;        while( xTaskScheduled == pdFALSE )
;        {
;            #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;            {
;                if( uxCurrentPriority < uxTopReadyPriority )
;                {
;                    /* We can't schedule any tasks, other than idle, that have a
;                     * priority lower than the priority of a task currently running
;                     * on another core. */
;                    uxCurrentPriority = tskIDLE_PRIORITY;
;                }
;            }
;            #endif
;
;            if( listLIST_IS_EMPTY( &( pxReadyTasksLists[ uxCurrentPriority ] ) ) == pdFALSE )
;            {
;                const List_t * const pxReadyList = &( pxReadyTasksLists[ uxCurrentPriority ] );
;                const ListItem_t * pxEndMarker = listGET_END_MARKER( pxReadyList );
;                ListItem_t * pxIterator;
;
;                /* The ready task list for uxCurrentPriority is not empty, so uxTopReadyPriority
;                 * must not be decremented any further. */
;                xDecrementTopPriority = pdFALSE;
;
;                for( pxIterator = listGET_HEAD_ENTRY( pxReadyList ); pxIterator != pxEndMarker; pxIterator = listGET_NEXT( pxIterator ) )
;                {
;                    /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                    /* coverity[misra_c_2012_rule_11_5_violation] */
;                    pxTCB = ( TCB_t * ) listGET_LIST_ITEM_OWNER( pxIterator );
;
;                    #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;                    {
;                        /* When falling back to the idle priority because only one priority
;                         * level is allowed to run at a time, we should ONLY schedule the true
;                         * idle tasks, not user tasks at the idle priority. */
;                        if( uxCurrentPriority < uxTopReadyPriority )
;                        {
;                            if( ( pxTCB->uxTaskAttributes & taskATTRIBUTE_IS_IDLE ) == 0U )
;                            {
;                                continue;
;                            }
;                        }
;                    }
;                    #endif /* #if ( configRUN_MULTIPLE_PRIORITIES == 0 ) */
;
;                    if( pxTCB->xTaskRunState == taskTASK_NOT_RUNNING )
;                    {
;                        #if ( configUSE_CORE_AFFINITY == 1 )
;                            if( ( pxTCB->uxCoreAffinityMask & ( ( UBaseType_t ) 1U << ( UBaseType_t ) xCoreID ) ) != 0U )
;                        #endif
;                        {
;                            /* If the task is not being executed by any core swap it in. */
;                            pxCurrentTCBs[ xCoreID ]->xTaskRunState = taskTASK_NOT_RUNNING;
;                            #if ( configUSE_CORE_AFFINITY == 1 )
;                                pxPreviousTCB = pxCurrentTCBs[ xCoreID ];
;                            #endif
;                            pxTCB->xTaskRunState = xCoreID;
;                            pxCurrentTCBs[ xCoreID ] = pxTCB;
;                            xTaskScheduled = pdTRUE;
;                        }
;                    }
;                    else if( pxTCB == pxCurrentTCBs[ xCoreID ] )
;                    {
;                        configASSERT( ( pxTCB->xTaskRunState == xCoreID ) || ( pxTCB->xTaskRunState == taskTASK_SCHEDULED_TO_YIELD ) );
;
;                        #if ( configUSE_CORE_AFFINITY == 1 )
;                            if( ( pxTCB->uxCoreAffinityMask & ( ( UBaseType_t ) 1U << ( UBaseType_t ) xCoreID ) ) != 0U )
;                        #endif
;                        {
;                            /* The task is already running on this core, mark it as scheduled. */
;                            pxTCB->xTaskRunState = xCoreID;
;                            xTaskScheduled = pdTRUE;
;                        }
;                    }
;                    else
;                    {
;                        /* This task is running on the core other than xCoreID. */
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;
;                    if( xTaskScheduled != pdFALSE )
;                    {
;                        /* A task has been selected to run on this core. */
;                        break;
;                    }
;                }
;            }
;            else
;            {
;                if( xDecrementTopPriority != pdFALSE )
;                {
;                    uxTopReadyPriority--;
;                    #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;                    {
;                        xPriorityDropped = pdTRUE;
;                    }
;                    #endif
;                }
;            }
;
;            /* There are configNUMBER_OF_CORES Idle tasks created when scheduler started.
;             * The scheduler should be able to select a task to run when uxCurrentPriority
;             * is tskIDLE_PRIORITY. uxCurrentPriority is never decreased to value blow
;             * tskIDLE_PRIORITY. */
;            if( uxCurrentPriority > tskIDLE_PRIORITY )
;            {
;                uxCurrentPriority--;
;            }
;            else
;            {
;                /* This function is called when idle task is not created. Break the
;                 * loop to prevent uxCurrentPriority overrun. */
;                break;
;            }
;        }
;
;        #if ( configRUN_MULTIPLE_PRIORITIES == 0 )
;        {
;            if( xTaskScheduled == pdTRUE )
;            {
;                if( xPriorityDropped != pdFALSE )
;                {
;                    /* There may be several ready tasks that were being prevented from running because there was
;                     * a higher priority task running. Now that the last of the higher priority tasks is no longer
;                     * running, make sure all the other idle tasks yield. */
;                    BaseType_t x;
;
;                    for( x = ( BaseType_t ) 0; x < ( BaseType_t ) configNUMBER_OF_CORES; x++ )
;                    {
;                        if( ( pxCurrentTCBs[ x ]->uxTaskAttributes & taskATTRIBUTE_IS_IDLE ) != 0U )
;                        {
;                            prvYieldCore( x );
;                        }
;                    }
;                }
;            }
;        }
;        #endif /* #if ( configRUN_MULTIPLE_PRIORITIES == 0 ) */
;
;        #if ( configUSE_CORE_AFFINITY == 1 )
;        {
;            if( xTaskScheduled == pdTRUE )
;            {
;                if( ( pxPreviousTCB != NULL ) && ( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ pxPreviousTCB->uxPriority ] ), &( pxPreviousTCB->xStateListItem ) ) != pdFALSE ) )
;                {
;                    /* A ready task was just evicted from this core. See if it can be
;                     * scheduled on any other core. */
;                    UBaseType_t uxCoreMap = pxPreviousTCB->uxCoreAffinityMask;
;                    BaseType_t xLowestPriority = ( BaseType_t ) pxPreviousTCB->uxPriority;
;                    BaseType_t xLowestPriorityCore = -1;
;                    BaseType_t x;
;
;                    if( ( pxPreviousTCB->uxTaskAttributes & taskATTRIBUTE_IS_IDLE ) != 0U )
;                    {
;                        xLowestPriority = xLowestPriority - 1;
;                    }
;
;                    if( ( uxCoreMap & ( ( UBaseType_t ) 1U << ( UBaseType_t ) xCoreID ) ) != 0U )
;                    {
;                        /* pxPreviousTCB was removed from this core and this core is not excluded
;                         * from it's core affinity mask.
;                         *
;                         * pxPreviousTCB is preempted by the new higher priority task
;                         * pxCurrentTCBs[ xCoreID ]. When searching a new core for pxPreviousTCB,
;                         * we do not need to look at the cores on which pxCurrentTCBs[ xCoreID ]
;                         * is allowed to run. The reason is - when more than one cores are
;                         * eligible for an incoming task, we preempt the core with the minimum
;                         * priority task. Because this core (i.e. xCoreID) was preempted for
;                         * pxCurrentTCBs[ xCoreID ], this means that all the others cores
;                         * where pxCurrentTCBs[ xCoreID ] can run, are running tasks with priority
;                         * no lower than pxPreviousTCB's priority. Therefore, the only cores where
;                         * which can be preempted for pxPreviousTCB are the ones where
;                         * pxCurrentTCBs[ xCoreID ] is not allowed to run (and obviously,
;                         * pxPreviousTCB is allowed to run).
;                         *
;                         * This is an optimization which reduces the number of cores needed to be
;                         * searched for pxPreviousTCB to run. */
;                        uxCoreMap &= ~( pxCurrentTCBs[ xCoreID ]->uxCoreAffinityMask );
;                    }
;                    else
;                    {
;                        /* pxPreviousTCB's core affinity mask is changed and it is no longer
;                         * allowed to run on this core. Searching all the cores in pxPreviousTCB's
;                         * new core affinity mask to find a core on which it can run. */
;                    }
;
;                    uxCoreMap &= ( ( 1U << configNUMBER_OF_CORES ) - 1U );
;
;                    for( x = ( ( BaseType_t ) configNUMBER_OF_CORES - 1 ); x >= ( BaseType_t ) 0; x-- )
;                    {
;                        UBaseType_t uxCore = ( UBaseType_t ) x;
;                        BaseType_t xTaskPriority;
;
;                        if( ( uxCoreMap & ( ( UBaseType_t ) 1U << uxCore ) ) != 0U )
;                        {
;                            xTaskPriority = ( BaseType_t ) pxCurrentTCBs[ uxCore ]->uxPriority;
;
;                            if( ( pxCurrentTCBs[ uxCore ]->uxTaskAttributes & taskATTRIBUTE_IS_IDLE ) != 0U )
;                            {
;                                xTaskPriority = xTaskPriority - ( BaseType_t ) 1;
;                            }
;
;                            uxCoreMap &= ~( ( UBaseType_t ) 1U << uxCore );
;
;                            if( ( xTaskPriority < xLowestPriority ) &&
;                                ( taskTASK_IS_RUNNING( pxCurrentTCBs[ uxCore ] ) != pdFALSE ) &&
;                                ( xYieldPendings[ uxCore ] == pdFALSE ) )
;                            {
;                                #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;                                    if( pxCurrentTCBs[ uxCore ]->xPreemptionDisable == pdFALSE )
;                                #endif
;                                {
;                                    xLowestPriority = xTaskPriority;
;                                    xLowestPriorityCore = ( BaseType_t ) uxCore;
;                                }
;                            }
;                        }
;                    }
;
;                    if( xLowestPriorityCore >= 0 )
;                    {
;                        prvYieldCore( xLowestPriorityCore );
;                    }
;                }
;            }
;        }
;        #endif /* #if ( configUSE_CORE_AFFINITY == 1 ) */
;    }
;
;#endif /* ( configNUMBER_OF_CORES > 1 ) */
;
;/*-----------------------------------------------------------*/
;
;#if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;    STATIC TCB_t * prvCreateStaticTask( TaskFunction_t pxTaskCode,
;                                        const char * const pcName,
;                                        const configSTACK_DEPTH_TYPE uxStackDepth,
;                                        void * const pvParameters,
;                                        UBaseType_t uxPriority,
;                                        StackType_t * const puxStackBuffer,
;                                        StaticTask_t * const pxTaskBuffer,
;                                        TaskHandle_t * const pxCreatedTask )
;    {
;        TCB_t * pxNewTCB;
;
;        configASSERT( puxStackBuffer != NULL );
;        configASSERT( pxTaskBuffer != NULL );
;
;        #if ( configASSERT_DEFINED == 1 )
;        {
;            /* Sanity check that the size of the structure used to declare a
;             * variable of type StaticTask_t equals the size of the real task
;             * structure. */
;            volatile size_t xSize = sizeof( StaticTask_t );
;            configASSERT( xSize == sizeof( TCB_t ) );
;            ( void ) xSize; /* Prevent unused variable warning when configASSERT() is not used. */
;        }
;        #endif /* configASSERT_DEFINED */
;
;        if( ( pxTaskBuffer != NULL ) && ( puxStackBuffer != NULL ) )
;        {
;            /* The memory used for the task's TCB and stack are passed into this
;             * function - use them. */
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            pxNewTCB = ( TCB_t * ) pxTaskBuffer;
;            ( void ) memset( ( void * ) pxNewTCB, 0x00, sizeof( TCB_t ) );
;            pxNewTCB->pxStack = ( StackType_t * ) puxStackBuffer;
;
;            #if ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE != 0 )
;            {
;                /* Tasks can be created statically or dynamically, so note this
;                 * task was created statically in case the task is later deleted. */
;                pxNewTCB->ucStaticallyAllocated = tskSTATICALLY_ALLOCATED_STACK_AND_TCB;
;            }
;            #endif /* tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE */
;
;            prvInitialiseNewTask( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, pxCreatedTask, pxNewTCB, NULL );
;        }
;        else
;        {
;            pxNewTCB = NULL;
;        }
;
;        return pxNewTCB;
;    }
;/*-----------------------------------------------------------*/
;
;    TaskHandle_t xTaskCreateStatic( TaskFunction_t pxTaskCode,
;                                    const char * const pcName,
;                                    const configSTACK_DEPTH_TYPE uxStackDepth,
;                                    void * const pvParameters,
;                                    UBaseType_t uxPriority,
;                                    StackType_t * const puxStackBuffer,
;                                    StaticTask_t * const pxTaskBuffer )
;    {
;        TaskHandle_t xReturn = NULL;
;        TCB_t * pxNewTCB;
;
;        traceENTER_xTaskCreateStatic( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, puxStackBuffer, pxTaskBuffer );
;
;        pxNewTCB = prvCreateStaticTask( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, puxStackBuffer, pxTaskBuffer, &xReturn );
;
;        if( pxNewTCB != NULL )
;        {
;            #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = configTASK_DEFAULT_CORE_AFFINITY;
;            }
;            #endif
;
;            prvAddNewTaskToReadyList( pxNewTCB );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_xTaskCreateStatic( xReturn );
;
;        return xReturn;
;    }
;/*-----------------------------------------------------------*/
;
;    #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;        TaskHandle_t xTaskCreateStaticAffinitySet( TaskFunction_t pxTaskCode,
;                                                   const char * const pcName,
;                                                   const configSTACK_DEPTH_TYPE uxStackDepth,
;                                                   void * const pvParameters,
;                                                   UBaseType_t uxPriority,
;                                                   StackType_t * const puxStackBuffer,
;                                                   StaticTask_t * const pxTaskBuffer,
;                                                   UBaseType_t uxCoreAffinityMask )
;        {
;            TaskHandle_t xReturn = NULL;
;            TCB_t * pxNewTCB;
;
;            traceENTER_xTaskCreateStaticAffinitySet( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, puxStackBuffer, pxTaskBuffer, uxCoreAffinityMask );
;
;            pxNewTCB = prvCreateStaticTask( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, puxStackBuffer, pxTaskBuffer, &xReturn );
;
;            if( pxNewTCB != NULL )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = uxCoreAffinityMask;
;
;                prvAddNewTaskToReadyList( pxNewTCB );
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;
;            traceRETURN_xTaskCreateStaticAffinitySet( xReturn );
;
;            return xReturn;
;        }
;    #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;#endif /* SUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;#if ( ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;    STATIC TCB_t * prvCreateRestrictedStaticTask( const TaskParameters_t * const pxTaskDefinition,
;                                                  TaskHandle_t * const pxCreatedTask )
;    {
;        TCB_t * pxNewTCB;
;
;        configASSERT( pxTaskDefinition->puxStackBuffer != NULL );
;        configASSERT( pxTaskDefinition->pxTaskBuffer != NULL );
;
;        if( ( pxTaskDefinition->puxStackBuffer != NULL ) && ( pxTaskDefinition->pxTaskBuffer != NULL ) )
;        {
;            /* Allocate space for the TCB.  Where the memory comes from depends
;             * on the implementation of the port malloc function and whether or
;             * not static allocation is being used. */
;            pxNewTCB = ( TCB_t * ) pxTaskDefinition->pxTaskBuffer;
;            ( void ) memset( ( void * ) pxNewTCB, 0x00, sizeof( TCB_t ) );
;
;            /* Store the stack location in the TCB. */
;            pxNewTCB->pxStack = pxTaskDefinition->puxStackBuffer;
;
;            #if ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE != 0 )
;            {
;                /* Tasks can be created statically or dynamically, so note this
;                 * task was created statically in case the task is later deleted. */
;                pxNewTCB->ucStaticallyAllocated = tskSTATICALLY_ALLOCATED_STACK_AND_TCB;
;            }
;            #endif /* tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE */
;
;            prvInitialiseNewTask( pxTaskDefinition->pvTaskCode,
;                                  pxTaskDefinition->pcName,
;                                  pxTaskDefinition->usStackDepth,
;                                  pxTaskDefinition->pvParameters,
;                                  pxTaskDefinition->uxPriority,
;                                  pxCreatedTask, pxNewTCB,
;                                  pxTaskDefinition->xRegions );
;        }
;        else
;        {
;            pxNewTCB = NULL;
;        }
;
;        return pxNewTCB;
;    }
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTaskCreateRestrictedStatic( const TaskParameters_t * const pxTaskDefinition,
;                                            TaskHandle_t * pxCreatedTask )
;    {
;        TCB_t * pxNewTCB;
;        BaseType_t xReturn;
;
;        traceENTER_xTaskCreateRestrictedStatic( pxTaskDefinition, pxCreatedTask );
;
;        configASSERT( pxTaskDefinition != NULL );
;
;        pxNewTCB = prvCreateRestrictedStaticTask( pxTaskDefinition, pxCreatedTask );
;
;        if( pxNewTCB != NULL )
;        {
;            #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = configTASK_DEFAULT_CORE_AFFINITY;
;            }
;            #endif
;
;            prvAddNewTaskToReadyList( pxNewTCB );
;            xReturn = pdPASS;
;        }
;        else
;        {
;            xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
;        }
;
;        traceRETURN_xTaskCreateRestrictedStatic( xReturn );
;
;        return xReturn;
;    }
;/*-----------------------------------------------------------*/
;
;    #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;        BaseType_t xTaskCreateRestrictedStaticAffinitySet( const TaskParameters_t * const pxTaskDefinition,
;                                                           UBaseType_t uxCoreAffinityMask,
;                                                           TaskHandle_t * pxCreatedTask )
;        {
;            TCB_t * pxNewTCB;
;            BaseType_t xReturn;
;
;            traceENTER_xTaskCreateRestrictedStaticAffinitySet( pxTaskDefinition, uxCoreAffinityMask, pxCreatedTask );
;
;            configASSERT( pxTaskDefinition != NULL );
;
;            pxNewTCB = prvCreateRestrictedStaticTask( pxTaskDefinition, pxCreatedTask );
;
;            if( pxNewTCB != NULL )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = uxCoreAffinityMask;
;
;                prvAddNewTaskToReadyList( pxNewTCB );
;                xReturn = pdPASS;
;            }
;            else
;            {
;                xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
;            }
;
;            traceRETURN_xTaskCreateRestrictedStaticAffinitySet( xReturn );
;
;            return xReturn;
;        }
;    #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;#endif /* ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( portUSING_MPU_WRAPPERS == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;    STATIC TCB_t * prvCreateRestrictedTask( const TaskParameters_t * const pxTaskDefinition,
;                                            TaskHandle_t * const pxCreatedTask )
;    {
;        TCB_t * pxNewTCB;
;
;        configASSERT( pxTaskDefinition->puxStackBuffer );
;
;        if( pxTaskDefinition->puxStackBuffer != NULL )
;        {
;            /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            pxNewTCB = ( TCB_t * ) pvPortMalloc( sizeof( TCB_t ) );
;
;            if( pxNewTCB != NULL )
;            {
;                ( void ) memset( ( void * ) pxNewTCB, 0x00, sizeof( TCB_t ) );
;
;                /* Store the stack location in the TCB. */
;                pxNewTCB->pxStack = pxTaskDefinition->puxStackBuffer;
;
;                #if ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE != 0 )
;                {
;                    /* Tasks can be created statically or dynamically, so note
;                     * this task had a statically allocated stack in case it is
;                     * later deleted.  The TCB was allocated dynamically. */
;                    pxNewTCB->ucStaticallyAllocated = tskSTATICALLY_ALLOCATED_STACK_ONLY;
;                }
;                #endif /* tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE */
;
;                prvInitialiseNewTask( pxTaskDefinition->pvTaskCode,
;                                      pxTaskDefinition->pcName,
;                                      pxTaskDefinition->usStackDepth,
;                                      pxTaskDefinition->pvParameters,
;                                      pxTaskDefinition->uxPriority,
;                                      pxCreatedTask, pxNewTCB,
;                                      pxTaskDefinition->xRegions );
;            }
;        }
;        else
;        {
;            pxNewTCB = NULL;
;        }
;
;        return pxNewTCB;
;    }
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTaskCreateRestricted( const TaskParameters_t * const pxTaskDefinition,
;                                      TaskHandle_t * pxCreatedTask )
;    {
;        TCB_t * pxNewTCB;
;        BaseType_t xReturn;
;
;        traceENTER_xTaskCreateRestricted( pxTaskDefinition, pxCreatedTask );
;
;        pxNewTCB = prvCreateRestrictedTask( pxTaskDefinition, pxCreatedTask );
;
;        if( pxNewTCB != NULL )
;        {
;            #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = configTASK_DEFAULT_CORE_AFFINITY;
;            }
;            #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;            prvAddNewTaskToReadyList( pxNewTCB );
;
;            xReturn = pdPASS;
;        }
;        else
;        {
;            xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
;        }
;
;        traceRETURN_xTaskCreateRestricted( xReturn );
;
;        return xReturn;
;    }
;/*-----------------------------------------------------------*/
;
;    #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;        BaseType_t xTaskCreateRestrictedAffinitySet( const TaskParameters_t * const pxTaskDefinition,
;                                                     UBaseType_t uxCoreAffinityMask,
;                                                     TaskHandle_t * pxCreatedTask )
;        {
;            TCB_t * pxNewTCB;
;            BaseType_t xReturn;
;
;            traceENTER_xTaskCreateRestrictedAffinitySet( pxTaskDefinition, uxCoreAffinityMask, pxCreatedTask );
;
;            pxNewTCB = prvCreateRestrictedTask( pxTaskDefinition, pxCreatedTask );
;
;            if( pxNewTCB != NULL )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = uxCoreAffinityMask;
;
;                prvAddNewTaskToReadyList( pxNewTCB );
;
;                xReturn = pdPASS;
;            }
;            else
;            {
;                xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
;            }
;
;            traceRETURN_xTaskCreateRestrictedAffinitySet( xReturn );
;
;            return xReturn;
;        }
;    #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;
;#endif /* portUSING_MPU_WRAPPERS */
;/*-----------------------------------------------------------*/
;
;
;#if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;    STATIC TCB_t * prvCreateTask( TaskFunction_t pxTaskCode,
;                                  const char * const pcName,
;                                  const configSTACK_DEPTH_TYPE uxStackDepth,
;                                  void * const pvParameters,
;                                  UBaseType_t uxPriority,
;                                  TaskHandle_t * const pxCreatedTask )
;    {
	code
	func
_~prvCreateTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
pxTaskCode_0	set	3
pcName_0	set	7
uxStackDepth_0	set	11
pvParameters_0	set	13
uxPriority_0	set	17
pxCreatedTask_0	set	19
;        TCB_t * pxNewTCB;
;
;        /* If the stack grows down then allocate the stack then the TCB so the stack
;         * does not grow into the TCB.  Likewise if the stack grows up then allocate
;         * the TCB then the stack. */
;        #if ( portSTACK_GROWTH > 0 )
;        {
;            /* Allocate space for the TCB.  Where the memory comes from depends on
;             * the implementation of the port malloc function and whether or not static
;             * allocation is being used. */
;            /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            pxNewTCB = ( TCB_t * ) pvPortMalloc( sizeof( TCB_t ) );
;			
;            if( pxNewTCB != NULL )
;            {
;                ( void ) memset( ( void * ) pxNewTCB, 0x00, sizeof( TCB_t ) );
;
;                /* Allocate space for the stack used by the task being created.
;                 * The base of the stack memory stored in the TCB so the task can
;                 * be deleted later if required. */
;                /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                /* coverity[misra_c_2012_rule_11_5_violation] */
;                pxNewTCB->pxStack = ( StackType_t * ) pvPortMallocStack( ( ( ( size_t ) uxStackDepth ) * sizeof( StackType_t ) ) );
;
;                if( pxNewTCB->pxStack == NULL )
;                {
;                    /* Could not allocate the stack.  Delete the allocated TCB. */
;                    vPortFree( pxNewTCB );
;                    pxNewTCB = NULL;
;                }
;            }
;        }
;        #else /* portSTACK_GROWTH */
;        {
pxNewTCB_1	set	0
;            StackType_t * pxStack;
;
;            /* Allocate space for the stack used by the task being created. */
;            /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            pxStack = ( StackType_t * ) pvPortMallocStack( ( ( ( size_t ) uxStackDepth ) * sizeof( StackType_t ) ) );
pxStack_2	set	4
	lda	<L8+uxStackDepth_0
	asl	A
	pha
	jsr	_~pvPortMallocStack
	sta	<L9+pxStack_2
	stx	<L9+pxStack_2+2
;			
;            if( pxStack != NULL )
;            {
	ora	<L9+pxStack_2+2
	beq	L10001
;                /* Allocate space for the TCB. */
;                /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                /* coverity[misra_c_2012_rule_11_5_violation] */
;                pxNewTCB = ( TCB_t * ) pvPortMalloc( sizeof( TCB_t ) );
	pea	#<$4b
	jsr	_~pvPortMalloc
	sta	<L9+pxNewTCB_1
	stx	<L9+pxNewTCB_1+2
;
;                if( pxNewTCB != NULL )
;                {
	ora	<L9+pxNewTCB_1+2
	beq	L10002
;                    ( void ) memset( ( void * ) pxNewTCB, 0x00, sizeof( TCB_t ) );
	pea	#<$4b
	pea	#<$0
	pei	<L9+pxNewTCB_1+2
	pei	<L9+pxNewTCB_1
	jsr	_~memset
;
;                    /* Store the stack location in the TCB. */
;                    pxNewTCB->pxStack = pxStack;
	lda	<L9+pxStack_2
	ldy	#$2e
	sta	[<L9+pxNewTCB_1],Y
	lda	<L9+pxStack_2+2
	iny
	iny
	sta	[<L9+pxNewTCB_1],Y
;                }
;                else
	bra	L10004
L10002:
;                {
;                    /* The stack cannot be used as the TCB was not created.  Free
;                     * it again. */
;                    vPortFreeStack( pxStack );
	pei	<L9+pxStack_2+2
	pei	<L9+pxStack_2
	jsr	_~vPortFreeStack
;                }
;            }
;            else
	bra	L10004
L10001:
;            {
;                pxNewTCB = NULL;
	stz	<L9+pxNewTCB_1
	stz	<L9+pxNewTCB_1+2
;            }
L10004:
;        }
;        #endif /* portSTACK_GROWTH */
;
;        if( pxNewTCB != NULL )
;        {
	lda	<L9+pxNewTCB_1
	ora	<L9+pxNewTCB_1+2
	beq	L10005
;            #if ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE != 0 )
;            {
;                /* Tasks can be created statically or dynamically, so note this
;                 * task was created dynamically in case it is later deleted. */
;                pxNewTCB->ucStaticallyAllocated = tskDYNAMICALLY_ALLOCATED_STACK_AND_TCB;
;            }
;            #endif /* tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE */
;
;            prvInitialiseNewTask( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, pxCreatedTask, pxNewTCB, NULL );
	pea	#^$0
	pea	#<$0
	pei	<L9+pxNewTCB_1+2
	pei	<L9+pxNewTCB_1
	pei	<L8+pxCreatedTask_0+2
	pei	<L8+pxCreatedTask_0
	pei	<L8+uxPriority_0
	pei	<L8+pvParameters_0+2
	pei	<L8+pvParameters_0
	pei	<L8+uxStackDepth_0
	pei	<L8+pcName_0+2
	pei	<L8+pcName_0
	pei	<L8+pxTaskCode_0+2
	pei	<L8+pxTaskCode_0
	jsr	_~prvInitialiseNewTask
;        }
;		
;        return pxNewTCB;
L10005:
	ldx	<L9+pxNewTCB_1+2
	lda	<L9+pxNewTCB_1
	tay
	lda	<L8+1
	sta	<L8+1+20
	pld
	tsc
	clc
	adc	#L8+20
	tcs
	tya
	rts
;    }
L8	equ	12
L9	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTaskCreate( TaskFunction_t pxTaskCode,
;                            const char * const pcName,
;                            const configSTACK_DEPTH_TYPE uxStackDepth,
;                            void * const pvParameters,
;                            UBaseType_t uxPriority,
;                            TaskHandle_t * const pxCreatedTask )
;    {
	code
	xdef	_~xTaskCreate
	func
_~xTaskCreate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L14
	tcs
	phd
	tcd
pxTaskCode_0	set	3
pcName_0	set	7
uxStackDepth_0	set	11
pvParameters_0	set	13
uxPriority_0	set	17
pxCreatedTask_0	set	19
;        TCB_t * pxNewTCB;
;        BaseType_t xReturn;
;
;        traceENTER_xTaskCreate( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, pxCreatedTask );
pxNewTCB_1	set	0
xReturn_1	set	4
;
;        pxNewTCB = prvCreateTask( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, pxCreatedTask );
	pei	<L14+pxCreatedTask_0+2
	pei	<L14+pxCreatedTask_0
	pei	<L14+uxPriority_0
	pei	<L14+pvParameters_0+2
	pei	<L14+pvParameters_0
	pei	<L14+uxStackDepth_0
	pei	<L14+pcName_0+2
	pei	<L14+pcName_0
	pei	<L14+pxTaskCode_0+2
	pei	<L14+pxTaskCode_0
	jsr	_~prvCreateTask
	sta	<L15+pxNewTCB_1
	stx	<L15+pxNewTCB_1+2
;
;        if( pxNewTCB != NULL )
;        {
	ora	<L15+pxNewTCB_1+2
	beq	L10006
;            #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = configTASK_DEFAULT_CORE_AFFINITY;
;            }
;            #endif
;
;            prvAddNewTaskToReadyList( pxNewTCB );
	pei	<L15+pxNewTCB_1+2
	pei	<L15+pxNewTCB_1
	jsr	_~prvAddNewTaskToReadyList
;            xReturn = pdPASS;
	lda	#$1
	bra	L20000
;        }
;        else
L10006:
;        {
;            xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
	lda	#$ffff
L20000:
	sta	<L15+xReturn_1
;        }
;
;        traceRETURN_xTaskCreate( xReturn );
;		
;		//debug_ptr(pxNewTCB);
;		
;        return xReturn;
	tay
	lda	<L14+1
	sta	<L14+1+20
	pld
	tsc
	clc
	adc	#L14+20
	tcs
	tya
	rts
;    }
L14	equ	6
L15	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;        BaseType_t xTaskCreateAffinitySet( TaskFunction_t pxTaskCode,
;                                           const char * const pcName,
;                                           const configSTACK_DEPTH_TYPE uxStackDepth,
;                                           void * const pvParameters,
;                                           UBaseType_t uxPriority,
;                                           UBaseType_t uxCoreAffinityMask,
;                                           TaskHandle_t * const pxCreatedTask )
;        {
;            TCB_t * pxNewTCB;
;            BaseType_t xReturn;
;
;            traceENTER_xTaskCreateAffinitySet( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, uxCoreAffinityMask, pxCreatedTask );
;
;            pxNewTCB = prvCreateTask( pxTaskCode, pcName, uxStackDepth, pvParameters, uxPriority, pxCreatedTask );
;
;            if( pxNewTCB != NULL )
;            {
;                /* Set the task's affinity before scheduling it. */
;                pxNewTCB->uxCoreAffinityMask = uxCoreAffinityMask;
;
;                prvAddNewTaskToReadyList( pxNewTCB );
;                xReturn = pdPASS;
;            }
;            else
;            {
;                xReturn = errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY;
;            }
;
;            traceRETURN_xTaskCreateAffinitySet( xReturn );
;
;            return xReturn;
;        }
;    #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;#endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;STATIC void prvInitialiseNewTask( TaskFunction_t pxTaskCode,
;                                  const char * const pcName,
;                                  const configSTACK_DEPTH_TYPE uxStackDepth,
;                                  void * const pvParameters,
;                                  UBaseType_t uxPriority,
;                                  TaskHandle_t * const pxCreatedTask,
;                                  TCB_t * pxNewTCB,
;                                  const MemoryRegion_t * const xRegions )
;{
	code
	func
_~prvInitialiseNewTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
pxTaskCode_0	set	3
pcName_0	set	7
uxStackDepth_0	set	11
pvParameters_0	set	13
uxPriority_0	set	17
pxCreatedTask_0	set	19
pxNewTCB_0	set	23
xRegions_0	set	27
;    StackType_t * pxTopOfStack;
;    UBaseType_t x;
;
;	#if ( portUSING_MPU_WRAPPERS == 1 )
;        /* Should the task be created in privileged mode? */
;        BaseType_t xRunPrivileged;
;
;        if( ( uxPriority & portPRIVILEGE_BIT ) != 0U )
;        {
;            xRunPrivileged = pdTRUE;
;        }
;        else
;        {
;            xRunPrivileged = pdFALSE;
;        }
;        uxPriority &= ~portPRIVILEGE_BIT;
;    #endif /* portUSING_MPU_WRAPPERS == 1 */
;
;    /* Avoid dependency on memset() if it is not required. */
;    #if ( tskSET_NEW_STACKS_TO_KNOWN_VALUE == 1 )
;    {
pxTopOfStack_1	set	0
x_1	set	4
;        /* Fill the stack with a known value to assist debugging. */
;        ( void ) memset( pxNewTCB->pxStack, ( int ) tskSTACK_FILL_BYTE, ( size_t ) uxStackDepth * sizeof( StackType_t ) );
	lda	<L18+uxStackDepth_0
	asl	A
	pha
	pea	#<$a5
	ldy	#$30
	lda	[<L18+pxNewTCB_0],Y
	pha
	dey
	dey
	lda	[<L18+pxNewTCB_0],Y
	pha
	jsr	_~memset
	sta	<R0
	stx	<R0+2
;    }
;    #endif /* tskSET_NEW_STACKS_TO_KNOWN_VALUE */
;
;    /* Calculate the top of stack address.  This depends on whether the stack
;     * grows from high memory to low (as per the 80x86) or vice versa.
;     * portSTACK_GROWTH is used to make the result positive or negative as required
;     * by the port. */
;    #if ( portSTACK_GROWTH < 0 )
;    {
;        pxTopOfStack = &( pxNewTCB->pxStack[ uxStackDepth - ( configSTACK_DEPTH_TYPE ) 1 ] );
	lda	#$ffff
	clc
	adc	<L18+uxStackDepth_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	clc
	ldy	#$2e
	lda	[<L18+pxNewTCB_0],Y
	adc	<R0
	sta	<L19+pxTopOfStack_1
	iny
	iny
	lda	[<L18+pxNewTCB_0],Y
	adc	<R0+2
	sta	<L19+pxTopOfStack_1+2
;        pxTopOfStack = ( StackType_t * ) ( ( ( portPOINTER_SIZE_TYPE ) pxTopOfStack ) & ( ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK ) ) );
	lda	<L19+pxTopOfStack_1
	sta	<L19+pxTopOfStack_1
	lda	<L19+pxTopOfStack_1+2
	sta	<L19+pxTopOfStack_1+2
;
;	    /* Check the alignment of the calculated top of stack is correct. */
;        configASSERT( ( ( ( portPOINTER_SIZE_TYPE ) pxTopOfStack & ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK ) == 0U ) );
;	
;		#if ( configRECORD_STACK_HIGH_ADDRESS == 1 )
;        {
;            /* Also record the stack's high address, which may assist
;             * debugging. */
;            pxNewTCB->pxEndOfStack = pxTopOfStack;
;        }
;        #endif /* configRECORD_STACK_HIGH_ADDRESS */
;    }
;    #else /* portSTACK_GROWTH */
;    {
;        pxTopOfStack = pxNewTCB->pxStack;
;        pxTopOfStack = ( StackType_t * ) ( ( ( ( portPOINTER_SIZE_TYPE ) pxTopOfStack ) + portBYTE_ALIGNMENT_MASK ) & ( ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK ) ) );
;
;        /* Check the alignment of the calculated top of stack is correct. */
;        configASSERT( ( ( ( portPOINTER_SIZE_TYPE ) pxTopOfStack & ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK ) == 0U ) );
;
;        /* The other extreme of the stack space is required if stack checking is
;         * performed. */
;        pxNewTCB->pxEndOfStack = pxNewTCB->pxStack + ( uxStackDepth - ( configSTACK_DEPTH_TYPE ) 1 );
;    }
;    #endif /* portSTACK_GROWTH */
;
;    /* Store the task name in the TCB. */
;    if( pcName != NULL )
;    {
	lda	<L18+pcName_0
	ora	<L18+pcName_0+2
	beq	*+5
	brl	L20
	brl	L10017
L20002:
;
;    if( uxPriority >= ( UBaseType_t ) configMAX_PRIORITIES )
;    {
	lda	<L18+uxPriority_0
	cmp	#<$5
	bcc	*+5
	brl	L24
L10023:
;
;    pxNewTCB->uxPriority = uxPriority;
	lda	<L18+uxPriority_0
	ldy	#$2c
	sta	[<L18+pxNewTCB_0],Y
;    #if ( configUSE_MUTEXES == 1 )
;    {
;        pxNewTCB->uxBasePriority = uxPriority;
	lda	<L18+uxPriority_0
	ldy	#$42
	sta	[<L18+pxNewTCB_0],Y
;    }
;    #endif /* configUSE_MUTEXES */
;
;    vListInitialiseItem( &( pxNewTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	<L18+pxNewTCB_0
	sta	<R0
	lda	#$0
	adc	<L18+pxNewTCB_0+2
	pha
	pei	<R0
	jsr	_~vListInitialiseItem
;    vListInitialiseItem( &( pxNewTCB->xEventListItem ) );
	lda	#$18
	clc
	adc	<L18+pxNewTCB_0
	sta	<R0
	lda	#$0
	adc	<L18+pxNewTCB_0+2
	sta	<R0+2
	pha
	pei	<R0
	jsr	_~vListInitialiseItem
;
;    /* Set the pxNewTCB as a link back from the ListItem_t.  This is so we can get
;     * back to  the containing TCB from a generic item in a list. */
;    listSET_LIST_ITEM_OWNER( &( pxNewTCB->xStateListItem ), pxNewTCB );
	lda	<L18+pxNewTCB_0
	ldy	#$10
	sta	[<L18+pxNewTCB_0],Y
	lda	<L18+pxNewTCB_0+2
	iny
	iny
	sta	[<L18+pxNewTCB_0],Y
;
;    /* Event lists are always in priority order. */
;    listSET_LIST_ITEM_VALUE( &( pxNewTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) uxPriority );
	lda	<L18+uxPriority_0
	sta	<R0
	stz	<R0+2
	sec
	lda	#$5
	sbc	<R0
	sta	<R1
	lda	#$0
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$18
	sta	[<L18+pxNewTCB_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L18+pxNewTCB_0],Y
;    listSET_LIST_ITEM_OWNER( &( pxNewTCB->xEventListItem ), pxNewTCB );
	lda	<L18+pxNewTCB_0
	ldy	#$24
	sta	[<L18+pxNewTCB_0],Y
	lda	<L18+pxNewTCB_0+2
	iny
	iny
	sta	[<L18+pxNewTCB_0],Y
;
;    #if ( portUSING_MPU_WRAPPERS == 1 )
;    {
;        vPortStoreTaskMPUSettings( &( pxNewTCB->xMPUSettings ), xRegions, pxNewTCB->pxStack, uxStackDepth );
;    }
;    #else
;    {
;        /* Avoid compiler warning about unreferenced parameter. */
;        ( void ) xRegions;
;    }
;    #endif
;
;    #if ( configUSE_C_RUNTIME_TLS_SUPPORT == 1 )
;    {
;        /* Allocate and initialize memory for the task's TLS Block. */
;        configINIT_TLS_BLOCK( pxNewTCB->xTLSBlock, pxTopOfStack );
;    }
;    #endif
;	
;    /* Initialize the TCB stack to look as if the task was already running,
;     * but had been interrupted by the scheduler.  The return address is set
;     * to the start of the task function. Once the stack has been initialised
;     * the top of stack variable is updated. */
;    #if ( portUSING_MPU_WRAPPERS == 1 )
;    {
;        /* If the port has capability to detect stack overflow,
;         * pass the stack end address to the stack initialization
;         * function as well. */
;        #if ( portHAS_STACK_OVERFLOW_CHECKING == 1 )
;        {
;            #if ( portSTACK_GROWTH < 0 )
;            {
;                pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxNewTCB->pxStack, pxTaskCode, pvParameters, xRunPrivileged, &( pxNewTCB->xMPUSettings ) );
;            }
;            #else /* portSTACK_GROWTH */
;            {
;                pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxNewTCB->pxEndOfStack, pxTaskCode, pvParameters, xRunPrivileged, &( pxNewTCB->xMPUSettings ) );
;            }
;            #endif /* portSTACK_GROWTH */
;        }
;        #else /* portHAS_STACK_OVERFLOW_CHECKING */
;        {
;            pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxTaskCode, pvParameters, xRunPrivileged, &( pxNewTCB->xMPUSettings ) );
;        }
;        #endif /* portHAS_STACK_OVERFLOW_CHECKING */
;    }
;    #else /* portUSING_MPU_WRAPPERS */
;    {
;        /* If the port has capability to detect stack overflow,
;         * pass the stack end address to the stack initialization
;         * function as well. */
;		
;        #if ( portHAS_STACK_OVERFLOW_CHECKING == 1 )
;        {
;            #if ( portSTACK_GROWTH < 0 )
;            {
;                pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxNewTCB->pxStack, pxTaskCode, pvParameters );
;            }
;            #else /* portSTACK_GROWTH */
;            {
;                pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxNewTCB->pxEndOfStack, pxTaskCode, pvParameters );
;            }
;            #endif /* portSTACK_GROWTH */
;        }
;        #else /* portHAS_STACK_OVERFLOW_CHECKING */
;        {
;            pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxTaskCode, pvParameters );
	pei	<L18+pvParameters_0+2
	pei	<L18+pvParameters_0
	pei	<L18+pxTaskCode_0+2
	pei	<L18+pxTaskCode_0
	pei	<L19+pxTopOfStack_1+2
	pei	<L19+pxTopOfStack_1
	jsr	_~pxPortInitialiseStack
	stx	<R0+2
	sta	[<L18+pxNewTCB_0]
	lda	<R0+2
	ldy	#$2
	sta	[<L18+pxNewTCB_0],Y
;        }
;        #endif /* portHAS_STACK_OVERFLOW_CHECKING */
;
;        #if ( portSTACK_GROWTH < 0 )
;        {			
;            configASSERT( ( ( portPOINTER_SIZE_TYPE ) ( pxTopOfStack - pxNewTCB->pxTopOfStack ) ) < ( ( portPOINTER_SIZE_TYPE ) uxStackDepth ) );
	lda	<L18+uxStackDepth_0
	sta	<R0
	stz	<R0+2
	sec
	lda	<L19+pxTopOfStack_1
	sbc	[<L18+pxNewTCB_0]
	sta	<R1
	lda	<L19+pxTopOfStack_1+2
	sbc	[<L18+pxNewTCB_0],Y
	sta	<R1+2
	lda	<R1
	sta	<R2
	lda	<R1+2
	sta	<R2+2
	asl	A
	ror	<R2+2
	ror	<R2
	lda	<R2
	cmp	<R0
	lda	<R2+2
	sbc	<R0+2
	bcs	L25
;        }
;        #else /* portSTACK_GROWTH */
;        {
;            configASSERT( ( ( portPOINTER_SIZE_TYPE ) ( pxNewTCB->pxTopOfStack - pxTopOfStack ) ) < ( ( portPOINTER_SIZE_TYPE ) uxStackDepth ) );
;        }
;        #endif /* portSTACK_GROWTH */
;    }
;    #endif /* portUSING_MPU_WRAPPERS */
;
;    /* Initialize task state and task attributes. */
;    #if ( configNUMBER_OF_CORES > 1 )
;    {
;        pxNewTCB->xTaskRunState = taskTASK_NOT_RUNNING;
;
;        /* Is this an idle task? */
;        if( ( ( TaskFunction_t ) pxTaskCode == ( TaskFunction_t ) ( &prvIdleTask ) ) || ( ( TaskFunction_t ) pxTaskCode == ( TaskFunction_t ) ( &prvPassiveIdleTask ) ) )
;        {
;            pxNewTCB->uxTaskAttributes |= taskATTRIBUTE_IS_IDLE;
;        }
;    }
;    #endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;    if( pxCreatedTask != NULL )
;    {
	lda	<L18+pxCreatedTask_0
	ora	<L18+pxCreatedTask_0+2
	bne	L26
L27:
	lda	<L18+1
	sta	<L18+1+28
	pld
	tsc
	clc
	adc	#L18+28
	tcs
	rts
L10009:
	bra	L10009
L20:
;        for( x = ( UBaseType_t ) 0; x < ( UBaseType_t ) configMAX_TASK_NAME_LEN; x++ )
	stz	<L19+x_1
L10015:
;        {
;            pxNewTCB->pcTaskName[ x ] = pcName[ x ];
	lda	#$32
	clc
	adc	<L19+x_1
	sta	<R0
	sep	#$20
	longa	off
	ldy	<L19+x_1
	lda	[<L18+pcName_0],Y
	ldy	<R0
	sta	[<L18+pxNewTCB_0],Y
	rep	#$20
	longa	on
;
;            /* Don't copy all configMAX_TASK_NAME_LEN if the string is shorter than
;             * configMAX_TASK_NAME_LEN characters just in case the memory after the
;             * string is not accessible (extremely unlikely). */
;            if( pcName[ x ] == ( char ) 0x00 )
;            {
	ldy	<L19+x_1
	lda	[<L18+pcName_0],Y
	and	#$ff
	beq	L10014
;                break;
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
	inc	<L19+x_1
	lda	<L19+x_1
	cmp	#<$10
	bcc	L10015
L10014:
;
;        /* Ensure the name string is terminated in the case that the string length
;         * was greater or equal to configMAX_TASK_NAME_LEN. */
;        pxNewTCB->pcTaskName[ configMAX_TASK_NAME_LEN - 1U ] = '\0';
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$41
	sta	[<L18+pxNewTCB_0],Y
	rep	#$20
	longa	on
;    }
;    else
L10017:
;	
;    /* This is used as an array index so must ensure it's not too large. */
;    configASSERT( uxPriority < configMAX_PRIORITIES );
	lda	<L18+uxPriority_0
	cmp	#<$5
	bcs	*+5
	brl	L20002
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
	asmstart
	sei
	asmend
L10019:
	bra	L10019
L24:
;        uxPriority = ( UBaseType_t ) configMAX_PRIORITIES - ( UBaseType_t ) 1U;
	lda	#$4
	sta	<L18+uxPriority_0
;    }
;    else
	brl	L10023
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L25:
	asmstart
	sei
	asmend
L10025:
	bra	L10025
L26:
;        /* Pass the handle out in an anonymous way.  The handle can be used to
;         * change the created task's priority, delete the created task, etc.*/
;        *pxCreatedTask = ( TaskHandle_t ) pxNewTCB;
	lda	<L18+pxNewTCB_0
	sta	[<L18+pxCreatedTask_0]
	lda	<L18+pxNewTCB_0+2
	ldy	#$2
	sta	[<L18+pxCreatedTask_0],Y
;    }
;    else
	bra	L27
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;	
;	//debug_ptr((void *)0xcafe);
;	//debug_ptr(pxTopOfStack);
;	//debug_ptr(pxNewTCB->pxStack);
;}
L18	equ	18
L19	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES == 1 )
;
;    STATIC void prvAddNewTaskToReadyList( TCB_t * pxNewTCB )
;    {
	code
	func
_~prvAddNewTaskToReadyList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
pxNewTCB_0	set	3
;        /* Ensure interrupts don't access the task lists while the lists are being
;         * updated. */
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            uxCurrentNumberOfTasks = ( UBaseType_t ) ( uxCurrentNumberOfTasks + 1U );
	inc	|_~uxCurrentNumberOfTasks	; volatile
;
;            if( pxCurrentTCB == NULL )
;            {
	lda	|_~pxCurrentTCB	; volatile
	ora	|_~pxCurrentTCB+2	; volatile
	beq	*+5
	brl	L10030
;                /* There are no other tasks, or all the other tasks are in
;                 * the suspended state - make this the current task. */
;                pxCurrentTCB = pxNewTCB;
	lda	<L28+pxNewTCB_0
	sta	|_~pxCurrentTCB	; volatile
	lda	<L28+pxNewTCB_0+2
	sta	|_~pxCurrentTCB+2	; volatile
;
;                if( uxCurrentNumberOfTasks == ( UBaseType_t ) 1 )
;                {
	lda	|_~uxCurrentNumberOfTasks	; volatile
	cmp	#<$1
	bne	L10033
;                    /* This is the first task to be created so do the preliminary
;                     * initialisation required.  We will not recover if this call
;                     * fails, but we will report the failure. */
;                    prvInitialiseTaskLists();
	jsr	_~prvInitialiseTaskLists
;                }
;                else
;                }
;                else
L10033:
;
;            uxTaskNumber++;
	inc	|_~uxTaskNumber
;
;            #if ( configUSE_TRACE_FACILITY == 1 )
;            {
;                /* Add a counter into the TCB for tracing only. */
;                pxNewTCB->uxTCBNumber = uxTaskNumber;
;            }
;            #endif /* configUSE_TRACE_FACILITY */
;            traceTASK_CREATE( pxNewTCB );
;
;            prvAddTaskToReadyList( pxNewTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L28+pxNewTCB_0],Y
	bcs	L10047
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
	lda	[<L28+pxNewTCB_0],Y
	sta	|_~uxTopReadyPriority	; volatile
L10047:
pxIndex_2	set	0
	ldy	#$2c
	lda	[<L28+pxNewTCB_0],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L29+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L29+pxIndex_2+2
	lda	<L29+pxIndex_2
	ldy	#$8
	sta	[<L28+pxNewTCB_0],Y
	lda	<L29+pxIndex_2+2
	iny
	iny
	sta	[<L28+pxNewTCB_0],Y
	dey
	dey
	lda	[<L29+pxIndex_2],Y
	ldy	#$c
	sta	[<L28+pxNewTCB_0],Y
	dey
	dey
	lda	[<L29+pxIndex_2],Y
	ldy	#$e
	sta	[<L28+pxNewTCB_0],Y
	ldy	#$8
	lda	[<L29+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L29+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L28+pxNewTCB_0
	sta	<R1
	lda	#$0
	adc	<L28+pxNewTCB_0+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L28+pxNewTCB_0
	sta	<R0
	lda	#$0
	adc	<L28+pxNewTCB_0+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L29+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L29+pxIndex_2],Y
	ldy	#$2c
	lda	[<L28+pxNewTCB_0],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L28+pxNewTCB_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L28+pxNewTCB_0],Y
	ldy	#$2c
	lda	[<L28+pxNewTCB_0],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L28+pxNewTCB_0],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;            portSETUP_TCB( pxNewTCB );
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        if( xSchedulerRunning != pdFALSE )
;        {
	lda	|_~xSchedulerRunning	; volatile
	beq	L37
;            /* If the created task is of a higher priority than the current task
;             * then it should run now. */
;            taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxNewTCB );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L28+pxNewTCB_0],Y
	bcs	L37
	jsl	_~vPortYield
L37:
	lda	<L28+1
	sta	<L28+1+4
	pld
	tsc
	clc
	adc	#L28+4
	tcs
	rts
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
L10030:
;            {
;                /* If the scheduler is not already running, make this task the
;                 * current task if it is the highest priority task to be created
;                 * so far. */
;                if( xSchedulerRunning == pdFALSE )
;                {
	lda	|_~xSchedulerRunning	; volatile
	beq	*+5
	brl	L10033
;                    if( pxCurrentTCB->uxPriority <= pxNewTCB->uxPriority )
;                    {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<L28+pxNewTCB_0],Y
	cmp	[<R0],Y
	bcs	*+5
	brl	L10033
;                        pxCurrentTCB = pxNewTCB;
	lda	<L28+pxNewTCB_0
	sta	|_~pxCurrentTCB	; volatile
	lda	<L28+pxNewTCB_0+2
	sta	|_~pxCurrentTCB+2	; volatile
;                    }
;                    else
	brl	L10033
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L28	equ	16
L29	equ	13
	ends
	efunc
;
;#else /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;    STATIC void prvAddNewTaskToReadyList( TCB_t * pxNewTCB )
;    {
;        /* Ensure interrupts don't access the task lists while the lists are being
;         * updated. */
;        taskENTER_CRITICAL();
;        {
;            uxCurrentNumberOfTasks++;
;
;            if( xSchedulerRunning == pdFALSE )
;            {
;                if( uxCurrentNumberOfTasks == ( UBaseType_t ) 1 )
;                {
;                    /* This is the first task to be created so do the preliminary
;                     * initialisation required.  We will not recover if this call
;                     * fails, but we will report the failure. */
;                    prvInitialiseTaskLists();
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;
;                /* All the cores start with idle tasks before the SMP scheduler
;                 * is running. Idle tasks are assigned to cores when they are
;                 * created in prvCreateIdleTasks(). */
;            }
;
;            uxTaskNumber++;
;
;            #if ( configUSE_TRACE_FACILITY == 1 )
;            {
;                /* Add a counter into the TCB for tracing only. */
;                pxNewTCB->uxTCBNumber = uxTaskNumber;
;            }
;            #endif /* configUSE_TRACE_FACILITY */
;            traceTASK_CREATE( pxNewTCB );
;
;            prvAddTaskToReadyList( pxNewTCB );
;
;            portSETUP_TCB( pxNewTCB );
;
;            if( xSchedulerRunning != pdFALSE )
;            {
;                /* If the created task is of a higher priority than another
;                 * currently running task and preemption is on then it should
;                 * run now. */
;                taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxNewTCB );
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        taskEXIT_CRITICAL();
;    }
;
;#endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_TRACE_FACILITY == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) )
;
;    STATIC size_t prvSnprintfReturnValueToCharsWritten( int iSnprintfReturnValue,
;                                                        size_t n )
;    {
;        size_t uxCharsWritten;
;
;        if( iSnprintfReturnValue < 0 )
;        {
;            /* Encoding error - Return 0 to indicate that nothing
;             * was written to the buffer. */
;            uxCharsWritten = 0;
;        }
;        else if( iSnprintfReturnValue >= ( int ) n )
;        {
;            /* This is the case when the supplied buffer is not
;             * large to hold the generated string. Return the
;             * number of characters actually written without
;             * counting the terminating NULL character. */
;            uxCharsWritten = n - 1U;
;        }
;        else
;        {
;            /* Complete string was written to the buffer. */
;            uxCharsWritten = ( size_t ) iSnprintfReturnValue;
;        }
;
;        return uxCharsWritten;
;    }
;
;#endif /* #if ( ( configUSE_TRACE_FACILITY == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskDelete == 1 )
;
;    void vTaskDelete( TaskHandle_t xTaskToDelete )
;    {
	code
	xdef	_~vTaskDelete
	func
_~vTaskDelete:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L38
	tcs
	phd
	tcd
xTaskToDelete_0	set	3
;        TCB_t * pxTCB;
;        BaseType_t xDeleteTCBInIdleTask = pdFALSE;
;        BaseType_t xTaskIsRunningOrYielding;
;
;        traceENTER_vTaskDelete( xTaskToDelete );
pxTCB_1	set	0
xDeleteTCBInIdleTask_1	set	4
xTaskIsRunningOrYielding_1	set	6
	stz	<L39+xDeleteTCBInIdleTask_1
;
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            /* If null is passed in here then it is the calling task that is
;             * being deleted. */
;            pxTCB = prvGetTCBFromHandle( xTaskToDelete );
	lda	<L38+xTaskToDelete_0
	ora	<L38+xTaskToDelete_0+2
	bne	L40
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L42
L40:
	ldx	<L38+xTaskToDelete_0+2
	lda	<L38+xTaskToDelete_0
L42:
	stx	<R0+2
	sta	<L39+pxTCB_1
	lda	<R0+2
	sta	<L39+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L39+pxTCB_1
	ora	<L39+pxTCB_1+2
	bne	L10055
	asmstart
	sei
	asmend
L10056:
	bra	L10056
L10055:
;
;            /* Remove task from the ready/delayed list. */
;            if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
;            {
	lda	#$4
	clc
	adc	<L39+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L39+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10060
;                taskRESET_READY_PRIORITY( pxTCB->uxPriority );
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10060:
;
;            /* Is the task waiting on an event also? */
;            if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
;            {
	ldy	#$28
	lda	[<L39+pxTCB_1],Y
	iny
	iny
	ora	[<L39+pxTCB_1],Y
	beq	L10062
;                ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
	lda	#$18
	clc
	adc	<L39+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L39+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10062:
;
;            /* Increment the uxTaskNumber also so kernel aware debuggers can
;             * detect that the task lists need re-generating.  This is done before
;             * portPRE_TASK_DELETE_HOOK() as in the Windows port that macro will
;             * not return. */
;            uxTaskNumber++;
	inc	|_~uxTaskNumber
;
;            /* Use temp variable as distinct sequence points for reading volatile
;             * variables prior to a logical operator to ensure compliance with
;             * MISRA C 2012 Rule 13.5. */
;            xTaskIsRunningOrYielding = taskTASK_IS_RUNNING_OR_SCHEDULED_TO_YIELD( pxTCB );
	lda	<L39+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L47
	lda	<L39+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L47:
	bne	L46
	lda	#$1
	bra	L49
L46:
	lda	#$0
L49:
	sta	<L39+xTaskIsRunningOrYielding_1
;
;            /* If the task is running (or yielding), we must add it to the
;             * termination list so that an idle task can delete it when it is
;             * no longer running. */
;            if( ( xSchedulerRunning != pdFALSE ) && ( xTaskIsRunningOrYielding != pdFALSE ) )
;            {
	lda	|_~xSchedulerRunning	; volatile
	beq	L10063
	lda	<L39+xTaskIsRunningOrYielding_1
	beq	L10063
;                /* A running task or a task which is scheduled to yield is being
;                 * deleted. This cannot complete when the task is still running
;                 * on a core, as a context switch to another task is required.
;                 * Place the task in the termination list. The idle task will check
;                 * the termination list and free up any memory allocated by the
;                 * scheduler for the TCB and stack of the deleted task. */
;                vListInsertEnd( &xTasksWaitingTermination, &( pxTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	<L39+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L39+pxTCB_1+2
	pha
	pei	<R0
	lda	#<_~xTasksWaitingTermination
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	jsr	_~vListInsertEnd
;
;                /* Increment the ucTasksDeleted variable so the idle task knows
;                 * there is a task that has been deleted and that it should therefore
;                 * check the xTasksWaitingTermination list. */
;                ++uxDeletedTasksWaitingCleanUp;
	inc	|_~uxDeletedTasksWaitingCleanUp	; volatile
;
;                /* Call the delete hook before portPRE_TASK_DELETE_HOOK() as
;                 * portPRE_TASK_DELETE_HOOK() does not return in the Win32 port. */
;                traceTASK_DELETE( pxTCB );
;
;                /* Delete the task TCB in idle task. */
;                xDeleteTCBInIdleTask = pdTRUE;
	lda	#$1
	sta	<L39+xDeleteTCBInIdleTask_1
;
;                /* The pre-delete hook is primarily for the Windows simulator,
;                 * in which Windows specific clean up operations are performed,
;                 * after which it is not possible to yield away from this task -
;                 * hence xYieldPending is used to latch that a context switch is
;                 * required. */
;                #if ( configNUMBER_OF_CORES == 1 )
;                    portPRE_TASK_DELETE_HOOK( pxTCB, &( xYieldPendings[ 0 ] ) );
;                #else
;                    portPRE_TASK_DELETE_HOOK( pxTCB, &( xYieldPendings[ pxTCB->xTaskRunState ] ) );
;                #endif
;
;                /* In the case of SMP, it is possible that the task being deleted
;                 * is running on another core. We must evict the task before
;                 * exiting the critical section to ensure that the task cannot
;                 * take an action which puts it back on ready/state/event list,
;                 * thereby nullifying the delete operation. Once evicted, the
;                 * task won't be scheduled ever as it will no longer be on the
;                 * ready list. */
;                #if ( configNUMBER_OF_CORES > 1 )
;                {
;                    if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                    {
;                        if( pxTCB->xTaskRunState == ( BaseType_t ) portGET_CORE_ID() )
;                        {
;                            configASSERT( uxSchedulerSuspended == 0 );
;                            taskYIELD_WITHIN_API();
;                        }
;                        else
;                        {
;                            prvYieldCore( pxTCB->xTaskRunState );
;                        }
;                    }
;                }
;                #endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;            }
;            else
	bra	L10064
L10063:
;            {
;                --uxCurrentNumberOfTasks;
	dec	|_~uxCurrentNumberOfTasks	; volatile
;                traceTASK_DELETE( pxTCB );
;
;                /* Reset the next expected unblock time in case it referred to
;                 * the task that has just been deleted. */
;                prvResetNextTaskUnblockTime();
	jsr	_~prvResetNextTaskUnblockTime
;            }
L10064:
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        /* If the task is not deleting itself, call prvDeleteTCB from outside of
;         * critical section. If a task deletes itself, prvDeleteTCB is called
;         * from prvCheckTasksWaitingTermination which is called from Idle task. */
;        if( xDeleteTCBInIdleTask != pdTRUE )
;        {
	lda	<L39+xDeleteTCBInIdleTask_1
	cmp	#<$1
	beq	L10065
;            prvDeleteTCB( pxTCB );
	pei	<L39+pxTCB_1+2
	pei	<L39+pxTCB_1
	jsr	_~prvDeleteTCB
;        }
;
;        /* Force a reschedule if it is the currently running task that has just
;         * been deleted. */
;        #if ( configNUMBER_OF_CORES == 1 )
;        {
L10065:
;            if( xSchedulerRunning != pdFALSE )
;            {
	lda	|_~xSchedulerRunning	; volatile
	beq	L57
;                if( pxTCB == pxCurrentTCB )
;                {
	lda	<L39+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L54
	lda	<L39+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L54:
	bne	L57
;                    configASSERT( uxSchedulerSuspended == 0 );
	lda	|_~uxSchedulerSuspended	; volatile
	beq	L10068
	asmstart
	sei
	asmend
L10069:
	bra	L10069
L10068:
;                    taskYIELD_WITHIN_API();
	jsl	_~vPortYield
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;        #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;        traceRETURN_vTaskDelete();
;    }
L57:
	lda	<L38+1
	sta	<L38+1+4
	pld
	tsc
	clc
	adc	#L38+4
	tcs
	rts
L38	equ	16
L39	equ	9
	ends
	efunc
;
;#endif /* INCLUDE_vTaskDelete */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_xTaskDelayUntil == 1 )
;
;    TickType_t xTaskPeriodicDelay( TickType_t * const pxPreviousWakeTime,
;                                   const TickType_t xTimeIncrement )
;    {
	code
	xdef	_~xTaskPeriodicDelay
	func
_~xTaskPeriodicDelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L58
	tcs
	phd
	tcd
pxPreviousWakeTime_0	set	3
xTimeIncrement_0	set	7
;        TickType_t xIncrements, xTicksIncrements, xTicksToWait;
;
;        traceENTER_xTaskPeriodicDelay( pxPreviousWakeTime, xTimeIncrement );
xIncrements_1	set	0
xTicksIncrements_1	set	4
xTicksToWait_1	set	8
;
;        configASSERT( pxPreviousWakeTime );
	lda	<L58+pxPreviousWakeTime_0
	ora	<L58+pxPreviousWakeTime_0+2
	bne	L10073
	asmstart
	sei
	asmend
L10074:
	bra	L10074
L10073:
;        configASSERT( ( xTimeIncrement > 0U ) );
	lda	#$0
	cmp	<L58+xTimeIncrement_0
	sbc	<L58+xTimeIncrement_0+2
	bcc	L10077
	asmstart
	sei
	asmend
L10078:
	bra	L10078
L10077:
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            /* As long as everything is the same type, this plays well with overflows */
;            const TickType_t xTicksElapsed = xTickCount - *pxPreviousWakeTime;
;
;            configASSERT( uxSchedulerSuspended == 1U );
xTicksElapsed_2	set	12
	sec
	lda	|_~xTickCount	; volatile
	sbc	[<L58+pxPreviousWakeTime_0]
	sta	<L59+xTicksElapsed_2
	lda	|_~xTickCount+2	; volatile
	ldy	#$2
	sbc	[<L58+pxPreviousWakeTime_0],Y
	sta	<L59+xTicksElapsed_2+2
	lda	|_~uxSchedulerSuspended	; volatile
	cmp	#<$1
	beq	L10081
	asmstart
	sei
	asmend
L10082:
	bra	L10082
L10081:
;
;            /* Number of increments to catch up: it could be 0 if
;             * not enough ticks have elapsed, 1 in the common case or
;             * more than 1 if the task has not been resumed in time */
;            xIncrements = xTicksElapsed / xTimeIncrement;
	pei	<L58+xTimeIncrement_0+2
	pei	<L58+xTimeIncrement_0
	pei	<L59+xTicksElapsed_2+2
	pei	<L59+xTicksElapsed_2
	xref	_~~ludv
	jsr	_~~ludv
	sta	<L59+xIncrements_1
	stx	<L59+xIncrements_1+2
;            xTicksIncrements = xIncrements * xTimeIncrement;
	pei	<L58+xTimeIncrement_0+2
	pei	<L58+xTimeIncrement_0
	pei	<L59+xIncrements_1+2
	pei	<L59+xIncrements_1
	xref	_~~lmul
	jsr	_~~lmul
	sta	<L59+xTicksIncrements_1
	stx	<L59+xTicksIncrements_1+2
;
;            /* Update to the last wake time */
;            *pxPreviousWakeTime += xTicksIncrements;
	lda	[<L58+pxPreviousWakeTime_0]
	clc
	adc	<L59+xTicksIncrements_1
	sta	[<L58+pxPreviousWakeTime_0]
	ldy	#$2
	lda	[<L58+pxPreviousWakeTime_0],Y
	adc	<L59+xTicksIncrements_1+2
	sta	[<L58+pxPreviousWakeTime_0],Y
;
;            /* Ticks to the next wake time */
;            xTicksToWait = xTimeIncrement - ( xTicksElapsed - xTicksIncrements );
	sec
	lda	<L59+xTicksElapsed_2
	sbc	<L59+xTicksIncrements_1
	sta	<R0
	lda	<L59+xTicksElapsed_2+2
	sbc	<L59+xTicksIncrements_1+2
	sta	<R0+2
	sec
	lda	<L58+xTimeIncrement_0
	sbc	<R0
	sta	<L59+xTicksToWait_1
	lda	<L58+xTimeIncrement_0+2
	sbc	<R0+2
	sta	<L59+xTicksToWait_1+2
;
;            prvAddCurrentTaskToDelayedList( xTicksToWait, pdFALSE );
	pea	#<$0
	pei	<L59+xTicksToWait_1+2
	pei	<L59+xTicksToWait_1
	jsr	_~prvAddCurrentTaskToDelayedList
;        }
;
;        /* Force a reschedule if xTaskResumeAll has not already done so, we may
;         * have put ourselves to sleep. */
;        if( xTaskResumeAll() == pdFALSE )
;        {
	jsr	_~xTaskResumeAll
	tax
	bne	L10086
;            taskYIELD_WITHIN_API();
	jsl	_~vPortYield
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10086:
;
;        traceRETURN_xTaskPeriodicDelay( xIncrements );
;
;        return xIncrements;
	ldx	<L59+xIncrements_1+2
	lda	<L59+xIncrements_1
	tay
	lda	<L58+1
	sta	<L58+1+8
	pld
	tsc
	clc
	adc	#L58+8
	tcs
	tya
	rts
;    }
L58	equ	20
L59	equ	5
	ends
	efunc
;
;
;    BaseType_t xTaskDelayUntil( TickType_t * const pxPreviousWakeTime,
;                                const TickType_t xTimeIncrement )
;    {
	code
	xdef	_~xTaskDelayUntil
	func
_~xTaskDelayUntil:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L65
	tcs
	phd
	tcd
pxPreviousWakeTime_0	set	3
xTimeIncrement_0	set	7
;        TickType_t xTimeToWake;
;        BaseType_t xAlreadyYielded, xShouldDelay = pdFALSE;
;
;        traceENTER_xTaskDelayUntil( pxPreviousWakeTime, xTimeIncrement );
xTimeToWake_1	set	0
xAlreadyYielded_1	set	4
xShouldDelay_1	set	6
	stz	<L66+xShouldDelay_1
;
;        configASSERT( pxPreviousWakeTime );
	lda	<L65+pxPreviousWakeTime_0
	ora	<L65+pxPreviousWakeTime_0+2
	bne	L10087
	asmstart
	sei
	asmend
L10088:
	bra	L10088
L10087:
;        configASSERT( ( xTimeIncrement > 0U ) );
	lda	#$0
	cmp	<L65+xTimeIncrement_0
	sbc	<L65+xTimeIncrement_0+2
	bcc	L10091
	asmstart
	sei
	asmend
L10092:
	bra	L10092
L10091:
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            /* Minor optimisation.  The tick count cannot change in this
;             * block. */
;            const TickType_t xConstTickCount = xTickCount;
;
;            configASSERT( uxSchedulerSuspended == 1U );
xConstTickCount_2	set	8
	lda	|_~xTickCount	; volatile
	sta	<L66+xConstTickCount_2
	lda	|_~xTickCount+2	; volatile
	sta	<L66+xConstTickCount_2+2
	lda	|_~uxSchedulerSuspended	; volatile
	cmp	#<$1
	beq	L10095
	asmstart
	sei
	asmend
L10096:
	bra	L10096
L10095:
;
;            /* Generate the tick time at which the task wants to wake. */
;            xTimeToWake = *pxPreviousWakeTime + xTimeIncrement;
	lda	[<L65+pxPreviousWakeTime_0]
	clc
	adc	<L65+xTimeIncrement_0
	sta	<L66+xTimeToWake_1
	ldy	#$2
	lda	[<L65+pxPreviousWakeTime_0],Y
	adc	<L65+xTimeIncrement_0+2
	sta	<L66+xTimeToWake_1+2
;
;            if( xConstTickCount < *pxPreviousWakeTime )
;            {
	lda	<L66+xConstTickCount_2
	cmp	[<L65+pxPreviousWakeTime_0]
	lda	<L66+xConstTickCount_2+2
	sbc	[<L65+pxPreviousWakeTime_0],Y
	bcs	L10099
;                /* The tick count has overflowed since this function was
;                 * lasted called.  In this case the only time we should ever
;                 * actually delay is if the wake time has also  overflowed,
;                 * and the wake time is greater than the tick time.  When this
;                 * is the case it is as if neither time had overflowed. */
;                if( ( xTimeToWake < *pxPreviousWakeTime ) && ( xTimeToWake > xConstTickCount ) )
;                {
	lda	<L66+xTimeToWake_1
	cmp	[<L65+pxPreviousWakeTime_0]
	lda	<L66+xTimeToWake_1+2
	sbc	[<L65+pxPreviousWakeTime_0],Y
	bcs	L10102
L20011:
	lda	<L66+xConstTickCount_2
	cmp	<L66+xTimeToWake_1
	lda	<L66+xConstTickCount_2+2
	sbc	<L66+xTimeToWake_1+2
	bcs	L10102
;                    xShouldDelay = pdTRUE;
L20006:
	lda	#$1
	sta	<L66+xShouldDelay_1
;                }
;                else
L10102:
;
;            /* Update the wake time ready for the next call. */
;            *pxPreviousWakeTime = xTimeToWake;
	lda	<L66+xTimeToWake_1
	sta	[<L65+pxPreviousWakeTime_0]
	lda	<L66+xTimeToWake_1+2
	ldy	#$2
	sta	[<L65+pxPreviousWakeTime_0],Y
;
;            if( xShouldDelay != pdFALSE )
;            {
	lda	<L66+xShouldDelay_1
	beq	L10106
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;                traceTASK_DELAY_UNTIL( xTimeToWake );
;
;                /* prvAddCurrentTaskToDelayedList() needs the block time, not
;                 * the time to wake, so subtract the current tick count. */
;                prvAddCurrentTaskToDelayedList( xTimeToWake - xConstTickCount, pdFALSE );
	pea	#<$0
	sec
	lda	<L66+xTimeToWake_1
	sbc	<L66+xConstTickCount_2
	sta	<R0
	lda	<L66+xTimeToWake_1+2
	sbc	<L66+xConstTickCount_2+2
	pha
	pei	<R0
	jsr	_~prvAddCurrentTaskToDelayedList
;            }
;            else
L10106:
;        }
;        xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L66+xAlreadyYielded_1
;
;        /* Force a reschedule if xTaskResumeAll has not already done so, we may
;         * have put ourselves to sleep. */
;        if( xAlreadyYielded == pdFALSE )
;        {
	lda	<L66+xAlreadyYielded_1
	beq	L77
L10108:
;
;        traceRETURN_xTaskDelayUntil( xShouldDelay );
;
;        return xShouldDelay;
	lda	<L66+xShouldDelay_1
	tay
	lda	<L65+1
	sta	<L65+1+8
	pld
	tsc
	clc
	adc	#L65+8
	tcs
	tya
	rts
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
L10099:
;            {
;                /* The tick time has not overflowed.  In this case we will
;                 * delay if either the wake time has overflowed, and/or the
;                 * tick time is less than the wake time. */
;                if( ( xTimeToWake < *pxPreviousWakeTime ) || ( xTimeToWake > xConstTickCount ) )
;                {
	lda	<L66+xTimeToWake_1
	cmp	[<L65+pxPreviousWakeTime_0]
	lda	<L66+xTimeToWake_1+2
	ldy	#$2
	sbc	[<L65+pxPreviousWakeTime_0],Y
	bcc	L20006
	bra	L20011
;                    xShouldDelay = pdTRUE;
;                }
;                else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L77:
;            taskYIELD_WITHIN_API();
	jsl	_~vPortYield
;        }
;        else
	bra	L10108
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L65	equ	16
L66	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_xTaskDelayUntil */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskDelay == 1 )
;
;    void vTaskDelay( const TickType_t xTicksToDelay )
;    {
	code
	xdef	_~vTaskDelay
	func
_~vTaskDelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L79
	tcs
	phd
	tcd
xTicksToDelay_0	set	3
;        BaseType_t xAlreadyYielded = pdFALSE;
;
;        traceENTER_vTaskDelay( xTicksToDelay );
xAlreadyYielded_1	set	0
	stz	<L80+xAlreadyYielded_1
;
;        /* A delay time of zero just forces a reschedule. */
;        if( xTicksToDelay > ( TickType_t ) 0U )
;        {
	lda	#$0
	cmp	<L79+xTicksToDelay_0
	sbc	<L79+xTicksToDelay_0+2
	bcs	L10114
;            vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;            {
;                configASSERT( uxSchedulerSuspended == 1U );
	lda	|_~uxSchedulerSuspended	; volatile
	cmp	#<$1
	beq	L10110
	asmstart
	sei
	asmend
L10111:
	bra	L10111
L10110:
;
;                traceTASK_DELAY();
;
;                /* A task that is removed from the event list while the
;                 * scheduler is suspended will not get placed in the ready
;                 * list or removed from the blocked list until the scheduler
;                 * is resumed.
;                 *
;                 * This task cannot be in an event list as it is the currently
;                 * executing task. */
;                prvAddCurrentTaskToDelayedList( xTicksToDelay, pdFALSE );
	pea	#<$0
	pei	<L79+xTicksToDelay_0+2
	pei	<L79+xTicksToDelay_0
	jsr	_~prvAddCurrentTaskToDelayedList
;            }
;            xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L80+xAlreadyYielded_1
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10114:
;
;        /* Force a reschedule if xTaskResumeAll has not already done so, we may
;         * have put ourselves to sleep. */
;        if( xAlreadyYielded == pdFALSE )
;        {
	lda	<L80+xAlreadyYielded_1
	bne	L84
;            taskYIELD_WITHIN_API();
	jsl	_~vPortYield
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskDelay();
;    }
L84:
	lda	<L79+1
	sta	<L79+1+4
	pld
	tsc
	clc
	adc	#L79+4
	tcs
	rts
L79	equ	2
L80	equ	1
	ends
	efunc
;
;#endif /* INCLUDE_vTaskDelay */
;/*-----------------------------------------------------------*/
;
;#if ( ( INCLUDE_eTaskGetState == 1 ) || ( configUSE_TRACE_FACILITY == 1 ) || ( INCLUDE_xTaskAbortDelay == 1 ) )
;
;    eTaskState eTaskGetState( TaskHandle_t xTask )
;    {
	code
	xdef	_~eTaskGetState
	func
_~eTaskGetState:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L85
	tcs
	phd
	tcd
xTask_0	set	3
;        eTaskState eReturn;
;        List_t const * pxStateList;
;        List_t const * pxEventList;
;        List_t const * pxDelayedList;
;        List_t const * pxOverflowedDelayedList;
;        const TCB_t * const pxTCB = xTask;
;
;        traceENTER_eTaskGetState( xTask );
eReturn_1	set	0
pxStateList_1	set	2
pxEventList_1	set	6
pxDelayedList_1	set	10
pxOverflowedDelayedList_1	set	14
pxTCB_1	set	18
	lda	<L85+xTask_0
	sta	<L86+pxTCB_1
	lda	<L85+xTask_0+2
	sta	<L86+pxTCB_1+2
;
;        configASSERT( pxTCB != NULL );
	lda	<L86+pxTCB_1
	ora	<L86+pxTCB_1+2
	bne	L10117
	asmstart
	sei
	asmend
L10118:
	bra	L10118
L10117:
;
;        #if ( configNUMBER_OF_CORES == 1 )
;            if( pxTCB == pxCurrentTCB )
;            {
	lda	<L86+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L88
	lda	<L86+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L88:
	bne	L10121
;                /* The task calling this function is querying its own state. */
;                eReturn = eRunning;
	stz	<L86+eReturn_1
;            }
;            else
	bra	L10122
L10121:
;        #endif
;        {
;            taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;            {
;                pxStateList = listLIST_ITEM_CONTAINER( &( pxTCB->xStateListItem ) );
	ldy	#$14
	lda	[<L86+pxTCB_1],Y
	sta	<L86+pxStateList_1
	iny
	iny
	lda	[<L86+pxTCB_1],Y
	sta	<L86+pxStateList_1+2
;                pxEventList = listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) );
	ldy	#$28
	lda	[<L86+pxTCB_1],Y
	sta	<L86+pxEventList_1
	iny
	iny
	lda	[<L86+pxTCB_1],Y
	sta	<L86+pxEventList_1+2
;                pxDelayedList = pxDelayedTaskList;
	lda	|_~pxDelayedTaskList	; volatile
	sta	<L86+pxDelayedList_1
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<L86+pxDelayedList_1+2
;                pxOverflowedDelayedList = pxOverflowDelayedTaskList;
	lda	|_~pxOverflowDelayedTaskList	; volatile
	sta	<L86+pxOverflowedDelayedList_1
	lda	|_~pxOverflowDelayedTaskList+2	; volatile
	sta	<L86+pxOverflowedDelayedList_1+2
;            }
;            taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;            if( pxEventList == &xPendingReadyList )
;            {
	lda	#<_~xPendingReadyList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<L86+pxEventList_1
	cmp	<R0
	bne	L90
	lda	<L86+pxEventList_1+2
	cmp	<R0+2
L90:
	bne	L10123
;                /* The task has been placed on the pending ready list, so its
;                 * state is eReady regardless of what list the task's state list
;                 * item is currently placed on. */
;                eReturn = eReady;
L10135:
;            {
;                #if ( configNUMBER_OF_CORES == 1 )
;                {
;                    /* If the task is not in any other state, it must be in the
;                     * Ready (including pending ready) state. */
;                    eReturn = eReady;
	lda	#$1
L20012:
	sta	<L86+eReturn_1
;                }
;                #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                {
;                    if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                    {
;                        /* Is it actively running on a core? */
;                        eReturn = eRunning;
;                    }
;                    else
;                    {
;                        /* If the task is not in any other state, it must be in the
;                         * Ready (including pending ready) state. */
;                        eReturn = eReady;
;                    }
;                }
;                #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;            }
;        }
L10122:
;
;        traceRETURN_eTaskGetState( eReturn );
;
;        return eReturn;
	lda	<L86+eReturn_1
	tay
	lda	<L85+1
	sta	<L85+1+4
	pld
	tsc
	clc
	adc	#L85+4
	tcs
	tya
	rts
;            }
;            else if( ( pxStateList == pxDelayedList ) || ( pxStateList == pxOverflowedDelayedList ) )
L10123:
;            {
	lda	<L86+pxStateList_1
	cmp	<L86+pxDelayedList_1
	bne	L93
	lda	<L86+pxStateList_1+2
	cmp	<L86+pxDelayedList_1+2
L93:
	beq	L92
	lda	<L86+pxStateList_1
	cmp	<L86+pxOverflowedDelayedList_1
	bne	L95
	lda	<L86+pxStateList_1+2
	cmp	<L86+pxOverflowedDelayedList_1+2
L95:
	bne	L10125
L92:
;                /* The task being queried is referenced from one of the Blocked
;                 * lists. */
;                eReturn = eBlocked;
	lda	#$2
	bra	L20012
;            }
;
;            #if ( INCLUDE_vTaskSuspend == 1 )
;                else if( pxStateList == &xSuspendedTaskList )
L10125:
;                {
	lda	#<_~xSuspendedTaskList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<L86+pxStateList_1
	cmp	<R0
	bne	L97
	lda	<L86+pxStateList_1+2
	cmp	<R0+2
L97:
	bne	L10127
;                    /* The task being queried is referenced from the suspended
;                     * list.  Is it genuinely suspended or is it blocked
;                     * indefinitely? */
;                    if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL )
;                    {
	ldy	#$28
	lda	[<L86+pxTCB_1],Y
	iny
	iny
	ora	[<L86+pxTCB_1],Y
	bne	L92
;                        #if ( configUSE_TASK_NOTIFICATIONS == 1 )
;                        {
;                            BaseType_t x;
;
;                            /* The task does not appear on the event list item of
;                             * and of the RTOS objects, but could still be in the
;                             * blocked state if it is waiting on its notification
;                             * rather than waiting on an object.  If not, is
;                             * suspended. */
;                            eReturn = eSuspended;
x_2	set	22
	lda	#$3
	sta	<L86+eReturn_1
;
;                            for( x = ( BaseType_t ) 0; x < ( BaseType_t ) configTASK_NOTIFICATION_ARRAY_ENTRIES; x++ )
	stz	<L86+x_2
L10131:
;                            {
;                                if( pxTCB->ucNotifyState[ x ] == taskWAITING_NOTIFICATION )
;                                {
	lda	#$4a
	clc
	adc	<L86+x_2
	tay
	sep	#$20
	longa	off
	lda	[<L86+pxTCB_1],Y
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L92
;                                    eReturn = eBlocked;
;                    {
;                        eReturn = eBlocked;
;                                    break;
;                                }
;                            }
	inc	<L86+x_2
	lda	<L86+x_2
	bmi	L10131
	dea
	bmi	L10131
	bra	L10122
;                        }
;                        #else /* if ( configUSE_TASK_NOTIFICATIONS == 1 ) */
;                        {
;                            eReturn = eSuspended;
;                        }
;                        #endif /* if ( configUSE_TASK_NOTIFICATIONS == 1 ) */
;                    }
;                    else
;                    }
;                }
;            #endif /* if ( INCLUDE_vTaskSuspend == 1 ) */
;
;            #if ( INCLUDE_vTaskDelete == 1 )
;                else if( ( pxStateList == &xTasksWaitingTermination ) || ( pxStateList == NULL ) )
L10127:
;                {
	lda	#<_~xTasksWaitingTermination
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<L86+pxStateList_1
	cmp	<R0
	bne	L104
	lda	<L86+pxStateList_1+2
	cmp	<R0+2
L104:
	beq	L103
	lda	<L86+pxStateList_1
	ora	<L86+pxStateList_1+2
	beq	*+5
	brl	L10135
L103:
;                    /* The task being queried is referenced from the deleted
;                     * tasks list, or it is not referenced from any lists at
;                     * all. */
;                    eReturn = eDeleted;
	lda	#$4
	brl	L20012
;                }
;            #endif
;
;            else
;    }
L85	equ	28
L86	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_eTaskGetState */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_uxTaskPriorityGet == 1 )
;
;    UBaseType_t uxTaskPriorityGet( const TaskHandle_t xTask )
;    {
	code
	xdef	_~uxTaskPriorityGet
	func
_~uxTaskPriorityGet:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L108
	tcs
	phd
	tcd
xTask_0	set	3
;        TCB_t const * pxTCB;
;        UBaseType_t uxReturn;
;
;        traceENTER_uxTaskPriorityGet( xTask );
pxTCB_1	set	0
uxReturn_1	set	4
;
;        portBASE_TYPE_ENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            /* If null is passed in here then it is the priority of the task
;             * that called uxTaskPriorityGet() that is being queried. */
;            pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L108+xTask_0
	ora	<L108+xTask_0+2
	bne	L110
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L112
L110:
	ldx	<L108+xTask_0+2
	lda	<L108+xTask_0
L112:
	stx	<R0+2
	sta	<L109+pxTCB_1
	lda	<R0+2
	sta	<L109+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L109+pxTCB_1
	ora	<L109+pxTCB_1+2
	bne	L10137
	asmstart
	sei
	asmend
L10138:
	bra	L10138
L10137:
;
;            uxReturn = pxTCB->uxPriority;
	ldy	#$2c
	lda	[<L109+pxTCB_1],Y
	sta	<L109+uxReturn_1
;        }
;        portBASE_TYPE_EXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_uxTaskPriorityGet( uxReturn );
;
;        return uxReturn;
	lda	<L109+uxReturn_1
	tay
	lda	<L108+1
	sta	<L108+1+4
	pld
	tsc
	clc
	adc	#L108+4
	tcs
	tya
	rts
;    }
L108	equ	10
L109	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_uxTaskPriorityGet */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_uxTaskPriorityGet == 1 )
;
;    UBaseType_t uxTaskPriorityGetFromISR( const TaskHandle_t xTask )
;    {
	code
	xdef	_~uxTaskPriorityGetFromISR
	func
_~uxTaskPriorityGetFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L115
	tcs
	phd
	tcd
xTask_0	set	3
;        TCB_t const * pxTCB;
;        UBaseType_t uxReturn;
;        UBaseType_t uxSavedInterruptStatus;
;
;        traceENTER_uxTaskPriorityGetFromISR( xTask );
pxTCB_1	set	0
uxReturn_1	set	4
uxSavedInterruptStatus_1	set	6
;
;        /* RTOS ports that support interrupt nesting have the concept of a
;         * maximum  system call (or maximum API call) interrupt priority.
;         * Interrupts that are  above the maximum system call priority are keep
;         * permanently enabled, even when the RTOS kernel is in a critical section,
;         * but cannot make any calls to FreeRTOS API functions.  If configASSERT()
;         * is defined in FreeRTOSConfig.h then
;         * portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;         * failure if a FreeRTOS API function is called from an interrupt that has
;         * been assigned a priority above the configured maximum system call
;         * priority.  Only FreeRTOS functions that end in FromISR can be called
;         * from interrupts  that have been assigned a priority at or (logically)
;         * below the maximum system call interrupt priority.  FreeRTOS maintains a
;         * separate interrupt safe API to ensure interrupt entry is as fast and as
;         * simple as possible.  More information (albeit Cortex-M specific) is
;         * provided on the following link:
;         * https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;        portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L116+uxSavedInterruptStatus_1
;        {
;            /* If null is passed in here then it is the priority of the calling
;             * task that is being queried. */
;            pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L115+xTask_0
	ora	<L115+xTask_0+2
	bne	L117
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L119
L117:
	ldx	<L115+xTask_0+2
	lda	<L115+xTask_0
L119:
	stx	<R0+2
	sta	<L116+pxTCB_1
	lda	<R0+2
	sta	<L116+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L116+pxTCB_1
	ora	<L116+pxTCB_1+2
	bne	L10141
	asmstart
	sei
	asmend
L10142:
	bra	L10142
L10141:
;
;            uxReturn = pxTCB->uxPriority;
	ldy	#$2c
	lda	[<L116+pxTCB_1],Y
	sta	<L116+uxReturn_1
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_uxTaskPriorityGetFromISR( uxReturn );
;
;        return uxReturn;
	tay
	lda	<L115+1
	sta	<L115+1+4
	pld
	tsc
	clc
	adc	#L115+4
	tcs
	tya
	rts
;    }
L115	equ	12
L116	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_uxTaskPriorityGet */
;/*-----------------------------------------------------------*/
;
;#if ( ( INCLUDE_uxTaskPriorityGet == 1 ) && ( configUSE_MUTEXES == 1 ) )
;
;    UBaseType_t uxTaskBasePriorityGet( const TaskHandle_t xTask )
;    {
	code
	xdef	_~uxTaskBasePriorityGet
	func
_~uxTaskBasePriorityGet:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L122
	tcs
	phd
	tcd
xTask_0	set	3
;        TCB_t const * pxTCB;
;        UBaseType_t uxReturn;
;
;        traceENTER_uxTaskBasePriorityGet( xTask );
pxTCB_1	set	0
uxReturn_1	set	4
;
;        portBASE_TYPE_ENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            /* If null is passed in here then it is the base priority of the task
;             * that called uxTaskBasePriorityGet() that is being queried. */
;            pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L122+xTask_0
	ora	<L122+xTask_0+2
	bne	L124
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L126
L124:
	ldx	<L122+xTask_0+2
	lda	<L122+xTask_0
L126:
	stx	<R0+2
	sta	<L123+pxTCB_1
	lda	<R0+2
	sta	<L123+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L123+pxTCB_1
	ora	<L123+pxTCB_1+2
	bne	L10145
	asmstart
	sei
	asmend
L10146:
	bra	L10146
L10145:
;
;            uxReturn = pxTCB->uxBasePriority;
	ldy	#$42
	lda	[<L123+pxTCB_1],Y
	sta	<L123+uxReturn_1
;        }
;        portBASE_TYPE_EXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_uxTaskBasePriorityGet( uxReturn );
;
;        return uxReturn;
	lda	<L123+uxReturn_1
	tay
	lda	<L122+1
	sta	<L122+1+4
	pld
	tsc
	clc
	adc	#L122+4
	tcs
	tya
	rts
;    }
L122	equ	10
L123	equ	5
	ends
	efunc
;
;#endif /* #if ( ( INCLUDE_uxTaskPriorityGet == 1 ) && ( configUSE_MUTEXES == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( INCLUDE_uxTaskPriorityGet == 1 ) && ( configUSE_MUTEXES == 1 ) )
;
;    UBaseType_t uxTaskBasePriorityGetFromISR( const TaskHandle_t xTask )
;    {
	code
	xdef	_~uxTaskBasePriorityGetFromISR
	func
_~uxTaskBasePriorityGetFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L129
	tcs
	phd
	tcd
xTask_0	set	3
;        TCB_t const * pxTCB;
;        UBaseType_t uxReturn;
;        UBaseType_t uxSavedInterruptStatus;
;
;        traceENTER_uxTaskBasePriorityGetFromISR( xTask );
pxTCB_1	set	0
uxReturn_1	set	4
uxSavedInterruptStatus_1	set	6
;
;        /* RTOS ports that support interrupt nesting have the concept of a
;         * maximum  system call (or maximum API call) interrupt priority.
;         * Interrupts that are  above the maximum system call priority are keep
;         * permanently enabled, even when the RTOS kernel is in a critical section,
;         * but cannot make any calls to FreeRTOS API functions.  If configASSERT()
;         * is defined in FreeRTOSConfig.h then
;         * portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;         * failure if a FreeRTOS API function is called from an interrupt that has
;         * been assigned a priority above the configured maximum system call
;         * priority.  Only FreeRTOS functions that end in FromISR can be called
;         * from interrupts  that have been assigned a priority at or (logically)
;         * below the maximum system call interrupt priority.  FreeRTOS maintains a
;         * separate interrupt safe API to ensure interrupt entry is as fast and as
;         * simple as possible.  More information (albeit Cortex-M specific) is
;         * provided on the following link:
;         * https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;        portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L130+uxSavedInterruptStatus_1
;        {
;            /* If null is passed in here then it is the base priority of the calling
;             * task that is being queried. */
;            pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L129+xTask_0
	ora	<L129+xTask_0+2
	bne	L131
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L133
L131:
	ldx	<L129+xTask_0+2
	lda	<L129+xTask_0
L133:
	stx	<R0+2
	sta	<L130+pxTCB_1
	lda	<R0+2
	sta	<L130+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L130+pxTCB_1
	ora	<L130+pxTCB_1+2
	bne	L10149
	asmstart
	sei
	asmend
L10150:
	bra	L10150
L10149:
;
;            uxReturn = pxTCB->uxBasePriority;
	ldy	#$42
	lda	[<L130+pxTCB_1],Y
	sta	<L130+uxReturn_1
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_uxTaskBasePriorityGetFromISR( uxReturn );
;
;        return uxReturn;
	tay
	lda	<L129+1
	sta	<L129+1+4
	pld
	tsc
	clc
	adc	#L129+4
	tcs
	tya
	rts
;    }
L129	equ	12
L130	equ	5
	ends
	efunc
;
;#endif /* #if ( ( INCLUDE_uxTaskPriorityGet == 1 ) && ( configUSE_MUTEXES == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskPrioritySet == 1 )
;
;    void vTaskPrioritySet( TaskHandle_t xTask,
;                           UBaseType_t uxNewPriority )
;    {
	code
	xdef	_~vTaskPrioritySet
	func
_~vTaskPrioritySet:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
xTask_0	set	3
uxNewPriority_0	set	7
;        TCB_t * pxTCB;
;        UBaseType_t uxCurrentBasePriority, uxPriorityUsedOnEntry;
;        BaseType_t xYieldRequired = pdFALSE;
;
;        #if ( configNUMBER_OF_CORES > 1 )
;            BaseType_t xYieldForTask = pdFALSE;
;        #endif
;
;        traceENTER_vTaskPrioritySet( xTask, uxNewPriority );
pxTCB_1	set	0
uxCurrentBasePriority_1	set	4
uxPriorityUsedOnEntry_1	set	6
xYieldRequired_1	set	8
	stz	<L137+xYieldRequired_1
;
;        configASSERT( uxNewPriority < configMAX_PRIORITIES );
	lda	<L136+uxNewPriority_0
	cmp	#<$5
	bcc	L10153
	asmstart
	sei
	asmend
L10154:
	bra	L10154
L10153:
;
;        /* Ensure the new priority is valid. */
;        if( uxNewPriority >= ( UBaseType_t ) configMAX_PRIORITIES )
;        {
	lda	<L136+uxNewPriority_0
	cmp	#<$5
	bcc	L10158
;            uxNewPriority = ( UBaseType_t ) configMAX_PRIORITIES - ( UBaseType_t ) 1U;
	lda	#$4
	sta	<L136+uxNewPriority_0
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10158:
;
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            /* If null is passed in here then it is the priority of the calling
;             * task that is being changed. */
;            pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L136+xTask_0
	ora	<L136+xTask_0+2
	bne	L140
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L142
L140:
	ldx	<L136+xTask_0+2
	lda	<L136+xTask_0
L142:
	stx	<R0+2
	sta	<L137+pxTCB_1
	lda	<R0+2
	sta	<L137+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L137+pxTCB_1
	ora	<L137+pxTCB_1+2
	bne	L10159
	asmstart
	sei
	asmend
L10160:
	bra	L10160
L10159:
;
;            traceTASK_PRIORITY_SET( pxTCB, uxNewPriority );
;
;            #if ( configUSE_MUTEXES == 1 )
;            {
;                uxCurrentBasePriority = pxTCB->uxBasePriority;
	ldy	#$42
	lda	[<L137+pxTCB_1],Y
	sta	<L137+uxCurrentBasePriority_1
;            }
;            #else
;            {
;                uxCurrentBasePriority = pxTCB->uxPriority;
;            }
;            #endif
;
;            if( uxCurrentBasePriority != uxNewPriority )
;            {
	cmp	<L136+uxNewPriority_0
	bne	*+5
	brl	L10163
;                /* The priority change may have readied a task of higher
;                 * priority than a running task. */
;                if( uxNewPriority > uxCurrentBasePriority )
;                {
	lda	<L137+uxCurrentBasePriority_1
	cmp	<L136+uxNewPriority_0
	bcc	*+5
	brl	L10164
;                    #if ( configNUMBER_OF_CORES == 1 )
;                    {
;                        if( pxTCB != pxCurrentTCB )
;                        {
	lda	<L137+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L146
	lda	<L137+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L146:
	beq	L10169
;                            /* The priority of a task other than the currently
;                             * running task is being raised.  Is the priority being
;                             * raised above that of the running task? */
;                            if( uxNewPriority > pxCurrentTCB->uxPriority )
;                            {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	<L136+uxNewPriority_0
	bcs	L10169
;                                xYieldRequired = pdTRUE;
L20018:
	lda	#$1
	sta	<L137+xYieldRequired_1
;                            }
;                            else
;                    }
;                    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                    {
;                        /* The priority of a task is being raised so
;                         * perform a yield for this task later. */
;                        xYieldForTask = pdTRUE;
;                    }
;                    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;                }
;                else if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
L10169:
;
;                /* Remember the ready list the task might be referenced from
;                 * before its uxPriority member is changed so the
;                 * taskRESET_READY_PRIORITY() macro can function correctly. */
;                uxPriorityUsedOnEntry = pxTCB->uxPriority;
	ldy	#$2c
	lda	[<L137+pxTCB_1],Y
	sta	<L137+uxPriorityUsedOnEntry_1
;
;                #if ( configUSE_MUTEXES == 1 )
;                {
;                    /* Only change the priority being used if the task is not
;                     * currently using an inherited priority or the new priority
;                     * is bigger than the inherited priority. */
;                    if( ( pxTCB->uxBasePriority == pxTCB->uxPriority ) || ( uxNewPriority > pxTCB->uxPriority ) )
;                    {
	ldy	#$42
	lda	[<L137+pxTCB_1],Y
	ldy	#$2c
	cmp	[<L137+pxTCB_1],Y
	beq	L154
;                {
;                    /* Setting the priority of any other task down does not
;                     * require a yield as the running task must be above the
;                     * new priority of the task being modified. */
;                }
	lda	[<L137+pxTCB_1],Y
	cmp	<L136+uxNewPriority_0
	bcc	L154
L10173:
;
;                    /* The base priority gets set whatever. */
;                    pxTCB->uxBasePriority = uxNewPriority;
	lda	<L136+uxNewPriority_0
	ldy	#$42
	sta	[<L137+pxTCB_1],Y
;                }
;                #else /* if ( configUSE_MUTEXES == 1 ) */
;                {
;                    pxTCB->uxPriority = uxNewPriority;
;                }
;                #endif /* if ( configUSE_MUTEXES == 1 ) */
;
;                /* Only reset the event list item value if the value is not
;                 * being used for anything else. */
;                if( ( listGET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ) ) & taskEVENT_LIST_ITEM_VALUE_IN_USE ) == ( ( TickType_t ) 0U ) )
;                {
	ldy	#$1a
	lda	[<L137+pxTCB_1],Y
	and	#^$80000000
	bne	L10175
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                    listSET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ), ( ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) uxNewPriority ) );
	lda	<L136+uxNewPriority_0
	sta	<R0
	stz	<R0+2
	sec
	lda	#$5
	sbc	<R0
	sta	<R1
	lda	#$0
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	dey
	dey
	sta	[<L137+pxTCB_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L137+pxTCB_1],Y
;                }
;                else
L10175:
;
;                /* If the task is in the blocked or suspended list we need do
;                 * nothing more than change its priority variable. However, if
;                 * the task is in a ready list it needs to be removed and placed
;                 * in the list appropriate to its new priority. */
;                if( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ uxPriorityUsedOnEntry ] ), &( pxTCB->xStateListItem ) ) != pdFALSE )
;                {
	lda	<L137+uxPriorityUsedOnEntry_1
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	cmp	[<L137+pxTCB_1],Y
	bne	L159
	lda	<R0+2
	iny
	iny
	cmp	[<L137+pxTCB_1],Y
L159:
	beq	L160
	lda	#$0
	bra	L161
L154:
;                        pxTCB->uxPriority = uxNewPriority;
	lda	<L136+uxNewPriority_0
	ldy	#$2c
	sta	[<L137+pxTCB_1],Y
;                    }
;                    else
	bra	L10173
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        else
;                        {
;                            /* The priority of the running task is being raised,
;                             * but the running task must already be the highest
;                             * priority task able to run so no yield is required. */
;                        }
L10164:
;                {
	lda	<L137+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L150
	lda	<L137+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L150:
	bne	L149
	lda	#$1
	bra	L152
L149:
	lda	#$0
L152:
	cmp	#<$1
	beq	*+5
	brl	L10169
;                    /* Setting the priority of a running task down means
;                     * there may now be another task of higher priority that
;                     * is ready to execute. */
;                    #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;                        if( pxTCB->xPreemptionDisable == pdFALSE )
;                    #endif
;                    {
;                        xYieldRequired = pdTRUE;
	brl	L20018
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L160:
	lda	#$1
L161:
	tax
	bne	*+5
	brl	L10189
;                    /* The task is currently in its ready list - remove before
;                     * adding it to its new ready list.  As we are in a critical
;                     * section we can do this even if the scheduler is suspended. */
;                    if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
;                    {
	lda	#$4
	clc
	adc	<L137+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L137+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10184
;                        /* It is known that the task is in its ready list so
;                         * there is no need to check again and the port level
;                         * reset macro can be called directly. */
;                        portRESET_READY_PRIORITY( uxPriorityUsedOnEntry, uxTopReadyPriority );
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;
;                    prvAddTaskToReadyList( pxTCB );
L10184:
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L137+pxTCB_1],Y
	bcs	L10188
	lda	[<L137+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10188:
pxIndex_2	set	10
	ldy	#$2c
	lda	[<L137+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L137+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L137+pxIndex_2+2
	lda	<L137+pxIndex_2
	ldy	#$8
	sta	[<L137+pxTCB_1],Y
	lda	<L137+pxIndex_2+2
	iny
	iny
	sta	[<L137+pxTCB_1],Y
	dey
	dey
	lda	[<L137+pxIndex_2],Y
	ldy	#$c
	sta	[<L137+pxTCB_1],Y
	dey
	dey
	lda	[<L137+pxIndex_2],Y
	ldy	#$e
	sta	[<L137+pxTCB_1],Y
	ldy	#$8
	lda	[<L137+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L137+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L137+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L137+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L137+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L137+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L137+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L137+pxIndex_2],Y
	ldy	#$2c
	lda	[<L137+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L137+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L137+pxTCB_1],Y
	ldy	#$2c
	lda	[<L137+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L137+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;                }
;                else
L10189:
;
;                if( xYieldRequired != pdFALSE )
;                {
	lda	<L137+xYieldRequired_1
	bne	L10193
L10163:
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_vTaskPrioritySet();
;    }
	lda	<L136+1
	sta	<L136+1+6
	pld
	tsc
	clc
	adc	#L136+6
	tcs
	rts
;                {
;                    #if ( configNUMBER_OF_CORES == 1 )
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                    #else
;                    {
;                        /* It's possible that xYieldForTask was already set to pdTRUE because
;                         * its priority is being raised. However, since it is not in a ready list
;                         * we don't actually need to yield for it. */
;                        xYieldForTask = pdFALSE;
;                    }
;                    #endif
;                }
;                    /* The running task priority is set down. Request the task to yield. */
;                    taskYIELD_TASK_CORE_IF_USING_PREEMPTION( pxTCB );
L10193:
	jsl	_~vPortYield
;                }
;                else
	bra	L10163
;                {
;                    #if ( configNUMBER_OF_CORES > 1 )
;                        if( xYieldForTask != pdFALSE )
;                        {
;                            /* The priority of the task is being raised. If a running
;                             * task has priority lower than this task, it should yield
;                             * for this task. */
;                            taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxTCB );
;                        }
;                        else
;                    #endif /* if ( configNUMBER_OF_CORES > 1 ) */
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;
;                /* Remove compiler warning about unused variables when the port
;                 * optimised task selection is not being used. */
;                ( void ) uxPriorityUsedOnEntry;
;            }
;        }
L136	equ	26
L137	equ	13
	ends
	efunc
;
;#endif /* INCLUDE_vTaskPrioritySet */
;/*-----------------------------------------------------------*/
;
;#if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;    void vTaskCoreAffinitySet( const TaskHandle_t xTask,
;                               UBaseType_t uxCoreAffinityMask )
;    {
;        TCB_t * pxTCB;
;        BaseType_t xCoreID;
;
;        traceENTER_vTaskCoreAffinitySet( xTask, uxCoreAffinityMask );
;
;        taskENTER_CRITICAL();
;        {
;            pxTCB = prvGetTCBFromHandle( xTask );
;            configASSERT( pxTCB != NULL );
;
;            pxTCB->uxCoreAffinityMask = uxCoreAffinityMask;
;
;            if( xSchedulerRunning != pdFALSE )
;            {
;                if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                {
;                    xCoreID = ( BaseType_t ) pxTCB->xTaskRunState;
;
;                    /* If the task can no longer run on the core it was running,
;                     * request the core to yield. */
;                    if( ( uxCoreAffinityMask & ( ( UBaseType_t ) 1U << ( UBaseType_t ) xCoreID ) ) == 0U )
;                    {
;                        prvYieldCore( xCoreID );
;                    }
;                }
;                else
;                {
;                    #if ( configUSE_PREEMPTION == 1 )
;                    {
;                        /* The SMP scheduler requests a core to yield when a ready
;                         * task is able to run. It is possible that the core affinity
;                         * of the ready task is changed before the requested core
;                         * can select it to run. In that case, the task may not be
;                         * selected by the previously requested core due to core affinity
;                         * constraint and the SMP scheduler must select a new core to
;                         * yield for the task. */
;                        prvYieldForTask( xTask );
;                    }
;                    #else /* #if( configUSE_PREEMPTION == 1 ) */
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                    #endif /* #if( configUSE_PREEMPTION == 1 ) */
;                }
;            }
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_vTaskCoreAffinitySet();
;    }
;#endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;    UBaseType_t vTaskCoreAffinityGet( ConstTaskHandle_t xTask )
;    {
;        const TCB_t * pxTCB;
;        UBaseType_t uxCoreAffinityMask;
;
;        traceENTER_vTaskCoreAffinityGet( xTask );
;
;        portBASE_TYPE_ENTER_CRITICAL();
;        {
;            pxTCB = prvGetTCBFromHandle( xTask );
;            configASSERT( pxTCB != NULL );
;
;            uxCoreAffinityMask = pxTCB->uxCoreAffinityMask;
;        }
;        portBASE_TYPE_EXIT_CRITICAL();
;
;        traceRETURN_vTaskCoreAffinityGet( uxCoreAffinityMask );
;
;        return uxCoreAffinityMask;
;    }
;#endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;
;    void vTaskPreemptionDisable( const TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;
;        traceENTER_vTaskPreemptionDisable( xTask );
;
;        taskENTER_CRITICAL();
;        {
;            pxTCB = prvGetTCBFromHandle( xTask );
;            configASSERT( pxTCB != NULL );
;
;            pxTCB->xPreemptionDisable = pdTRUE;
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_vTaskPreemptionDisable();
;    }
;
;#endif /* #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;
;    void vTaskPreemptionEnable( const TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;        BaseType_t xCoreID;
;
;        traceENTER_vTaskPreemptionEnable( xTask );
;
;        taskENTER_CRITICAL();
;        {
;            pxTCB = prvGetTCBFromHandle( xTask );
;            configASSERT( pxTCB != NULL );
;
;            pxTCB->xPreemptionDisable = pdFALSE;
;
;            if( xSchedulerRunning != pdFALSE )
;            {
;                if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                {
;                    xCoreID = ( BaseType_t ) pxTCB->xTaskRunState;
;                    prvYieldCore( xCoreID );
;                }
;            }
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_vTaskPreemptionEnable();
;    }
;
;#endif /* #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskSuspend == 1 )
;
;    void vTaskSuspend( TaskHandle_t xTaskToSuspend )
;    {
	code
	xdef	_~vTaskSuspend
	func
_~vTaskSuspend:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L167
	tcs
	phd
	tcd
xTaskToSuspend_0	set	3
;        TCB_t * pxTCB;
;
;        traceENTER_vTaskSuspend( xTaskToSuspend );
pxTCB_1	set	0
;
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            /* If null is passed in here then it is the running task that is
;             * being suspended. */
;            pxTCB = prvGetTCBFromHandle( xTaskToSuspend );
	lda	<L167+xTaskToSuspend_0
	ora	<L167+xTaskToSuspend_0+2
	bne	L169
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L171
L169:
	ldx	<L167+xTaskToSuspend_0+2
	lda	<L167+xTaskToSuspend_0
L171:
	stx	<R0+2
	sta	<L168+pxTCB_1
	lda	<R0+2
	sta	<L168+pxTCB_1+2
;            configASSERT( pxTCB != NULL );
	lda	<L168+pxTCB_1
	ora	<L168+pxTCB_1+2
	bne	L10195
	asmstart
	sei
	asmend
L10196:
	bra	L10196
L10195:
;
;            traceTASK_SUSPEND( pxTCB );
;
;            /* Remove task from the ready/delayed list and place in the
;             * suspended list. */
;            if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
;            {
	lda	#$4
	clc
	adc	<L168+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L168+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10200
;                taskRESET_READY_PRIORITY( pxTCB->uxPriority );
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10200:
;
;            /* Is the task waiting on an event also? */
;            if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
;            {
	ldy	#$28
	lda	[<L168+pxTCB_1],Y
	iny
	iny
	ora	[<L168+pxTCB_1],Y
	beq	L10202
;                ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
	lda	#$18
	clc
	adc	<L168+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L168+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10202:
;
;            vListInsertEnd( &xSuspendedTaskList, &( pxTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	<L168+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L168+pxTCB_1+2
	pha
	pei	<R0
	lda	#<_~xSuspendedTaskList
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	jsr	_~vListInsertEnd
;
;            #if ( configUSE_TASK_NOTIFICATIONS == 1 )
;            {
;                BaseType_t x;
;
;                for( x = ( BaseType_t ) 0; x < ( BaseType_t ) configTASK_NOTIFICATION_ARRAY_ENTRIES; x++ )
x_2	set	4
	stz	<L168+x_2
L10205:
;                {
;                    if( pxTCB->ucNotifyState[ x ] == taskWAITING_NOTIFICATION )
;                    {
	lda	#$4a
	clc
	adc	<L168+x_2
	tay
	sep	#$20
	longa	off
	lda	[<L168+pxTCB_1],Y
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10203
;                        /* The task was blocked to wait for a notification, but is
;                         * now suspended, so no notification was received. */
;                        pxTCB->ucNotifyState[ x ] = taskNOT_WAITING_NOTIFICATION;
	lda	#$4a
	clc
	adc	<L168+x_2
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L168+pxTCB_1],Y
	rep	#$20
	longa	on
;                    }
;                }
L10203:
	inc	<L168+x_2
	lda	<L168+x_2
	bmi	L10205
	dea
	bmi	L10205
;            }
;            #endif /* if ( configUSE_TASK_NOTIFICATIONS == 1 ) */
;
;            /* In the case of SMP, it is possible that the task being suspended
;             * is running on another core. We must evict the task before
;             * exiting the critical section to ensure that the task cannot
;             * take an action which puts it back on ready/state/event list,
;             * thereby nullifying the suspend operation. Once evicted, the
;             * task won't be scheduled before it is resumed as it will no longer
;             * be on the ready list. */
;            #if ( configNUMBER_OF_CORES > 1 )
;            {
;                if( xSchedulerRunning != pdFALSE )
;                {
;                    /* Reset the next expected unblock time in case it referred to the
;                     * task that is now in the Suspended state. */
;                    prvResetNextTaskUnblockTime();
;
;                    if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                    {
;                        if( pxTCB->xTaskRunState == ( BaseType_t ) portGET_CORE_ID() )
;                        {
;                            /* The current task has just been suspended. */
;                            configASSERT( uxSchedulerSuspended == 0 );
;                            vTaskYieldWithinAPI();
;                        }
;                        else
;                        {
;                            prvYieldCore( pxTCB->xTaskRunState );
;                        }
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
;            #endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        #if ( configNUMBER_OF_CORES == 1 )
;        {
;            UBaseType_t uxCurrentListLength;
;
;            if( xSchedulerRunning != pdFALSE )
uxCurrentListLength_3	set	4
;            {
	lda	|_~xSchedulerRunning	; volatile
	beq	L10208
;                /* Reset the next expected unblock time in case it referred to the
;                 * task that is now in the Suspended state. */
;                taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;                {
;                    prvResetNextTaskUnblockTime();
	jsr	_~prvResetNextTaskUnblockTime
;                }
;                taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10208:
;
;            if( pxTCB == pxCurrentTCB )
;            {
	lda	<L168+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L179
	lda	<L168+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L179:
	bne	L184
;                if( xSchedulerRunning != pdFALSE )
;                {
	lda	|_~xSchedulerRunning	; volatile
	beq	L10210
;                    /* The current task has just been suspended. */
;                    configASSERT( uxSchedulerSuspended == 0 );
	lda	|_~uxSchedulerSuspended	; volatile
	beq	L10211
	asmstart
	sei
	asmend
L10212:
	bra	L10212
L10211:
;                    portYIELD_WITHIN_API();
	jsl	_~vPortYield
;                }
;                else
	bra	L184
L20020:
;                        /* No other tasks are ready, so set pxCurrentTCB back to
;                         * NULL so when the next task is created pxCurrentTCB will
;                         * be set to point to it no matter what its relative priority
;                         * is. */
;                        pxCurrentTCB = NULL;
	stz	|_~pxCurrentTCB	; volatile
	stz	|_~pxCurrentTCB+2	; volatile
;                    }
;                    else
L184:
	lda	<L167+1
	sta	<L167+1+4
	pld
	tsc
	clc
	adc	#L167+4
	tcs
	rts
L10210:
;                {
;                    /* The scheduler is not running, but the task that was pointed
;                     * to by pxCurrentTCB has just been suspended and pxCurrentTCB
;                     * must be adjusted to point to a different task. */
;
;                    /* Use a temp variable as a distinct sequence point for reading
;                     * volatile variables prior to a comparison to ensure compliance
;                     * with MISRA C 2012 Rule 13.2. */
;                    uxCurrentListLength = listCURRENT_LIST_LENGTH( &xSuspendedTaskList );
	lda	|_~xSuspendedTaskList
	sta	<L168+uxCurrentListLength_3
;
;                    if( uxCurrentListLength == uxCurrentNumberOfTasks )
;                    {
	cmp	|_~uxCurrentNumberOfTasks	; volatile
	beq	L20020
;                    {
;                        vTaskSwitchContext();
	jsr	_~vTaskSwitchContext
;                    }
;                }
;            }
;            else
	bra	L184
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;        traceRETURN_vTaskSuspend();
;    }
L167	equ	14
L168	equ	9
	ends
	efunc
;
;#endif /* INCLUDE_vTaskSuspend */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskSuspend == 1 )
;
;    STATIC BaseType_t prvTaskIsTaskSuspended( const TaskHandle_t xTask )
;    {
	code
	func
_~prvTaskIsTaskSuspended:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L185
	tcs
	phd
	tcd
xTask_0	set	3
;        BaseType_t xReturn = pdFALSE;
;        const TCB_t * const pxTCB = xTask;
;
;        /* Accesses xPendingReadyList so must be called from a critical
;         * section. */
;
;        /* It does not make sense to check if the calling task is suspended. */
;        configASSERT( xTask );
xReturn_1	set	0
pxTCB_1	set	2
	stz	<L186+xReturn_1
	lda	<L185+xTask_0
	sta	<L186+pxTCB_1
	lda	<L185+xTask_0+2
	sta	<L186+pxTCB_1+2
	lda	<L185+xTask_0
	ora	<L185+xTask_0+2
	bne	L10219
	asmstart
	sei
	asmend
L10220:
	bra	L10220
L10219:
;
;        /* Is the task being resumed actually in the suspended list? */
;        if( listIS_CONTAINED_WITHIN( &xSuspendedTaskList, &( pxTCB->xStateListItem ) ) != pdFALSE )
;        {
	lda	#<_~xSuspendedTaskList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldy	#$14
	lda	[<L186+pxTCB_1],Y
	cmp	<R0
	bne	L189
	iny
	iny
	lda	[<L186+pxTCB_1],Y
	cmp	<R0+2
L189:
	bne	L188
	lda	#$1
	bra	L191
L188:
	lda	#$0
L191:
	tax
	beq	L10232
;            /* Has the task already been resumed from within an ISR? */
;            if( listIS_CONTAINED_WITHIN( &xPendingReadyList, &( pxTCB->xEventListItem ) ) == pdFALSE )
;            {
	lda	#<_~xPendingReadyList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldy	#$28
	lda	[<L186+pxTCB_1],Y
	cmp	<R0
	bne	L194
	iny
	iny
	lda	[<L186+pxTCB_1],Y
	cmp	<R0+2
L194:
	bne	L193
	lda	#$1
	bra	L196
L193:
	lda	#$0
L196:
	tax
	bne	L10232
;                /* Is it in the suspended list because it is in the Suspended
;                 * state, or because it is blocked with no timeout? */
;                if( listIS_CONTAINED_WITHIN( NULL, &( pxTCB->xEventListItem ) ) != pdFALSE )
;                {
	ldy	#$28
	lda	[<L186+pxTCB_1],Y
	iny
	iny
	ora	[<L186+pxTCB_1],Y
	bne	L198
	lda	#$1
	bra	L200
L198:
	lda	#$0
L200:
	tax
	beq	L10232
;                    #if ( configUSE_TASK_NOTIFICATIONS == 1 )
;                    {
;                        BaseType_t x;
;
;                        /* The task does not appear on the event list item of
;                         * and of the RTOS objects, but could still be in the
;                         * blocked state if it is waiting on its notification
;                         * rather than waiting on an object.  If not, is
;                         * suspended. */
;                        xReturn = pdTRUE;
x_2	set	6
	lda	#$1
	sta	<L186+xReturn_1
;
;                        for( x = ( BaseType_t ) 0; x < ( BaseType_t ) configTASK_NOTIFICATION_ARRAY_ENTRIES; x++ )
	stz	<L186+x_2
L10228:
;                        {
;                            if( pxTCB->ucNotifyState[ x ] == taskWAITING_NOTIFICATION )
;                            {
	lda	#$4a
	clc
	adc	<L186+x_2
	tay
	sep	#$20
	longa	off
	lda	[<L186+pxTCB_1],Y
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10226
;                                xReturn = pdFALSE;
	stz	<L186+xReturn_1
;                                break;
;            }
;            else
L10232:
;
;        return xReturn;
	lda	<L186+xReturn_1
	tay
	lda	<L185+1
	sta	<L185+1+4
	pld
	tsc
	clc
	adc	#L185+4
	tcs
	tya
	rts
;                            }
;                        }
L10226:
	inc	<L186+x_2
	lda	<L186+x_2
	bmi	L10228
	dea
	bpl	L10232
	bra	L10228
;                    }
;                    #else /* if ( configUSE_TASK_NOTIFICATIONS == 1 ) */
;                    {
;                        xReturn = pdTRUE;
;                    }
;                    #endif /* if ( configUSE_TASK_NOTIFICATIONS == 1 ) */
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L185	equ	12
L186	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_vTaskSuspend */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskSuspend == 1 )
;
;    void vTaskResume( TaskHandle_t xTaskToResume )
;    {
	code
	xdef	_~vTaskResume
	func
_~vTaskResume:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L206
	tcs
	phd
	tcd
xTaskToResume_0	set	3
;        TCB_t * const pxTCB = xTaskToResume;
;
;        traceENTER_vTaskResume( xTaskToResume );
pxTCB_1	set	0
	lda	<L206+xTaskToResume_0
	sta	<L207+pxTCB_1
	lda	<L206+xTaskToResume_0+2
	sta	<L207+pxTCB_1+2
;
;        /* It does not make sense to resume the calling task. */
;        configASSERT( xTaskToResume );
	lda	<L206+xTaskToResume_0
	ora	<L206+xTaskToResume_0+2
	bne	L10233
	asmstart
	sei
	asmend
L10234:
	bra	L10234
L10233:
;
;        #if ( configNUMBER_OF_CORES == 1 )
;
;            /* The parameter cannot be NULL as it is impossible to resume the
;             * currently executing task. */
;            if( ( pxTCB != pxCurrentTCB ) && ( pxTCB != NULL ) )
;        #else
;
;            /* The parameter cannot be NULL as it is impossible to resume the
;             * currently executing task. It is also impossible to resume a task
;             * that is actively running on another core but it is not safe
;             * to check their run state here. Therefore, we get into a critical
;             * section and check if the task is actually suspended or not. */
;            if( pxTCB != NULL )
;        #endif
;        {
	lda	<L207+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L209
	lda	<L207+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L209:
	bne	*+5
	brl	L215
	lda	<L207+pxTCB_1
	ora	<L207+pxTCB_1+2
	bne	*+5
	brl	L215
;            taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;            {
;                if( prvTaskIsTaskSuspended( pxTCB ) != pdFALSE )
;                {
	pei	<L207+pxTCB_1+2
	pei	<L207+pxTCB_1
	jsr	_~prvTaskIsTaskSuspended
	tax
	bne	*+5
	brl	L10254
;                    traceTASK_RESUME( pxTCB );
;
;                    /* The ready list can be accessed even if the scheduler is
;                     * suspended because this is inside a critical section. */
;                    ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	<L207+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L207+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;                    prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L207+pxTCB_1],Y
	bcs	L10248
	lda	[<L207+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10248:
pxIndex_2	set	4
	ldy	#$2c
	lda	[<L207+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L207+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L207+pxIndex_2+2
	lda	<L207+pxIndex_2
	ldy	#$8
	sta	[<L207+pxTCB_1],Y
	lda	<L207+pxIndex_2+2
	iny
	iny
	sta	[<L207+pxTCB_1],Y
	dey
	dey
	lda	[<L207+pxIndex_2],Y
	ldy	#$c
	sta	[<L207+pxTCB_1],Y
	dey
	dey
	lda	[<L207+pxIndex_2],Y
	ldy	#$e
	sta	[<L207+pxTCB_1],Y
	ldy	#$8
	lda	[<L207+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L207+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L207+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L207+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L207+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L207+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L207+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L207+pxIndex_2],Y
	ldy	#$2c
	lda	[<L207+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L207+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L207+pxTCB_1],Y
	ldy	#$2c
	lda	[<L207+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L207+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;                    /* This yield may not cause the task just resumed to run,
;                     * but will leave the lists in the correct state for the
;                     * next yield. */
;                    taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxTCB );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L207+pxTCB_1],Y
	bcs	L10254
	jsl	_~vPortYield
L10254:
;            }
;            taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;        }
;        else
L215:
	lda	<L206+1
	sta	<L206+1+4
	pld
	tsc
	clc
	adc	#L206+4
	tcs
	rts
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskResume();
;    }
L206	equ	20
L207	equ	13
	ends
	efunc
;
;#endif /* INCLUDE_vTaskSuspend */
;
;/*-----------------------------------------------------------*/
;
;#if ( ( INCLUDE_xTaskResumeFromISR == 1 ) && ( INCLUDE_vTaskSuspend == 1 ) )
;
;    BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume )
;    {
	code
	xdef	_~xTaskResumeFromISR
	func
_~xTaskResumeFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L216
	tcs
	phd
	tcd
xTaskToResume_0	set	3
;        BaseType_t xYieldRequired = pdFALSE;
;        TCB_t * const pxTCB = xTaskToResume;
;        UBaseType_t uxSavedInterruptStatus;
;
;        traceENTER_xTaskResumeFromISR( xTaskToResume );
xYieldRequired_1	set	0
pxTCB_1	set	2
uxSavedInterruptStatus_1	set	6
	stz	<L217+xYieldRequired_1
	lda	<L216+xTaskToResume_0
	sta	<L217+pxTCB_1
	lda	<L216+xTaskToResume_0+2
	sta	<L217+pxTCB_1+2
;
;        configASSERT( xTaskToResume );
	lda	<L216+xTaskToResume_0
	ora	<L216+xTaskToResume_0+2
	bne	L10256
	asmstart
	sei
	asmend
L10257:
	bra	L10257
L10256:
;
;        /* RTOS ports that support interrupt nesting have the concept of a
;         * maximum  system call (or maximum API call) interrupt priority.
;         * Interrupts that are  above the maximum system call priority are keep
;         * permanently enabled, even when the RTOS kernel is in a critical section,
;         * but cannot make any calls to FreeRTOS API functions.  If configASSERT()
;         * is defined in FreeRTOSConfig.h then
;         * portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;         * failure if a FreeRTOS API function is called from an interrupt that has
;         * been assigned a priority above the configured maximum system call
;         * priority.  Only FreeRTOS functions that end in FromISR can be called
;         * from interrupts  that have been assigned a priority at or (logically)
;         * below the maximum system call interrupt priority.  FreeRTOS maintains a
;         * separate interrupt safe API to ensure interrupt entry is as fast and as
;         * simple as possible.  More information (albeit Cortex-M specific) is
;         * provided on the following link:
;         * https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;        portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L217+uxSavedInterruptStatus_1
;        {
;            if( prvTaskIsTaskSuspended( pxTCB ) != pdFALSE )
;            {
	pei	<L217+pxTCB_1+2
	pei	<L217+pxTCB_1
	jsr	_~prvTaskIsTaskSuspended
	tax
	bne	*+5
	brl	L10275
;                traceTASK_RESUME_FROM_ISR( pxTCB );
;
;                /* Check the ready lists can be accessed. */
;                if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;                {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	*+5
	brl	L10261
;                    #if ( configNUMBER_OF_CORES == 1 )
;                    {
;                        /* Ready lists can be accessed so move the task from the
;                         * suspended list to the ready list directly. */
;                        if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
;                        {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L217+pxTCB_1],Y
	bcs	L10263
;                            xYieldRequired = pdTRUE;
	lda	#$1
	sta	<L217+xYieldRequired_1
;
;                            /* Mark that a yield is pending in case the user is not
;                             * using the return value to initiate a context switch
;                             * from the ISR using the port specific portYIELD_FROM_ISR(). */
;                            xYieldPendings[ 0 ] = pdTRUE;
	sta	|_~xYieldPendings	; volatile
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
L10263:
;                    }
;                    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;                    ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	<L217+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L217+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;                    prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L217+pxTCB_1],Y
	bcs	L10273
	lda	[<L217+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10273:
pxIndex_2	set	8
	ldy	#$2c
	lda	[<L217+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L217+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L217+pxIndex_2+2
	lda	<L217+pxIndex_2
	ldy	#$8
	sta	[<L217+pxTCB_1],Y
	lda	<L217+pxIndex_2+2
	iny
	iny
	sta	[<L217+pxTCB_1],Y
	dey
	dey
	lda	[<L217+pxIndex_2],Y
	ldy	#$c
	sta	[<L217+pxTCB_1],Y
	dey
	dey
	lda	[<L217+pxIndex_2],Y
	ldy	#$e
	sta	[<L217+pxTCB_1],Y
	ldy	#$8
	lda	[<L217+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L217+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L217+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L217+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L217+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L217+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L217+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L217+pxIndex_2],Y
	ldy	#$2c
	lda	[<L217+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L217+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L217+pxTCB_1],Y
	ldy	#$2c
	lda	[<L217+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L217+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;                }
;                else
L10275:
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_xTaskResumeFromISR( xYieldRequired );
;
;        return xYieldRequired;
	lda	<L217+xYieldRequired_1
	tay
	lda	<L216+1
	sta	<L216+1+4
	pld
	tsc
	clc
	adc	#L216+4
	tcs
	tya
	rts
L10261:
;                {
;                    /* The delayed or ready lists cannot be accessed so the task
;                     * is held in the pending ready list until the scheduler is
;                     * unsuspended. */
;                    vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
	lda	#$18
	clc
	adc	<L217+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L217+pxTCB_1+2
	pha
	pei	<R0
	lda	#<_~xPendingReadyList
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	jsr	_~vListInsertEnd
;                }
;
;                #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_PREEMPTION == 1 ) )
;                {
;                    prvYieldForTask( pxTCB );
;
;                    if( xYieldPendings[ portGET_CORE_ID() ] != pdFALSE )
;                    {
;                        xYieldRequired = pdTRUE;
;                    }
;                }
;                #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_PREEMPTION == 1 ) ) */
;            }
;            else
	bra	L10275
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;    }
L216	equ	24
L217	equ	13
	ends
	efunc
;
;#endif /* ( ( INCLUDE_xTaskResumeFromISR == 1 ) && ( INCLUDE_vTaskSuspend == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;STATIC BaseType_t prvCreateIdleTasks( void )
;{
	code
	func
_~prvCreateIdleTasks:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L224
	tcs
	phd
	tcd
;    BaseType_t xReturn = pdPASS;
;    BaseType_t xCoreID;
;    char cIdleName[ configMAX_TASK_NAME_LEN ] = { 0 };
;    //TaskFunction_t pxIdleTaskFunction = NULL;
;    TaskFunction_t pxIdleTaskFunction = 0;
;    UBaseType_t xIdleTaskNameIndex;
;
;    /* MISRA Ref 14.3.1 [Configuration dependent invariant] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-143. */
;    /* coverity[misra_c_2012_rule_14_3_violation] */
;    for( xIdleTaskNameIndex = 0U; xIdleTaskNameIndex < ( configMAX_TASK_NAME_LEN - taskRESERVED_TASK_NAME_LENGTH ); xIdleTaskNameIndex++ )
xReturn_1	set	0
xCoreID_1	set	2
cIdleName_1	set	4
pxIdleTaskFunction_1	set	20
xIdleTaskNameIndex_1	set	24
	lda	#$1
	sta	<L225+xReturn_1
	pea	#^L226
	pea	#<L226
	clc
	tdc
	adc	#<L225+cIdleName_1
	sta	<R0
	lda	#$0
	pha
	pei	<R0
	lda	#$10
	xref	_~~fmov
	jsr	_~~fmov
	stz	<L225+pxIdleTaskFunction_1
	stz	<L225+pxIdleTaskFunction_1+2
	stz	<L225+xIdleTaskNameIndex_1
L10278:
;    {
;        /* MISRA Ref 18.1.1 [Configuration dependent bounds checking] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-181. */
;        /* coverity[misra_c_2012_rule_18_1_violation] */
;        cIdleName[ xIdleTaskNameIndex ] = configIDLE_TASK_NAME[ xIdleTaskNameIndex ];
	lda	#<L1
	sta	<R0
	lda	#^L1
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L225+xIdleTaskNameIndex_1
	lda	[<R0],Y
	ldx	<L225+xIdleTaskNameIndex_1
	sta	<L225+cIdleName_1,X
	rep	#$20
	longa	on
;
;        if( cIdleName[ xIdleTaskNameIndex ] == ( char ) 0x00 )
;        {
	lda	<L225+cIdleName_1,X
	and	#$ff
	beq	L10277
;            break;
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
	inc	<L225+xIdleTaskNameIndex_1
	lda	<L225+xIdleTaskNameIndex_1
	cmp	#<$f
	bcc	L10278
L10277:
;
;    /* Ensure null termination. */
;    cIdleName[ xIdleTaskNameIndex ] = '\0';
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L225+xIdleTaskNameIndex_1
	sta	<L225+cIdleName_1,X
	rep	#$20
	longa	on
;
;    /* Add each idle task at the lowest priority. */
;    for( xCoreID = ( BaseType_t ) 0; xCoreID < ( BaseType_t ) configNUMBER_OF_CORES; xCoreID++ )
	stz	<L225+xCoreID_1
L10282:
;    {
;        #if ( configNUMBER_OF_CORES == 1 )
;        {
;            pxIdleTaskFunction = &prvIdleTask;
	lda	#<_~prvIdleTask
	sta	<L225+pxIdleTaskFunction_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L225+pxIdleTaskFunction_1+2
;        }
;        #else /* #if (  configNUMBER_OF_CORES == 1 ) */
;        {
;            /* In the FreeRTOS SMP, configNUMBER_OF_CORES - 1 passive idle tasks
;             * are also created to ensure that each core has an idle task to
;             * run when no other task is available to run. */
;            if( xCoreID == 0 )
;            {
;                pxIdleTaskFunction = &prvIdleTask;
;            }
;            else
;            {
;                pxIdleTaskFunction = &prvPassiveIdleTask;
;            }
;        }
;        #endif /* #if (  configNUMBER_OF_CORES == 1 ) */
;
;        /* Update the idle task name with suffix to differentiate the idle tasks.
;         * This function is not required in single core FreeRTOS since there is
;         * only one idle task. */
;        #if ( configNUMBER_OF_CORES > 1 )
;        {
;            /* Append the idle task number to the end of the name.
;             *
;             * Note: Idle task name index only supports single-character
;             * core IDs (0-9). If the core ID exceeds 9, the idle task
;             * name will contain an incorrect ASCII character. This is
;             * acceptable as the task name is used mainly for debugging. */
;            cIdleName[ xIdleTaskNameIndex ] = ( char ) ( xCoreID + '0' );
;            cIdleName[ xIdleTaskNameIndex + 1U ] = '\0';
;        }
;        #endif /* if ( configNUMBER_OF_CORES > 1 ) */
;
;        #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;        {
;            StaticTask_t * pxIdleTaskTCBBuffer = NULL;
;            StackType_t * pxIdleTaskStackBuffer = NULL;
;            configSTACK_DEPTH_TYPE uxIdleTaskStackSize;
;
;            /* The Idle task is created using user provided RAM - obtain the
;             * address of the RAM then create the idle task. */
;            #if ( configNUMBER_OF_CORES == 1 )
;            {
;                vApplicationGetIdleTaskMemory( &pxIdleTaskTCBBuffer, &pxIdleTaskStackBuffer, &uxIdleTaskStackSize );
;            }
;            #else
;            {
;                if( xCoreID == 0 )
;                {
;                    vApplicationGetIdleTaskMemory( &pxIdleTaskTCBBuffer, &pxIdleTaskStackBuffer, &uxIdleTaskStackSize );
;                }
;                else
;                {
;                    vApplicationGetPassiveIdleTaskMemory( &pxIdleTaskTCBBuffer, &pxIdleTaskStackBuffer, &uxIdleTaskStackSize, ( BaseType_t ) ( xCoreID - 1 ) );
;                }
;            }
;            #endif /* if ( configNUMBER_OF_CORES == 1 ) */
;            xIdleTaskHandles[ xCoreID ] = xTaskCreateStatic( pxIdleTaskFunction,
;                                                             cIdleName,
;                                                             uxIdleTaskStackSize,
;                                                             ( void * ) NULL,
;                                                             portPRIVILEGE_BIT, /* In effect ( tskIDLE_PRIORITY | portPRIVILEGE_BIT ), but tskIDLE_PRIORITY is zero. */
;                                                             pxIdleTaskStackBuffer,
;                                                             pxIdleTaskTCBBuffer );
;
;            if( xIdleTaskHandles[ xCoreID ] != NULL )
;            {
;                xReturn = pdPASS;
;            }
;            else
;            {
;                xReturn = pdFAIL;
;            }
;        }
;        #else /* if ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;        {
;            /* The Idle task is being created using dynamically allocated RAM. */
;            xReturn = xTaskCreate( pxIdleTaskFunction,
;                                   cIdleName,
;                                   configMINIMAL_STACK_SIZE,
;                                   ( void * ) NULL,
;                                   portPRIVILEGE_BIT, /* In effect ( tskIDLE_PRIORITY | portPRIVILEGE_BIT ), but tskIDLE_PRIORITY is zero. */
;                                   &xIdleTaskHandles[ xCoreID ] );
	lda	<L225+xCoreID_1
	asl	A
	asl	A
	clc
	adc	#<_~xIdleTaskHandles
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#<$80
	pea	#0
	clc
	tdc
	adc	#<L225+cIdleName_1
	pha
	pei	<L225+pxIdleTaskFunction_1+2
	pei	<L225+pxIdleTaskFunction_1
	jsr	_~xTaskCreate
	sta	<L225+xReturn_1
;        }
;        #endif /* configSUPPORT_STATIC_ALLOCATION */
;
;        /* Break the loop if any of the idle task is failed to be created. */
;        if( xReturn != pdPASS )
;        {
	cmp	#<$1
	bne	L10281
;            break;
;        }
;        else
;        {
;            #if ( configNUMBER_OF_CORES == 1 )
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;            #else
;            {
;                /* Assign idle task to each core before SMP scheduler is running. */
;                xIdleTaskHandles[ xCoreID ]->xTaskRunState = xCoreID;
;                pxCurrentTCBs[ xCoreID ] = xIdleTaskHandles[ xCoreID ];
;                #if ( ( configIDLE_AFFINITY == 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;                {
;                    xIdleTaskHandles[ xCoreID ]->uxCoreAffinityMask = ( ( UBaseType_t ) 1U << ( UBaseType_t ) xCoreID );
;                }
;                #endif /* #if ( ( configIDLE_AFFINITY == 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;            }
;            #endif /* if ( configNUMBER_OF_CORES == 1 ) */
;        }
;    }
	inc	<L225+xCoreID_1
	lda	<L225+xCoreID_1
	bmi	L10282
	dea
	bmi	L10282
L10281:
;
;    return xReturn;
	lda	<L225+xReturn_1
	tay
	pld
	tsc
	clc
	adc	#L224
	tcs
	tya
	rts
;}
L224	equ	38
L225	equ	13
	ends
	efunc
	data
L226:
	db	$0
	ds	15
	ends
	data
L1:
	db	$49,$44,$4C,$45,$00
	ends
;
;/*-----------------------------------------------------------*/
;
;void vTaskStartScheduler( void )
;{
	code
	xdef	_~vTaskStartScheduler
	func
_~vTaskStartScheduler:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L234
	tcs
	phd
	tcd
;    BaseType_t xReturn;
;
;    traceENTER_vTaskStartScheduler();
xReturn_1	set	0
;
;    #if ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 )
;    {
;        /* Sanity check that the UBaseType_t must have greater than or equal to
;         * the number of bits as confNUMBER_OF_CORES. */
;        configASSERT( ( sizeof( UBaseType_t ) * taskBITS_PER_BYTE ) >= configNUMBER_OF_CORES );
;    }
;    #endif /* #if ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 ) */
;
;    xReturn = prvCreateIdleTasks();
	jsr	_~prvCreateIdleTasks
	sta	<L235+xReturn_1
;
;    #if ( configUSE_TIMERS == 1 )
;    {
;        if( xReturn == pdPASS )
;        {
;            xReturn = xTimerCreateTimerTask();
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    #endif /* configUSE_TIMERS */
;
;    if( xReturn == pdPASS )
;    {
	cmp	#<$1
	bne	L10284
;        /* freertos_tasks_c_additions_init() should only be called if the user
;         * definable macro FREERTOS_TASKS_C_ADDITIONS_INIT() is defined, as that is
;         * the only macro called by the function. */
;        #ifdef FREERTOS_TASKS_C_ADDITIONS_INIT
;        {
;            freertos_tasks_c_additions_init();
;        }
;        #endif
;
;        /* Interrupts are turned off here, to ensure a tick does not occur
;         * before or during the call to xPortStartScheduler().  The stacks of
;         * the created tasks contain a status word with interrupts switched on
;         * so interrupts will automatically get re-enabled when the first task
;         * starts to run. */
;        portDISABLE_INTERRUPTS();
	asmstart
	sei
	asmend
;
;        #if ( configUSE_C_RUNTIME_TLS_SUPPORT == 1 )
;        {
;            /* Switch C-Runtime's TLS Block to point to the TLS
;             * block specific to the task that will run first. */
;            configSET_TLS_BLOCK( pxCurrentTCB->xTLSBlock );
;        }
;        #endif
;
;        xNextTaskUnblockTime = portMAX_DELAY;
	lda	#$ffff
	sta	|_~xNextTaskUnblockTime	; volatile
	sta	|_~xNextTaskUnblockTime+2	; volatile
;        xSchedulerRunning = pdTRUE;
	lda	#$1
	sta	|_~xSchedulerRunning	; volatile
;        xTickCount = ( TickType_t ) configINITIAL_TICK_COUNT;
	stz	|_~xTickCount	; volatile
	stz	|_~xTickCount+2	; volatile
;
;        /* If configGENERATE_RUN_TIME_STATS is defined then the following
;         * macro must be defined to configure the timer/counter used to generate
;         * the run time counter time base.   NOTE:  If configGENERATE_RUN_TIME_STATS
;         * is set to 0 and the following line fails to build then ensure you do not
;         * have portCONFIGURE_TIMER_FOR_RUN_TIME_STATS() defined in your
;         * FreeRTOSConfig.h file. */
;        portCONFIGURE_TIMER_FOR_RUN_TIME_STATS();
;
;        traceTASK_SWITCHED_IN();
;
;        traceSTARTING_SCHEDULER( xIdleTaskHandles );
;
;        /* Setting up the timer tick is hardware specific and thus in the
;         * portable interface. */
;
;        /* The return value for xPortStartScheduler is not required
;         * hence using a void datatype. */
;        ( void ) xPortStartScheduler();
	jsr	_~xPortStartScheduler
;
;        /* In most cases, xPortStartScheduler() will not return. If it
;         * returns pdTRUE then there was not enough heap memory available
;         * to create either the Idle or the Timer task. If it returned
;         * pdFALSE, then the application called xTaskEndScheduler().
;         * Most ports don't implement xTaskEndScheduler() as there is
;         * nothing to return to. */
;    }
;    else
L238:
	pld
	tsc
	clc
	adc	#L234
	tcs
	rts
L10284:
;    {
;        /* This line will only be reached if the kernel could not be started,
;         * because there was not enough FreeRTOS heap to create the idle task
;         * or the timer task. */
;        configASSERT( xReturn != errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY );
	lda	<L235+xReturn_1
	cmp	#<$ffffffff
	bne	L238
	asmstart
	sei
	asmend
L10287:
	bra	L10287
;    }
;
;    /* Prevent compiler warnings if INCLUDE_xTaskGetIdleTaskHandle is set to 0,
;     * meaning xIdleTaskHandles are not used anywhere else. */
;    ( void ) xIdleTaskHandles;
;
;    /* OpenOCD makes use of uxTopUsedPriority for thread debugging. Prevent uxTopUsedPriority
;     * from getting optimized out as it is no longer used by the kernel. */
;    ( void ) uxTopUsedPriority;
;
;    traceRETURN_vTaskStartScheduler();
;}
L234	equ	6
L235	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vTaskEndScheduler( void )
;{
	code
	xdef	_~vTaskEndScheduler
	func
_~vTaskEndScheduler:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L239
	tcs
	phd
	tcd
;    traceENTER_vTaskEndScheduler();
;
;    #if ( INCLUDE_vTaskDelete == 1 )
;    {
;        BaseType_t xCoreID;
;
;        #if ( configUSE_TIMERS == 1 )
;        {
;            /* Delete the timer task created by the kernel. */
;            vTaskDelete( xTimerGetTimerDaemonTaskHandle() );
;        }
;        #endif /* #if ( configUSE_TIMERS == 1 ) */
;
;        /* Delete Idle tasks created by the kernel.*/
;        for( xCoreID = 0; xCoreID < ( BaseType_t ) configNUMBER_OF_CORES; xCoreID++ )
xCoreID_2	set	0
	stz	<L240+xCoreID_2
L10292:
;        {
;            vTaskDelete( xIdleTaskHandles[ xCoreID ] );
	lda	<L240+xCoreID_2
	asl	A
	asl	A
	clc
	adc	#<_~xIdleTaskHandles
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsr	_~vTaskDelete
;        }
	inc	<L240+xCoreID_2
	lda	<L240+xCoreID_2
	bmi	L10292
	dea
	bmi	L10292
;
;        /* Idle task is responsible for reclaiming the resources of the tasks in
;         * xTasksWaitingTermination list. Since the idle task is now deleted and
;         * no longer going to run, we need to reclaim resources of all the tasks
;         * in the xTasksWaitingTermination list. */
;        prvCheckTasksWaitingTermination();
	jsr	_~prvCheckTasksWaitingTermination
;    }
;    #endif /* #if ( INCLUDE_vTaskDelete == 1 ) */
;
;    /* Stop the scheduler interrupts and call the portable scheduler end
;     * routine so the original ISRs can be restored if necessary.  The port
;     * layer must ensure interrupts enable  bit is left in the correct state. */
;    portDISABLE_INTERRUPTS();
	asmstart
	sei
	asmend
;    xSchedulerRunning = pdFALSE;
	stz	|_~xSchedulerRunning	; volatile
;
;    /* This function must be called from a task and the application is
;     * responsible for deleting that task after the scheduler is stopped. */
;    vPortEndScheduler();
	jsr	_~vPortEndScheduler
;
;    traceRETURN_vTaskEndScheduler();
;}
	pld
	tsc
	clc
	adc	#L239
	tcs
	rts
L239	equ	10
L240	equ	9
	ends
	efunc
;/*----------------------------------------------------------*/
;
;void vTaskSuspendAll( void )
;{
	code
	xdef	_~vTaskSuspendAll
	func
_~vTaskSuspendAll:
	longa	on
	longi	on
;    traceENTER_vTaskSuspendAll();
;
;    #if ( configNUMBER_OF_CORES == 1 )
;    {
;        /* A critical section is not required as the variable is of type
;         * BaseType_t. Each task maintains its own context, and a context switch
;         * cannot occur if the variable is non zero. So, as long as the writing
;         * from the register back into the memory is atomic, it is not a
;         * problem.
;         *
;         * Consider the following scenario, which starts with
;         * uxSchedulerSuspended at zero.
;         *
;         * 1. load uxSchedulerSuspended into register.
;         * 2. Now a context switch causes another task to run, and the other
;         *    task uses the same variable. The other task will see the variable
;         *    as zero because the variable has not yet been updated by the
;         *    original task. Eventually the original task runs again. **That can
;         *    only happen when uxSchedulerSuspended is once again zero**. When
;         *    the original task runs again, the contents of the CPU registers
;         *    are restored to exactly how they were when it was switched out -
;         *    therefore the value it read into the register still matches the
;         *    value of the uxSchedulerSuspended variable.
;         *
;         * 3. increment register.
;         * 4. store register into uxSchedulerSuspended. The value restored to
;         *    uxSchedulerSuspended will be the correct value of 1, even though
;         *    the variable was used by other tasks in the mean time.
;         */
;
;        /* portSOFTWARE_BARRIER() is only implemented for emulated/simulated ports that
;         * do not otherwise exhibit real time behaviour. */
;        portSOFTWARE_BARRIER();
;
;        /* The scheduler is suspended if uxSchedulerSuspended is non-zero.  An increment
;         * is used to allow calls to vTaskSuspendAll() to nest. */
;        uxSchedulerSuspended = ( UBaseType_t ) ( uxSchedulerSuspended + 1U );
	inc	|_~uxSchedulerSuspended	; volatile
;
;        /* Enforces ordering for ports and optimised compilers that may otherwise place
;         * the above increment elsewhere. */
;        portMEMORY_BARRIER();
;    }
;    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;    {
;        UBaseType_t ulState;
;        BaseType_t xCoreID;
;
;        /* This must only be called from within a task. */
;        portASSERT_IF_IN_ISR();
;
;        if( xSchedulerRunning != pdFALSE )
;        {
;            /* Writes to uxSchedulerSuspended must be protected by both the task AND ISR locks.
;             * We must disable interrupts before we grab the locks in the event that this task is
;             * interrupted and switches context before incrementing uxSchedulerSuspended.
;             * It is safe to re-enable interrupts after releasing the ISR lock and incrementing
;             * uxSchedulerSuspended since that will prevent context switches. */
;            ulState = portSET_INTERRUPT_MASK();
;
;            xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;            /* This must never be called from inside a critical section. */
;            configASSERT( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0 );
;
;            /* portSOFTWARE_BARRIER() is only implemented for emulated/simulated ports that
;             * do not otherwise exhibit real time behaviour. */
;            portSOFTWARE_BARRIER();
;
;            portGET_TASK_LOCK( xCoreID );
;
;            /* uxSchedulerSuspended is increased after prvCheckForRunStateChange. The
;             * purpose is to prevent altering the variable when fromISR APIs are readying
;             * it. */
;            if( uxSchedulerSuspended == 0U )
;            {
;                prvCheckForRunStateChange();
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;
;            /* Query the coreID again as prvCheckForRunStateChange may have
;             * caused the task to get scheduled on a different core. The correct
;             * task lock for the core is acquired in prvCheckForRunStateChange. */
;            xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;            portGET_ISR_LOCK( xCoreID );
;
;            /* The scheduler is suspended if uxSchedulerSuspended is non-zero. An increment
;             * is used to allow calls to vTaskSuspendAll() to nest. */
;            ++uxSchedulerSuspended;
;            portRELEASE_ISR_LOCK( xCoreID );
;
;            portCLEAR_INTERRUPT_MASK( ulState );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;    traceRETURN_vTaskSuspendAll();
;}
	rts
L244	equ	0
L245	equ	1
	ends
	efunc
;
;/*----------------------------------------------------------*/
;
;#if ( configUSE_TICKLESS_IDLE != 0 )
;
;    STATIC TickType_t prvGetExpectedIdleTime( void )
;    {
;        TickType_t xReturn;
;        BaseType_t xHigherPriorityReadyTasks = pdFALSE;
;
;        /* xHigherPriorityReadyTasks takes care of the case where
;         * configUSE_PREEMPTION is 0, so there may be tasks above the idle priority
;         * task that are in the Ready state, even though the idle task is
;         * running. */
;        #if ( configUSE_PORT_OPTIMISED_TASK_SELECTION == 0 )
;        {
;            if( uxTopReadyPriority > tskIDLE_PRIORITY )
;            {
;                xHigherPriorityReadyTasks = pdTRUE;
;            }
;        }
;        #else
;        {
;            const UBaseType_t uxLeastSignificantBit = ( UBaseType_t ) 0x01;
;
;            /* When port optimised task selection is used the uxTopReadyPriority
;             * variable is used as a bit map.  If bits other than the least
;             * significant bit are set then there are tasks that have a priority
;             * above the idle priority that are in the Ready state.  This takes
;             * care of the case where the co-operative scheduler is in use. */
;            if( uxTopReadyPriority > uxLeastSignificantBit )
;            {
;                xHigherPriorityReadyTasks = pdTRUE;
;            }
;        }
;        #endif /* if ( configUSE_PORT_OPTIMISED_TASK_SELECTION == 0 ) */
;
;        if( pxCurrentTCB->uxPriority > tskIDLE_PRIORITY )
;        {
;            xReturn = 0;
;        }
;        else if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ tskIDLE_PRIORITY ] ) ) > 1U )
;        {
;            /* There are other idle priority tasks in the ready state.  If
;             * time slicing is used then the very next tick interrupt must be
;             * processed. */
;            xReturn = 0;
;        }
;        else if( xHigherPriorityReadyTasks != pdFALSE )
;        {
;            /* There are tasks in the Ready state that have a priority above the
;             * idle priority.  This path can only be reached if
;             * configUSE_PREEMPTION is 0. */
;            xReturn = 0;
;        }
;        else
;        {
;            xReturn = xNextTaskUnblockTime;
;            xReturn -= xTickCount;
;        }
;
;        return xReturn;
;    }
;
;#endif /* configUSE_TICKLESS_IDLE */
;/*----------------------------------------------------------*/
;
;BaseType_t xTaskResumeAll( void )
;{
	code
	xdef	_~xTaskResumeAll
	func
_~xTaskResumeAll:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L247
	tcs
	phd
	tcd
;    TCB_t * pxTCB = NULL;
;    BaseType_t xAlreadyYielded = pdFALSE;
;
;    traceENTER_xTaskResumeAll();
pxTCB_1	set	0
xAlreadyYielded_1	set	4
	stz	<L248+pxTCB_1
	stz	<L248+pxTCB_1+2
	stz	<L248+xAlreadyYielded_1
;
;    #if ( configNUMBER_OF_CORES > 1 )
;        if( xSchedulerRunning != pdFALSE )
;    #endif
;    {
;        /* It is possible that an ISR caused a task to be removed from an event
;         * list while the scheduler was suspended.  If this was the case then the
;         * removed task will have been added to the xPendingReadyList.  Once the
;         * scheduler has been resumed it is safe to move all the pending ready
;         * tasks from this list into their appropriate ready list. */
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            const BaseType_t xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;            /* If uxSchedulerSuspended is zero then this function does not match a
;             * previous call to vTaskSuspendAll(). */
;            configASSERT( uxSchedulerSuspended != 0U );
xCoreID_2	set	6
	stz	<L248+xCoreID_2
	lda	|_~uxSchedulerSuspended	; volatile
	bne	L10293
	asmstart
	sei
	asmend
L10294:
	bra	L10294
L10293:
;
;            uxSchedulerSuspended = ( UBaseType_t ) ( uxSchedulerSuspended - 1U );
	dec	|_~uxSchedulerSuspended	; volatile
;            portRELEASE_TASK_LOCK( xCoreID );
;
;            if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;            {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	*+5
	brl	L10334
;                if( uxCurrentNumberOfTasks > ( UBaseType_t ) 0U )
;                {
	lda	#$0
	cmp	|_~uxCurrentNumberOfTasks	; volatile
	bcs	*+5
	brl	L10299
;                    /* Move any readied tasks from the pending list into the
;                     * appropriate ready list. */
;                    while( listLIST_IS_EMPTY( &xPendingReadyList ) == pdFALSE )
	brl	L10334
L20023:
	lda	#$1
	brl	L254
L20021:
;                    {
;                        /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                        /* coverity[misra_c_2012_rule_11_5_violation] */
;                        pxTCB = listGET_OWNER_OF_HEAD_ENTRY( ( &xPendingReadyList ) );
	lda	|_~xPendingReadyList+10
	sta	<R0
	lda	|_~xPendingReadyList+10+2
	sta	<R0+2
	ldy	#$c
	lda	[<R0],Y
	sta	<L248+pxTCB_1
	iny
	iny
	lda	[<R0],Y
	sta	<L248+pxTCB_1+2
;                        listREMOVE_ITEM( &( pxTCB->xEventListItem ) );
pxList_3	set	8
	ldy	#$28
	lda	[<L248+pxTCB_1],Y
	sta	<L248+pxList_3
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<L248+pxList_3+2
	ldy	#$1c
	lda	[<L248+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$22
	lda	[<L248+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	ldy	#$20
	lda	[<L248+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<R0+2
	ldy	#$1c
	lda	[<L248+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$1e
	lda	[<L248+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$18
	clc
	adc	<L248+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L248+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L248+pxList_3],Y
	cmp	<R0
	bne	L256
	iny
	iny
	lda	[<L248+pxList_3],Y
	cmp	<R0+2
L256:
	bne	L10304
	ldy	#$20
	lda	[<L248+pxTCB_1],Y
	ldy	#$2
	sta	[<L248+pxList_3],Y
	ldy	#$22
	lda	[<L248+pxTCB_1],Y
	ldy	#$4
	sta	[<L248+pxList_3],Y
L10304:
	lda	#$0
	ldy	#$28
	sta	[<L248+pxTCB_1],Y
	iny
	iny
	sta	[<L248+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L248+pxList_3]
	sta	[<L248+pxList_3]
;                        portMEMORY_BARRIER();
;                        listREMOVE_ITEM( &( pxTCB->xStateListItem ) );
pxList_4	set	8
	ldy	#$14
	lda	[<L248+pxTCB_1],Y
	sta	<L248+pxList_4
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<L248+pxList_4+2
	ldy	#$8
	lda	[<L248+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L248+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L248+pxTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L248+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L248+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L248+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L248+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L248+pxList_4],Y
	cmp	<R0
	bne	L258
	iny
	iny
	lda	[<L248+pxList_4],Y
	cmp	<R0+2
L258:
	bne	L10308
	ldy	#$c
	lda	[<L248+pxTCB_1],Y
	ldy	#$2
	sta	[<L248+pxList_4],Y
	ldy	#$e
	lda	[<L248+pxTCB_1],Y
	ldy	#$4
	sta	[<L248+pxList_4],Y
L10308:
	lda	#$0
	ldy	#$14
	sta	[<L248+pxTCB_1],Y
	iny
	iny
	sta	[<L248+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L248+pxList_4]
	sta	[<L248+pxList_4]
;                        prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L248+pxTCB_1],Y
	bcs	L10318
	lda	[<L248+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10318:
pxIndex_5	set	8
	ldy	#$2c
	lda	[<L248+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L248+pxIndex_5
	ldy	#$2
	lda	(<R2),Y
	sta	<L248+pxIndex_5+2
	lda	<L248+pxIndex_5
	ldy	#$8
	sta	[<L248+pxTCB_1],Y
	lda	<L248+pxIndex_5+2
	iny
	iny
	sta	[<L248+pxTCB_1],Y
	dey
	dey
	lda	[<L248+pxIndex_5],Y
	ldy	#$c
	sta	[<L248+pxTCB_1],Y
	dey
	dey
	lda	[<L248+pxIndex_5],Y
	ldy	#$e
	sta	[<L248+pxTCB_1],Y
	ldy	#$8
	lda	[<L248+pxIndex_5],Y
	sta	<R0
	iny
	iny
	lda	[<L248+pxIndex_5],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L248+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L248+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L248+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L248+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L248+pxIndex_5],Y
	lda	<R0+2
	iny
	iny
	sta	[<L248+pxIndex_5],Y
	ldy	#$2c
	lda	[<L248+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L248+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L248+pxTCB_1],Y
	ldy	#$2c
	lda	[<L248+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L248+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;                        #if ( configNUMBER_OF_CORES == 1 )
;                        {
;                            /* If the moved task has a priority higher than the current
;                             * task then a yield must be performed. */
;                            if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
;                            {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L248+pxTCB_1],Y
	bcs	L10299
;                                xYieldPendings[ xCoreID ] = pdTRUE;
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;                            }
;                            else
;                        }
;                        #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                        {
;                            /* All appropriate tasks yield at the moment a task is added to xPendingReadyList.
;                             * If the current core yielded then vTaskSwitchContext() has already been called
;                             * which sets xYieldPendings for the current core to pdTRUE. */
;                        }
;                        #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;                    }
L10299:
	lda	|_~xPendingReadyList
	bne	*+5
	brl	L20023
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
	lda	#$0
L254:
	tax
	bne	*+5
	brl	L20021
;
;                    if( pxTCB != NULL )
;                    {
	lda	<L248+pxTCB_1
	ora	<L248+pxTCB_1+2
	beq	L10321
;                        /* A task was unblocked while the scheduler was suspended,
;                         * which may have prevented the next unblock time from being
;                         * re-calculated, in which case re-calculate it now.  Mainly
;                         * important for low power tickless implementations, where
;                         * this can prevent an unnecessary exit from low power
;                         * state. */
;                        prvResetNextTaskUnblockTime();
	jsr	_~prvResetNextTaskUnblockTime
;                    }
;
;                    /* If any ticks occurred while the scheduler was suspended then
;                     * they should be processed now.  This ensures the tick count does
;                     * not  slip, and that any delayed tasks are resumed at the correct
;                     * time.
;                     *
;                     * It should be safe to call xTaskIncrementTick here from any core
;                     * since we are in a critical section and xTaskIncrementTick itself
;                     * protects itself within a critical section. Suspending the scheduler
;                     * from any core causes xTaskIncrementTick to increment uxPendedCounts. */
;                    {
L10321:
;                        TickType_t xPendedCounts = xPendedTicks; /* Non-volatile copy. */
;
;                        if( xPendedCounts > ( TickType_t ) 0U )
xPendedCounts_6	set	8
	lda	|_~xPendedTicks	; volatile
	sta	<L248+xPendedCounts_6
	lda	|_~xPendedTicks+2	; volatile
	sta	<L248+xPendedCounts_6+2
;                        {
	lda	#$0
	cmp	<L248+xPendedCounts_6
	sbc	<L248+xPendedCounts_6+2
	bcs	L10328
;                            do
L10325:
;                            {
;                                if( xTaskIncrementTick() != pdFALSE )
;                                {
	jsr	_~xTaskIncrementTick
	tax
	beq	L10327
;                                    /* Other cores are interrupted from
;                                     * within xTaskIncrementTick(). */
;                                    xYieldPendings[ xCoreID ] = pdTRUE;
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;                                }
;                                else
;                                {
;                                    mtCOVERAGE_TEST_MARKER();
;                                }
L10327:
;
;                                --xPendedCounts;
	lda	<L248+xPendedCounts_6
	bne	L265
	dec	<L248+xPendedCounts_6+2
L265:
	dec	<L248+xPendedCounts_6
;                            } while( xPendedCounts > ( TickType_t ) 0U );
	lda	#$0
	cmp	<L248+xPendedCounts_6
	sbc	<L248+xPendedCounts_6+2
	bcc	L10325
;
;                            xPendedTicks = 0;
	stz	|_~xPendedTicks	; volatile
	stz	|_~xPendedTicks+2	; volatile
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
L10328:
;                    }
;
;                    if( xYieldPendings[ xCoreID ] != pdFALSE )
;                    {
	lda	|_~xYieldPendings	; volatile
	beq	L10334
;                        #if ( configUSE_PREEMPTION != 0 )
;                        {
;                            xAlreadyYielded = pdTRUE;
	lda	#$1
	sta	<L248+xAlreadyYielded_1
;                        }
;                        #endif /* #if ( configUSE_PREEMPTION != 0 ) */
;
;                        #if ( configNUMBER_OF_CORES == 1 )
;                        {
;                            taskYIELD_TASK_CORE_IF_USING_PREEMPTION( pxCurrentTCB );
	jsl	_~vPortYield
;                        }
;                        #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;                    }
;                    else
L10334:
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;    }
;
;    traceRETURN_xTaskResumeAll( xAlreadyYielded );
;
;    return xAlreadyYielded;
	lda	<L248+xAlreadyYielded_1
	tay
	pld
	tsc
	clc
	adc	#L247
	tcs
	tya
	rts
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;}
L247	equ	24
L248	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;TickType_t xTaskGetTickCount( void )
;{
	code
	xdef	_~xTaskGetTickCount
	func
_~xTaskGetTickCount:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L269
	tcs
	phd
	tcd
;    TickType_t xTicks;
;
;    traceENTER_xTaskGetTickCount();
xTicks_1	set	0
;
;    /* Critical section required if running on a 16 bit processor. */
;    portTICK_TYPE_ENTER_CRITICAL();
	asmstart
	sei
	asmend
;    {
;        xTicks = xTickCount;
	lda	|_~xTickCount	; volatile
	sta	<L270+xTicks_1
	lda	|_~xTickCount+2	; volatile
	sta	<L270+xTicks_1+2
;    }
;    portTICK_TYPE_EXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;    traceRETURN_xTaskGetTickCount( xTicks );
;
;    return xTicks;
	ldx	<L270+xTicks_1+2
	lda	<L270+xTicks_1
	tay
	pld
	tsc
	clc
	adc	#L269
	tcs
	tya
	rts
;}
L269	equ	4
L270	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;TickType_t xTaskGetTickCountFromISR( void )
;{
	code
	xdef	_~xTaskGetTickCountFromISR
	func
_~xTaskGetTickCountFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L272
	tcs
	phd
	tcd
;    TickType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;
;    traceENTER_xTaskGetTickCountFromISR();
xReturn_1	set	0
uxSavedInterruptStatus_1	set	4
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
;     * system call  interrupt priority.  FreeRTOS maintains a separate interrupt
;     * safe API to ensure interrupt entry is as fast and as simple as possible.
;     * More information (albeit Cortex-M specific) is provided on the following
;     * link: https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;    portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;    uxSavedInterruptStatus = portTICK_TYPE_SET_INTERRUPT_MASK_FROM_ISR();
	stz	<L273+uxSavedInterruptStatus_1
;    {
;        xReturn = xTickCount;
	lda	|_~xTickCount	; volatile
	sta	<L273+xReturn_1
	lda	|_~xTickCount+2	; volatile
	sta	<L273+xReturn_1+2
;    }
;    portTICK_TYPE_CLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xTaskGetTickCountFromISR( xReturn );
;
;    return xReturn;
	ldx	<L273+xReturn_1+2
	lda	<L273+xReturn_1
	tay
	pld
	tsc
	clc
	adc	#L272
	tcs
	tya
	rts
;}
L272	equ	6
L273	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxTaskGetNumberOfTasks( void )
;{
	code
	xdef	_~uxTaskGetNumberOfTasks
	func
_~uxTaskGetNumberOfTasks:
	longa	on
	longi	on
;    traceENTER_uxTaskGetNumberOfTasks();
;
;    /* A critical section is not required because the variables are of type
;     * BaseType_t. */
;    traceRETURN_uxTaskGetNumberOfTasks( uxCurrentNumberOfTasks );
;
;    return uxCurrentNumberOfTasks;
	lda	|_~uxCurrentNumberOfTasks	; volatile
	rts
;}
L275	equ	0
L276	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;char * pcTaskGetName( TaskHandle_t xTaskToQuery )
;{
	code
	xdef	_~pcTaskGetName
	func
_~pcTaskGetName:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L278
	tcs
	phd
	tcd
xTaskToQuery_0	set	3
;    TCB_t * pxTCB;
;
;    traceENTER_pcTaskGetName( xTaskToQuery );
pxTCB_1	set	0
;
;    /* If null is passed in here then the name of the calling task is being
;     * queried. */
;    pxTCB = prvGetTCBFromHandle( xTaskToQuery );
	lda	<L278+xTaskToQuery_0
	ora	<L278+xTaskToQuery_0+2
	bne	L280
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L282
L280:
	ldx	<L278+xTaskToQuery_0+2
	lda	<L278+xTaskToQuery_0
L282:
	stx	<R0+2
	sta	<L279+pxTCB_1
	lda	<R0+2
	sta	<L279+pxTCB_1+2
;    configASSERT( pxTCB != NULL );
	lda	<L279+pxTCB_1
	ora	<L279+pxTCB_1+2
	bne	L10335
	asmstart
	sei
	asmend
L10336:
	bra	L10336
L10335:
;
;    traceRETURN_pcTaskGetName( &( pxTCB->pcTaskName[ 0 ] ) );
;
;    return &( pxTCB->pcTaskName[ 0 ] );
	lda	#$32
	clc
	adc	<L279+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L279+pxTCB_1+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	tay
	lda	<L278+1
	sta	<L278+1+4
	pld
	tsc
	clc
	adc	#L278+4
	tcs
	tya
	rts
;}
L278	equ	8
L279	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_xTaskGetHandle == 1 )
;    STATIC TCB_t * prvSearchForNameWithinSingleList( List_t * pxList,
;                                                     const char pcNameToQuery[] )
;    {
	code
	func
_~prvSearchForNameWithinSingleList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L285
	tcs
	phd
	tcd
pxList_0	set	3
pcNameToQuery_0	set	7
;        TCB_t * pxReturn = NULL;
;        TCB_t * pxTCB = NULL;
;        UBaseType_t x;
;        char cNextChar;
;        BaseType_t xBreakLoop;
;        const ListItem_t * pxEndMarker = listGET_END_MARKER( pxList );
;        ListItem_t * pxIterator;
;
;        /* This function is called with the scheduler suspended. */
;
;        if( listCURRENT_LIST_LENGTH( pxList ) > ( UBaseType_t ) 0 )
pxReturn_1	set	0
pxTCB_1	set	4
x_1	set	8
cNextChar_1	set	10
xBreakLoop_1	set	11
pxEndMarker_1	set	13
pxIterator_1	set	17
	stz	<L286+pxReturn_1
	stz	<L286+pxReturn_1+2
	stz	<L286+pxTCB_1
	stz	<L286+pxTCB_1+2
	lda	#$6
	clc
	adc	<L285+pxList_0
	sta	<L286+pxEndMarker_1
	lda	#$0
	adc	<L285+pxList_0+2
	sta	<L286+pxEndMarker_1+2
;        {
	lda	#$0
	cmp	[<L285+pxList_0]
	bcs	L10353
;            for( pxIterator = listGET_HEAD_ENTRY( pxList ); pxIterator != pxEndMarker; pxIterator = listGET_NEXT( pxIterator ) )
	ldy	#$a
	lda	[<L285+pxList_0],Y
	sta	<L286+pxIterator_1
	iny
	iny
	lda	[<L285+pxList_0],Y
	bra	L20024
L20031:
;                    /* The handle has been found. */
;                    break;
;                }
;            }
	ldy	#$4
	lda	[<L286+pxIterator_1],Y
	sta	<R0
	iny
	iny
	lda	[<L286+pxIterator_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L286+pxIterator_1
	lda	<R0+2
L20024:
	sta	<L286+pxIterator_1+2
	lda	<L286+pxIterator_1
	cmp	<L286+pxEndMarker_1
	bne	L293
	lda	<L286+pxIterator_1+2
	cmp	<L286+pxEndMarker_1+2
L293:
	beq	L10353
;            {
;                /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                /* coverity[misra_c_2012_rule_11_5_violation] */
;                pxTCB = listGET_LIST_ITEM_OWNER( pxIterator );
	ldy	#$c
	lda	[<L286+pxIterator_1],Y
	sta	<L286+pxTCB_1
	iny
	iny
	lda	[<L286+pxIterator_1],Y
	sta	<L286+pxTCB_1+2
;
;                /* Check each character in the name looking for a match or
;                 * mismatch. */
;                xBreakLoop = pdFALSE;
	stz	<L286+xBreakLoop_1
;
;                for( x = ( UBaseType_t ) 0; x < ( UBaseType_t ) configMAX_TASK_NAME_LEN; x++ )
	stz	<L286+x_1
	bra	L10346
L20029:
	inc	<L286+x_1
	lda	<L286+x_1
	cmp	#<$10
	bcs	L10345
L10346:
;                {
;                    cNextChar = pxTCB->pcTaskName[ x ];
	lda	#$32
	clc
	adc	<L286+x_1
	tay
	sep	#$20
	longa	off
	lda	[<L286+pxTCB_1],Y
	sta	<L286+cNextChar_1
;
;                    if( cNextChar != pcNameToQuery[ x ] )
;                    {
	ldy	<L286+x_1
	lda	[<L285+pcNameToQuery_0],Y
	cmp	<L286+cNextChar_1
	rep	#$20
	longa	on
	bne	L20026
;                    {
	lda	<L286+cNextChar_1
	and	#$ff
	bne	L10348
;                        /* Both strings terminated, a match must have been
;                         * found. */
;                        pxReturn = pxTCB;
	lda	<L286+pxTCB_1
	sta	<L286+pxReturn_1
	lda	<L286+pxTCB_1+2
	sta	<L286+pxReturn_1+2
;                        xBreakLoop = pdTRUE;
L20026:
;                        /* Characters didn't match. */
;                        xBreakLoop = pdTRUE;
	lda	#$1
	sta	<L286+xBreakLoop_1
;                    }
;                    else if( cNextChar == ( char ) 0x00 )
L10348:
;
;                    if( xBreakLoop != pdFALSE )
;                    {
	lda	<L286+xBreakLoop_1
	beq	L20029
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                        break;
;                    }
;                }
L10345:
;
;                if( pxReturn != NULL )
;                {
	lda	<L286+pxReturn_1
	ora	<L286+pxReturn_1+2
	beq	L20031
;                    }
;                    else
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10353:
;
;        return pxReturn;
	ldx	<L286+pxReturn_1+2
	lda	<L286+pxReturn_1
	tay
	lda	<L285+1
	sta	<L285+1+8
	pld
	tsc
	clc
	adc	#L285+8
	tcs
	tya
	rts
;    }
L285	equ	25
L286	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_xTaskGetHandle */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_xTaskGetHandle == 1 )
;
;    TaskHandle_t xTaskGetHandle( const char * pcNameToQuery )
;    {
	code
	xdef	_~xTaskGetHandle
	func
_~xTaskGetHandle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L296
	tcs
	phd
	tcd
pcNameToQuery_0	set	3
;        UBaseType_t uxQueue = configMAX_PRIORITIES;
;        TCB_t * pxTCB;
;
;        traceENTER_xTaskGetHandle( pcNameToQuery );
uxQueue_1	set	0
pxTCB_1	set	2
	lda	#$5
	sta	<L297+uxQueue_1
;
;        /* Task names will be truncated to configMAX_TASK_NAME_LEN - 1 bytes. */
;        configASSERT( strlen( pcNameToQuery ) < configMAX_TASK_NAME_LEN );
	pei	<L296+pcNameToQuery_0+2
	pei	<L296+pcNameToQuery_0
	jsr	_~strlen
	cmp	#<$10
	bcc	L10354
	asmstart
	sei
	asmend
L10355:
	bra	L10355
L10354:
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            /* Search the ready lists. */
;            do
L10360:
;            {
;                uxQueue--;
	dec	<L297+uxQueue_1
;                pxTCB = prvSearchForNameWithinSingleList( ( List_t * ) &( pxReadyTasksLists[ uxQueue ] ), pcNameToQuery );
	pei	<L296+pcNameToQuery_0+2
	pei	<L296+pcNameToQuery_0
	lda	<L297+uxQueue_1
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~prvSearchForNameWithinSingleList
	sta	<L297+pxTCB_1
	stx	<L297+pxTCB_1+2
;
;                if( pxTCB != NULL )
;                {
	ora	<L297+pxTCB_1+2
	bne	L10359
;                    /* Found the handle. */
;                    break;
;                }
;            } while( uxQueue > ( UBaseType_t ) tskIDLE_PRIORITY );
	lda	#$0
	cmp	<L297+uxQueue_1
	bcc	L10360
L10359:
;
;            /* Search the delayed lists. */
;            if( pxTCB == NULL )
;            {
	lda	<L297+pxTCB_1
	ora	<L297+pxTCB_1+2
	bne	L10362
;                pxTCB = prvSearchForNameWithinSingleList( ( List_t * ) pxDelayedTaskList, pcNameToQuery );
	pei	<L296+pcNameToQuery_0+2
	pei	<L296+pcNameToQuery_0
	lda	|_~pxDelayedTaskList+2	; volatile
	pha
	lda	|_~pxDelayedTaskList	; volatile
	pha
	jsr	_~prvSearchForNameWithinSingleList
	sta	<L297+pxTCB_1
	stx	<L297+pxTCB_1+2
;            }
;
;            if( pxTCB == NULL )
L10362:
;            {
	lda	<L297+pxTCB_1
	ora	<L297+pxTCB_1+2
	bne	L10363
;                pxTCB = prvSearchForNameWithinSingleList( ( List_t * ) pxOverflowDelayedTaskList, pcNameToQuery );
	pei	<L296+pcNameToQuery_0+2
	pei	<L296+pcNameToQuery_0
	lda	|_~pxOverflowDelayedTaskList+2	; volatile
	pha
	lda	|_~pxOverflowDelayedTaskList	; volatile
	pha
	jsr	_~prvSearchForNameWithinSingleList
	sta	<L297+pxTCB_1
	stx	<L297+pxTCB_1+2
;            }
;
;            #if ( INCLUDE_vTaskSuspend == 1 )
;            {
L10363:
;                if( pxTCB == NULL )
;                {
	lda	<L297+pxTCB_1
	ora	<L297+pxTCB_1+2
	bne	L10364
;                    /* Search the suspended list. */
;                    pxTCB = prvSearchForNameWithinSingleList( &xSuspendedTaskList, pcNameToQuery );
	pei	<L296+pcNameToQuery_0+2
	pei	<L296+pcNameToQuery_0
	lda	#<_~xSuspendedTaskList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~prvSearchForNameWithinSingleList
	sta	<L297+pxTCB_1
	stx	<L297+pxTCB_1+2
;                }
;            }
L10364:
;            #endif
;
;            #if ( INCLUDE_vTaskDelete == 1 )
;            {
;                if( pxTCB == NULL )
;                {
	lda	<L297+pxTCB_1
	ora	<L297+pxTCB_1+2
	bne	L10365
;                    /* Search the deleted list. */
;                    pxTCB = prvSearchForNameWithinSingleList( &xTasksWaitingTermination, pcNameToQuery );
	pei	<L296+pcNameToQuery_0+2
	pei	<L296+pcNameToQuery_0
	lda	#<_~xTasksWaitingTermination
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~prvSearchForNameWithinSingleList
	sta	<L297+pxTCB_1
	stx	<L297+pxTCB_1+2
;                }
;            }
L10365:
;            #endif
;        }
;        ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;        traceRETURN_xTaskGetHandle( pxTCB );
;
;        return pxTCB;
	ldx	<L297+pxTCB_1+2
	lda	<L297+pxTCB_1
	tay
	lda	<L296+1
	sta	<L296+1+4
	pld
	tsc
	clc
	adc	#L296+4
	tcs
	tya
	rts
;    }
L296	equ	18
L297	equ	13
	ends
	efunc
;
;#endif /* INCLUDE_xTaskGetHandle */
;/*-----------------------------------------------------------*/
;
;#if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;    BaseType_t xTaskGetStaticBuffers( TaskHandle_t xTask,
;                                      StackType_t ** ppuxStackBuffer,
;                                      StaticTask_t ** ppxTaskBuffer )
;    {
;        BaseType_t xReturn;
;        TCB_t * pxTCB;
;
;        traceENTER_xTaskGetStaticBuffers( xTask, ppuxStackBuffer, ppxTaskBuffer );
;
;        configASSERT( ppuxStackBuffer != NULL );
;        configASSERT( ppxTaskBuffer != NULL );
;
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        #if ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE == 1 )
;        {
;            if( pxTCB->ucStaticallyAllocated == tskSTATICALLY_ALLOCATED_STACK_AND_TCB )
;            {
;                *ppuxStackBuffer = pxTCB->pxStack;
;                /* MISRA Ref 11.3.1 [Misaligned access] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;                /* coverity[misra_c_2012_rule_11_3_violation] */
;                *ppxTaskBuffer = ( StaticTask_t * ) pxTCB;
;                xReturn = pdTRUE;
;            }
;            else if( pxTCB->ucStaticallyAllocated == tskSTATICALLY_ALLOCATED_STACK_ONLY )
;            {
;                *ppuxStackBuffer = pxTCB->pxStack;
;                *ppxTaskBuffer = NULL;
;                xReturn = pdTRUE;
;            }
;            else
;            {
;                xReturn = pdFALSE;
;            }
;        }
;        #else /* tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE == 1 */
;        {
;            *ppuxStackBuffer = pxTCB->pxStack;
;            *ppxTaskBuffer = ( StaticTask_t * ) pxTCB;
;            xReturn = pdTRUE;
;        }
;        #endif /* tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE == 1 */
;
;        traceRETURN_xTaskGetStaticBuffers( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    STATIC UBaseType_t prvForEachTaskInList( List_t * pxList,
;                                             eTaskState eState,
;                                             TaskStatusCallbackFunction_t pxCallbackFunction,
;                                             void * pvCallbackContext );
;
;/* for uxTaskGetSystemState callback context: current write position into TaskStatusArray */
;    typedef struct xTASK_STATUS_ARRAY_WRITER_CONTEXT
;    {
;        TaskStatus_t * pxTaskStatusArray;
;        UBaseType_t uxIndex;
;    } TaskStatusArrayWriterContext_t;
;
;/* callback for uxTaskGetSystemState: write one task's status into TaskStatusArray */
;    STATIC void prvTaskStatusArrayWriter( TaskHandle_t xTask,
;                                          eTaskState eState,
;                                          void * pvCallbackContext )
;    {
;        TaskStatusArrayWriterContext_t * pxContext = ( TaskStatusArrayWriterContext_t * ) pvCallbackContext;
;
;        vTaskGetInfo( xTask, &( pxContext->pxTaskStatusArray[ pxContext->uxIndex++ ] ), pdTRUE, eState );
;    }
;
;    STATIC void prvGetTotalRunTime( configRUN_TIME_COUNTER_TYPE * const pulTotalRunTime )
;    {
;        if( pulTotalRunTime != NULL )
;        {
;            #if ( configGENERATE_RUN_TIME_STATS == 1 )
;                #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;                    portALT_GET_RUN_TIME_COUNTER_VALUE( ( *pulTotalRunTime ) );
;                #else
;                    *pulTotalRunTime = ( configRUN_TIME_COUNTER_TYPE ) portGET_RUN_TIME_COUNTER_VALUE();
;                #endif
;            #else
;                *pulTotalRunTime = 0;
;            #endif /* if ( configGENERATE_RUN_TIME_STATS == 1 ) */
;        }
;    }
;
;/* For each task, call the provided callback function (passing the provided context). */
;/* Caller must suspend the scheduler around use of this function. */
;    STATIC UBaseType_t prvCallForEachTask( TaskStatusCallbackFunction_t pxCallbackFunction,
;                                           void * pvCallbackContext )
;    {
;        UBaseType_t uxTask = 0, uxQueue = configMAX_PRIORITIES;
;
;        /* Visit each task in the Ready state. */
;        do
;        {
;            uxQueue--;
;            uxTask = ( UBaseType_t ) ( uxTask + prvForEachTaskInList( &( pxReadyTasksLists[ uxQueue ] ), eReady, pxCallbackFunction, pvCallbackContext ) );
;        } while( uxQueue > ( UBaseType_t ) tskIDLE_PRIORITY );
;
;        /* Visit each task in the Blocked state. */
;        uxTask = ( UBaseType_t ) ( uxTask + prvForEachTaskInList( ( List_t * ) pxDelayedTaskList, eBlocked, pxCallbackFunction, pvCallbackContext ) );
;        uxTask = ( UBaseType_t ) ( uxTask + prvForEachTaskInList( ( List_t * ) pxOverflowDelayedTaskList, eBlocked, pxCallbackFunction, pvCallbackContext ) );
;
;        #if ( INCLUDE_vTaskDelete == 1 )
;        {
;            /* Visit each task that has been deleted but not yet cleaned up. */
;            uxTask = ( UBaseType_t ) ( uxTask + prvForEachTaskInList( &xTasksWaitingTermination, eDeleted, pxCallbackFunction, pvCallbackContext ) );
;        }
;        #endif
;
;        #if ( INCLUDE_vTaskSuspend == 1 )
;        {
;            /* Visit each task in the Suspended state. */
;            uxTask = ( UBaseType_t ) ( uxTask + prvForEachTaskInList( &xSuspendedTaskList, eSuspended, pxCallbackFunction, pvCallbackContext ) );
;        }
;        #endif
;
;        return uxTask;
;    }
;
;    UBaseType_t uxTaskCallForEachTask( TaskStatusCallbackFunction_t pxCallbackFunction,
;                                       void * pvCallbackContext,
;                                       configRUN_TIME_COUNTER_TYPE * const pulTotalRunTime )
;    {
;        UBaseType_t uxTask;
;
;        configASSERT( pxCallbackFunction != NULL );
;
;        if( pxCallbackFunction == NULL )
;        {
;            return 0;
;        }
;
;        vTaskSuspendAll();
;        {
;            uxTask = prvCallForEachTask( pxCallbackFunction, pvCallbackContext );
;            prvGetTotalRunTime( pulTotalRunTime );
;        }
;        ( void ) xTaskResumeAll();
;
;        return uxTask;
;    }
;
;    UBaseType_t uxTaskGetSystemState( TaskStatus_t * const pxTaskStatusArray,
;                                      const UBaseType_t uxArraySize,
;                                      configRUN_TIME_COUNTER_TYPE * const pulTotalRunTime )
;    {
;        UBaseType_t uxTask = 0;
;
;        traceENTER_uxTaskGetSystemState( pxTaskStatusArray, uxArraySize, pulTotalRunTime );
;
;        vTaskSuspendAll();
;        {
;            /* Is there a space in the array for each task in the system? */
;            if( uxArraySize >= uxCurrentNumberOfTasks )
;            {
;                TaskStatusArrayWriterContext_t xContext;
;                xContext.pxTaskStatusArray = pxTaskStatusArray;
;                xContext.uxIndex = 0;
;                uxTask = prvCallForEachTask( prvTaskStatusArrayWriter, &xContext );
;                prvGetTotalRunTime( pulTotalRunTime );
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        ( void ) xTaskResumeAll();
;
;        traceRETURN_uxTaskGetSystemState( uxTask );
;
;        return uxTask;
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*----------------------------------------------------------*/
;
;#if ( INCLUDE_xTaskGetIdleTaskHandle == 1 )
;
;    #if ( configNUMBER_OF_CORES == 1 )
;        TaskHandle_t xTaskGetIdleTaskHandle( void )
;        {
;            traceENTER_xTaskGetIdleTaskHandle();
;
;            /* If xTaskGetIdleTaskHandle() is called before the scheduler has been
;             * started, then xIdleTaskHandles will be NULL. */
;            configASSERT( ( xIdleTaskHandles[ 0 ] != NULL ) );
;
;            traceRETURN_xTaskGetIdleTaskHandle( xIdleTaskHandles[ 0 ] );
;
;            return xIdleTaskHandles[ 0 ];
;        }
;    #endif /* if ( configNUMBER_OF_CORES == 1 ) */
;
;    TaskHandle_t xTaskGetIdleTaskHandleForCore( BaseType_t xCoreID )
;    {
;        traceENTER_xTaskGetIdleTaskHandleForCore( xCoreID );
;
;        /* Ensure the core ID is valid. */
;        configASSERT( taskVALID_CORE_ID( xCoreID ) == pdTRUE );
;
;        /* If xTaskGetIdleTaskHandle() is called before the scheduler has been
;         * started, then xIdleTaskHandles will be NULL. */
;        configASSERT( ( xIdleTaskHandles[ xCoreID ] != NULL ) );
;
;        traceRETURN_xTaskGetIdleTaskHandleForCore( xIdleTaskHandles[ xCoreID ] );
;
;        return xIdleTaskHandles[ xCoreID ];
;    }
;
;#endif /* INCLUDE_xTaskGetIdleTaskHandle */
;/*----------------------------------------------------------*/
;
;/* This conditional compilation should use inequality to 0, not equality to 1.
; * This is to ensure vTaskStepTick() is available when user defined low power mode
; * implementations require configUSE_TICKLESS_IDLE to be set to a value other than
; * 1. */
;#if ( configUSE_TICKLESS_IDLE != 0 )
;
;    void vTaskStepTick( TickType_t xTicksToJump )
;    {
;        TickType_t xUpdatedTickCount;
;
;        traceENTER_vTaskStepTick( xTicksToJump );
;
;        /* Correct the tick count value after a period during which the tick
;         * was suppressed.  Note this does *not* call the tick hook function for
;         * each stepped tick. */
;        xUpdatedTickCount = xTickCount + xTicksToJump;
;        configASSERT( xUpdatedTickCount <= xNextTaskUnblockTime );
;
;        if( xUpdatedTickCount == xNextTaskUnblockTime )
;        {
;            /* Arrange for xTickCount to reach xNextTaskUnblockTime in
;             * xTaskIncrementTick() when the scheduler resumes.  This ensures
;             * that any delayed tasks are resumed at the correct time. */
;            configASSERT( uxSchedulerSuspended != ( UBaseType_t ) 0U );
;            configASSERT( xTicksToJump != ( TickType_t ) 0 );
;
;            /* Prevent the tick interrupt modifying xPendedTicks simultaneously. */
;            taskENTER_CRITICAL();
;            {
;                xPendedTicks++;
;            }
;            taskEXIT_CRITICAL();
;            xTicksToJump--;
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        xTickCount += xTicksToJump;
;
;        traceINCREASE_TICK_COUNT( xTicksToJump );
;        traceRETURN_vTaskStepTick();
;    }
;
;#endif /* configUSE_TICKLESS_IDLE */
;/*----------------------------------------------------------*/
;
;BaseType_t xTaskCatchUpTicks( TickType_t xTicksToCatchUp )
;{
	code
	xdef	_~xTaskCatchUpTicks
	func
_~xTaskCatchUpTicks:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L306
	tcs
	phd
	tcd
xTicksToCatchUp_0	set	3
;    BaseType_t xYieldOccurred;
;
;    traceENTER_xTaskCatchUpTicks( xTicksToCatchUp );
xYieldOccurred_1	set	0
;
;    /* Must not be called with the scheduler suspended as the implementation
;     * relies on xPendedTicks being wound down to 0 in xTaskResumeAll(). */
;    configASSERT( uxSchedulerSuspended == ( UBaseType_t ) 0U );
	lda	|_~uxSchedulerSuspended	; volatile
	beq	L10366
	asmstart
	sei
	asmend
L10367:
	bra	L10367
L10366:
;
;    /* Use xPendedTicks to mimic xTicksToCatchUp number of ticks occurring when
;     * the scheduler is suspended so the ticks are executed in xTaskResumeAll(). */
;    vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;
;    /* Prevent the tick interrupt modifying xPendedTicks simultaneously. */
;    taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;    {
;        xPendedTicks += xTicksToCatchUp;
	lda	|_~xPendedTicks	; volatile
	clc
	adc	<L306+xTicksToCatchUp_0
	sta	|_~xPendedTicks	; volatile
	lda	|_~xPendedTicks+2	; volatile
	adc	<L306+xTicksToCatchUp_0+2
	sta	|_~xPendedTicks+2	; volatile
;    }
;    taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;    xYieldOccurred = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L307+xYieldOccurred_1
;
;    traceRETURN_xTaskCatchUpTicks( xYieldOccurred );
;
;    return xYieldOccurred;
	tay
	lda	<L306+1
	sta	<L306+1+4
	pld
	tsc
	clc
	adc	#L306+4
	tcs
	tya
	rts
;}
L306	equ	2
L307	equ	1
	ends
	efunc
;/*----------------------------------------------------------*/
;
;#if ( INCLUDE_xTaskAbortDelay == 1 )
;
;    BaseType_t xTaskAbortDelay( TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB = xTask;
;        BaseType_t xReturn;
;
;        traceENTER_xTaskAbortDelay( xTask );
;
;        configASSERT( pxTCB != NULL );
;
;        vTaskSuspendAll();
;        {
;            /* A task can only be prematurely removed from the Blocked state if
;             * it is actually in the Blocked state. */
;            if( eTaskGetState( xTask ) == eBlocked )
;            {
;                xReturn = pdPASS;
;
;                /* Remove the reference to the task from the blocked list.  An
;                 * interrupt won't touch the xStateListItem because the
;                 * scheduler is suspended. */
;                ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
;
;                /* Is the task waiting on an event also?  If so remove it from
;                 * the event list too.  Interrupts can touch the event list item,
;                 * even though the scheduler is suspended, so a critical section
;                 * is used. */
;                taskENTER_CRITICAL();
;                {
;                    if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
;                    {
;                        ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
;
;                        /* This lets the task know it was forcibly removed from the
;                         * blocked state so it should not re-evaluate its block time and
;                         * then block again. */
;                        pxTCB->ucDelayAborted = ( uint8_t ) pdTRUE;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                taskEXIT_CRITICAL();
;
;                /* Place the unblocked task into the appropriate ready list. */
;                prvAddTaskToReadyList( pxTCB );
;
;                /* A task being unblocked cannot cause an immediate context
;                 * switch if preemption is turned off. */
;                #if ( configUSE_PREEMPTION == 1 )
;                {
;                    #if ( configNUMBER_OF_CORES == 1 )
;                    {
;                        /* Preemption is on, but a context switch should only be
;                         * performed if the unblocked task has a priority that is
;                         * higher than the currently executing task. */
;                        if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
;                        {
;                            /* Pend the yield to be performed when the scheduler
;                             * is unsuspended. */
;                            xYieldPendings[ 0 ] = pdTRUE;
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                    {
;                        taskENTER_CRITICAL();
;                        {
;                            prvYieldForTask( pxTCB );
;                        }
;                        taskEXIT_CRITICAL();
;                    }
;                    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;                }
;                #endif /* #if ( configUSE_PREEMPTION == 1 ) */
;            }
;            else
;            {
;                xReturn = pdFAIL;
;            }
;        }
;        ( void ) xTaskResumeAll();
;
;        traceRETURN_xTaskAbortDelay( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* INCLUDE_xTaskAbortDelay */
;/*----------------------------------------------------------*/
;
;BaseType_t xTaskIncrementTick( void )
;{
	code
	xdef	_~xTaskIncrementTick
	func
_~xTaskIncrementTick:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L310
	tcs
	phd
	tcd
;    TCB_t * pxTCB;
;    TickType_t xItemValue;
;    BaseType_t xSwitchRequired = pdFALSE;
;
;    traceENTER_xTaskIncrementTick();
pxTCB_1	set	0
xItemValue_1	set	4
xSwitchRequired_1	set	8
	stz	<L311+xSwitchRequired_1
;
;    /* Called by the portable layer each time a tick interrupt occurs.
;     * Increments the tick then checks to see if the new tick value will cause any
;     * tasks to be unblocked. */
;    traceTASK_INCREMENT_TICK( xTickCount );
;
;    /* Tick increment should occur on every kernel timer event. Core 0 has the
;     * responsibility to increment the tick, or increment the pended ticks if the
;     * scheduler is suspended.  If pended ticks is greater than zero, the core that
;     * calls xTaskResumeAll has the responsibility to increment the tick. */
;    if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;    {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	*+5
	brl	L10370
;        /* Minor optimisation.  The tick count cannot change in this
;         * block. */
;        const TickType_t xConstTickCount = xTickCount + ( TickType_t ) 1;
;
;        /* Increment the RTOS tick, switching the delayed and overflowed
;         * delayed lists if it wraps to 0. */
;        xTickCount = xConstTickCount;
xConstTickCount_2	set	10
	lda	#$1
	clc
	adc	|_~xTickCount	; volatile
	sta	<L311+xConstTickCount_2
	lda	#$0
	adc	|_~xTickCount+2	; volatile
	sta	<L311+xConstTickCount_2+2
	lda	<L311+xConstTickCount_2
	sta	|_~xTickCount	; volatile
	lda	<L311+xConstTickCount_2+2
	sta	|_~xTickCount+2	; volatile
;
;        if( xConstTickCount == ( TickType_t ) 0U )
;        {
	lda	<L311+xConstTickCount_2
	ora	<L311+xConstTickCount_2+2
	bne	L10379
;            taskSWITCH_DELAYED_LISTS();
pxTemp_3	set	14
	lda	|_~pxDelayedTaskList	; volatile
	sta	<R0
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<R0+2
	lda	[<R0]
	bne	L314
	lda	#$1
	bra	L316
L314:
	lda	#$0
L316:
	tax
	bne	L10375
	asmstart
	sei
	asmend
L10376:
	bra	L10376
L10375:
	lda	|_~pxDelayedTaskList	; volatile
	sta	<L311+pxTemp_3
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<L311+pxTemp_3+2
	lda	|_~pxOverflowDelayedTaskList	; volatile
	sta	|_~pxDelayedTaskList	; volatile
	lda	|_~pxOverflowDelayedTaskList+2	; volatile
	sta	|_~pxDelayedTaskList+2	; volatile
	lda	<L311+pxTemp_3
	sta	|_~pxOverflowDelayedTaskList	; volatile
	lda	<L311+pxTemp_3+2
	sta	|_~pxOverflowDelayedTaskList+2	; volatile
	inc	|_~xNumOfOverflows	; volatile
	jsr	_~prvResetNextTaskUnblockTime
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10379:
;
;        /* See if this tick has made a timeout expire.  Tasks are stored in
;         * the  queue in the order of their wake time - meaning once one task
;         * has been found whose block time has not expired there is no need to
;         * look any further down the list. */
;        if( xConstTickCount >= xNextTaskUnblockTime )
;        {
	lda	<L311+xConstTickCount_2
	cmp	|_~xNextTaskUnblockTime	; volatile
	lda	<L311+xConstTickCount_2+2
	sbc	|_~xNextTaskUnblockTime+2	; volatile
	bcc	L10380
;            for( ; ; )
L10383:
;            {
;                if( listLIST_IS_EMPTY( pxDelayedTaskList ) != pdFALSE )
;                {
	lda	|_~pxDelayedTaskList	; volatile
	sta	<R0
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<R0+2
	lda	[<R0]
	bne	L319
	lda	#$1
	bra	L321
L319:
	lda	#$0
L321:
	tax
	beq	L10384
;                    /* The delayed list is empty.  Set xNextTaskUnblockTime
;                     * to the maximum possible value so it is extremely
;                     * unlikely that the
;                     * if( xTickCount >= xNextTaskUnblockTime ) test will pass
;                     * next time through. */
;                    xNextTaskUnblockTime = portMAX_DELAY;
	lda	#$ffff
	sta	|_~xNextTaskUnblockTime	; volatile
L20032:
	sta	|_~xNextTaskUnblockTime+2	; volatile
;                    break;
L10380:
;            #if ( configNUMBER_OF_CORES == 1 )
;            {
;                if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ pxCurrentTCB->uxPriority ] ) ) > 1U )
;                {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	#$1
	cmp	|_~pxReadyTasksLists,X
	bcs	*+5
	brl	L331
	brl	L10409
;                }
;                else
L10384:
;                {
;                    /* The delayed list is not empty, get the value of the
;                     * item at the head of the delayed list.  This is the time
;                     * at which the task at the head of the delayed list must
;                     * be removed from the Blocked state. */
;                    /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                    /* coverity[misra_c_2012_rule_11_5_violation] */
;                    pxTCB = listGET_OWNER_OF_HEAD_ENTRY( pxDelayedTaskList );
	lda	|_~pxDelayedTaskList	; volatile
	sta	<R0
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<R0+2
	ldy	#$a
	lda	[<R0],Y
	sta	<R1
	iny
	iny
	lda	[<R0],Y
	sta	<R1+2
	lda	[<R1],Y
	sta	<L311+pxTCB_1
	iny
	iny
	lda	[<R1],Y
	sta	<L311+pxTCB_1+2
;                    xItemValue = listGET_LIST_ITEM_VALUE( &( pxTCB->xStateListItem ) );
	ldy	#$4
	lda	[<L311+pxTCB_1],Y
	sta	<L311+xItemValue_1
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<L311+xItemValue_1+2
;
;                    if( xConstTickCount < xItemValue )
;                    {
	lda	<L311+xConstTickCount_2
	cmp	<L311+xItemValue_1
	lda	<L311+xConstTickCount_2+2
	sbc	<L311+xItemValue_1+2
	bcs	L10388
;                        /* It is not time to unblock this item yet, but the
;                         * item value is the time at which the task at the head
;                         * of the blocked list must be removed from the Blocked
;                         * state -  so record the item value in
;                         * xNextTaskUnblockTime. */
;                        xNextTaskUnblockTime = xItemValue;
	lda	<L311+xItemValue_1
	sta	|_~xNextTaskUnblockTime	; volatile
	lda	<L311+xItemValue_1+2
	bra	L20032
;                        break;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;
;                    /* It is time to remove the item from the Blocked state. */
;                    listREMOVE_ITEM( &( pxTCB->xStateListItem ) );
L10388:
pxList_4	set	14
	ldy	#$14
	lda	[<L311+pxTCB_1],Y
	sta	<L311+pxList_4
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<L311+pxList_4+2
	ldy	#$8
	lda	[<L311+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L311+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L311+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L311+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L311+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L311+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L311+pxList_4],Y
	cmp	<R0
	bne	L324
	iny
	iny
	lda	[<L311+pxList_4],Y
	cmp	<R0+2
L324:
	bne	L10389
	ldy	#$c
	lda	[<L311+pxTCB_1],Y
	ldy	#$2
	sta	[<L311+pxList_4],Y
	ldy	#$e
	lda	[<L311+pxTCB_1],Y
	ldy	#$4
	sta	[<L311+pxList_4],Y
L10389:
	lda	#$0
	ldy	#$14
	sta	[<L311+pxTCB_1],Y
	iny
	iny
	sta	[<L311+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L311+pxList_4]
	sta	[<L311+pxList_4]
;
;                    /* Is the task waiting on an event also?  If so remove
;                     * it from the event list. */
;                    if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
;                    {
	ldy	#$28
	lda	[<L311+pxTCB_1],Y
	iny
	iny
	ora	[<L311+pxTCB_1],Y
	bne	*+5
	brl	L10401
;                        listREMOVE_ITEM( &( pxTCB->xEventListItem ) );
pxList_5	set	14
	dey
	dey
	lda	[<L311+pxTCB_1],Y
	sta	<L311+pxList_5
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<L311+pxList_5+2
	ldy	#$1c
	lda	[<L311+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$22
	lda	[<L311+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	ldy	#$20
	lda	[<L311+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L311+pxTCB_1],Y
	sta	<R0+2
	ldy	#$1c
	lda	[<L311+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$1e
	lda	[<L311+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$18
	clc
	adc	<L311+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L311+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L311+pxList_5],Y
	cmp	<R0
	bne	L327
	iny
	iny
	lda	[<L311+pxList_5],Y
	cmp	<R0+2
L327:
	bne	L10394
	ldy	#$20
	lda	[<L311+pxTCB_1],Y
	ldy	#$2
	sta	[<L311+pxList_5],Y
	ldy	#$22
	lda	[<L311+pxTCB_1],Y
	ldy	#$4
	sta	[<L311+pxList_5],Y
L10394:
	lda	#$0
	ldy	#$28
	sta	[<L311+pxTCB_1],Y
	iny
	iny
	sta	[<L311+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L311+pxList_5]
	sta	[<L311+pxList_5]
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;
;                    /* Place the unblocked task into the appropriate ready
;                     * list. */
;                    prvAddTaskToReadyList( pxTCB );
L10401:
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L311+pxTCB_1],Y
	bcs	L10405
	lda	[<L311+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10405:
pxIndex_6	set	14
	ldy	#$2c
	lda	[<L311+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L311+pxIndex_6
	ldy	#$2
	lda	(<R2),Y
	sta	<L311+pxIndex_6+2
	lda	<L311+pxIndex_6
	ldy	#$8
	sta	[<L311+pxTCB_1],Y
	lda	<L311+pxIndex_6+2
	iny
	iny
	sta	[<L311+pxTCB_1],Y
	dey
	dey
	lda	[<L311+pxIndex_6],Y
	ldy	#$c
	sta	[<L311+pxTCB_1],Y
	dey
	dey
	lda	[<L311+pxIndex_6],Y
	ldy	#$e
	sta	[<L311+pxTCB_1],Y
	ldy	#$8
	lda	[<L311+pxIndex_6],Y
	sta	<R0
	iny
	iny
	lda	[<L311+pxIndex_6],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L311+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L311+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L311+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L311+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L311+pxIndex_6],Y
	lda	<R0+2
	iny
	iny
	sta	[<L311+pxIndex_6],Y
	ldy	#$2c
	lda	[<L311+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L311+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L311+pxTCB_1],Y
	ldy	#$2c
	lda	[<L311+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L311+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;                    /* A task being unblocked cannot cause an immediate
;                     * context switch if preemption is turned off. */
;                    #if ( configUSE_PREEMPTION == 1 )
;                    {
;                        #if ( configNUMBER_OF_CORES == 1 )
;                        {
;                            /* Preemption is on, but a context switch should
;                             * only be performed if the unblocked task's
;                             * priority is higher than the currently executing
;                             * task.
;                             * The case of equal priority tasks sharing
;                             * processing time (which happens when both
;                             * preemption and time slicing are on) is
;                             * handled below.*/
;                            if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
;                            {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L311+pxTCB_1],Y
	bcc	*+5
	brl	L10383
;                                xSwitchRequired = pdTRUE;
	lda	#$1
	sta	<L311+xSwitchRequired_1
;                            }
;                            else
	brl	L10383
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;                        }
;                        #else /* #if( configNUMBER_OF_CORES == 1 ) */
;                        {
;                            prvYieldForTask( pxTCB );
;                        }
;                        #endif /* #if( configNUMBER_OF_CORES == 1 ) */
;                    }
;                    #endif /* #if ( configUSE_PREEMPTION == 1 ) */
;                }
;            }
;        }
;
;        /* Tasks of equal priority to the currently running task will share
;         * processing time (time slice) if preemption is on, and the application
;         * writer has not explicitly turned time slicing off. */
;        #if ( ( configUSE_PREEMPTION == 1 ) && ( configUSE_TIME_SLICING == 1 ) )
;        {
L331:
;                    xSwitchRequired = pdTRUE;
	lda	#$1
	sta	<L311+xSwitchRequired_1
;                }
;                else
L10409:
;            }
;            #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;            {
;                BaseType_t xCoreID;
;
;                for( xCoreID = 0; xCoreID < ( ( BaseType_t ) configNUMBER_OF_CORES ); xCoreID++ )
;                {
;                    if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ pxCurrentTCBs[ xCoreID ]->uxPriority ] ) ) > 1U )
;                    {
;                        xYieldPendings[ xCoreID ] = pdTRUE;
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;            }
;            #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;        }
;        #endif /* #if ( ( configUSE_PREEMPTION == 1 ) && ( configUSE_TIME_SLICING == 1 ) ) */
;
;        #if ( configUSE_TICK_HOOK == 1 )
;        {
;            /* Guard against the tick hook being called when the pended tick
;             * count is being unwound (when the scheduler is being unlocked). */
;            if( xPendedTicks == ( TickType_t ) 0 )
;            {
;                vApplicationTickHook();
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* configUSE_TICK_HOOK */
;
;        #if ( configUSE_PREEMPTION == 1 )
;        {
;            #if ( configNUMBER_OF_CORES == 1 )
;            {
;                /* For single core the core ID is always 0. */
;                if( xYieldPendings[ 0 ] != pdFALSE )
;                {
	lda	|_~xYieldPendings	; volatile
	beq	L10412
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;                    xSwitchRequired = pdTRUE;
	lda	#$1
	sta	<L311+xSwitchRequired_1
;                }
;                else
	bra	L10412
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;            {
;                BaseType_t xCoreID, xCurrentCoreID;
;                xCurrentCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;                for( xCoreID = 0; xCoreID < ( BaseType_t ) configNUMBER_OF_CORES; xCoreID++ )
;                {
;                    #if ( configUSE_TASK_PREEMPTION_DISABLE == 1 )
;                        if( pxCurrentTCBs[ xCoreID ]->xPreemptionDisable == pdFALSE )
;                    #endif
;                    {
;                        if( xYieldPendings[ xCoreID ] != pdFALSE )
;                        {
;                            if( xCoreID == xCurrentCoreID )
;                            {
;                                xSwitchRequired = pdTRUE;
;                            }
;                            else
;                            {
;                                prvYieldCore( xCoreID );
;                            }
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                }
;            }
;            #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;        }
;        #endif /* #if ( configUSE_PREEMPTION == 1 ) */
;    }
;    else
L10370:
;    {
;        xPendedTicks += 1U;
	inc	|_~xPendedTicks	; volatile
	bne	L10412
	inc	|_~xPendedTicks+2	; volatile
;
;        /* The tick hook gets called at regular intervals, even if the
;         * scheduler is locked. */
;        #if ( configUSE_TICK_HOOK == 1 )
;        {
;            vApplicationTickHook();
;        }
;        #endif
;    }
L10412:
;
;    traceRETURN_xTaskIncrementTick( xSwitchRequired );
;
;    return xSwitchRequired;
	lda	<L311+xSwitchRequired_1
	tay
	pld
	tsc
	clc
	adc	#L310
	tcs
	tya
	rts
;}
L310	equ	30
L311	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_APPLICATION_TASK_TAG == 1 )
;
;    void vTaskSetApplicationTaskTag( TaskHandle_t xTask,
;                                     TaskHookFunction_t pxHookFunction )
;    {
;        TCB_t * xTCB;
;
;        traceENTER_vTaskSetApplicationTaskTag( xTask, pxHookFunction );
;
;        /* If xTask is NULL then it is the task hook of the calling task that is
;         * getting set. */
;        if( xTask == NULL )
;        {
;            xTCB = ( TCB_t * ) pxCurrentTCB;
;        }
;        else
;        {
;            xTCB = xTask;
;        }
;
;        /* Save the hook function in the TCB.  A critical section is required as
;         * the value can be accessed from an interrupt. */
;        taskENTER_CRITICAL();
;        {
;            xTCB->pxTaskTag = pxHookFunction;
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_vTaskSetApplicationTaskTag();
;    }
;
;#endif /* configUSE_APPLICATION_TASK_TAG */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_APPLICATION_TASK_TAG == 1 )
;
;    TaskHookFunction_t xTaskGetApplicationTaskTag( TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;        TaskHookFunction_t xReturn;
;
;        traceENTER_xTaskGetApplicationTaskTag( xTask );
;
;        /* If xTask is NULL then get the calling task's hook. */
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        /* Access the hook function in the TCB.  A critical section is required as
;         * the value can be accessed from an interrupt. */
;        taskENTER_CRITICAL();
;        {
;            xReturn = pxTCB->pxTaskTag;
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_xTaskGetApplicationTaskTag( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_APPLICATION_TASK_TAG */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_APPLICATION_TASK_TAG == 1 )
;
;    TaskHookFunction_t xTaskGetApplicationTaskTagFromISR( TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;        TaskHookFunction_t xReturn;
;        UBaseType_t uxSavedInterruptStatus;
;
;        traceENTER_xTaskGetApplicationTaskTagFromISR( xTask );
;
;        /* If xTask is NULL then get the calling task's hook. */
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        /* Access the hook function in the TCB.  A critical section is required as
;         * the value can be accessed from an interrupt. */
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
;        {
;            xReturn = pxTCB->pxTaskTag;
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_xTaskGetApplicationTaskTagFromISR( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_APPLICATION_TASK_TAG */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_APPLICATION_TASK_TAG == 1 )
;
;    BaseType_t xTaskCallApplicationTaskHook( TaskHandle_t xTask,
;                                             void * pvParameter )
;    {
;        TCB_t * xTCB;
;        BaseType_t xReturn;
;
;        traceENTER_xTaskCallApplicationTaskHook( xTask, pvParameter );
;
;        /* If xTask is NULL then we are calling our own task hook. */
;        if( xTask == NULL )
;        {
;            xTCB = pxCurrentTCB;
;        }
;        else
;        {
;            xTCB = xTask;
;        }
;
;        if( xTCB->pxTaskTag != NULL )
;        {
;            xReturn = xTCB->pxTaskTag( pvParameter );
;        }
;        else
;        {
;            xReturn = pdFAIL;
;        }
;
;        traceRETURN_xTaskCallApplicationTaskHook( xReturn );
;
;        return xReturn;
;    }
;
;#endif /* configUSE_APPLICATION_TASK_TAG */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES == 1 )
;    void vTaskSwitchContext( void )
;    {
	code
	xdef	_~vTaskSwitchContext
	func
_~vTaskSwitchContext:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L335
	tcs
	phd
	tcd
;        traceENTER_vTaskSwitchContext();
;
;        if( uxSchedulerSuspended != ( UBaseType_t ) 0U )
;        {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	L10413
;            /* The scheduler is currently suspended - do not allow a context
;             * switch. */
;            xYieldPendings[ 0 ] = pdTRUE;
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;        }
;        else
	brl	L345
L10413:
;        {
;            xYieldPendings[ 0 ] = pdFALSE;
	stz	|_~xYieldPendings	; volatile
;            traceTASK_SWITCHED_OUT();
;
;            #if ( configGENERATE_RUN_TIME_STATS == 1 )
;            {
;                #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;                    portALT_GET_RUN_TIME_COUNTER_VALUE( ulTotalRunTime[ 0 ] );
;                #else
;                    ulTotalRunTime[ 0 ] = portGET_RUN_TIME_COUNTER_VALUE();
;                #endif
;
;                /* Add the amount of time the task has been running to the
;                 * accumulated time so far.  The time the task started running was
;                 * stored in ulTaskSwitchedInTime.  Note that there is no overflow
;                 * protection here so count values are only valid until the timer
;                 * overflows.  The guard against negative values is to protect
;                 * against suspect run time stat counter implementations - which
;                 * are provided by the application, not the kernel. */
;                if( ulTotalRunTime[ 0 ] > ulTaskSwitchedInTime[ 0 ] )
;                {
;                    pxCurrentTCB->ulRunTimeCounter += ( ulTotalRunTime[ 0 ] - ulTaskSwitchedInTime[ 0 ] );
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;
;                ulTaskSwitchedInTime[ 0 ] = ulTotalRunTime[ 0 ];
;            }
;            #endif /* configGENERATE_RUN_TIME_STATS */
;
;            /* Check for stack overflow, if configured. */
;            taskCHECK_FOR_STACK_OVERFLOW();
;
;            /* Before the currently running task is switched out, save its errno. */
;            #if ( configUSE_POSIX_ERRNO == 1 )
;            {
;                pxCurrentTCB->iTaskErrno = FreeRTOS_errno;
;            }
;            #endif
;
;            /* Select a new task to run using either the generic C or port
;             * optimised asm code. */
;            /* MISRA Ref 11.5.3 [Void pointer assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            taskSELECT_HIGHEST_PRIORITY_TASK();
uxTopPriority_2	set	0
	lda	|_~uxTopReadyPriority	; volatile
	sta	<L336+uxTopPriority_2
	bra	L10418
L20036:
	lda	<L336+uxTopPriority_2
	bne	L10420
	asmstart
	sei
	asmend
L10421:
	bra	L10421
L10420:
	dec	<L336+uxTopPriority_2
L10418:
	lda	<L336+uxTopPriority_2
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	bne	L338
	lda	#$1
	bra	L340
L338:
	lda	#$0
L340:
	tax
	bne	L20036
pxConstList_3	set	2
	lda	<L336+uxTopPriority_2
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<L336+pxConstList_3
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L336+pxConstList_3+2
	ldy	#$2
	lda	[<L336+pxConstList_3],Y
	sta	<R0
	iny
	iny
	lda	[<L336+pxConstList_3],Y
	sta	<R0+2
	lda	[<R0],Y
	dey
	dey
	sta	[<L336+pxConstList_3],Y
	ldy	#$6
	lda	[<R0],Y
	dey
	dey
	sta	[<L336+pxConstList_3],Y
	lda	#$6
	clc
	adc	<L336+pxConstList_3
	sta	<R0
	lda	#$0
	adc	<L336+pxConstList_3+2
	sta	<R0+2
	dey
	dey
	lda	[<L336+pxConstList_3],Y
	cmp	<R0
	bne	L343
	iny
	iny
	lda	[<L336+pxConstList_3],Y
	cmp	<R0+2
L343:
	bne	L10427
	ldy	#$a
	lda	[<L336+pxConstList_3],Y
	ldy	#$2
	sta	[<L336+pxConstList_3],Y
	ldy	#$c
	lda	[<L336+pxConstList_3],Y
	ldy	#$4
	sta	[<L336+pxConstList_3],Y
L10427:
	ldy	#$2
	lda	[<L336+pxConstList_3],Y
	sta	<R0
	iny
	iny
	lda	[<L336+pxConstList_3],Y
	sta	<R0+2
	ldy	#$c
	lda	[<R0],Y
	sta	|_~pxCurrentTCB	; volatile
	iny
	iny
	lda	[<R0],Y
	sta	|_~pxCurrentTCB+2	; volatile
	lda	<L336+uxTopPriority_2
	sta	|_~uxTopReadyPriority	; volatile
;            traceTASK_SWITCHED_IN();
;
;            /* Macro to inject port specific behaviour immediately after
;             * switching tasks, such as setting an end of stack watchpoint
;             * or reconfiguring the MPU. */
;            portTASK_SWITCH_HOOK( pxCurrentTCB );
;
;            /* After the new task is switched in, update the global errno. */
;            #if ( configUSE_POSIX_ERRNO == 1 )
;            {
;                FreeRTOS_errno = pxCurrentTCB->iTaskErrno;
;            }
;            #endif
;
;            #if ( configUSE_C_RUNTIME_TLS_SUPPORT == 1 )
;            {
;                /* Switch C-Runtime's TLS Block to point to the TLS
;                 * Block specific to this task. */
;                configSET_TLS_BLOCK( pxCurrentTCB->xTLSBlock );
;            }
;            #endif
;        }
;
;        traceRETURN_vTaskSwitchContext();
;    }
L345:
	pld
	tsc
	clc
	adc	#L335
	tcs
	rts
L335	equ	14
L336	equ	9
	ends
	efunc
;#else /* if ( configNUMBER_OF_CORES == 1 ) */
;    void vTaskSwitchContext( BaseType_t xCoreID )
;    {
;        traceENTER_vTaskSwitchContext();
;
;        /* Acquire both locks:
;         * - The ISR lock protects the ready list from simultaneous access by
;         *   both other ISRs and tasks.
;         * - We also take the task lock to pause here in case another core has
;         *   suspended the scheduler. We don't want to simply set xYieldPending
;         *   and move on if another core suspended the scheduler. We should only
;         *   do that if the current core has suspended the scheduler. */
;
;        portGET_TASK_LOCK( xCoreID ); /* Must always acquire the task lock first. */
;        portGET_ISR_LOCK( xCoreID );
;        {
;            /* vTaskSwitchContext() must never be called from within a critical section.
;             * This is not necessarily true for single core FreeRTOS, but it is for this
;             * SMP port. */
;            configASSERT( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0 );
;
;            if( uxSchedulerSuspended != ( UBaseType_t ) 0U )
;            {
;                /* The scheduler is currently suspended - do not allow a context
;                 * switch. */
;                xYieldPendings[ xCoreID ] = pdTRUE;
;            }
;            else
;            {
;                xYieldPendings[ xCoreID ] = pdFALSE;
;                traceTASK_SWITCHED_OUT();
;
;                #if ( configGENERATE_RUN_TIME_STATS == 1 )
;                {
;                    #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;                        portALT_GET_RUN_TIME_COUNTER_VALUE( ulTotalRunTime[ xCoreID ] );
;                    #else
;                        ulTotalRunTime[ xCoreID ] = portGET_RUN_TIME_COUNTER_VALUE();
;                    #endif
;
;                    /* Add the amount of time the task has been running to the
;                     * accumulated time so far.  The time the task started running was
;                     * stored in ulTaskSwitchedInTime.  Note that there is no overflow
;                     * protection here so count values are only valid until the timer
;                     * overflows.  The guard against negative values is to protect
;                     * against suspect run time stat counter implementations - which
;                     * are provided by the application, not the kernel. */
;                    if( ulTotalRunTime[ xCoreID ] > ulTaskSwitchedInTime[ xCoreID ] )
;                    {
;                        pxCurrentTCBs[ xCoreID ]->ulRunTimeCounter += ( ulTotalRunTime[ xCoreID ] - ulTaskSwitchedInTime[ xCoreID ] );
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;
;                    ulTaskSwitchedInTime[ xCoreID ] = ulTotalRunTime[ xCoreID ];
;                }
;                #endif /* configGENERATE_RUN_TIME_STATS */
;
;                /* Check for stack overflow, if configured. */
;                taskCHECK_FOR_STACK_OVERFLOW();
;
;                /* Before the currently running task is switched out, save its errno. */
;                #if ( configUSE_POSIX_ERRNO == 1 )
;                {
;                    pxCurrentTCBs[ xCoreID ]->iTaskErrno = FreeRTOS_errno;
;                }
;                #endif
;
;                /* Select a new task to run. */
;                taskSELECT_HIGHEST_PRIORITY_TASK( xCoreID );
;                traceTASK_SWITCHED_IN();
;
;                /* Macro to inject port specific behaviour immediately after
;                 * switching tasks, such as setting an end of stack watchpoint
;                 * or reconfiguring the MPU. */
;                portTASK_SWITCH_HOOK( pxCurrentTCBs[ portGET_CORE_ID() ] );
;
;                /* After the new task is switched in, update the global errno. */
;                #if ( configUSE_POSIX_ERRNO == 1 )
;                {
;                    FreeRTOS_errno = pxCurrentTCBs[ xCoreID ]->iTaskErrno;
;                }
;                #endif
;
;                #if ( configUSE_C_RUNTIME_TLS_SUPPORT == 1 )
;                {
;                    /* Switch C-Runtime's TLS Block to point to the TLS
;                     * Block specific to this task. */
;                    configSET_TLS_BLOCK( pxCurrentTCBs[ xCoreID ]->xTLSBlock );
;                }
;                #endif
;            }
;        }
;        portRELEASE_ISR_LOCK( xCoreID );
;        portRELEASE_TASK_LOCK( xCoreID );
;
;        traceRETURN_vTaskSwitchContext();
;    }
;#endif /* if ( configNUMBER_OF_CORES > 1 ) */
;/*-----------------------------------------------------------*/
;
;void vTaskPlaceOnEventList( List_t * const pxEventList,
;                            const TickType_t xTicksToWait )
;{
	code
	xdef	_~vTaskPlaceOnEventList
	func
_~vTaskPlaceOnEventList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L346
	tcs
	phd
	tcd
pxEventList_0	set	3
xTicksToWait_0	set	7
;    traceENTER_vTaskPlaceOnEventList( pxEventList, xTicksToWait );
;
;    configASSERT( pxEventList );
	lda	<L346+pxEventList_0
	ora	<L346+pxEventList_0+2
	bne	L10428
	asmstart
	sei
	asmend
L10429:
	bra	L10429
L10428:
;
;    /* THIS FUNCTION MUST BE CALLED WITH THE
;     * SCHEDULER SUSPENDED AND THE QUEUE BEING ACCESSED LOCKED. */
;
;    /* Place the event list item of the TCB in the appropriate event list.
;     * This is placed in the list in priority order so the highest priority task
;     * is the first to be woken by the event.
;     *
;     * Note: Lists are sorted in ascending order by ListItem_t.xItemValue.
;     * Normally, the xItemValue of a TCB's ListItem_t members is:
;     *      xItemValue = ( configMAX_PRIORITIES - uxPriority )
;     * Therefore, the event list is sorted in descending priority order.
;     *
;     * The queue that contains the event list is locked, preventing
;     * simultaneous access from interrupts. */
;    vListInsert( pxEventList, &( pxCurrentTCB->xEventListItem ) );
	lda	#$18
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	pha
	pei	<R0
	pei	<L346+pxEventList_0+2
	pei	<L346+pxEventList_0
	jsr	_~vListInsert
;
;    prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
	pea	#<$1
	pei	<L346+xTicksToWait_0+2
	pei	<L346+xTicksToWait_0
	jsr	_~prvAddCurrentTaskToDelayedList
;
;    traceRETURN_vTaskPlaceOnEventList();
;}
	lda	<L346+1
	sta	<L346+1+8
	pld
	tsc
	clc
	adc	#L346+8
	tcs
	rts
L346	equ	4
L347	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vTaskPlaceOnUnorderedEventList( List_t * pxEventList,
;                                     const TickType_t xItemValue,
;                                     const TickType_t xTicksToWait )
;{
	code
	xdef	_~vTaskPlaceOnUnorderedEventList
	func
_~vTaskPlaceOnUnorderedEventList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L350
	tcs
	phd
	tcd
pxEventList_0	set	3
xItemValue_0	set	7
xTicksToWait_0	set	11
;    traceENTER_vTaskPlaceOnUnorderedEventList( pxEventList, xItemValue, xTicksToWait );
;
;    configASSERT( pxEventList );
	lda	<L350+pxEventList_0
	ora	<L350+pxEventList_0+2
	bne	L10432
	asmstart
	sei
	asmend
L10433:
	bra	L10433
L10432:
;
;    /* THIS FUNCTION MUST BE CALLED WITH THE SCHEDULER SUSPENDED.  It is used by
;     * the event groups implementation. */
;    configASSERT( uxSchedulerSuspended != ( UBaseType_t ) 0U );
	lda	|_~uxSchedulerSuspended	; volatile
	bne	L10436
	asmstart
	sei
	asmend
L10437:
	bra	L10437
L10436:
;
;    /* Store the item value in the event list item.  It is safe to access the
;     * event list item here as interrupts won't access the event list item of a
;     * task that is not in the Blocked state. */
;    listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xEventListItem ), xItemValue | taskEVENT_LIST_ITEM_VALUE_IN_USE );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<L350+xItemValue_0
	sta	<R1
	lda	<L350+xItemValue_0+2
	ora	#^$80000000
	sta	<R1+2
	lda	<R1
	ldy	#$18
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
;
;    /* Place the event list item of the TCB at the end of the appropriate event
;     * list.  It is safe to access the event list here because it is part of an
;     * event group implementation - and interrupts don't access event groups
;     * directly (instead they access them indirectly by pending function calls to
;     * the task level). */
;    listINSERT_END( pxEventList, &( pxCurrentTCB->xEventListItem ) );
pxIndex_2	set	0
	ldy	#$2
	lda	[<L350+pxEventList_0],Y
	sta	<L351+pxIndex_2
	iny
	iny
	lda	[<L350+pxEventList_0],Y
	sta	<L351+pxIndex_2+2
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<L351+pxIndex_2
	ldy	#$1c
	sta	[<R0],Y
	lda	<L351+pxIndex_2+2
	iny
	iny
	sta	[<R0],Y
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$8
	lda	[<L351+pxIndex_2],Y
	ldy	#$20
	sta	[<R0],Y
	ldy	#$a
	lda	[<L351+pxIndex_2],Y
	ldy	#$22
	sta	[<R0],Y
	ldy	#$8
	lda	[<L351+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L351+pxIndex_2],Y
	sta	<R0+2
	lda	#$18
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R1
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$18
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L351+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L351+pxIndex_2],Y
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<L350+pxEventList_0
	ldy	#$28
	sta	[<R0],Y
	lda	<L350+pxEventList_0+2
	iny
	iny
	sta	[<R0],Y
	lda	[<L350+pxEventList_0]
	ina
	sta	[<L350+pxEventList_0]
;
;    prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
	pea	#<$1
	pei	<L350+xTicksToWait_0+2
	pei	<L350+xTicksToWait_0
	jsr	_~prvAddCurrentTaskToDelayedList
;
;    traceRETURN_vTaskPlaceOnUnorderedEventList();
;}
	lda	<L350+1
	sta	<L350+1+12
	pld
	tsc
	clc
	adc	#L350+12
	tcs
	rts
L350	equ	12
L351	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TIMERS == 1 )
;
;    void vTaskPlaceOnEventListRestricted( List_t * const pxEventList,
;                                          TickType_t xTicksToWait,
;                                          const BaseType_t xWaitIndefinitely )
;    {
;        traceENTER_vTaskPlaceOnEventListRestricted( pxEventList, xTicksToWait, xWaitIndefinitely );
;
;        configASSERT( pxEventList );
;
;        /* This function should not be called by application code hence the
;         * 'Restricted' in its name.  It is not part of the public API.  It is
;         * designed for use by kernel code, and has special calling requirements -
;         * it should be called with the scheduler suspended. */
;
;
;        /* Place the event list item of the TCB in the appropriate event list.
;         * In this case it is assume that this is the only task that is going to
;         * be waiting on this event list, so the faster vListInsertEnd() function
;         * can be used in place of vListInsert. */
;        listINSERT_END( pxEventList, &( pxCurrentTCB->xEventListItem ) );
;
;        /* If the task should block indefinitely then set the block time to a
;         * value that will be recognised as an indefinite delay inside the
;         * prvAddCurrentTaskToDelayedList() function. */
;        if( xWaitIndefinitely != pdFALSE )
;        {
;            xTicksToWait = portMAX_DELAY;
;        }
;
;        traceTASK_DELAY_UNTIL( ( xTickCount + xTicksToWait ) );
;        prvAddCurrentTaskToDelayedList( xTicksToWait, xWaitIndefinitely );
;
;        traceRETURN_vTaskPlaceOnEventListRestricted();
;    }
;
;#endif /* configUSE_TIMERS */
;/*-----------------------------------------------------------*/
;
;BaseType_t xTaskRemoveFromEventList( const List_t * const pxEventList )
;{
	code
	xdef	_~xTaskRemoveFromEventList
	func
_~xTaskRemoveFromEventList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L355
	tcs
	phd
	tcd
pxEventList_0	set	3
;    TCB_t * pxUnblockedTCB;
;    BaseType_t xReturn;
;
;    traceENTER_xTaskRemoveFromEventList( pxEventList );
pxUnblockedTCB_1	set	0
xReturn_1	set	4
;
;    /* THIS FUNCTION MUST BE CALLED FROM A CRITICAL SECTION.  It can also be
;     * called from a critical section within an ISR. */
;
;    /* The event list is sorted in priority order, so the first in the list can
;     * be removed as it is known to be the highest priority.  Remove the TCB from
;     * the delayed list, and add it to the ready list.
;     *
;     * If an event is for a queue that is locked then this function will never
;     * get called - the lock count on the queue will get modified instead.  This
;     * means exclusive access to the event list is guaranteed here.
;     *
;     * This function assumes that a check has already been made to ensure that
;     * pxEventList is not empty. */
;    /* MISRA Ref 11.5.3 [Void pointer assignment] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;    /* coverity[misra_c_2012_rule_11_5_violation] */
;    pxUnblockedTCB = listGET_OWNER_OF_HEAD_ENTRY( pxEventList );
	ldy	#$a
	lda	[<L355+pxEventList_0],Y
	sta	<R0
	iny
	iny
	lda	[<L355+pxEventList_0],Y
	sta	<R0+2
	lda	[<R0],Y
	sta	<L356+pxUnblockedTCB_1
	iny
	iny
	lda	[<R0],Y
	sta	<L356+pxUnblockedTCB_1+2
;    configASSERT( pxUnblockedTCB );
	lda	<L356+pxUnblockedTCB_1
	ora	<L356+pxUnblockedTCB_1+2
	bne	L10449
	asmstart
	sei
	asmend
L10444:
	bra	L10444
;    listREMOVE_ITEM( &( pxUnblockedTCB->xEventListItem ) );
L10449:
pxList_2	set	6
	ldy	#$28
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<L356+pxList_2
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<L356+pxList_2+2
	ldy	#$1c
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$22
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	ldy	#$20
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0+2
	ldy	#$1c
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$1e
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$18
	clc
	adc	<L356+pxUnblockedTCB_1
	sta	<R0
	lda	#$0
	adc	<L356+pxUnblockedTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L356+pxList_2],Y
	cmp	<R0
	bne	L358
	iny
	iny
	lda	[<L356+pxList_2],Y
	cmp	<R0+2
L358:
	bne	L10450
	ldy	#$20
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$2
	sta	[<L356+pxList_2],Y
	ldy	#$22
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$4
	sta	[<L356+pxList_2],Y
L10450:
	lda	#$0
	ldy	#$28
	sta	[<L356+pxUnblockedTCB_1],Y
	iny
	iny
	sta	[<L356+pxUnblockedTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L356+pxList_2]
	sta	[<L356+pxList_2]
;
;    if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;    {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	*+5
	brl	L10469
;        listREMOVE_ITEM( &( pxUnblockedTCB->xStateListItem ) );
pxList_3	set	6
	ldy	#$14
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<L356+pxList_3
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<L356+pxList_3+2
	ldy	#$8
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L356+pxUnblockedTCB_1
	sta	<R0
	lda	#$0
	adc	<L356+pxUnblockedTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L356+pxList_3],Y
	cmp	<R0
	bne	L361
	iny
	iny
	lda	[<L356+pxList_3],Y
	cmp	<R0+2
L361:
	bne	L10455
	ldy	#$c
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$2
	sta	[<L356+pxList_3],Y
	ldy	#$e
	lda	[<L356+pxUnblockedTCB_1],Y
	ldy	#$4
	sta	[<L356+pxList_3],Y
L10455:
	lda	#$0
	ldy	#$14
	sta	[<L356+pxUnblockedTCB_1],Y
	iny
	iny
	sta	[<L356+pxUnblockedTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L356+pxList_3]
	sta	[<L356+pxList_3]
;        prvAddTaskToReadyList( pxUnblockedTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L356+pxUnblockedTCB_1],Y
	bcs	L10465
	lda	[<L356+pxUnblockedTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10465:
pxIndex_4	set	6
	ldy	#$2c
	lda	[<L356+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L356+pxIndex_4
	ldy	#$2
	lda	(<R2),Y
	sta	<L356+pxIndex_4+2
	lda	<L356+pxIndex_4
	ldy	#$8
	sta	[<L356+pxUnblockedTCB_1],Y
	lda	<L356+pxIndex_4+2
	iny
	iny
	sta	[<L356+pxUnblockedTCB_1],Y
	dey
	dey
	lda	[<L356+pxIndex_4],Y
	ldy	#$c
	sta	[<L356+pxUnblockedTCB_1],Y
	dey
	dey
	lda	[<L356+pxIndex_4],Y
	ldy	#$e
	sta	[<L356+pxUnblockedTCB_1],Y
	ldy	#$8
	lda	[<L356+pxIndex_4],Y
	sta	<R0
	iny
	iny
	lda	[<L356+pxIndex_4],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L356+pxUnblockedTCB_1
	sta	<R1
	lda	#$0
	adc	<L356+pxUnblockedTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L356+pxUnblockedTCB_1
	sta	<R0
	lda	#$0
	adc	<L356+pxUnblockedTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L356+pxIndex_4],Y
	lda	<R0+2
	iny
	iny
	sta	[<L356+pxIndex_4],Y
	ldy	#$2c
	lda	[<L356+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L356+pxUnblockedTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L356+pxUnblockedTCB_1],Y
	ldy	#$2c
	lda	[<L356+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L356+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;        #if ( configUSE_TICKLESS_IDLE != 0 )
;        {
;            /* If a task is blocked on a kernel object then xNextTaskUnblockTime
;             * might be set to the blocked task's time out time.  If the task is
;             * unblocked for a reason other than a timeout xNextTaskUnblockTime is
;             * normally left unchanged, because it is automatically reset to a new
;             * value when the tick count equals xNextTaskUnblockTime.  However if
;             * tickless idling is used it might be more important to enter sleep mode
;             * at the earliest possible time - so reset xNextTaskUnblockTime here to
;             * ensure it is updated at the earliest possible time. */
;            prvResetNextTaskUnblockTime();
;        }
;        #endif
;    }
;    else
	brl	L10466
;    {
;        /* The delayed and ready lists cannot be accessed, so hold this task
;         * pending until the scheduler is resumed. */
;        listINSERT_END( &( xPendingReadyList ), &( pxUnblockedTCB->xEventListItem ) );
L10469:
pxIndex_5	set	6
	lda	|_~xPendingReadyList+2
	sta	<L356+pxIndex_5
	lda	|_~xPendingReadyList+2+2
	sta	<L356+pxIndex_5+2
	lda	<L356+pxIndex_5
	ldy	#$1c
	sta	[<L356+pxUnblockedTCB_1],Y
	lda	<L356+pxIndex_5+2
	iny
	iny
	sta	[<L356+pxUnblockedTCB_1],Y
	ldy	#$8
	lda	[<L356+pxIndex_5],Y
	ldy	#$20
	sta	[<L356+pxUnblockedTCB_1],Y
	ldy	#$a
	lda	[<L356+pxIndex_5],Y
	ldy	#$22
	sta	[<L356+pxUnblockedTCB_1],Y
	ldy	#$8
	lda	[<L356+pxIndex_5],Y
	sta	<R0
	iny
	iny
	lda	[<L356+pxIndex_5],Y
	sta	<R0+2
	lda	#$18
	clc
	adc	<L356+pxUnblockedTCB_1
	sta	<R1
	lda	#$0
	adc	<L356+pxUnblockedTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$18
	clc
	adc	<L356+pxUnblockedTCB_1
	sta	<R0
	lda	#$0
	adc	<L356+pxUnblockedTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L356+pxIndex_5],Y
	lda	<R0+2
	iny
	iny
	sta	[<L356+pxIndex_5],Y
	lda	#<_~xPendingReadyList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$28
	sta	[<L356+pxUnblockedTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L356+pxUnblockedTCB_1],Y
	inc	|_~xPendingReadyList
;    }
L10466:
;
;    #if ( configNUMBER_OF_CORES == 1 )
;    {
;        if( pxUnblockedTCB->uxPriority > pxCurrentTCB->uxPriority )
;        {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L356+pxUnblockedTCB_1],Y
	bcs	L10470
;            /* Return true if the task removed from the event list has a higher
;             * priority than the calling task.  This allows the calling task to know if
;             * it should force a context switch now. */
;            xReturn = pdTRUE;
	lda	#$1
	sta	<L356+xReturn_1
;
;            /* Mark that a yield is pending in case the user is not using the
;             * "xHigherPriorityTaskWoken" parameter to an ISR safe FreeRTOS function. */
;            xYieldPendings[ 0 ] = pdTRUE;
	sta	|_~xYieldPendings	; volatile
;        }
;        else
	bra	L10471
L10470:
;        {
;            xReturn = pdFALSE;
	stz	<L356+xReturn_1
;        }
L10471:
;    }
;    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;    {
;        xReturn = pdFALSE;
;
;        #if ( configUSE_PREEMPTION == 1 )
;        {
;            prvYieldForTask( pxUnblockedTCB );
;
;            if( xYieldPendings[ portGET_CORE_ID() ] != pdFALSE )
;            {
;                xReturn = pdTRUE;
;            }
;        }
;        #endif /* #if ( configUSE_PREEMPTION == 1 ) */
;    }
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;    traceRETURN_xTaskRemoveFromEventList( xReturn );
;    return xReturn;
	lda	<L356+xReturn_1
	tay
	lda	<L355+1
	sta	<L355+1+4
	pld
	tsc
	clc
	adc	#L355+4
	tcs
	tya
	rts
;}
L355	equ	22
L356	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vTaskRemoveFromUnorderedEventList( ListItem_t * pxEventListItem,
;                                        const TickType_t xItemValue )
;{
	code
	xdef	_~vTaskRemoveFromUnorderedEventList
	func
_~vTaskRemoveFromUnorderedEventList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L366
	tcs
	phd
	tcd
pxEventListItem_0	set	3
xItemValue_0	set	7
;    TCB_t * pxUnblockedTCB;
;
;    traceENTER_vTaskRemoveFromUnorderedEventList( pxEventListItem, xItemValue );
pxUnblockedTCB_1	set	0
;
;    /* THIS FUNCTION MUST BE CALLED WITH THE SCHEDULER SUSPENDED.  It is used by
;     * the event flags implementation. */
;    configASSERT( uxSchedulerSuspended != ( UBaseType_t ) 0U );
	lda	|_~uxSchedulerSuspended	; volatile
	bne	L10472
	asmstart
	sei
	asmend
L10473:
	bra	L10473
L10472:
;
;    /* Store the new item value in the event list. */
;    listSET_LIST_ITEM_VALUE( pxEventListItem, xItemValue | taskEVENT_LIST_ITEM_VALUE_IN_USE );
	lda	<L366+xItemValue_0
	sta	<R0
	lda	<L366+xItemValue_0+2
	ora	#^$80000000
	sta	<R0+2
	lda	<R0
	sta	[<L366+pxEventListItem_0]
	lda	<R0+2
	ldy	#$2
	sta	[<L366+pxEventListItem_0],Y
;
;    /* Remove the event list form the event flag.  Interrupts do not access
;     * event flags. */
;    /* MISRA Ref 11.5.3 [Void pointer assignment] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;    /* coverity[misra_c_2012_rule_11_5_violation] */
;    pxUnblockedTCB = listGET_LIST_ITEM_OWNER( pxEventListItem );
	ldy	#$c
	lda	[<L366+pxEventListItem_0],Y
	sta	<L367+pxUnblockedTCB_1
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	<L367+pxUnblockedTCB_1+2
;    configASSERT( pxUnblockedTCB );
	lda	<L367+pxUnblockedTCB_1
	ora	<L367+pxUnblockedTCB_1+2
	bne	L10482
	asmstart
	sei
	asmend
L10477:
	bra	L10477
;    listREMOVE_ITEM( pxEventListItem );
L10482:
pxList_2	set	4
	ldy	#$10
	lda	[<L366+pxEventListItem_0],Y
	sta	<L367+pxList_2
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	<L367+pxList_2+2
	ldy	#$4
	lda	[<L366+pxEventListItem_0],Y
	sta	<R0
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	<R0+2
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	[<R0],Y
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	[<R0],Y
	dey
	dey
	lda	[<L366+pxEventListItem_0],Y
	sta	<R0
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	<R0+2
	ldy	#$4
	lda	[<L366+pxEventListItem_0],Y
	sta	[<R0],Y
	iny
	iny
	lda	[<L366+pxEventListItem_0],Y
	sta	[<R0],Y
	ldy	#$2
	lda	[<L367+pxList_2],Y
	cmp	<L366+pxEventListItem_0
	bne	L370
	iny
	iny
	lda	[<L367+pxList_2],Y
	cmp	<L366+pxEventListItem_0+2
L370:
	bne	L10483
	ldy	#$8
	lda	[<L366+pxEventListItem_0],Y
	ldy	#$2
	sta	[<L367+pxList_2],Y
	ldy	#$a
	lda	[<L366+pxEventListItem_0],Y
	ldy	#$4
	sta	[<L367+pxList_2],Y
L10483:
	lda	#$0
	ldy	#$10
	sta	[<L366+pxEventListItem_0],Y
	iny
	iny
	sta	[<L366+pxEventListItem_0],Y
	lda	#$ffff
	clc
	adc	[<L367+pxList_2]
	sta	[<L367+pxList_2]
;
;    #if ( configUSE_TICKLESS_IDLE != 0 )
;    {
;        /* If a task is blocked on a kernel object then xNextTaskUnblockTime
;         * might be set to the blocked task's time out time.  If the task is
;         * unblocked for a reason other than a timeout xNextTaskUnblockTime is
;         * normally left unchanged, because it is automatically reset to a new
;         * value when the tick count equals xNextTaskUnblockTime.  However if
;         * tickless idling is used it might be more important to enter sleep mode
;         * at the earliest possible time - so reset xNextTaskUnblockTime here to
;         * ensure it is updated at the earliest possible time. */
;        prvResetNextTaskUnblockTime();
;    }
;    #endif
;
;    /* Remove the task from the delayed list and add it to the ready list.  The
;     * scheduler is suspended so interrupts will not be accessing the ready
;     * lists. */
;    listREMOVE_ITEM( &( pxUnblockedTCB->xStateListItem ) );
pxList_3	set	4
	iny
	iny
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	<L367+pxList_3
	iny
	iny
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	<L367+pxList_3+2
	ldy	#$8
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L367+pxUnblockedTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L367+pxUnblockedTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L367+pxUnblockedTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L367+pxUnblockedTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L367+pxUnblockedTCB_1
	sta	<R0
	lda	#$0
	adc	<L367+pxUnblockedTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L367+pxList_3],Y
	cmp	<R0
	bne	L372
	iny
	iny
	lda	[<L367+pxList_3],Y
	cmp	<R0+2
L372:
	bne	L10487
	ldy	#$c
	lda	[<L367+pxUnblockedTCB_1],Y
	ldy	#$2
	sta	[<L367+pxList_3],Y
	ldy	#$e
	lda	[<L367+pxUnblockedTCB_1],Y
	ldy	#$4
	sta	[<L367+pxList_3],Y
L10487:
	lda	#$0
	ldy	#$14
	sta	[<L367+pxUnblockedTCB_1],Y
	iny
	iny
	sta	[<L367+pxUnblockedTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L367+pxList_3]
	sta	[<L367+pxList_3]
;    prvAddTaskToReadyList( pxUnblockedTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L367+pxUnblockedTCB_1],Y
	bcs	L10497
	lda	[<L367+pxUnblockedTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10497:
pxIndex_4	set	4
	ldy	#$2c
	lda	[<L367+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L367+pxIndex_4
	ldy	#$2
	lda	(<R2),Y
	sta	<L367+pxIndex_4+2
	lda	<L367+pxIndex_4
	ldy	#$8
	sta	[<L367+pxUnblockedTCB_1],Y
	lda	<L367+pxIndex_4+2
	iny
	iny
	sta	[<L367+pxUnblockedTCB_1],Y
	dey
	dey
	lda	[<L367+pxIndex_4],Y
	ldy	#$c
	sta	[<L367+pxUnblockedTCB_1],Y
	dey
	dey
	lda	[<L367+pxIndex_4],Y
	ldy	#$e
	sta	[<L367+pxUnblockedTCB_1],Y
	ldy	#$8
	lda	[<L367+pxIndex_4],Y
	sta	<R0
	iny
	iny
	lda	[<L367+pxIndex_4],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L367+pxUnblockedTCB_1
	sta	<R1
	lda	#$0
	adc	<L367+pxUnblockedTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L367+pxUnblockedTCB_1
	sta	<R0
	lda	#$0
	adc	<L367+pxUnblockedTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L367+pxIndex_4],Y
	lda	<R0+2
	iny
	iny
	sta	[<L367+pxIndex_4],Y
	ldy	#$2c
	lda	[<L367+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L367+pxUnblockedTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L367+pxUnblockedTCB_1],Y
	ldy	#$2c
	lda	[<L367+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L367+pxUnblockedTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;    #if ( configNUMBER_OF_CORES == 1 )
;    {
;        if( pxUnblockedTCB->uxPriority > pxCurrentTCB->uxPriority )
;        {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L367+pxUnblockedTCB_1],Y
	bcs	L376
;            /* The unblocked task has a priority above that of the calling task, so
;             * a context switch is required.  This function is called with the
;             * scheduler suspended so xYieldPending is set so the context switch
;             * occurs immediately that the scheduler is resumed (unsuspended). */
;            xYieldPendings[ 0 ] = pdTRUE;
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;        }
;    }
;    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;    {
;        #if ( configUSE_PREEMPTION == 1 )
;        {
;            taskENTER_CRITICAL();
;            {
;                prvYieldForTask( pxUnblockedTCB );
;            }
;            taskEXIT_CRITICAL();
;        }
;        #endif
;    }
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;    traceRETURN_vTaskRemoveFromUnorderedEventList();
;}
L376:
	lda	<L366+1
	sta	<L366+1+8
	pld
	tsc
	clc
	adc	#L366+8
	tcs
	rts
L366	equ	20
L367	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vTaskSetTimeOutState( TimeOut_t * const pxTimeOut )
;{
	code
	xdef	_~vTaskSetTimeOutState
	func
_~vTaskSetTimeOutState:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L377
	tcs
	phd
	tcd
pxTimeOut_0	set	3
;    traceENTER_vTaskSetTimeOutState( pxTimeOut );
;
;    configASSERT( pxTimeOut );
	lda	<L377+pxTimeOut_0
	ora	<L377+pxTimeOut_0+2
	bne	L10499
	asmstart
	sei
	asmend
L10500:
	bra	L10500
L10499:
;    taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;    {
;        pxTimeOut->xOverflowCount = xNumOfOverflows;
	lda	|_~xNumOfOverflows	; volatile
	sta	[<L377+pxTimeOut_0]
;        pxTimeOut->xTimeOnEntering = xTickCount;
	lda	|_~xTickCount	; volatile
	ldy	#$2
	sta	[<L377+pxTimeOut_0],Y
	lda	|_~xTickCount+2	; volatile
	iny
	iny
	sta	[<L377+pxTimeOut_0],Y
;    }
;    taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;    traceRETURN_vTaskSetTimeOutState();
;}
	lda	<L377+1
	sta	<L377+1+4
	pld
	tsc
	clc
	adc	#L377+4
	tcs
	rts
L377	equ	0
L378	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vTaskInternalSetTimeOutState( TimeOut_t * const pxTimeOut )
;{
	code
	xdef	_~vTaskInternalSetTimeOutState
	func
_~vTaskInternalSetTimeOutState:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L381
	tcs
	phd
	tcd
pxTimeOut_0	set	3
;    traceENTER_vTaskInternalSetTimeOutState( pxTimeOut );
;
;    /* For internal use only as it does not use a critical section. */
;    pxTimeOut->xOverflowCount = xNumOfOverflows;
	lda	|_~xNumOfOverflows	; volatile
	sta	[<L381+pxTimeOut_0]
;    pxTimeOut->xTimeOnEntering = xTickCount;
	lda	|_~xTickCount	; volatile
	ldy	#$2
	sta	[<L381+pxTimeOut_0],Y
	lda	|_~xTickCount+2	; volatile
	iny
	iny
	sta	[<L381+pxTimeOut_0],Y
;
;    traceRETURN_vTaskInternalSetTimeOutState();
;}
	lda	<L381+1
	sta	<L381+1+4
	pld
	tsc
	clc
	adc	#L381+4
	tcs
	rts
L381	equ	0
L382	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xTaskCheckForTimeOut( TimeOut_t * const pxTimeOut,
;                                 TickType_t * const pxTicksToWait )
;{
	code
	xdef	_~xTaskCheckForTimeOut
	func
_~xTaskCheckForTimeOut:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L384
	tcs
	phd
	tcd
pxTimeOut_0	set	3
pxTicksToWait_0	set	7
;    BaseType_t xReturn;
;
;    traceENTER_xTaskCheckForTimeOut( pxTimeOut, pxTicksToWait );
xReturn_1	set	0
;
;    configASSERT( pxTimeOut );
	lda	<L384+pxTimeOut_0
	ora	<L384+pxTimeOut_0+2
	bne	L10503
	asmstart
	sei
	asmend
L10504:
	bra	L10504
L10503:
;    configASSERT( pxTicksToWait );
	lda	<L384+pxTicksToWait_0
	ora	<L384+pxTicksToWait_0+2
	bne	L10507
	asmstart
	sei
	asmend
L10508:
	bra	L10508
L10507:
;
;    taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;    {
;        /* Minor optimisation.  The tick count cannot change in this block. */
;        const TickType_t xConstTickCount = xTickCount;
;        const TickType_t xElapsedTime = xConstTickCount - pxTimeOut->xTimeOnEntering;
;
;        #if ( INCLUDE_xTaskAbortDelay == 1 )
;            if( pxCurrentTCB->ucDelayAborted != ( uint8_t ) pdFALSE )
;            {
;                /* The delay was aborted, which is not the same as a time out,
;                 * but has the same result. */
;                pxCurrentTCB->ucDelayAborted = ( uint8_t ) pdFALSE;
;                xReturn = pdTRUE;
;            }
;            else
;        #endif
;
;        #if ( INCLUDE_vTaskSuspend == 1 )
;            if( *pxTicksToWait == portMAX_DELAY )
xConstTickCount_2	set	2
xElapsedTime_2	set	6
	lda	|_~xTickCount	; volatile
	sta	<L385+xConstTickCount_2
	lda	|_~xTickCount+2	; volatile
	sta	<L385+xConstTickCount_2+2
	sec
	lda	<L385+xConstTickCount_2
	ldy	#$2
	sbc	[<L384+pxTimeOut_0],Y
	sta	<L385+xElapsedTime_2
	lda	<L385+xConstTickCount_2+2
	iny
	iny
	sbc	[<L384+pxTimeOut_0],Y
	sta	<L385+xElapsedTime_2+2
;            {
	lda	[<L384+pxTicksToWait_0]
	cmp	#<$ffffffff
	bne	L388
	dey
	dey
	lda	[<L384+pxTicksToWait_0],Y
	cmp	#^$ffffffff
L388:
	bne	L10511
;                /* If INCLUDE_vTaskSuspend is set to 1 and the block time
;                 * specified is the maximum block time then the task should block
;                 * indefinitely, and therefore never time out. */
;                xReturn = pdFALSE;
L20037:
	stz	<L385+xReturn_1
;            }
;            else
	bra	L10512
L10511:
;        #endif
;
;        if( ( xNumOfOverflows != pxTimeOut->xOverflowCount ) && ( xConstTickCount >= pxTimeOut->xTimeOnEntering ) )
;        {
	lda	|_~xNumOfOverflows	; volatile
	cmp	[<L384+pxTimeOut_0]
	beq	L10513
	lda	<L385+xConstTickCount_2
	ldy	#$2
	cmp	[<L384+pxTimeOut_0],Y
	lda	<L385+xConstTickCount_2+2
	iny
	iny
	sbc	[<L384+pxTimeOut_0],Y
	bcc	L10513
;            /* The tick count is greater than the time at which
;             * vTaskSetTimeout() was called, but has also overflowed since
;             * vTaskSetTimeOut() was called.  It must have wrapped all the way
;             * around and gone past again. This passed since vTaskSetTimeout()
;             * was called. */
;            xReturn = pdTRUE;
	lda	#$1
	sta	<L385+xReturn_1
;            *pxTicksToWait = ( TickType_t ) 0;
	dea
	sta	[<L384+pxTicksToWait_0]
	dey
	dey
	sta	[<L384+pxTicksToWait_0],Y
;        }
;        else if( xElapsedTime < *pxTicksToWait )
	bra	L10512
L10513:
;        {
	lda	<L385+xElapsedTime_2
	cmp	[<L384+pxTicksToWait_0]
	lda	<L385+xElapsedTime_2+2
	ldy	#$2
	sbc	[<L384+pxTicksToWait_0],Y
	bcs	L10515
;            /* Not a genuine timeout. Adjust parameters for time remaining. */
;            *pxTicksToWait -= xElapsedTime;
	sec
	lda	[<L384+pxTicksToWait_0]
	sbc	<L385+xElapsedTime_2
	sta	[<L384+pxTicksToWait_0]
	lda	[<L384+pxTicksToWait_0],Y
	sbc	<L385+xElapsedTime_2+2
	sta	[<L384+pxTicksToWait_0],Y
;            vTaskInternalSetTimeOutState( pxTimeOut );
	pei	<L384+pxTimeOut_0+2
	pei	<L384+pxTimeOut_0
	jsr	_~vTaskInternalSetTimeOutState
;            xReturn = pdFALSE;
;        }
;        else
	bra	L20037
L10515:
;        {
;            *pxTicksToWait = ( TickType_t ) 0;
	lda	#$0
	sta	[<L384+pxTicksToWait_0]
	ldy	#$2
	sta	[<L384+pxTicksToWait_0],Y
;            xReturn = pdTRUE;
	ina
	sta	<L385+xReturn_1
;        }
L10512:
;    }
;    taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;    traceRETURN_xTaskCheckForTimeOut( xReturn );
;
;    return xReturn;
	lda	<L385+xReturn_1
	tay
	lda	<L384+1
	sta	<L384+1+8
	pld
	tsc
	clc
	adc	#L384+8
	tcs
	tya
	rts
;}
L384	equ	10
L385	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vTaskMissedYield( void )
;{
	code
	xdef	_~vTaskMissedYield
	func
_~vTaskMissedYield:
	longa	on
	longi	on
;    traceENTER_vTaskMissedYield();
;
;    /* Must be called from within a critical section. */
;    xYieldPendings[ portGET_CORE_ID() ] = pdTRUE;
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;
;    traceRETURN_vTaskMissedYield();
;}
	rts
L394	equ	0
L395	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    UBaseType_t uxTaskGetTaskNumber( TaskHandle_t xTask )
;    {
;        UBaseType_t uxReturn;
;        TCB_t const * pxTCB;
;
;        traceENTER_uxTaskGetTaskNumber( xTask );
;
;        if( xTask != NULL )
;        {
;            pxTCB = xTask;
;            uxReturn = pxTCB->uxTaskNumber;
;        }
;        else
;        {
;            uxReturn = 0U;
;        }
;
;        traceRETURN_uxTaskGetTaskNumber( uxReturn );
;
;        return uxReturn;
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    void vTaskSetTaskNumber( TaskHandle_t xTask,
;                             const UBaseType_t uxHandle )
;    {
;        TCB_t * pxTCB;
;
;        traceENTER_vTaskSetTaskNumber( xTask, uxHandle );
;
;        if( xTask != NULL )
;        {
;            pxTCB = xTask;
;            pxTCB->uxTaskNumber = uxHandle;
;        }
;
;        traceRETURN_vTaskSetTaskNumber();
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;/*
; * -----------------------------------------------------------
; * The passive idle task.
; * ----------------------------------------------------------
; *
; * The passive idle task is used for all the additional cores in a SMP
; * system. There must be only 1 active idle task and the rest are passive
; * idle tasks.
; *
; * The portTASK_FUNCTION() macro is used to allow port/compiler specific
; * language extensions.  The equivalent prototype for this function is:
; *
; * void prvPassiveIdleTask( void *pvParameters );
; */
;
;#if ( configNUMBER_OF_CORES > 1 )
;    STATIC portTASK_FUNCTION( prvPassiveIdleTask,
;                              pvParameters )
;    {
;        ( void ) pvParameters;
;
;        taskYIELD();
;
;        for( ; configCONTROL_INFINITE_LOOP(); )
;        {
;            #if ( configUSE_PREEMPTION == 0 )
;            {
;                /* If we are not using preemption we keep forcing a task switch to
;                 * see if any other task has become available.  If we are using
;                 * preemption we don't need to do this as any task becoming available
;                 * will automatically get the processor anyway. */
;                taskYIELD();
;            }
;            #endif /* configUSE_PREEMPTION */
;
;            #if ( ( configUSE_PREEMPTION == 1 ) && ( configIDLE_SHOULD_YIELD == 1 ) )
;            {
;                /* When using preemption tasks of equal priority will be
;                 * timesliced.  If a task that is sharing the idle priority is ready
;                 * to run then the idle task should yield before the end of the
;                 * timeslice.
;                 *
;                 * A critical region is not required here as we are just reading from
;                 * the list, and an occasional incorrect value will not matter.  If
;                 * the ready list at the idle priority contains one more task than the
;                 * number of idle tasks, which is equal to the configured numbers of cores
;                 * then a task other than the idle task is ready to execute. */
;                if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ tskIDLE_PRIORITY ] ) ) > ( UBaseType_t ) configNUMBER_OF_CORES )
;                {
;                    taskYIELD();
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            #endif /* ( ( configUSE_PREEMPTION == 1 ) && ( configIDLE_SHOULD_YIELD == 1 ) ) */
;
;            #if ( configUSE_PASSIVE_IDLE_HOOK == 1 )
;            {
;                /* Call the user defined function from within the idle task.  This
;                 * allows the application designer to add background functionality
;                 * without the overhead of a separate task.
;                 *
;                 * This hook is intended to manage core activity such as disabling cores that go idle.
;                 *
;                 * NOTE: vApplicationPassiveIdleHook() MUST NOT, UNDER ANY CIRCUMSTANCES,
;                 * CALL A FUNCTION THAT MIGHT BLOCK. */
;                vApplicationPassiveIdleHook();
;            }
;            #endif /* configUSE_PASSIVE_IDLE_HOOK */
;        }
;    }
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;/*
; * -----------------------------------------------------------
; * The idle task.
; * ----------------------------------------------------------
; *
; * The portTASK_FUNCTION() macro is used to allow port/compiler specific
; * language extensions.  The equivalent prototype for this function is:
; *
; * void prvIdleTask( void *pvParameters );
; *
; */
;
;STATIC portTASK_FUNCTION( prvIdleTask,
;                          pvParameters )
;{
	code
	func
_~prvIdleTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L397
	tcs
	phd
	tcd
pvParameters_0	set	3
;    /* Stop warnings. */
;    ( void ) pvParameters;
;
;    /** THIS IS THE RTOS IDLE TASK - WHICH IS CREATED AUTOMATICALLY WHEN THE
;     * SCHEDULER IS STARTED. **/
;
;    /* In case a task that has a secure context deletes itself, in which case
;     * the idle task is responsible for deleting the task's secure context, if
;     * any. */
;    portALLOCATE_SECURE_CONTEXT( configMINIMAL_SECURE_STACK_SIZE );
;
;    #if ( configNUMBER_OF_CORES > 1 )
;    {
;        /* SMP all cores start up in the idle task. This initial yield gets the application
;         * tasks started. */
;        taskYIELD();
;    }
;    #endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;    for( ; configCONTROL_INFINITE_LOOP(); )
	bra	L10519
L20039:
;				//*debug_char = 'Y';
;                taskYIELD();
	jsl	_~vPortYield
;            }
;            else
L10519:
;    {
;		//*debug_char = '*';
;		
;        /* See if any tasks have deleted themselves - if so then the idle task
;         * is responsible for freeing the deleted task's TCB and stack. */
;        prvCheckTasksWaitingTermination();
	jsr	_~prvCheckTasksWaitingTermination
;
;        #if ( configUSE_PREEMPTION == 0 )
;        {
;            /* If we are not using preemption we keep forcing a task switch to
;             * see if any other task has become available.  If we are using
;             * preemption we don't need to do this as any task becoming available
;             * will automatically get the processor anyway. */
;            taskYIELD();
;        }
;        #endif /* configUSE_PREEMPTION */
;
;        #if ( ( configUSE_PREEMPTION == 1 ) && ( configIDLE_SHOULD_YIELD == 1 ) )
;        {
;            /* When using preemption tasks of equal priority will be
;             * timesliced.  If a task that is sharing the idle priority is ready
;             * to run then the idle task should yield before the end of the
;             * timeslice.
;             *
;             * A critical region is not required here as we are just reading from
;             * the list, and an occasional incorrect value will not matter.  If
;             * the ready list at the idle priority contains one more task than the
;             * number of idle tasks, which is equal to the configured numbers of cores
;             * then a task other than the idle task is ready to execute. */
;            if( listCURRENT_LIST_LENGTH( &( pxReadyTasksLists[ tskIDLE_PRIORITY ] ) ) > ( UBaseType_t ) configNUMBER_OF_CORES )
;            {
	lda	#$1
	cmp	|_~pxReadyTasksLists
	bcc	L20039
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* ( ( configUSE_PREEMPTION == 1 ) && ( configIDLE_SHOULD_YIELD == 1 ) ) */
;
;        #if ( configUSE_IDLE_HOOK == 1 )
;        {
;            /* Call the user defined function from within the idle task. */
;            vApplicationIdleHook();
;        }
;        #endif /* configUSE_IDLE_HOOK */
;
;        /* This conditional compilation should use inequality to 0, not equality
;         * to 1.  This is to ensure portSUPPRESS_TICKS_AND_SLEEP() is called when
;         * user defined low power mode  implementations require
;         * configUSE_TICKLESS_IDLE to be set to a value other than 1. */
;        #if ( configUSE_TICKLESS_IDLE != 0 )
;        {
;            TickType_t xExpectedIdleTime;
;
;            /* It is not desirable to suspend then resume the scheduler on
;             * each iteration of the idle task.  Therefore, a preliminary
;             * test of the expected idle time is performed without the
;             * scheduler suspended.  The result here is not necessarily
;             * valid. */
;            xExpectedIdleTime = prvGetExpectedIdleTime();
;
;            if( xExpectedIdleTime >= ( TickType_t ) configEXPECTED_IDLE_TIME_BEFORE_SLEEP )
;            {
;                vTaskSuspendAll();
;                {
;                    /* Now the scheduler is suspended, the expected idle
;                     * time can be sampled again, and this time its value can
;                     * be used. */
;                    configASSERT( xNextTaskUnblockTime >= xTickCount );
;                    xExpectedIdleTime = prvGetExpectedIdleTime();
;
;                    /* Define the following macro to set xExpectedIdleTime to 0
;                     * if the application does not want
;                     * portSUPPRESS_TICKS_AND_SLEEP() to be called. */
;                    configPRE_SUPPRESS_TICKS_AND_SLEEP_PROCESSING( xExpectedIdleTime );
;
;                    if( xExpectedIdleTime >= ( TickType_t ) configEXPECTED_IDLE_TIME_BEFORE_SLEEP )
;                    {
;                        traceLOW_POWER_IDLE_BEGIN();
;                        portSUPPRESS_TICKS_AND_SLEEP( xExpectedIdleTime );
;                        traceLOW_POWER_IDLE_END();
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                ( void ) xTaskResumeAll();
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* configUSE_TICKLESS_IDLE */
;
;        #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_PASSIVE_IDLE_HOOK == 1 ) )
;        {
;            /* Call the user defined function from within the idle task.  This
;             * allows the application designer to add background functionality
;             * without the overhead of a separate task.
;             *
;             * This hook is intended to manage core activity such as disabling cores that go idle.
;             *
;             * NOTE: vApplicationPassiveIdleHook() MUST NOT, UNDER ANY CIRCUMSTANCES,
;             * CALL A FUNCTION THAT MIGHT BLOCK. */
;            vApplicationPassiveIdleHook();
;        }
;        #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_PASSIVE_IDLE_HOOK == 1 ) ) */
;    }
	bra	L10519
;}
L397	equ	0
L398	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TICKLESS_IDLE != 0 )
;
;    eSleepModeStatus eTaskConfirmSleepModeStatus( void )
;    {
;        #if ( INCLUDE_vTaskSuspend == 1 )
;            /* The idle task exists in addition to the application tasks. */
;            const UBaseType_t uxNonApplicationTasks = configNUMBER_OF_CORES;
;        #endif /* INCLUDE_vTaskSuspend */
;
;        eSleepModeStatus eReturn = eStandardSleep;
;
;        traceENTER_eTaskConfirmSleepModeStatus();
;
;        /* This function must be called from a critical section. */
;
;        if( listCURRENT_LIST_LENGTH( &xPendingReadyList ) != 0U )
;        {
;            /* A task was made ready while the scheduler was suspended. */
;            eReturn = eAbortSleep;
;        }
;        else if( xYieldPendings[ portGET_CORE_ID() ] != pdFALSE )
;        {
;            /* A yield was pended while the scheduler was suspended. */
;            eReturn = eAbortSleep;
;        }
;        else if( xPendedTicks != 0U )
;        {
;            /* A tick interrupt has already occurred but was held pending
;             * because the scheduler is suspended. */
;            eReturn = eAbortSleep;
;        }
;
;        #if ( INCLUDE_vTaskSuspend == 1 )
;            else if( listCURRENT_LIST_LENGTH( &xSuspendedTaskList ) == ( uxCurrentNumberOfTasks - uxNonApplicationTasks ) )
;            {
;                /* If all the tasks are in the suspended list (which might mean they
;                 * have an infinite block time rather than actually being suspended)
;                 * then it is safe to turn all clocks off and just wait for external
;                 * interrupts. */
;                eReturn = eNoTasksWaitingTimeout;
;            }
;        #endif /* INCLUDE_vTaskSuspend */
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_eTaskConfirmSleepModeStatus( eReturn );
;
;        return eReturn;
;    }
;
;#endif /* configUSE_TICKLESS_IDLE */
;/*-----------------------------------------------------------*/
;
;#if ( configNUM_THREAD_LOCAL_STORAGE_POINTERS != 0 )
;
;    void vTaskSetThreadLocalStoragePointer( TaskHandle_t xTaskToSet,
;                                            BaseType_t xIndex,
;                                            void * pvValue )
;    {
;        TCB_t * pxTCB;
;
;        traceENTER_vTaskSetThreadLocalStoragePointer( xTaskToSet, xIndex, pvValue );
;
;        if( ( xIndex >= 0 ) &&
;            ( xIndex < ( BaseType_t ) configNUM_THREAD_LOCAL_STORAGE_POINTERS ) )
;        {
;            pxTCB = prvGetTCBFromHandle( xTaskToSet );
;            configASSERT( pxTCB != NULL );
;            pxTCB->pvThreadLocalStoragePointers[ xIndex ] = pvValue;
;        }
;
;        traceRETURN_vTaskSetThreadLocalStoragePointer();
;    }
;
;#endif /* configNUM_THREAD_LOCAL_STORAGE_POINTERS */
;/*-----------------------------------------------------------*/
;
;#if ( configNUM_THREAD_LOCAL_STORAGE_POINTERS != 0 )
;
;    void * pvTaskGetThreadLocalStoragePointer( TaskHandle_t xTaskToQuery,
;                                               BaseType_t xIndex )
;    {
;        void * pvReturn = NULL;
;        TCB_t * pxTCB;
;
;        traceENTER_pvTaskGetThreadLocalStoragePointer( xTaskToQuery, xIndex );
;
;        if( ( xIndex >= 0 ) &&
;            ( xIndex < ( BaseType_t ) configNUM_THREAD_LOCAL_STORAGE_POINTERS ) )
;        {
;            pxTCB = prvGetTCBFromHandle( xTaskToQuery );
;            configASSERT( pxTCB != NULL );
;
;            pvReturn = pxTCB->pvThreadLocalStoragePointers[ xIndex ];
;        }
;        else
;        {
;            pvReturn = NULL;
;        }
;
;        traceRETURN_pvTaskGetThreadLocalStoragePointer( pvReturn );
;
;        return pvReturn;
;    }
;
;#endif /* configNUM_THREAD_LOCAL_STORAGE_POINTERS */
;/*-----------------------------------------------------------*/
;
;#if ( portUSING_MPU_WRAPPERS == 1 )
;
;    void vTaskAllocateMPURegions( TaskHandle_t xTaskToModify,
;                                  const MemoryRegion_t * const pxRegions )
;    {
;        TCB_t * pxTCB;
;
;        traceENTER_vTaskAllocateMPURegions( xTaskToModify, pxRegions );
;
;        /* If null is passed in here then we are modifying the MPU settings of
;         * the calling task. */
;        pxTCB = prvGetTCBFromHandle( xTaskToModify );
;        configASSERT( pxTCB != NULL );
;
;        vPortStoreTaskMPUSettings( &( pxTCB->xMPUSettings ), pxRegions, NULL, 0 );
;
;        traceRETURN_vTaskAllocateMPURegions();
;    }
;
;#endif /* portUSING_MPU_WRAPPERS */
;/*-----------------------------------------------------------*/
;
;STATIC void prvInitialiseTaskLists( void )
;{
	code
	func
_~prvInitialiseTaskLists:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L400
	tcs
	phd
	tcd
;    UBaseType_t uxPriority;
;
;    for( uxPriority = ( UBaseType_t ) 0U; uxPriority < ( UBaseType_t ) configMAX_PRIORITIES; uxPriority++ )
uxPriority_1	set	0
	stz	<L401+uxPriority_1
L10524:
;    {
;        vListInitialise( &( pxReadyTasksLists[ uxPriority ] ) );
	lda	<L401+uxPriority_1
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;    }
	inc	<L401+uxPriority_1
	lda	<L401+uxPriority_1
	cmp	#<$5
	bcc	L10524
;
;    vListInitialise( &xDelayedTaskList1 );
	lda	#<_~xDelayedTaskList1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;    vListInitialise( &xDelayedTaskList2 );
	lda	#<_~xDelayedTaskList2
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;    vListInitialise( &xPendingReadyList );
	lda	#<_~xPendingReadyList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;
;    #if ( INCLUDE_vTaskDelete == 1 )
;    {
;        vListInitialise( &xTasksWaitingTermination );
	lda	#<_~xTasksWaitingTermination
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;    }
;    #endif /* INCLUDE_vTaskDelete */
;
;    #if ( INCLUDE_vTaskSuspend == 1 )
;    {
;        vListInitialise( &xSuspendedTaskList );
	lda	#<_~xSuspendedTaskList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;    }
;    #endif /* INCLUDE_vTaskSuspend */
;
;    /* Start with pxDelayedTaskList using list1 and the pxOverflowDelayedTaskList
;     * using list2. */
;    pxDelayedTaskList = &xDelayedTaskList1;
	lda	#<_~xDelayedTaskList1
	sta	|_~pxDelayedTaskList	; volatile
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|_~pxDelayedTaskList+2	; volatile
;    pxOverflowDelayedTaskList = &xDelayedTaskList2;
	lda	#<_~xDelayedTaskList2
	sta	|_~pxOverflowDelayedTaskList	; volatile
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|_~pxOverflowDelayedTaskList+2	; volatile
;}
	pld
	tsc
	clc
	adc	#L400
	tcs
	rts
L400	equ	14
L401	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;STATIC void prvCheckTasksWaitingTermination( void )
;{
	code
	func
_~prvCheckTasksWaitingTermination:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L404
	tcs
	phd
	tcd
;    /** THIS FUNCTION IS CALLED FROM THE RTOS IDLE TASK **/
;
;    #if ( INCLUDE_vTaskDelete == 1 )
;    {
;        TCB_t * pxTCB;
;
;        /* uxDeletedTasksWaitingCleanUp is used to prevent taskENTER_CRITICAL()
;         * being called too often in the idle task. */
;        while( uxDeletedTasksWaitingCleanUp > ( UBaseType_t ) 0U )
pxTCB_2	set	0
	bra	L10525
L20041:
;        {
;            #if ( configNUMBER_OF_CORES == 1 )
;            {
;                taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;                {
;                    {
;                        /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                        /* coverity[misra_c_2012_rule_11_5_violation] */
;                        pxTCB = listGET_OWNER_OF_HEAD_ENTRY( ( &xTasksWaitingTermination ) );
	lda	|_~xTasksWaitingTermination+10
	sta	<R0
	lda	|_~xTasksWaitingTermination+10+2
	sta	<R0+2
	ldy	#$c
	lda	[<R0],Y
	sta	<L405+pxTCB_2
	iny
	iny
	lda	[<R0],Y
	sta	<L405+pxTCB_2+2
;                        ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	<L405+pxTCB_2
	sta	<R0
	lda	#$0
	adc	<L405+pxTCB_2+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;                        --uxCurrentNumberOfTasks;
	dec	|_~uxCurrentNumberOfTasks	; volatile
;                        --uxDeletedTasksWaitingCleanUp;
	dec	|_~uxDeletedTasksWaitingCleanUp	; volatile
;                    }
;                }
;                taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;                prvDeleteTCB( pxTCB );
	pei	<L405+pxTCB_2+2
	pei	<L405+pxTCB_2
	jsr	_~prvDeleteTCB
;            }
;            #else /* #if( configNUMBER_OF_CORES == 1 ) */
;            {
;                pxTCB = NULL;
;
;                taskENTER_CRITICAL();
;                {
;                    /* For SMP, multiple idles can be running simultaneously
;                     * and we need to check that other idles did not cleanup while we were
;                     * waiting to enter the critical section. */
;                    if( uxDeletedTasksWaitingCleanUp > ( UBaseType_t ) 0U )
;                    {
;                        /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                        /* coverity[misra_c_2012_rule_11_5_violation] */
;                        pxTCB = listGET_OWNER_OF_HEAD_ENTRY( ( &xTasksWaitingTermination ) );
;
;                        if( pxTCB->xTaskRunState == taskTASK_NOT_RUNNING )
;                        {
;                            ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
;                            --uxCurrentNumberOfTasks;
;                            --uxDeletedTasksWaitingCleanUp;
;                        }
;                        else
;                        {
;                            /* The TCB to be deleted still has not yet been switched out
;                             * by the scheduler, so we will just exit this loop early and
;                             * try again next time. */
;                            taskEXIT_CRITICAL();
;                            break;
;                        }
;                    }
;                }
;                taskEXIT_CRITICAL();
;
;                if( pxTCB != NULL )
;                {
;                    prvDeleteTCB( pxTCB );
;                }
;            }
;            #endif /* #if( configNUMBER_OF_CORES == 1 ) */
;        }
L10525:
	lda	#$0
	cmp	|_~uxDeletedTasksWaitingCleanUp	; volatile
	bcc	L20041
;    }
;    #endif /* INCLUDE_vTaskDelete */
;}
	pld
	tsc
	clc
	adc	#L404
	tcs
	rts
L404	equ	12
L405	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    void vTaskGetInfo( TaskHandle_t xTask,
;                       TaskStatus_t * pxTaskStatus,
;                       BaseType_t xGetFreeStackSpace,
;                       eTaskState eState )
;    {
;        TCB_t * pxTCB;
;
;        traceENTER_vTaskGetInfo( xTask, pxTaskStatus, xGetFreeStackSpace, eState );
;
;        /* xTask is NULL then get the state of the calling task. */
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        pxTaskStatus->xHandle = pxTCB;
;        pxTaskStatus->pcTaskName = ( const char * ) &( pxTCB->pcTaskName[ 0 ] );
;        pxTaskStatus->uxCurrentPriority = pxTCB->uxPriority;
;        pxTaskStatus->pxStackBase = pxTCB->pxStack;
;        #if ( ( portSTACK_GROWTH > 0 ) || ( configRECORD_STACK_HIGH_ADDRESS == 1 ) )
;            pxTaskStatus->pxTopOfStack = ( StackType_t * ) pxTCB->pxTopOfStack;
;            pxTaskStatus->pxEndOfStack = pxTCB->pxEndOfStack;
;        #endif
;        pxTaskStatus->xTaskNumber = pxTCB->uxTCBNumber;
;
;        #if ( ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 ) )
;        {
;            pxTaskStatus->uxCoreAffinityMask = pxTCB->uxCoreAffinityMask;
;        }
;        #endif
;
;        #if ( configUSE_MUTEXES == 1 )
;        {
;            pxTaskStatus->uxBasePriority = pxTCB->uxBasePriority;
;        }
;        #else
;        {
;            pxTaskStatus->uxBasePriority = 0;
;        }
;        #endif
;
;        #if ( configGENERATE_RUN_TIME_STATS == 1 )
;        {
;            pxTaskStatus->ulRunTimeCounter = ulTaskGetRunTimeCounter( xTask );
;        }
;        #else
;        {
;            pxTaskStatus->ulRunTimeCounter = ( configRUN_TIME_COUNTER_TYPE ) 0;
;        }
;        #endif
;
;        /* Obtaining the task state is a little fiddly, so is only done if the
;         * value of eState passed into this function is eInvalid - otherwise the
;         * state is just set to whatever is passed in. */
;        if( eState != eInvalid )
;        {
;            if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;            {
;                pxTaskStatus->eCurrentState = eRunning;
;            }
;            else
;            {
;                pxTaskStatus->eCurrentState = eState;
;
;                #if ( INCLUDE_vTaskSuspend == 1 )
;                {
;                    /* If the task is in the suspended list then there is a
;                     *  chance it is actually just blocked indefinitely - so really
;                     *  it should be reported as being in the Blocked state. */
;                    if( eState == eSuspended )
;                    {
;                        vTaskSuspendAll();
;                        {
;                            if( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) != NULL )
;                            {
;                                pxTaskStatus->eCurrentState = eBlocked;
;                            }
;                            else
;                            {
;                                #if ( configUSE_TASK_NOTIFICATIONS == 1 )
;                                {
;                                    BaseType_t x;
;
;                                    /* The task does not appear on the event list item of
;                                     * and of the RTOS objects, but could still be in the
;                                     * blocked state if it is waiting on its notification
;                                     * rather than waiting on an object.  If not, is
;                                     * suspended. */
;                                    for( x = ( BaseType_t ) 0; x < ( BaseType_t ) configTASK_NOTIFICATION_ARRAY_ENTRIES; x++ )
;                                    {
;                                        if( pxTCB->ucNotifyState[ x ] == taskWAITING_NOTIFICATION )
;                                        {
;                                            pxTaskStatus->eCurrentState = eBlocked;
;                                            break;
;                                        }
;                                    }
;                                }
;                                #endif /* if ( configUSE_TASK_NOTIFICATIONS == 1 ) */
;                            }
;                        }
;                        ( void ) xTaskResumeAll();
;                    }
;                }
;                #endif /* INCLUDE_vTaskSuspend */
;
;                /* Tasks can be in pending ready list and other state list at the
;                 * same time. These tasks are in ready state no matter what state
;                 * list the task is in. */
;                taskENTER_CRITICAL();
;                {
;                    if( listIS_CONTAINED_WITHIN( &xPendingReadyList, &( pxTCB->xEventListItem ) ) != pdFALSE )
;                    {
;                        pxTaskStatus->eCurrentState = eReady;
;                    }
;                }
;                taskEXIT_CRITICAL();
;            }
;        }
;        else
;        {
;            pxTaskStatus->eCurrentState = eTaskGetState( pxTCB );
;        }
;
;        /* Obtaining the stack space takes some time, so the xGetFreeStackSpace
;         * parameter is provided to allow it to be skipped. */
;        if( xGetFreeStackSpace != pdFALSE )
;        {
;            #if ( portSTACK_GROWTH > 0 )
;            {
;                pxTaskStatus->usStackHighWaterMark = prvTaskCheckFreeStackSpace( ( uint8_t * ) pxTCB->pxEndOfStack );
;            }
;            #else
;            {
;                pxTaskStatus->usStackHighWaterMark = prvTaskCheckFreeStackSpace( ( uint8_t * ) pxTCB->pxStack );
;            }
;            #endif
;        }
;        else
;        {
;            pxTaskStatus->usStackHighWaterMark = 0;
;        }
;
;        traceRETURN_vTaskGetInfo();
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TRACE_FACILITY == 1 )
;
;    STATIC UBaseType_t prvForEachTaskInList( List_t * pxList,
;                                             eTaskState eState,
;                                             TaskStatusCallbackFunction_t pxCallbackFunction,
;                                             void * pvCallbackContext )
;    {
;        UBaseType_t uxTask = 0;
;        const ListItem_t * pxEndMarker = listGET_END_MARKER( pxList );
;        ListItem_t * pxIterator;
;        TCB_t * pxTCB = NULL;
;
;        if( listCURRENT_LIST_LENGTH( pxList ) > ( UBaseType_t ) 0 )
;        {
;            /* Hand the callback each task handle referenced from pxList. */
;            for( pxIterator = listGET_HEAD_ENTRY( pxList ); pxIterator != pxEndMarker; pxIterator = listGET_NEXT( pxIterator ) )
;            {
;                /* MISRA Ref 11.5.3 [Void pointer assignment] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                /* coverity[misra_c_2012_rule_11_5_violation] */
;                pxTCB = listGET_LIST_ITEM_OWNER( pxIterator );
;
;                pxCallbackFunction( ( TaskHandle_t ) pxTCB, eState, pvCallbackContext );
;                uxTask++;
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        return uxTask;
;    }
;
;#endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_TRACE_FACILITY == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark2 == 1 ) )
;
;    STATIC configSTACK_DEPTH_TYPE prvTaskCheckFreeStackSpace( const uint8_t * pucStackByte )
;    {
	code
	func
_~prvTaskCheckFreeStackSpace:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L408
	tcs
	phd
	tcd
pucStackByte_0	set	3
;        configSTACK_DEPTH_TYPE uxCount = 0U;
;
;        while( *pucStackByte == ( uint8_t ) tskSTACK_FILL_BYTE )
uxCount_1	set	0
	stz	<L409+uxCount_1
	bra	L10527
L20043:
;        {
;            pucStackByte -= portSTACK_GROWTH;
	inc	<L408+pucStackByte_0
	bne	L411
	inc	<L408+pucStackByte_0+2
L411:
;            uxCount++;
	inc	<L409+uxCount_1
;        }
L10527:
	sep	#$20
	longa	off
	lda	[<L408+pucStackByte_0]
	cmp	#<$a5
	rep	#$20
	longa	on
	beq	L20043
;
;        uxCount /= ( configSTACK_DEPTH_TYPE ) sizeof( StackType_t );
	lsr	<L409+uxCount_1
;
;        return uxCount;
	lda	<L409+uxCount_1
	tay
	lda	<L408+1
	sta	<L408+1+4
	pld
	tsc
	clc
	adc	#L408+4
	tcs
	tya
	rts
;    }
L408	equ	2
L409	equ	1
	ends
	efunc
;
;#endif /* ( ( configUSE_TRACE_FACILITY == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark == 1 ) || ( INCLUDE_uxTaskGetStackHighWaterMark2 == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_uxTaskGetStackHighWaterMark2 == 1 )
;
;/* uxTaskGetStackHighWaterMark() and uxTaskGetStackHighWaterMark2() are the
; * same except for their return type.  Using configSTACK_DEPTH_TYPE allows the
; * user to determine the return type.  It gets around the problem of the value
; * overflowing on 8-bit types without breaking backward compatibility for
; * applications that expect an 8-bit return type. */
;    configSTACK_DEPTH_TYPE uxTaskGetStackHighWaterMark2( TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;        uint8_t * pucEndOfStack;
;        configSTACK_DEPTH_TYPE uxReturn;
;
;        traceENTER_uxTaskGetStackHighWaterMark2( xTask );
;
;        /* uxTaskGetStackHighWaterMark() and uxTaskGetStackHighWaterMark2() are
;         * the same except for their return type.  Using configSTACK_DEPTH_TYPE
;         * allows the user to determine the return type.  It gets around the
;         * problem of the value overflowing on 8-bit types without breaking
;         * backward compatibility for applications that expect an 8-bit return
;         * type. */
;
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        #if portSTACK_GROWTH < 0
;        {
;            pucEndOfStack = ( uint8_t * ) pxTCB->pxStack;
;        }
;        #else
;        {
;            pucEndOfStack = ( uint8_t * ) pxTCB->pxEndOfStack;
;        }
;        #endif
;
;        uxReturn = prvTaskCheckFreeStackSpace( pucEndOfStack );
;
;        traceRETURN_uxTaskGetStackHighWaterMark2( uxReturn );
;
;        return uxReturn;
;    }
;
;#endif /* INCLUDE_uxTaskGetStackHighWaterMark2 */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_uxTaskGetStackHighWaterMark == 1 )
;
;    UBaseType_t uxTaskGetStackHighWaterMark( TaskHandle_t xTask )
;    {
	code
	xdef	_~uxTaskGetStackHighWaterMark
	func
_~uxTaskGetStackHighWaterMark:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L413
	tcs
	phd
	tcd
xTask_0	set	3
;        TCB_t * pxTCB;
;        uint8_t * pucEndOfStack;
;        UBaseType_t uxReturn;
;
;        traceENTER_uxTaskGetStackHighWaterMark( xTask );
pxTCB_1	set	0
pucEndOfStack_1	set	4
uxReturn_1	set	8
;
;        pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L413+xTask_0
	ora	<L413+xTask_0+2
	bne	L415
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L417
L415:
	ldx	<L413+xTask_0+2
	lda	<L413+xTask_0
L417:
	stx	<R0+2
	sta	<L414+pxTCB_1
	lda	<R0+2
	sta	<L414+pxTCB_1+2
;        configASSERT( pxTCB != NULL );
	lda	<L414+pxTCB_1
	ora	<L414+pxTCB_1+2
	bne	L10529
	asmstart
	sei
	asmend
L10530:
	bra	L10530
L10529:
;
;        #if portSTACK_GROWTH < 0
;        {
;            pucEndOfStack = ( uint8_t * ) pxTCB->pxStack;
	ldy	#$2e
	lda	[<L414+pxTCB_1],Y
	sta	<L414+pucEndOfStack_1
	iny
	iny
	lda	[<L414+pxTCB_1],Y
	sta	<L414+pucEndOfStack_1+2
;        }
;        #else
;        {
;            pucEndOfStack = ( uint8_t * ) pxTCB->pxEndOfStack;
;        }
;        #endif
;
;        uxReturn = ( UBaseType_t ) prvTaskCheckFreeStackSpace( pucEndOfStack );
	pha
	pei	<L414+pucEndOfStack_1
	jsr	_~prvTaskCheckFreeStackSpace
	sta	<L414+uxReturn_1
;
;        traceRETURN_uxTaskGetStackHighWaterMark( uxReturn );
;
;        return uxReturn;
	tay
	lda	<L413+1
	sta	<L413+1+4
	pld
	tsc
	clc
	adc	#L413+4
	tcs
	tya
	rts
;    }
L413	equ	14
L414	equ	5
	ends
	efunc
;
;#endif /* INCLUDE_uxTaskGetStackHighWaterMark */
;/*-----------------------------------------------------------*/
;
;#if ( INCLUDE_vTaskDelete == 1 )
;
;    STATIC void prvDeleteTCB( TCB_t * pxTCB )
;    {
	code
	func
_~prvDeleteTCB:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L420
	tcs
	phd
	tcd
pxTCB_0	set	3
;        /* This call is required specifically for the TriCore port.  It must be
;         * above the vPortFree() calls.  The call is also used by ports/demos that
;         * want to allocate and clean RAM statically. */
;        portCLEAN_UP_TCB( pxTCB );
;
;        #if ( configUSE_C_RUNTIME_TLS_SUPPORT == 1 )
;        {
;            /* Free up the memory allocated for the task's TLS Block. */
;            configDEINIT_TLS_BLOCK( pxTCB->xTLSBlock );
;        }
;        #endif
;
;        #if ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 0 ) && ( portUSING_MPU_WRAPPERS == 0 ) )
;        {
;            /* The task can only have been allocated dynamically - free both
;             * the stack and TCB. */
;            vPortFreeStack( pxTCB->pxStack );
	ldy	#$30
	lda	[<L420+pxTCB_0],Y
	pha
	dey
	dey
	lda	[<L420+pxTCB_0],Y
	pha
	jsr	_~vPortFreeStack
;            vPortFree( pxTCB );
	pei	<L420+pxTCB_0+2
	pei	<L420+pxTCB_0
	jsr	_~vPortFree
;        }
;        #elif ( tskSTATIC_AND_DYNAMIC_ALLOCATION_POSSIBLE != 0 )
;        {
;            /* The task could have been allocated statically or dynamically, so
;             * check what was statically allocated before trying to free the
;             * memory. */
;            if( pxTCB->ucStaticallyAllocated == tskDYNAMICALLY_ALLOCATED_STACK_AND_TCB )
;            {
;                /* Both the stack and TCB were allocated dynamically, so both
;                 * must be freed. */
;                vPortFreeStack( pxTCB->pxStack );
;                vPortFree( pxTCB );
;            }
;            else if( pxTCB->ucStaticallyAllocated == tskSTATICALLY_ALLOCATED_STACK_ONLY )
;            {
;                /* Only the stack was statically allocated, so the TCB is the
;                 * only memory that must be freed. */
;                vPortFree( pxTCB );
;            }
;            else
;            {
;                /* Neither the stack nor the TCB were allocated dynamically, so
;                 * nothing needs to be freed. */
;                configASSERT( pxTCB->ucStaticallyAllocated == tskSTATICALLY_ALLOCATED_STACK_AND_TCB );
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;    }
	lda	<L420+1
	sta	<L420+1+4
	pld
	tsc
	clc
	adc	#L420+4
	tcs
	rts
L420	equ	0
L421	equ	1
	ends
	efunc
;
;#endif /* INCLUDE_vTaskDelete */
;/*-----------------------------------------------------------*/
;
;STATIC void prvResetNextTaskUnblockTime( void )
;{
	code
	func
_~prvResetNextTaskUnblockTime:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L423
	tcs
	phd
	tcd
;    if( listLIST_IS_EMPTY( pxDelayedTaskList ) != pdFALSE )
;    {
	lda	|_~pxDelayedTaskList	; volatile
	sta	<R0
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<R0+2
	lda	[<R0]
	bne	L425
	lda	#$1
	bra	L427
L425:
	lda	#$0
L427:
	tax
	beq	L10533
;        /* The new current delayed list is empty.  Set xNextTaskUnblockTime to
;         * the maximum possible value so it is  extremely unlikely that the
;         * if( xTickCount >= xNextTaskUnblockTime ) test will pass until
;         * there is an item in the delayed list. */
;        xNextTaskUnblockTime = portMAX_DELAY;
	lda	#$ffff
	sta	|_~xNextTaskUnblockTime	; volatile
	bra	L20044
;    }
;    else
L10533:
;    {
;        /* The new current delayed list is not empty, get the value of
;         * the item at the head of the delayed list.  This is the time at
;         * which the task at the head of the delayed list should be removed
;         * from the Blocked state. */
;        xNextTaskUnblockTime = listGET_ITEM_VALUE_OF_HEAD_ENTRY( pxDelayedTaskList );
	lda	|_~pxDelayedTaskList	; volatile
	sta	<R0
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<R0+2
	ldy	#$a
	lda	[<R0],Y
	sta	<R1
	iny
	iny
	lda	[<R0],Y
	sta	<R1+2
	lda	[<R1]
	sta	|_~xNextTaskUnblockTime	; volatile
	ldy	#$2
	lda	[<R1],Y
L20044:
	sta	|_~xNextTaskUnblockTime+2	; volatile
;    }
;}
	pld
	tsc
	clc
	adc	#L423
	tcs
	rts
L423	equ	8
L424	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( ( INCLUDE_xTaskGetCurrentTaskHandle == 1 ) || ( configUSE_RECURSIVE_MUTEXES == 1 ) ) || ( configNUMBER_OF_CORES > 1 )
;
;    #if ( configNUMBER_OF_CORES == 1 )
;        TaskHandle_t xTaskGetCurrentTaskHandle( void )
;        {
	code
	xdef	_~xTaskGetCurrentTaskHandle
	func
_~xTaskGetCurrentTaskHandle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L430
	tcs
	phd
	tcd
;            TaskHandle_t xReturn;
;
;            traceENTER_xTaskGetCurrentTaskHandle();
xReturn_1	set	0
;
;            /* A critical section is not required as this is not called from
;             * an interrupt and the current TCB will always be the same for any
;             * individual execution thread. */
;            xReturn = pxCurrentTCB;
	lda	|_~pxCurrentTCB	; volatile
	sta	<L431+xReturn_1
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<L431+xReturn_1+2
;
;            traceRETURN_xTaskGetCurrentTaskHandle( xReturn );
;
;            return xReturn;
	ldx	<L431+xReturn_1+2
	lda	<L431+xReturn_1
	tay
	pld
	tsc
	clc
	adc	#L430
	tcs
	tya
	rts
;        }
L430	equ	4
L431	equ	1
	ends
	efunc
;    #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;        TaskHandle_t xTaskGetCurrentTaskHandle( void )
;        {
;            TaskHandle_t xReturn;
;            UBaseType_t uxSavedInterruptStatus;
;
;            traceENTER_xTaskGetCurrentTaskHandle();
;
;            uxSavedInterruptStatus = portSET_INTERRUPT_MASK();
;            {
;                xReturn = pxCurrentTCBs[ portGET_CORE_ID() ];
;            }
;            portCLEAR_INTERRUPT_MASK( uxSavedInterruptStatus );
;
;            traceRETURN_xTaskGetCurrentTaskHandle( xReturn );
;
;            return xReturn;
;        }
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;    TaskHandle_t xTaskGetCurrentTaskHandleForCore( BaseType_t xCoreID )
;    {
	code
	xdef	_~xTaskGetCurrentTaskHandleForCore
	func
_~xTaskGetCurrentTaskHandleForCore:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L433
	tcs
	phd
	tcd
xCoreID_0	set	3
;        TaskHandle_t xReturn = NULL;
;
;        traceENTER_xTaskGetCurrentTaskHandleForCore( xCoreID );
xReturn_1	set	0
	stz	<L434+xReturn_1
	stz	<L434+xReturn_1+2
;
;        if( taskVALID_CORE_ID( xCoreID ) != pdFALSE )
;        {
	lda	<L433+xCoreID_0
	bmi	L435
	lda	<L433+xCoreID_0
	bmi	L437
	dea
	bpl	L435
L437:
	lda	#$1
	bra	L438
L435:
	lda	#$0
L438:
	tax
	beq	L10535
;            #if ( configNUMBER_OF_CORES == 1 )
;                xReturn = pxCurrentTCB;
	lda	|_~pxCurrentTCB	; volatile
	sta	<L434+xReturn_1
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<L434+xReturn_1+2
;            #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                xReturn = pxCurrentTCBs[ xCoreID ];
;            #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;        }
;
;        traceRETURN_xTaskGetCurrentTaskHandleForCore( xReturn );
L10535:
;
;        return xReturn;
	ldx	<L434+xReturn_1+2
	lda	<L434+xReturn_1
	tay
	lda	<L433+1
	sta	<L433+1+2
	pld
	tsc
	clc
	adc	#L433+2
	tcs
	tya
	rts
;    }
L433	equ	4
L434	equ	1
	ends
	efunc
;
;#endif /* ( ( INCLUDE_xTaskGetCurrentTaskHandle == 1 ) || ( configUSE_RECURSIVE_MUTEXES == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;
;    BaseType_t xTaskGetSchedulerState( void )
;    {
	code
	xdef	_~xTaskGetSchedulerState
	func
_~xTaskGetSchedulerState:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L441
	tcs
	phd
	tcd
;        BaseType_t xReturn;
;
;        traceENTER_xTaskGetSchedulerState();
xReturn_1	set	0
;
;        if( xSchedulerRunning == pdFALSE )
;        {
	lda	|_~xSchedulerRunning	; volatile
	bne	L10536
;            xReturn = taskSCHEDULER_NOT_STARTED;
	lda	#$1
	bra	L20045
L20047:
;                    xReturn = taskSCHEDULER_RUNNING;
	lda	#$2
;                }
;                else
L20045:
	sta	<L442+xReturn_1
;        }
;        else
	bra	L10537
L10536:
;        {
;            #if ( configNUMBER_OF_CORES > 1 )
;                taskENTER_CRITICAL();
;            #endif
;            {
;                if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;                {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	L20047
;                {
;                    xReturn = taskSCHEDULER_SUSPENDED;
	stz	<L442+xReturn_1
;                }
;            }
;            #if ( configNUMBER_OF_CORES > 1 )
;                taskEXIT_CRITICAL();
;            #endif
;        }
L10537:
;
;        traceRETURN_xTaskGetSchedulerState( xReturn );
;
;        return xReturn;
	lda	<L442+xReturn_1
	tay
	pld
	tsc
	clc
	adc	#L441
	tcs
	tya
	rts
;    }
L441	equ	2
L442	equ	1
	ends
	efunc
;
;#endif /* ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_MUTEXES == 1 )
;
;    BaseType_t xTaskPriorityInherit( TaskHandle_t const pxMutexHolder )
;    {
	code
	xdef	_~xTaskPriorityInherit
	func
_~xTaskPriorityInherit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L446
	tcs
	phd
	tcd
pxMutexHolder_0	set	3
;        TCB_t * const pxMutexHolderTCB = pxMutexHolder;
;        BaseType_t xReturn = pdFALSE;
;
;        traceENTER_xTaskPriorityInherit( pxMutexHolder );
pxMutexHolderTCB_1	set	0
xReturn_1	set	4
	lda	<L446+pxMutexHolder_0
	sta	<L447+pxMutexHolderTCB_1
	lda	<L446+pxMutexHolder_0+2
	sta	<L447+pxMutexHolderTCB_1+2
	stz	<L447+xReturn_1
;
;        /* If the mutex is taken by an interrupt, the mutex holder is NULL. Priority
;         * inheritance is not applied in this scenario. */
;        if( pxMutexHolder != NULL )
;        {
	lda	<L446+pxMutexHolder_0
	ora	<L446+pxMutexHolder_0+2
	bne	*+5
	brl	L10561
;            /* If the holder of the mutex has a priority below the priority of
;             * the task attempting to obtain the mutex then it will temporarily
;             * inherit the priority of the task attempting to obtain the mutex. */
;            if( pxMutexHolderTCB->uxPriority < pxCurrentTCB->uxPriority )
;            {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<L447+pxMutexHolderTCB_1],Y
	cmp	[<R0],Y
	bcc	*+5
	brl	L10541
;                /* Adjust the mutex holder state to account for its new
;                 * priority.  Only reset the event list item value if the value is
;                 * not being used for anything else. */
;                if( ( listGET_LIST_ITEM_VALUE( &( pxMutexHolderTCB->xEventListItem ) ) & taskEVENT_LIST_ITEM_VALUE_IN_USE ) == ( ( TickType_t ) 0U ) )
;                {
	ldy	#$1a
	lda	[<L447+pxMutexHolderTCB_1],Y
	and	#^$80000000
	bne	L10543
;                    listSET_LIST_ITEM_VALUE( &( pxMutexHolderTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) pxCurrentTCB->uxPriority );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	sta	<R0
	stz	<R0+2
	sec
	lda	#$5
	sbc	<R0
	sta	<R1
	lda	#$0
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$18
	sta	[<L447+pxMutexHolderTCB_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L447+pxMutexHolderTCB_1],Y
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10543:
;
;                /* If the task being modified is in the ready state it will need
;                 * to be moved into a new list. */
;                if( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ pxMutexHolderTCB->uxPriority ] ), &( pxMutexHolderTCB->xStateListItem ) ) != pdFALSE )
;                {
	ldy	#$2c
	lda	[<L447+pxMutexHolderTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	cmp	[<L447+pxMutexHolderTCB_1],Y
	bne	L452
	lda	<R0+2
	iny
	iny
	cmp	[<L447+pxMutexHolderTCB_1],Y
L452:
	bne	L451
	lda	#$1
	bra	L454
L451:
	lda	#$0
L454:
	tax
	bne	*+5
	brl	L10544
;                    if( uxListRemove( &( pxMutexHolderTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
;                    {
	lda	#$4
	clc
	adc	<L447+pxMutexHolderTCB_1
	sta	<R0
	lda	#$0
	adc	<L447+pxMutexHolderTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10546
;                        /* It is known that the task is in its ready list so
;                         * there is no need to check again and the port level
;                         * reset macro can be called directly. */
;                        portRESET_READY_PRIORITY( pxMutexHolderTCB->uxPriority, uxTopReadyPriority );
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10546:
;
;                    /* Inherit the priority before being moved into the new list. */
;                    pxMutexHolderTCB->uxPriority = pxCurrentTCB->uxPriority;
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	sta	[<L447+pxMutexHolderTCB_1],Y
;                    prvAddTaskToReadyList( pxMutexHolderTCB );
	lda	|_~uxTopReadyPriority	; volatile
	cmp	[<L447+pxMutexHolderTCB_1],Y
	bcs	L10556
	lda	[<L447+pxMutexHolderTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10556:
pxIndex_2	set	6
	ldy	#$2c
	lda	[<L447+pxMutexHolderTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L447+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L447+pxIndex_2+2
	lda	<L447+pxIndex_2
	ldy	#$8
	sta	[<L447+pxMutexHolderTCB_1],Y
	lda	<L447+pxIndex_2+2
	iny
	iny
	sta	[<L447+pxMutexHolderTCB_1],Y
	dey
	dey
	lda	[<L447+pxIndex_2],Y
	ldy	#$c
	sta	[<L447+pxMutexHolderTCB_1],Y
	dey
	dey
	lda	[<L447+pxIndex_2],Y
	ldy	#$e
	sta	[<L447+pxMutexHolderTCB_1],Y
	ldy	#$8
	lda	[<L447+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L447+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L447+pxMutexHolderTCB_1
	sta	<R1
	lda	#$0
	adc	<L447+pxMutexHolderTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L447+pxMutexHolderTCB_1
	sta	<R0
	lda	#$0
	adc	<L447+pxMutexHolderTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L447+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L447+pxIndex_2],Y
	ldy	#$2c
	lda	[<L447+pxMutexHolderTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L447+pxMutexHolderTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L447+pxMutexHolderTCB_1],Y
	ldy	#$2c
	lda	[<L447+pxMutexHolderTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L447+pxMutexHolderTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;                    #if ( configNUMBER_OF_CORES > 1 )
;                    {
;                        /* The priority of the task is raised. Yield for this task
;                         * if it is not running. */
;                        if( taskTASK_IS_RUNNING( pxMutexHolderTCB ) != pdTRUE )
;                        {
;                            prvYieldForTask( pxMutexHolderTCB );
;                        }
;                    }
;                    #endif /* if ( configNUMBER_OF_CORES > 1 ) */
;                }
;                else
	bra	L10557
L10544:
;                {
;                    /* Just inherit the priority. */
;                    pxMutexHolderTCB->uxPriority = pxCurrentTCB->uxPriority;
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	sta	[<L447+pxMutexHolderTCB_1],Y
;                }
L10557:
;
;                traceTASK_PRIORITY_INHERIT( pxMutexHolderTCB, pxCurrentTCB->uxPriority );
;
;                /* Inheritance occurred. */
;                xReturn = pdTRUE;
	lda	#$1
	sta	<L447+xReturn_1
;            }
;            else
L10561:
;
;        traceRETURN_xTaskPriorityInherit( xReturn );
;
;        return xReturn;
	lda	<L447+xReturn_1
	tay
	lda	<L446+1
	sta	<L446+1+4
	pld
	tsc
	clc
	adc	#L446+4
	tcs
	tya
	rts
L10541:
;            {
;                if( pxMutexHolderTCB->uxBasePriority < pxCurrentTCB->uxPriority )
;                {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$42
	lda	[<L447+pxMutexHolderTCB_1],Y
	ldy	#$2c
	cmp	[<R0],Y
	bcs	L10561
;                    /* The base priority of the mutex holder is lower than the
;                     * priority of the task attempting to take the mutex, but the
;                     * current priority of the mutex holder is not lower than the
;                     * priority of the task attempting to take the mutex.
;                     * Therefore the mutex holder must have already inherited a
;                     * priority, but inheritance would have occurred if that had
;                     * not been the case. */
;                    xReturn = pdTRUE;
	bra	L10557
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L446	equ	22
L447	equ	13
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_MUTEXES == 1 )
;
;    BaseType_t xTaskPriorityDisinherit( TaskHandle_t const pxMutexHolder )
;    {
	code
	xdef	_~xTaskPriorityDisinherit
	func
_~xTaskPriorityDisinherit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L460
	tcs
	phd
	tcd
pxMutexHolder_0	set	3
;        TCB_t * const pxTCB = pxMutexHolder;
;        BaseType_t xReturn = pdFALSE;
;
;        traceENTER_xTaskPriorityDisinherit( pxMutexHolder );
pxTCB_1	set	0
xReturn_1	set	4
	lda	<L460+pxMutexHolder_0
	sta	<L461+pxTCB_1
	lda	<L460+pxMutexHolder_0+2
	sta	<L461+pxTCB_1+2
	stz	<L461+xReturn_1
;
;        if( pxMutexHolder != NULL )
;        {
	lda	<L460+pxMutexHolder_0
	ora	<L460+pxMutexHolder_0+2
	bne	*+5
	brl	L10587
;            /* A task can only have an inherited priority if it holds the mutex.
;             * If the mutex is held by a task then it cannot be given from an
;             * interrupt, and if a mutex is given by the holding task then it must
;             * be the running state task. */
;            configASSERT( pxTCB == pxCurrentTCB );
	lda	<L461+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L463
	lda	<L461+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L463:
	beq	L10563
	asmstart
	sei
	asmend
L10564:
	bra	L10564
L10563:
;            configASSERT( pxTCB->uxMutexesHeld );
	ldy	#$44
	lda	[<L461+pxTCB_1],Y
	bne	L10567
	asmstart
	sei
	asmend
L10568:
	bra	L10568
L10567:
;            ( pxTCB->uxMutexesHeld )--;
	clc
	lda	#$ffff
	ldy	#$44
	adc	[<L461+pxTCB_1],Y
	sta	[<L461+pxTCB_1],Y
;
;            /* Has the holder of the mutex inherited the priority of another
;             * task? */
;            if( pxTCB->uxPriority != pxTCB->uxBasePriority )
;            {
	ldy	#$2c
	lda	[<L461+pxTCB_1],Y
	ldy	#$42
	cmp	[<L461+pxTCB_1],Y
	bne	*+5
	brl	L10587
;                /* Only disinherit if no other mutexes are held. */
;                if( pxTCB->uxMutexesHeld == ( UBaseType_t ) 0 )
;                {
	iny
	iny
	lda	[<L461+pxTCB_1],Y
	beq	*+5
	brl	L10587
;                    /* A task can only have an inherited priority if it holds
;                     * the mutex.  If the mutex is held by a task then it cannot be
;                     * given from an interrupt, and if a mutex is given by the
;                     * holding task then it must be the running state task.  Remove
;                     * the holding task from the ready list. */
;                    if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
;                    {
	lda	#$4
	clc
	adc	<L461+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L461+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10574
;                        portRESET_READY_PRIORITY( pxTCB->uxPriority, uxTopReadyPriority );
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10574:
;
;                    /* Disinherit the priority before adding the task into the
;                     * new  ready list. */
;                    traceTASK_PRIORITY_DISINHERIT( pxTCB, pxTCB->uxBasePriority );
;                    pxTCB->uxPriority = pxTCB->uxBasePriority;
	ldy	#$42
	lda	[<L461+pxTCB_1],Y
	ldy	#$2c
	sta	[<L461+pxTCB_1],Y
;
;                    /* Reset the event list item value.  It cannot be in use for
;                     * any other purpose if this task is running, and it must be
;                     * running to give back the mutex. */
;                    listSET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) pxTCB->uxPriority );
	sta	<R0
	stz	<R0+2
	sec
	lda	#$5
	sbc	<R0
	sta	<R1
	lda	#$0
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$18
	sta	[<L461+pxTCB_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L461+pxTCB_1],Y
;                    prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L461+pxTCB_1],Y
	bcs	L10584
	lda	[<L461+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10584:
pxIndex_2	set	6
	ldy	#$2c
	lda	[<L461+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L461+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L461+pxIndex_2+2
	lda	<L461+pxIndex_2
	ldy	#$8
	sta	[<L461+pxTCB_1],Y
	lda	<L461+pxIndex_2+2
	iny
	iny
	sta	[<L461+pxTCB_1],Y
	dey
	dey
	lda	[<L461+pxIndex_2],Y
	ldy	#$c
	sta	[<L461+pxTCB_1],Y
	dey
	dey
	lda	[<L461+pxIndex_2],Y
	ldy	#$e
	sta	[<L461+pxTCB_1],Y
	ldy	#$8
	lda	[<L461+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L461+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L461+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L461+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L461+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L461+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L461+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L461+pxIndex_2],Y
	ldy	#$2c
	lda	[<L461+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L461+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L461+pxTCB_1],Y
	ldy	#$2c
	lda	[<L461+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L461+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;                    #if ( configNUMBER_OF_CORES > 1 )
;                    {
;                        /* The priority of the task is dropped. Yield the core on
;                         * which the task is running. */
;                        if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                        {
;                            prvYieldCore( pxTCB->xTaskRunState );
;                        }
;                    }
;                    #endif /* if ( configNUMBER_OF_CORES > 1 ) */
;
;                    /* Return true to indicate that a context switch is required.
;                     * This is only actually required in the corner case whereby
;                     * multiple mutexes were held and the mutexes were given back
;                     * in an order different to that in which they were taken.
;                     * If a context switch did not occur when the first mutex was
;                     * returned, even if a task was waiting on it, then a context
;                     * switch should occur when the last mutex is returned whether
;                     * a task is waiting on it or not. */
;                    xReturn = pdTRUE;
	lda	#$1
	sta	<L461+xReturn_1
;                }
;                else
;        }
;        else
L10587:
;
;        traceRETURN_xTaskPriorityDisinherit( xReturn );
;
;        return xReturn;
	lda	<L461+xReturn_1
	tay
	lda	<L460+1
	sta	<L460+1+4
	pld
	tsc
	clc
	adc	#L460+4
	tcs
	tya
	rts
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L460	equ	22
L461	equ	13
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_MUTEXES == 1 )
;
;    void vTaskPriorityDisinheritAfterTimeout( TaskHandle_t const pxMutexHolder,
;                                              UBaseType_t uxHighestPriorityWaitingTask )
;    {
	code
	xdef	_~vTaskPriorityDisinheritAfterTimeout
	func
_~vTaskPriorityDisinheritAfterTimeout:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L471
	tcs
	phd
	tcd
pxMutexHolder_0	set	3
uxHighestPriorityWaitingTask_0	set	7
;        TCB_t * const pxTCB = pxMutexHolder;
;        UBaseType_t uxPriorityUsedOnEntry, uxPriorityToUse;
;        const UBaseType_t uxOnlyOneMutexHeld = ( UBaseType_t ) 1;
;
;        traceENTER_vTaskPriorityDisinheritAfterTimeout( pxMutexHolder, uxHighestPriorityWaitingTask );
pxTCB_1	set	0
uxPriorityUsedOnEntry_1	set	4
uxPriorityToUse_1	set	6
uxOnlyOneMutexHeld_1	set	8
	lda	<L471+pxMutexHolder_0
	sta	<L472+pxTCB_1
	lda	<L471+pxMutexHolder_0+2
	sta	<L472+pxTCB_1+2
	lda	#$1
	sta	<L472+uxOnlyOneMutexHeld_1
;
;        if( pxMutexHolder != NULL )
;        {
	lda	<L471+pxMutexHolder_0
	ora	<L471+pxMutexHolder_0+2
	bne	*+5
	brl	L488
;            /* If pxMutexHolder is not NULL then the holder must hold at least
;             * one mutex. */
;            configASSERT( pxTCB->uxMutexesHeld );
	ldy	#$44
	lda	[<L472+pxTCB_1],Y
	bne	L10589
	asmstart
	sei
	asmend
L10590:
	bra	L10590
L10589:
;
;            /* Determine the priority to which the priority of the task that
;             * holds the mutex should be set.  This will be the greater of the
;             * holding task's base priority and the priority of the highest
;             * priority task that is waiting to obtain the mutex. */
;            if( pxTCB->uxBasePriority < uxHighestPriorityWaitingTask )
;            {
	ldy	#$42
	lda	[<L472+pxTCB_1],Y
	cmp	<L471+uxHighestPriorityWaitingTask_0
	bcs	L10593
;                uxPriorityToUse = uxHighestPriorityWaitingTask;
	lda	<L471+uxHighestPriorityWaitingTask_0
	bra	L20049
;            }
;            else
L10593:
;            {
;                uxPriorityToUse = pxTCB->uxBasePriority;
	ldy	#$42
	lda	[<L472+pxTCB_1],Y
L20049:
	sta	<L472+uxPriorityToUse_1
;            }
;
;            /* Does the priority need to change? */
;            if( pxTCB->uxPriority != uxPriorityToUse )
;            {
	ldy	#$2c
	lda	[<L472+pxTCB_1],Y
	cmp	<L472+uxPriorityToUse_1
	bne	*+5
	brl	L488
;                /* Only disinherit if no other mutexes are held.  This is a
;                 * simplification in the priority inheritance implementation.  If
;                 * the task that holds the mutex is also holding other mutexes then
;                 * the other mutexes may have caused the priority inheritance. */
;                if( pxTCB->uxMutexesHeld == uxOnlyOneMutexHeld )
;                {
	ldy	#$44
	lda	[<L472+pxTCB_1],Y
	cmp	#<$1
	beq	*+5
	brl	L488
;                    /* If a task has timed out because it already holds the
;                     * mutex it was trying to obtain then it cannot of inherited
;                     * its own priority. */
;                    configASSERT( pxTCB != pxCurrentTCB );
	lda	<L472+pxTCB_1
	cmp	|_~pxCurrentTCB	; volatile
	bne	L478
	lda	<L472+pxTCB_1+2
	cmp	|_~pxCurrentTCB+2	; volatile
L478:
	bne	L10597
	asmstart
	sei
	asmend
L10598:
	bra	L10598
L10597:
;
;                    /* Disinherit the priority, remembering the previous
;                     * priority to facilitate determining the subject task's
;                     * state. */
;                    traceTASK_PRIORITY_DISINHERIT( pxTCB, uxPriorityToUse );
;                    uxPriorityUsedOnEntry = pxTCB->uxPriority;
	ldy	#$2c
	lda	[<L472+pxTCB_1],Y
	sta	<L472+uxPriorityUsedOnEntry_1
;                    pxTCB->uxPriority = uxPriorityToUse;
	lda	<L472+uxPriorityToUse_1
	sta	[<L472+pxTCB_1],Y
;
;                    /* Only reset the event list item value if the value is not
;                     * being used for anything else. */
;                    if( ( listGET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ) ) & taskEVENT_LIST_ITEM_VALUE_IN_USE ) == ( ( TickType_t ) 0U ) )
;                    {
	ldy	#$1a
	lda	[<L472+pxTCB_1],Y
	and	#^$80000000
	bne	L10602
;                        listSET_LIST_ITEM_VALUE( &( pxTCB->xEventListItem ), ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) uxPriorityToUse );
	lda	<L472+uxPriorityToUse_1
	sta	<R0
	stz	<R0+2
	sec
	lda	#$5
	sbc	<R0
	sta	<R1
	lda	#$0
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	dey
	dey
	sta	[<L472+pxTCB_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L472+pxTCB_1],Y
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10602:
;
;                    /* If the running task is not the task that holds the mutex
;                     * then the task that holds the mutex could be in either the
;                     * Ready, Blocked or Suspended states.  Only remove the task
;                     * from its current state list if it is in the Ready state as
;                     * the task's priority is going to change and there is one
;                     * Ready list per priority. */
;                    if( listIS_CONTAINED_WITHIN( &( pxReadyTasksLists[ uxPriorityUsedOnEntry ] ), &( pxTCB->xStateListItem ) ) != pdFALSE )
;                    {
	lda	<L472+uxPriorityUsedOnEntry_1
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	cmp	[<L472+pxTCB_1],Y
	bne	L482
	lda	<R0+2
	iny
	iny
	cmp	[<L472+pxTCB_1],Y
L482:
	bne	L481
	lda	#$1
	bra	L484
L481:
	lda	#$0
L484:
	tax
	bne	*+5
	brl	L488
;                        if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
;                        {
	lda	#$4
	clc
	adc	<L472+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L472+pxTCB_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10611
;                            /* It is known that the task is in its ready list so
;                             * there is no need to check again and the port level
;                             * reset macro can be called directly. */
;                            portRESET_READY_PRIORITY( uxPriorityUsedOnEntry, uxTopReadyPriority );
;                        }
;                        else
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;
;                        prvAddTaskToReadyList( pxTCB );
L10611:
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L472+pxTCB_1],Y
	bcs	L10615
	lda	[<L472+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10615:
pxIndex_2	set	10
	ldy	#$2c
	lda	[<L472+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L472+pxIndex_2
	ldy	#$2
	lda	(<R2),Y
	sta	<L472+pxIndex_2+2
	lda	<L472+pxIndex_2
	ldy	#$8
	sta	[<L472+pxTCB_1],Y
	lda	<L472+pxIndex_2+2
	iny
	iny
	sta	[<L472+pxTCB_1],Y
	dey
	dey
	lda	[<L472+pxIndex_2],Y
	ldy	#$c
	sta	[<L472+pxTCB_1],Y
	dey
	dey
	lda	[<L472+pxIndex_2],Y
	ldy	#$e
	sta	[<L472+pxTCB_1],Y
	ldy	#$8
	lda	[<L472+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L472+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L472+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L472+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L472+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L472+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L472+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L472+pxIndex_2],Y
	ldy	#$2c
	lda	[<L472+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L472+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L472+pxTCB_1],Y
	ldy	#$2c
	lda	[<L472+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L472+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;                        #if ( configNUMBER_OF_CORES > 1 )
;                        {
;                            /* The priority of the task is dropped. Yield the core on
;                             * which the task is running. */
;                            if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;                            {
;                                prvYieldCore( pxTCB->xTaskRunState );
;                            }
;                        }
;                        #endif /* if ( configNUMBER_OF_CORES > 1 ) */
;                    }
;                    else
;            }
;            else
L488:
	lda	<L471+1
	sta	<L471+1+6
	pld
	tsc
	clc
	adc	#L471+6
	tcs
	rts
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskPriorityDisinheritAfterTimeout();
;    }
L471	equ	26
L472	equ	13
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;/* If not in a critical section then yield immediately.
; * Otherwise set xYieldPendings to true to wait to
; * yield until exiting the critical section.
; */
;    void vTaskYieldWithinAPI( void )
;    {
;        UBaseType_t ulState;
;
;        traceENTER_vTaskYieldWithinAPI();
;
;        ulState = portSET_INTERRUPT_MASK();
;        {
;            const BaseType_t xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;            if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0U )
;            {
;                portYIELD();
;            }
;            else
;            {
;                xYieldPendings[ xCoreID ] = pdTRUE;
;            }
;        }
;        portCLEAR_INTERRUPT_MASK( ulState );
;
;        traceRETURN_vTaskYieldWithinAPI();
;    }
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;/*-----------------------------------------------------------*/
;
;#if ( ( portCRITICAL_NESTING_IN_TCB == 1 ) && ( configNUMBER_OF_CORES == 1 ) )
;
;    void vTaskEnterCritical( void )
;    {
;        traceENTER_vTaskEnterCritical();
;
;        portDISABLE_INTERRUPTS();
;
;        if( xSchedulerRunning != pdFALSE )
;        {
;            ( pxCurrentTCB->uxCriticalNesting )++;
;
;            /* This is not the interrupt safe version of the enter critical
;             * function so  assert() if it is being called from an interrupt
;             * context.  Only API functions that end in "FromISR" can be used in an
;             * interrupt.  Only assert if the critical nesting count is 1 to
;             * protect against recursive calls if the assert function also uses a
;             * critical section. */
;            if( pxCurrentTCB->uxCriticalNesting == 1U )
;            {
;                portASSERT_IF_IN_ISR();
;            }
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskEnterCritical();
;    }
;
;#endif /* #if ( ( portCRITICAL_NESTING_IN_TCB == 1 ) && ( configNUMBER_OF_CORES == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;    void vTaskEnterCritical( void )
;    {
;        traceENTER_vTaskEnterCritical();
;
;        portDISABLE_INTERRUPTS();
;        {
;            const BaseType_t xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;            if( xSchedulerRunning != pdFALSE )
;            {
;                if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0U )
;                {
;                    portGET_TASK_LOCK( xCoreID );
;                    portGET_ISR_LOCK( xCoreID );
;                }
;
;                portINCREMENT_CRITICAL_NESTING_COUNT( xCoreID );
;
;                /* This is not the interrupt safe version of the enter critical
;                 * function so  assert() if it is being called from an interrupt
;                 * context.  Only API functions that end in "FromISR" can be used in an
;                 * interrupt.  Only assert if the critical nesting count is 1 to
;                 * protect against recursive calls if the assert function also uses a
;                 * critical section. */
;                if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 1U )
;                {
;                    portASSERT_IF_IN_ISR();
;
;                    if( uxSchedulerSuspended == 0U )
;                    {
;                        /* The only time there would be a problem is if this is called
;                         * before a context switch and vTaskExitCritical() is called
;                         * after pxCurrentTCB changes. Therefore this should not be
;                         * used within vTaskSwitchContext(). */
;                        prvCheckForRunStateChange();
;                    }
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;
;        traceRETURN_vTaskEnterCritical();
;    }
;
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;    UBaseType_t vTaskEnterCriticalFromISR( void )
;    {
;        UBaseType_t uxSavedInterruptStatus = 0;
;        const BaseType_t xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;        traceENTER_vTaskEnterCriticalFromISR();
;
;        if( xSchedulerRunning != pdFALSE )
;        {
;            uxSavedInterruptStatus = portSET_INTERRUPT_MASK_FROM_ISR();
;
;            if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0U )
;            {
;                portGET_ISR_LOCK( xCoreID );
;            }
;
;            portINCREMENT_CRITICAL_NESTING_COUNT( xCoreID );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskEnterCriticalFromISR( uxSavedInterruptStatus );
;
;        return uxSavedInterruptStatus;
;    }
;
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( portCRITICAL_NESTING_IN_TCB == 1 ) && ( configNUMBER_OF_CORES == 1 ) )
;
;    void vTaskExitCritical( void )
;    {
;        traceENTER_vTaskExitCritical();
;
;        if( xSchedulerRunning != pdFALSE )
;        {
;            /* If pxCurrentTCB->uxCriticalNesting is zero then this function
;             * does not match a previous call to vTaskEnterCritical(). */
;            configASSERT( pxCurrentTCB->uxCriticalNesting > 0U );
;
;            /* This function should not be called in ISR. Use vTaskExitCriticalFromISR
;             * to exit critical section from ISR. */
;            portASSERT_IF_IN_ISR();
;
;            if( pxCurrentTCB->uxCriticalNesting > 0U )
;            {
;                ( pxCurrentTCB->uxCriticalNesting )--;
;
;                if( pxCurrentTCB->uxCriticalNesting == 0U )
;                {
;                    portENABLE_INTERRUPTS();
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
;        traceRETURN_vTaskExitCritical();
;    }
;
;#endif /* #if ( ( portCRITICAL_NESTING_IN_TCB == 1 ) && ( configNUMBER_OF_CORES == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;    void vTaskExitCritical( void )
;    {
;        const BaseType_t xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;        traceENTER_vTaskExitCritical();
;
;        if( xSchedulerRunning != pdFALSE )
;        {
;            /* If critical nesting count is zero then this function
;             * does not match a previous call to vTaskEnterCritical(). */
;            configASSERT( portGET_CRITICAL_NESTING_COUNT( xCoreID ) > 0U );
;
;            /* This function should not be called in ISR. Use vTaskExitCriticalFromISR
;             * to exit critical section from ISR. */
;            portASSERT_IF_IN_ISR();
;
;            if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) > 0U )
;            {
;                portDECREMENT_CRITICAL_NESTING_COUNT( xCoreID );
;
;                if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0U )
;                {
;                    BaseType_t xYieldCurrentTask;
;
;                    /* Get the xYieldPending stats inside the critical section. */
;                    xYieldCurrentTask = xYieldPendings[ xCoreID ];
;
;                    portRELEASE_ISR_LOCK( xCoreID );
;                    portRELEASE_TASK_LOCK( xCoreID );
;                    portENABLE_INTERRUPTS();
;
;                    /* When a task yields in a critical section it just sets
;                     * xYieldPending to true. So now that we have exited the
;                     * critical section check if xYieldPending is true, and
;                     * if so yield. */
;                    if( xYieldCurrentTask != pdFALSE )
;                    {
;                        portYIELD();
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
;        traceRETURN_vTaskExitCritical();
;    }
;
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( configNUMBER_OF_CORES > 1 )
;
;    void vTaskExitCriticalFromISR( UBaseType_t uxSavedInterruptStatus )
;    {
;        BaseType_t xCoreID;
;
;        traceENTER_vTaskExitCriticalFromISR( uxSavedInterruptStatus );
;
;        if( xSchedulerRunning != pdFALSE )
;        {
;            xCoreID = ( BaseType_t ) portGET_CORE_ID();
;
;            /* If critical nesting count is zero then this function
;             * does not match a previous call to vTaskEnterCritical(). */
;            configASSERT( portGET_CRITICAL_NESTING_COUNT( xCoreID ) > 0U );
;
;            if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) > 0U )
;            {
;                portDECREMENT_CRITICAL_NESTING_COUNT( xCoreID );
;
;                if( portGET_CRITICAL_NESTING_COUNT( xCoreID ) == 0U )
;                {
;                    portRELEASE_ISR_LOCK( xCoreID );
;                    portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedInterruptStatus );
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
;        traceRETURN_vTaskExitCriticalFromISR();
;    }
;
;#endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 )
;
;    STATIC char * prvWriteNameToBuffer( char * pcBuffer,
;                                        const char * pcTaskName )
;    {
;        size_t x;
;
;        /* Start by copying the entire string. */
;        ( void ) strcpy( pcBuffer, pcTaskName );
;
;        /* Pad the end of the string with spaces to ensure columns line up when
;         * printed out. */
;        for( x = strlen( pcBuffer ); x < ( size_t ) ( ( size_t ) configMAX_TASK_NAME_LEN - 1U ); x++ )
;        {
;            pcBuffer[ x ] = ' ';
;        }
;
;        /* Terminate. */
;        pcBuffer[ x ] = ( char ) 0x00;
;
;        /* Return the new end of string. */
;        return &( pcBuffer[ x ] );
;    }
;
;#endif /* ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configUSE_TRACE_FACILITY == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) )
;
;    void vTaskListTasks( char * pcWriteBuffer,
;                         size_t uxBufferLength )
;    {
;        TaskStatus_t * pxTaskStatusArray;
;        size_t uxConsumedBufferLength = 0;
;        size_t uxCharsWrittenBySnprintf;
;        int iSnprintfReturnValue;
;        BaseType_t xOutputBufferFull = pdFALSE;
;        UBaseType_t uxArraySize, x;
;        char cStatus;
;
;        traceENTER_vTaskListTasks( pcWriteBuffer, uxBufferLength );
;
;        /*
;         * PLEASE NOTE:
;         *
;         * This function is provided for convenience only, and is used by many
;         * of the demo applications.  Do not consider it to be part of the
;         * scheduler.
;         *
;         * vTaskListTasks() calls uxTaskGetSystemState(), then formats part of the
;         * uxTaskGetSystemState() output into a human readable table that
;         * displays task: names, states, priority, stack usage and task number.
;         * Stack usage specified as the number of unused StackType_t words stack can hold
;         * on top of stack - not the number of bytes.
;         *
;         * vTaskListTasks() has a dependency on the snprintf() C library function that
;         * might bloat the code size, use a lot of stack, and provide different
;         * results on different platforms.  An alternative, tiny, third party,
;         * and limited functionality implementation of snprintf() is provided in
;         * many of the FreeRTOS/Demo sub-directories in a file called
;         * printf-stdarg.c (note printf-stdarg.c does not provide a full
;         * snprintf() implementation!).
;         *
;         * It is recommended that production systems call uxTaskGetSystemState()
;         * directly to get access to raw stats data, rather than indirectly
;         * through a call to vTaskListTasks().
;         */
;
;
;        /* Make sure the write buffer does not contain a string. */
;        *pcWriteBuffer = ( char ) 0x00;
;
;        /* Take a snapshot of the number of tasks in case it changes while this
;         * function is executing. */
;        uxArraySize = uxCurrentNumberOfTasks;
;
;        /* Allocate an array index for each task.  NOTE!  if
;         * configSUPPORT_DYNAMIC_ALLOCATION is set to 0 then pvPortMalloc() will
;         * equate to NULL. */
;        /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        pxTaskStatusArray = pvPortMalloc( uxArraySize * sizeof( TaskStatus_t ) );
;
;        if( pxTaskStatusArray != NULL )
;        {
;            /* Generate the (binary) data. */
;            uxArraySize = uxTaskGetSystemState( pxTaskStatusArray, uxArraySize, NULL );
;
;            /* Create a human readable table from the binary data. */
;            for( x = 0; x < uxArraySize; x++ )
;            {
;                switch( pxTaskStatusArray[ x ].eCurrentState )
;                {
;                    case eRunning:
;                        cStatus = tskRUNNING_CHAR;
;                        break;
;
;                    case eReady:
;                        cStatus = tskREADY_CHAR;
;                        break;
;
;                    case eBlocked:
;                        cStatus = tskBLOCKED_CHAR;
;                        break;
;
;                    case eSuspended:
;                        cStatus = tskSUSPENDED_CHAR;
;                        break;
;
;                    case eDeleted:
;                        cStatus = tskDELETED_CHAR;
;                        break;
;
;                    case eInvalid: /* Fall through. */
;                    default:       /* Should not get here, but it is included
;                                    * to prevent static checking errors. */
;                        cStatus = ( char ) 0x00;
;                        break;
;                }
;
;                /* Is there enough space in the buffer to hold task name? */
;                if( ( uxConsumedBufferLength + configMAX_TASK_NAME_LEN ) <= uxBufferLength )
;                {
;                    /* Write the task name to the string, padding with spaces so it
;                     * can be printed in tabular form more easily. */
;                    pcWriteBuffer = prvWriteNameToBuffer( pcWriteBuffer, pxTaskStatusArray[ x ].pcTaskName );
;                    /* Do not count the terminating null character. */
;                    uxConsumedBufferLength = uxConsumedBufferLength + ( configMAX_TASK_NAME_LEN - 1U );
;
;                    /* Is there space left in the buffer? -1 is done because snprintf
;                     * writes a terminating null character. So we are essentially
;                     * checking if the buffer has space to write at least one non-null
;                     * character. */
;                    if( uxConsumedBufferLength < ( uxBufferLength - 1U ) )
;                    {
;                        /* Write the rest of the string. */
;                        #if ( ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 ) )
;                            /* MISRA Ref 21.6.1 [snprintf for utility] */
;                            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-216 */
;                            /* coverity[misra_c_2012_rule_21_6_violation] */
;                            iSnprintfReturnValue = snprintf( pcWriteBuffer,
;                                                             uxBufferLength - uxConsumedBufferLength,
;                                                             "\t%c\t%u\t%u\t%u\t0x%x\r\n",
;                                                             cStatus,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].uxCurrentPriority,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].usStackHighWaterMark,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].xTaskNumber,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].uxCoreAffinityMask );
;                        #else /* ( ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 ) ) */
;                            /* MISRA Ref 21.6.1 [snprintf for utility] */
;                            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-216 */
;                            /* coverity[misra_c_2012_rule_21_6_violation] */
;                            iSnprintfReturnValue = snprintf( pcWriteBuffer,
;                                                             uxBufferLength - uxConsumedBufferLength,
;                                                             "\t%c\t%u\t%u\t%u\r\n",
;                                                             cStatus,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].uxCurrentPriority,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].usStackHighWaterMark,
;                                                             ( unsigned int ) pxTaskStatusArray[ x ].xTaskNumber );
;                        #endif /* ( ( configUSE_CORE_AFFINITY == 1 ) && ( configNUMBER_OF_CORES > 1 ) ) */
;                        uxCharsWrittenBySnprintf = prvSnprintfReturnValueToCharsWritten( iSnprintfReturnValue, uxBufferLength - uxConsumedBufferLength );
;
;                        uxConsumedBufferLength += uxCharsWrittenBySnprintf;
;                        pcWriteBuffer += uxCharsWrittenBySnprintf;
;                    }
;                    else
;                    {
;                        xOutputBufferFull = pdTRUE;
;                    }
;                }
;                else
;                {
;                    xOutputBufferFull = pdTRUE;
;                }
;
;                if( xOutputBufferFull == pdTRUE )
;                {
;                    break;
;                }
;            }
;
;            /* Free the array again.  NOTE!  If configSUPPORT_DYNAMIC_ALLOCATION
;             * is 0 then vPortFree() will be #defined to nothing. */
;            vPortFree( pxTaskStatusArray );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskListTasks();
;    }
;
;#endif /* ( ( configUSE_TRACE_FACILITY == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) ) */
;/*----------------------------------------------------------*/
;
;#if ( ( configGENERATE_RUN_TIME_STATS == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) && ( configUSE_TRACE_FACILITY == 1 ) )
;
;    void vTaskGetRunTimeStatistics( char * pcWriteBuffer,
;                                    size_t uxBufferLength )
;    {
;        TaskStatus_t * pxTaskStatusArray;
;        size_t uxConsumedBufferLength = 0;
;        size_t uxCharsWrittenBySnprintf;
;        int iSnprintfReturnValue;
;        BaseType_t xOutputBufferFull = pdFALSE;
;        UBaseType_t uxArraySize, x;
;        configRUN_TIME_COUNTER_TYPE ulTotalTime = 0;
;        configRUN_TIME_COUNTER_TYPE ulStatsAsPercentage;
;
;        traceENTER_vTaskGetRunTimeStatistics( pcWriteBuffer, uxBufferLength );
;
;        /*
;         * PLEASE NOTE:
;         *
;         * This function is provided for convenience only, and is used by many
;         * of the demo applications.  Do not consider it to be part of the
;         * scheduler.
;         *
;         * vTaskGetRunTimeStatistics() calls uxTaskGetSystemState(), then formats part
;         * of the uxTaskGetSystemState() output into a human readable table that
;         * displays the amount of time each task has spent in the Running state
;         * in both absolute and percentage terms.
;         *
;         * vTaskGetRunTimeStatistics() has a dependency on the snprintf() C library
;         * function that might bloat the code size, use a lot of stack, and
;         * provide different results on different platforms.  An alternative,
;         * tiny, third party, and limited functionality implementation of
;         * snprintf() is provided in many of the FreeRTOS/Demo sub-directories in
;         * a file called printf-stdarg.c (note printf-stdarg.c does not provide
;         * a full snprintf() implementation!).
;         *
;         * It is recommended that production systems call uxTaskGetSystemState()
;         * directly to get access to raw stats data, rather than indirectly
;         * through a call to vTaskGetRunTimeStatistics().
;         */
;
;        /* Make sure the write buffer does not contain a string. */
;        *pcWriteBuffer = ( char ) 0x00;
;
;        /* Take a snapshot of the number of tasks in case it changes while this
;         * function is executing. */
;        uxArraySize = uxCurrentNumberOfTasks;
;
;        /* Allocate an array index for each task.  NOTE!  If
;         * configSUPPORT_DYNAMIC_ALLOCATION is set to 0 then pvPortMalloc() will
;         * equate to NULL. */
;        /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        pxTaskStatusArray = pvPortMalloc( uxArraySize * sizeof( TaskStatus_t ) );
;
;        if( pxTaskStatusArray != NULL )
;        {
;            /* Generate the (binary) data. */
;            uxArraySize = uxTaskGetSystemState( pxTaskStatusArray, uxArraySize, &ulTotalTime );
;
;            /* For percentage calculations. */
;            ulTotalTime /= ( ( configRUN_TIME_COUNTER_TYPE ) 100U );
;
;            /* Avoid divide by zero errors. */
;            if( ulTotalTime > 0U )
;            {
;                /* Create a human readable table from the binary data. */
;                for( x = 0; x < uxArraySize; x++ )
;                {
;                    /* What percentage of the total run time has the task used?
;                     * This will always be rounded down to the nearest integer.
;                     * ulTotalRunTime has already been divided by 100. */
;                    ulStatsAsPercentage = pxTaskStatusArray[ x ].ulRunTimeCounter / ulTotalTime;
;
;                    /* Is there enough space in the buffer to hold task name? */
;                    if( ( uxConsumedBufferLength + configMAX_TASK_NAME_LEN ) <= uxBufferLength )
;                    {
;                        /* Write the task name to the string, padding with
;                         * spaces so it can be printed in tabular form more
;                         * easily. */
;                        pcWriteBuffer = prvWriteNameToBuffer( pcWriteBuffer, pxTaskStatusArray[ x ].pcTaskName );
;                        /* Do not count the terminating null character. */
;                        uxConsumedBufferLength = uxConsumedBufferLength + ( configMAX_TASK_NAME_LEN - 1U );
;
;                        /* Is there space left in the buffer? -1 is done because snprintf
;                         * writes a terminating null character. So we are essentially
;                         * checking if the buffer has space to write at least one non-null
;                         * character. */
;                        if( uxConsumedBufferLength < ( uxBufferLength - 1U ) )
;                        {
;                            if( ulStatsAsPercentage > 0U )
;                            {
;                                #ifdef portLU_PRINTF_SPECIFIER_REQUIRED
;                                {
;                                    /* MISRA Ref 21.6.1 [snprintf for utility] */
;                                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-216 */
;                                    /* coverity[misra_c_2012_rule_21_6_violation] */
;                                    iSnprintfReturnValue = snprintf( pcWriteBuffer,
;                                                                     uxBufferLength - uxConsumedBufferLength,
;                                                                     "\t%lu\t\t%lu%%\r\n",
;                                                                     pxTaskStatusArray[ x ].ulRunTimeCounter,
;                                                                     ulStatsAsPercentage );
;                                }
;                                #else /* ifdef portLU_PRINTF_SPECIFIER_REQUIRED */
;                                {
;                                    /* sizeof( int ) == sizeof( long ) so a smaller
;                                     * printf() library can be used. */
;                                    /* MISRA Ref 21.6.1 [snprintf for utility] */
;                                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-216 */
;                                    /* coverity[misra_c_2012_rule_21_6_violation] */
;                                    iSnprintfReturnValue = snprintf( pcWriteBuffer,
;                                                                     uxBufferLength - uxConsumedBufferLength,
;                                                                     "\t%u\t\t%u%%\r\n",
;                                                                     ( unsigned int ) pxTaskStatusArray[ x ].ulRunTimeCounter,
;                                                                     ( unsigned int ) ulStatsAsPercentage );
;                                }
;                                #endif /* ifdef portLU_PRINTF_SPECIFIER_REQUIRED */
;                            }
;                            else
;                            {
;                                /* If the percentage is zero here then the task has
;                                 * consumed less than 1% of the total run time. */
;                                #ifdef portLU_PRINTF_SPECIFIER_REQUIRED
;                                {
;                                    /* MISRA Ref 21.6.1 [snprintf for utility] */
;                                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-216 */
;                                    /* coverity[misra_c_2012_rule_21_6_violation] */
;                                    iSnprintfReturnValue = snprintf( pcWriteBuffer,
;                                                                     uxBufferLength - uxConsumedBufferLength,
;                                                                     "\t%lu\t\t<1%%\r\n",
;                                                                     pxTaskStatusArray[ x ].ulRunTimeCounter );
;                                }
;                                #else
;                                {
;                                    /* sizeof( int ) == sizeof( long ) so a smaller
;                                     * printf() library can be used. */
;                                    /* MISRA Ref 21.6.1 [snprintf for utility] */
;                                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-216 */
;                                    /* coverity[misra_c_2012_rule_21_6_violation] */
;                                    iSnprintfReturnValue = snprintf( pcWriteBuffer,
;                                                                     uxBufferLength - uxConsumedBufferLength,
;                                                                     "\t%u\t\t<1%%\r\n",
;                                                                     ( unsigned int ) pxTaskStatusArray[ x ].ulRunTimeCounter );
;                                }
;                                #endif /* ifdef portLU_PRINTF_SPECIFIER_REQUIRED */
;                            }
;
;                            uxCharsWrittenBySnprintf = prvSnprintfReturnValueToCharsWritten( iSnprintfReturnValue, uxBufferLength - uxConsumedBufferLength );
;                            uxConsumedBufferLength += uxCharsWrittenBySnprintf;
;                            pcWriteBuffer += uxCharsWrittenBySnprintf;
;                        }
;                        else
;                        {
;                            xOutputBufferFull = pdTRUE;
;                        }
;                    }
;                    else
;                    {
;                        xOutputBufferFull = pdTRUE;
;                    }
;
;                    if( xOutputBufferFull == pdTRUE )
;                    {
;                        break;
;                    }
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;
;            /* Free the array again.  NOTE!  If configSUPPORT_DYNAMIC_ALLOCATION
;             * is 0 then vPortFree() will be #defined to nothing. */
;            vPortFree( pxTaskStatusArray );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;
;        traceRETURN_vTaskGetRunTimeStatistics();
;    }
;
;#endif /* ( ( configGENERATE_RUN_TIME_STATS == 1 ) && ( configUSE_STATS_FORMATTING_FUNCTIONS > 0 ) ) */
;/*-----------------------------------------------------------*/
;
;TickType_t uxTaskResetEventItemValue( void )
;{
	code
	xdef	_~uxTaskResetEventItemValue
	func
_~uxTaskResetEventItemValue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L489
	tcs
	phd
	tcd
;    TickType_t uxReturn;
;
;    traceENTER_uxTaskResetEventItemValue();
uxReturn_1	set	0
;
;    uxReturn = listGET_LIST_ITEM_VALUE( &( pxCurrentTCB->xEventListItem ) );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$18
	lda	[<R0],Y
	sta	<L490+uxReturn_1
	iny
	iny
	lda	[<R0],Y
	sta	<L490+uxReturn_1+2
;
;    /* Reset the event list item to its normal value - so it can be used with
;     * queues and semaphores. */
;    listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xEventListItem ), ( ( TickType_t ) configMAX_PRIORITIES - ( TickType_t ) pxCurrentTCB->uxPriority ) );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	|_~pxCurrentTCB	; volatile
	sta	<R1
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R1+2
	ldy	#$2c
	lda	[<R1],Y
	sta	<R1
	stz	<R1+2
	sec
	lda	#$5
	sbc	<R1
	sta	<R2
	lda	#$0
	sbc	<R1+2
	sta	<R2+2
	lda	<R2
	ldy	#$18
	sta	[<R0],Y
	lda	<R2+2
	iny
	iny
	sta	[<R0],Y
;
;    traceRETURN_uxTaskResetEventItemValue( uxReturn );
;
;    return uxReturn;
	ldx	<L490+uxReturn_1+2
	lda	<L490+uxReturn_1
	tay
	pld
	tsc
	clc
	adc	#L489
	tcs
	tya
	rts
;}
L489	equ	16
L490	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_MUTEXES == 1 )
;
;    TaskHandle_t pvTaskIncrementMutexHeldCount( void )
;    {
	code
	xdef	_~pvTaskIncrementMutexHeldCount
	func
_~pvTaskIncrementMutexHeldCount:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L492
	tcs
	phd
	tcd
;        TCB_t * pxTCB;
;
;        traceENTER_pvTaskIncrementMutexHeldCount();
pxTCB_1	set	0
;
;        pxTCB = pxCurrentTCB;
	lda	|_~pxCurrentTCB	; volatile
	sta	<L493+pxTCB_1
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<L493+pxTCB_1+2
;
;        /* If xSemaphoreCreateMutex() is called before any tasks have been created
;         * then pxCurrentTCB will be NULL. */
;        if( pxTCB != NULL )
;        {
	lda	<L493+pxTCB_1
	ora	<L493+pxTCB_1+2
	beq	L10620
;            ( pxTCB->uxMutexesHeld )++;
	ldy	#$44
	lda	[<L493+pxTCB_1],Y
	ina
	sta	[<L493+pxTCB_1],Y
;        }
;
;        traceRETURN_pvTaskIncrementMutexHeldCount( pxTCB );
L10620:
;
;        return pxTCB;
	ldx	<L493+pxTCB_1+2
	lda	<L493+pxTCB_1
	tay
	pld
	tsc
	clc
	adc	#L492
	tcs
	tya
	rts
;    }
L492	equ	4
L493	equ	1
	ends
	efunc
;
;#endif /* configUSE_MUTEXES */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    uint32_t ulTaskGenericNotifyTake( UBaseType_t uxIndexToWaitOn,
;                                      BaseType_t xClearCountOnExit,
;                                      TickType_t xTicksToWait )
;    {
	code
	xdef	_~ulTaskGenericNotifyTake
	func
_~ulTaskGenericNotifyTake:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L496
	tcs
	phd
	tcd
uxIndexToWaitOn_0	set	3
xClearCountOnExit_0	set	5
xTicksToWait_0	set	7
;        uint32_t ulReturn;
;        BaseType_t xAlreadyYielded, xShouldBlock = pdFALSE;
;
;        traceENTER_ulTaskGenericNotifyTake( uxIndexToWaitOn, xClearCountOnExit, xTicksToWait );
ulReturn_1	set	0
xAlreadyYielded_1	set	4
xShouldBlock_1	set	6
	stz	<L497+xShouldBlock_1
;
;        configASSERT( uxIndexToWaitOn < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L496+uxIndexToWaitOn_0
	cmp	#<$1
	bcc	L10621
	asmstart
	sei
	asmend
L10622:
	bra	L10622
L10621:
;
;        /* If the notification count is zero, and if we are willing to wait for a
;         * notification, then block the task and wait. */
;        if( ( pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ] == 0U ) && ( xTicksToWait > ( TickType_t ) 0 ) )
;        {
	lda	<L496+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R2
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ldy	#$2
	ora	[<R3],Y
	beq	*+5
	brl	L10625
	lda	#$0
	cmp	<L496+xTicksToWait_0
	sbc	<L496+xTicksToWait_0+2
	bcc	*+5
	brl	L10625
;            /* We suspend the scheduler here as prvAddCurrentTaskToDelayedList is a
;             * non-deterministic operation. */
;            vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;            {
;                /* We MUST enter a critical section to atomically check if a notification
;                 * has occurred and set the flag to indicate that we are waiting for
;                 * a notification. If we do not do so, a notification sent from an ISR
;                 * will get lost. */
;                taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;                {
;                    /* Only block if the notification count is not already non-zero. */
;                    if( pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ] == 0U )
;                    {
	lda	<L496+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R2
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ldy	#$2
	ora	[<R3],Y
	bne	L10627
;                        /* Mark this task as waiting for a notification. */
;                        pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] = taskWAITING_NOTIFICATION;
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L496+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	#$1
	sta	[<R0],Y
	rep	#$20
	longa	on
;
;                        /* Arrange to wait for a notification. */
;                        xShouldBlock = pdTRUE;
	lda	#$1
	sta	<L497+xShouldBlock_1
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10627:
;                }
;                taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;                /* We are now out of the critical section but the scheduler is still
;                 * suspended, so we are safe to do non-deterministic operations such
;                 * as prvAddCurrentTaskToDelayedList. */
;                if( xShouldBlock == pdTRUE )
;                {
	lda	<L497+xShouldBlock_1
	cmp	#<$1
	bne	L10629
;                    traceTASK_NOTIFY_TAKE_BLOCK( uxIndexToWaitOn );
;                    prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
	pea	#<$1
	pei	<L496+xTicksToWait_0+2
	pei	<L496+xTicksToWait_0
	jsr	_~prvAddCurrentTaskToDelayedList
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10629:
;            }
;            xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L497+xAlreadyYielded_1
;
;            /* Force a reschedule if xTaskResumeAll has not already done so. */
;            if( ( xShouldBlock == pdTRUE ) && ( xAlreadyYielded == pdFALSE ) )
;            {
	lda	<L497+xShouldBlock_1
	cmp	#<$1
	bne	L10625
	lda	<L497+xAlreadyYielded_1
	bne	L10625
;                taskYIELD_WITHIN_API();
	jsl	_~vPortYield
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;
;        taskENTER_CRITICAL();
L10625:
	asmstart
	sei
	asmend
;        {
;            traceTASK_NOTIFY_TAKE( uxIndexToWaitOn );
;            ulReturn = pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ];
	lda	<L496+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R2
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	<L497+ulReturn_1
	ldy	#$2
	lda	[<R3],Y
	sta	<L497+ulReturn_1+2
;
;            if( ulReturn != 0U )
;            {
	lda	<L497+ulReturn_1
	ora	<L497+ulReturn_1+2
	beq	L10635
;                if( xClearCountOnExit != pdFALSE )
;                {
	lda	<L496+xClearCountOnExit_0
	beq	L10633
;                    pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ] = ( uint32_t ) 0U;
	lda	<L496+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	tya
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R2
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
L20051:
	ldy	#$2
	sta	[<R3],Y
;                }
;                else
L10635:
;
;            pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] = taskNOT_WAITING_NOTIFICATION;
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L496+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<R0],Y
	rep	#$20
	longa	on
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_ulTaskGenericNotifyTake( ulReturn );
;
;        return ulReturn;
	ldx	<L497+ulReturn_1+2
	lda	<L497+ulReturn_1
	tay
	lda	<L496+1
	sta	<L496+1+8
	pld
	tsc
	clc
	adc	#L496+8
	tcs
	tya
	rts
L10633:
;                {
;                    pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ] = ulReturn - ( uint32_t ) 1;
	lda	<L496+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R2
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$ffff
	clc
	adc	<L497+ulReturn_1
	sta	<R0
	lda	#$ffff
	adc	<L497+ulReturn_1+2
	sta	<R0+2
	lda	<R0
	sta	[<R3]
	lda	<R0+2
	brl	L20051
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;    }
L496	equ	24
L497	equ	17
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    BaseType_t xTaskGenericNotifyWait( UBaseType_t uxIndexToWaitOn,
;                                       uint32_t ulBitsToClearOnEntry,
;                                       uint32_t ulBitsToClearOnExit,
;                                       uint32_t * pulNotificationValue,
;                                       TickType_t xTicksToWait )
;    {
	code
	xdef	_~xTaskGenericNotifyWait
	func
_~xTaskGenericNotifyWait:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L508
	tcs
	phd
	tcd
uxIndexToWaitOn_0	set	3
ulBitsToClearOnEntry_0	set	5
ulBitsToClearOnExit_0	set	9
pulNotificationValue_0	set	13
xTicksToWait_0	set	17
;        BaseType_t xReturn, xAlreadyYielded, xShouldBlock = pdFALSE;
;
;        traceENTER_xTaskGenericNotifyWait( uxIndexToWaitOn, ulBitsToClearOnEntry, ulBitsToClearOnExit, pulNotificationValue, xTicksToWait );
xReturn_1	set	0
xAlreadyYielded_1	set	2
xShouldBlock_1	set	4
	stz	<L509+xShouldBlock_1
;
;        configASSERT( uxIndexToWaitOn < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L508+uxIndexToWaitOn_0
	cmp	#<$1
	bcc	L10636
	asmstart
	sei
	asmend
L10637:
	bra	L10637
L10636:
;
;        /* If the task hasn't received a notification, and if we are willing to wait
;         * for it, then block the task and wait. */
;        if( ( pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] != taskNOTIFICATION_RECEIVED ) && ( xTicksToWait > ( TickType_t ) 0 ) )
;        {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L508+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	[<R0],Y
	cmp	#<$2
	rep	#$20
	longa	on
	bne	*+5
	brl	L10640
	lda	#$0
	cmp	<L508+xTicksToWait_0
	sbc	<L508+xTicksToWait_0+2
	bcc	*+5
	brl	L10640
;            /* We suspend the scheduler here as prvAddCurrentTaskToDelayedList is a
;             * non-deterministic operation. */
;            vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;            {
;                /* We MUST enter a critical section to atomically check and update the
;                 * task notification value. If we do not do so, a notification from
;                 * an ISR will get lost. */
;                taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;                {
;                    /* Only block if a notification is not already pending. */
;                    if( pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] != taskNOTIFICATION_RECEIVED )
;                    {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L508+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	[<R0],Y
	cmp	#<$2
	rep	#$20
	longa	on
	beq	L10642
;                        /* Clear bits in the task's notification value as bits may get
;                         * set by the notifying task or interrupt. This can be used
;                         * to clear the value to zero. */
;                        pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ] &= ~ulBitsToClearOnEntry;
	lda	<L508+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	lda	|_~pxCurrentTCB	; volatile
	clc
	adc	<R2
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	adc	<R2+2
	sta	<R0+2
	lda	<L508+ulBitsToClearOnEntry_0
	eor	#<$ffffffff
	sta	<R3
	lda	<L508+ulBitsToClearOnEntry_0+2
	eor	#^$ffffffff
	sta	<R3+2
	lda	<R3
	and	[<R0]
	sta	[<R0]
	lda	<R3+2
	ldy	#$2
	and	[<R0],Y
	sta	[<R0],Y
;
;                        /* Mark this task as waiting for a notification. */
;                        pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] = taskWAITING_NOTIFICATION;
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L508+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	#$1
	sta	[<R0],Y
	rep	#$20
	longa	on
;
;                        /* Arrange to wait for a notification. */
;                        xShouldBlock = pdTRUE;
	lda	#$1
	sta	<L509+xShouldBlock_1
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10642:
;                }
;                taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;                /* We are now out of the critical section but the scheduler is still
;                 * suspended, so we are safe to do non-deterministic operations such
;                 * as prvAddCurrentTaskToDelayedList. */
;                if( xShouldBlock == pdTRUE )
;                {
	lda	<L509+xShouldBlock_1
	cmp	#<$1
	bne	L10644
;                    traceTASK_NOTIFY_WAIT_BLOCK( uxIndexToWaitOn );
;                    prvAddCurrentTaskToDelayedList( xTicksToWait, pdTRUE );
	pea	#<$1
	pei	<L508+xTicksToWait_0+2
	pei	<L508+xTicksToWait_0
	jsr	_~prvAddCurrentTaskToDelayedList
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10644:
;            }
;            xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L509+xAlreadyYielded_1
;
;            /* Force a reschedule if xTaskResumeAll has not already done so. */
;            if( ( xShouldBlock == pdTRUE ) && ( xAlreadyYielded == pdFALSE ) )
;            {
	lda	<L509+xShouldBlock_1
	cmp	#<$1
	bne	L10640
	lda	<L509+xAlreadyYielded_1
	bne	L10640
;                taskYIELD_WITHIN_API();
	jsl	_~vPortYield
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;
;        taskENTER_CRITICAL();
L10640:
	asmstart
	sei
	asmend
;        {
;            traceTASK_NOTIFY_WAIT( uxIndexToWaitOn );
;
;            if( pulNotificationValue != NULL )
;            {
	lda	<L508+pulNotificationValue_0
	ora	<L508+pulNotificationValue_0+2
	beq	L10647
;                /* Output the current notification value, which may or may not
;                 * have changed. */
;                *pulNotificationValue = pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ];
	lda	<L508+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R2
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	[<L508+pulNotificationValue_0]
	ldy	#$2
	lda	[<R3],Y
	sta	[<L508+pulNotificationValue_0],Y
;            }
;
;            /* If ucNotifyState is set then either the task never entered the
;             * blocked state (because a notification was already pending) or the
;             * task unblocked because of a notification.  Otherwise the task
;             * unblocked because of a timeout. */
;            if( pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] != taskNOTIFICATION_RECEIVED )
L10647:
;            {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L508+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	[<R0],Y
	cmp	#<$2
	rep	#$20
	longa	on
	beq	L10648
;                /* A notification was not received. */
;                xReturn = pdFALSE;
	stz	<L509+xReturn_1
;            }
;            else
	bra	L10649
L10648:
;            {
;                /* A notification was already pending or a notification was
;                 * received while the task was waiting. */
;                pxCurrentTCB->ulNotifiedValue[ uxIndexToWaitOn ] &= ~ulBitsToClearOnExit;
	lda	<L508+uxIndexToWaitOn_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	lda	|_~pxCurrentTCB	; volatile
	clc
	adc	<R2
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	adc	<R2+2
	sta	<R0+2
	lda	<L508+ulBitsToClearOnExit_0
	eor	#<$ffffffff
	sta	<R3
	lda	<L508+ulBitsToClearOnExit_0+2
	eor	#^$ffffffff
	sta	<R3+2
	lda	<R3
	and	[<R0]
	sta	[<R0]
	lda	<R3+2
	ldy	#$2
	and	[<R0],Y
	sta	[<R0],Y
;                xReturn = pdTRUE;
	lda	#$1
	sta	<L509+xReturn_1
;            }
L10649:
;
;            pxCurrentTCB->ucNotifyState[ uxIndexToWaitOn ] = taskNOT_WAITING_NOTIFICATION;
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#$4a
	clc
	adc	<L508+uxIndexToWaitOn_0
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<R0],Y
	rep	#$20
	longa	on
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_xTaskGenericNotifyWait( xReturn );
;
;        return xReturn;
	lda	<L509+xReturn_1
	tay
	lda	<L508+1
	sta	<L508+1+18
	pld
	tsc
	clc
	adc	#L508+18
	tcs
	tya
	rts
;    }
L508	equ	22
L509	equ	17
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify,
;                                   UBaseType_t uxIndexToNotify,
;                                   uint32_t ulValue,
;                                   eNotifyAction eAction,
;                                   uint32_t * pulPreviousNotificationValue )
;    {
	code
	xdef	_~xTaskGenericNotify
	func
_~xTaskGenericNotify:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L520
	tcs
	phd
	tcd
xTaskToNotify_0	set	3
uxIndexToNotify_0	set	7
ulValue_0	set	9
eAction_0	set	13
pulPreviousNotificationValue_0	set	15
;        TCB_t * pxTCB;
;        BaseType_t xReturn = pdPASS;
;        uint8_t ucOriginalNotifyState;
;
;        traceENTER_xTaskGenericNotify( xTaskToNotify, uxIndexToNotify, ulValue, eAction, pulPreviousNotificationValue );
pxTCB_1	set	0
xReturn_1	set	4
ucOriginalNotifyState_1	set	6
	lda	#$1
	sta	<L521+xReturn_1
;
;        configASSERT( uxIndexToNotify < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L520+uxIndexToNotify_0
	cmp	#<$1
	bcc	L10650
	asmstart
	sei
	asmend
L10651:
	bra	L10651
L10650:
;        configASSERT( xTaskToNotify );
	lda	<L520+xTaskToNotify_0
	ora	<L520+xTaskToNotify_0+2
	bne	L10654
	asmstart
	sei
	asmend
L10655:
	bra	L10655
L10654:
;        pxTCB = xTaskToNotify;
	lda	<L520+xTaskToNotify_0
	sta	<L521+pxTCB_1
	lda	<L520+xTaskToNotify_0+2
	sta	<L521+pxTCB_1+2
;
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            if( pulPreviousNotificationValue != NULL )
;            {
	lda	<L520+pulPreviousNotificationValue_0
	ora	<L520+pulPreviousNotificationValue_0+2
	beq	L10658
;                *pulPreviousNotificationValue = pxTCB->ulNotifiedValue[ uxIndexToNotify ];
	lda	<L520+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L521+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L521+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	[<L520+pulPreviousNotificationValue_0]
	ldy	#$2
	lda	[<R3],Y
	sta	[<L520+pulPreviousNotificationValue_0],Y
;            }
;
;            ucOriginalNotifyState = pxTCB->ucNotifyState[ uxIndexToNotify ];
L10658:
	lda	#$4a
	clc
	adc	<L520+uxIndexToNotify_0
	tay
	sep	#$20
	longa	off
	lda	[<L521+pxTCB_1],Y
	sta	<L521+ucOriginalNotifyState_1
	rep	#$20
	longa	on
;
;            pxTCB->ucNotifyState[ uxIndexToNotify ] = taskNOTIFICATION_RECEIVED;
	lda	#$4a
	clc
	adc	<L520+uxIndexToNotify_0
	tay
	sep	#$20
	longa	off
	lda	#$2
	sta	[<L521+pxTCB_1],Y
	rep	#$20
	longa	on
;
;            switch( eAction )
	lda	<L520+eAction_0
	xref	_~~fsw
	jsr	_~~fsw
	dw	0
	dw	5
	dw	L10668-1
	dw	L10660-1
	dw	L10661-1
	dw	L10662-1
	dw	L10663-1
	dw	L10664-1
;            {
;                case eSetBits:
L10661:
;                    pxTCB->ulNotifiedValue[ uxIndexToNotify ] |= ulValue;
	lda	<L520+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	lda	<L521+pxTCB_1
	clc
	adc	<R2
	sta	<R0
	lda	<L521+pxTCB_1+2
	adc	<R2+2
	sta	<R0+2
	lda	<L520+ulValue_0
	ora	[<R0]
	sta	[<R0]
	lda	<L520+ulValue_0+2
	ldy	#$2
	ora	[<R0],Y
	sta	[<R0],Y
;                    break;
;
;                    break;
L10660:
;
;            traceTASK_NOTIFY( uxIndexToNotify );
;
;            /* If the task is in the blocked state specifically to wait for a
;             * notification then unblock it now. */
;            if( ucOriginalNotifyState == taskWAITING_NOTIFICATION )
;            {
	sep	#$20
	longa	off
	lda	<L521+ucOriginalNotifyState_1
	cmp	#<$1
	rep	#$20
	longa	on
	beq	*+5
	brl	L10697
;            }
;                listREMOVE_ITEM( &( pxTCB->xStateListItem ) );
pxList_2	set	7
	ldy	#$14
	lda	[<L521+pxTCB_1],Y
	sta	<L521+pxList_2
	iny
	iny
	lda	[<L521+pxTCB_1],Y
	sta	<L521+pxList_2+2
	ldy	#$8
	lda	[<L521+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L521+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L521+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L521+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L521+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L521+pxTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L521+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L521+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L521+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L521+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L521+pxList_2],Y
	cmp	<R0
	bne	L528
	iny
	iny
	lda	[<L521+pxList_2],Y
	cmp	<R0+2
L528:
	bne	L10677
	ldy	#$c
	lda	[<L521+pxTCB_1],Y
	ldy	#$2
	sta	[<L521+pxList_2],Y
	ldy	#$e
	lda	[<L521+pxTCB_1],Y
	ldy	#$4
	sta	[<L521+pxList_2],Y
L10677:
	lda	#$0
	ldy	#$14
	sta	[<L521+pxTCB_1],Y
	iny
	iny
	sta	[<L521+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L521+pxList_2]
	sta	[<L521+pxList_2]
;                prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L521+pxTCB_1],Y
	bcs	L10687
	lda	[<L521+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10687:
pxIndex_3	set	7
	ldy	#$2c
	lda	[<L521+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L521+pxIndex_3
	ldy	#$2
	lda	(<R2),Y
	sta	<L521+pxIndex_3+2
	lda	<L521+pxIndex_3
	ldy	#$8
	sta	[<L521+pxTCB_1],Y
	lda	<L521+pxIndex_3+2
	iny
	iny
	sta	[<L521+pxTCB_1],Y
	dey
	dey
	lda	[<L521+pxIndex_3],Y
	ldy	#$c
	sta	[<L521+pxTCB_1],Y
	dey
	dey
	lda	[<L521+pxIndex_3],Y
	ldy	#$e
	sta	[<L521+pxTCB_1],Y
	ldy	#$8
	lda	[<L521+pxIndex_3],Y
	sta	<R0
	iny
	iny
	lda	[<L521+pxIndex_3],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L521+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L521+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L521+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L521+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L521+pxIndex_3],Y
	lda	<R0+2
	iny
	iny
	sta	[<L521+pxIndex_3],Y
	ldy	#$2c
	lda	[<L521+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L521+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L521+pxTCB_1],Y
	ldy	#$2c
	lda	[<L521+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L521+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;                /* The task should not have been on an event list. */
;                configASSERT( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL );
	ldy	#$28
	lda	[<L521+pxTCB_1],Y
	iny
	iny
	ora	[<L521+pxTCB_1],Y
	bne	*+5
	brl	L10694
	asmstart
	sei
	asmend
L10689:
	bra	L10689
;
;                case eIncrement:
L10662:
;                    ( pxTCB->ulNotifiedValue[ uxIndexToNotify ] )++;
	lda	<L520+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L521+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L521+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$1
	clc
	adc	[<R3]
	sta	[<R3]
	lda	#$0
	ldy	#$2
	adc	[<R3],Y
L20053:
	ldy	#$2
	sta	[<R3],Y
;                    break;
	brl	L10660
;
;                case eSetValueWithOverwrite:
L10663:
;                    pxTCB->ulNotifiedValue[ uxIndexToNotify ] = ulValue;
	lda	<L520+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L521+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L521+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	<L520+ulValue_0
	sta	[<R3]
	lda	<L520+ulValue_0+2
;                    break;
	bra	L20053
;
;                case eSetValueWithoutOverwrite:
L10664:
;
;                    if( ucOriginalNotifyState != taskNOTIFICATION_RECEIVED )
;                    {
	sep	#$20
	longa	off
	lda	<L521+ucOriginalNotifyState_1
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10663
;                        pxTCB->ulNotifiedValue[ uxIndexToNotify ] = ulValue;
;                    }
;                    else
;                    {
;                        /* The value could not be written to the task. */
;                        xReturn = pdFAIL;
	stz	<L521+xReturn_1
;                    }
;
;                    break;
	brl	L10660
;
;                case eNoAction:
;
;                    /* The task is being notified without its notify value being
;                     * updated. */
;                    break;
;
;                default:
L10668:
;
;                    /* Should not get here if all enums are handled.
;                     * Artificially force an assert by testing a value the
;                     * compiler can't assume is const. */
;                    configASSERT( xTickCount == ( TickType_t ) 0 );
	lda	|_~xTickCount	; volatile
	ora	|_~xTickCount+2	; volatile
	bne	*+5
	brl	L10660
	asmstart
	sei
	asmend
L10670:
	bra	L10670
;
;                #if ( configUSE_TICKLESS_IDLE != 0 )
;                {
;                    /* If a task is blocked waiting for a notification then
;                     * xNextTaskUnblockTime might be set to the blocked task's time
;                     * out time.  If the task is unblocked for a reason other than
;                     * a timeout xNextTaskUnblockTime is normally left unchanged,
;                     * because it will automatically get reset to a new value when
;                     * the tick count equals xNextTaskUnblockTime.  However if
;                     * tickless idling is used it might be more important to enter
;                     * sleep mode at the earliest possible time - so reset
;                     * xNextTaskUnblockTime here to ensure it is updated at the
;                     * earliest possible time. */
;                    prvResetNextTaskUnblockTime();
;                }
;                #endif
;
;                /* Check if the notified task has a priority above the currently
;                 * executing task. */
;                taskYIELD_ANY_CORE_IF_USING_PREEMPTION( pxTCB );
L10694:
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L521+pxTCB_1],Y
	bcs	L10697
	jsl	_~vPortYield
L10697:
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_xTaskGenericNotify( xReturn );
;
;        return xReturn;
	lda	<L521+xReturn_1
	tay
	lda	<L520+1
	sta	<L520+1+16
	pld
	tsc
	clc
	adc	#L520+16
	tcs
	tya
	rts
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;    }
L520	equ	27
L521	equ	17
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify,
;                                          UBaseType_t uxIndexToNotify,
;                                          uint32_t ulValue,
;                                          eNotifyAction eAction,
;                                          uint32_t * pulPreviousNotificationValue,
;                                          BaseType_t * pxHigherPriorityTaskWoken )
;    {
	code
	xdef	_~xTaskGenericNotifyFromISR
	func
_~xTaskGenericNotifyFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L534
	tcs
	phd
	tcd
xTaskToNotify_0	set	3
uxIndexToNotify_0	set	7
ulValue_0	set	9
eAction_0	set	13
pulPreviousNotificationValue_0	set	15
pxHigherPriorityTaskWoken_0	set	19
;        TCB_t * pxTCB;
;        uint8_t ucOriginalNotifyState;
;        BaseType_t xReturn = pdPASS;
;        UBaseType_t uxSavedInterruptStatus;
;
;        traceENTER_xTaskGenericNotifyFromISR( xTaskToNotify, uxIndexToNotify, ulValue, eAction, pulPreviousNotificationValue, pxHigherPriorityTaskWoken );
pxTCB_1	set	0
ucOriginalNotifyState_1	set	4
xReturn_1	set	5
uxSavedInterruptStatus_1	set	7
	lda	#$1
	sta	<L535+xReturn_1
;
;        configASSERT( xTaskToNotify );
	lda	<L534+xTaskToNotify_0
	ora	<L534+xTaskToNotify_0+2
	bne	L10698
	asmstart
	sei
	asmend
L10699:
	bra	L10699
L10698:
;        configASSERT( uxIndexToNotify < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L534+uxIndexToNotify_0
	cmp	#<$1
	bcc	L10702
	asmstart
	sei
	asmend
L10703:
	bra	L10703
L10702:
;
;        /* RTOS ports that support interrupt nesting have the concept of a
;         * maximum  system call (or maximum API call) interrupt priority.
;         * Interrupts that are  above the maximum system call priority are keep
;         * permanently enabled, even when the RTOS kernel is in a critical section,
;         * but cannot make any calls to FreeRTOS API functions.  If configASSERT()
;         * is defined in FreeRTOSConfig.h then
;         * portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;         * failure if a FreeRTOS API function is called from an interrupt that has
;         * been assigned a priority above the configured maximum system call
;         * priority.  Only FreeRTOS functions that end in FromISR can be called
;         * from interrupts  that have been assigned a priority at or (logically)
;         * below the maximum system call interrupt priority.  FreeRTOS maintains a
;         * separate interrupt safe API to ensure interrupt entry is as fast and as
;         * simple as possible.  More information (albeit Cortex-M specific) is
;         * provided on the following link:
;         * https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;        portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;        pxTCB = xTaskToNotify;
	lda	<L534+xTaskToNotify_0
	sta	<L535+pxTCB_1
	lda	<L534+xTaskToNotify_0+2
	sta	<L535+pxTCB_1+2
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L535+uxSavedInterruptStatus_1
;        {
;            if( pulPreviousNotificationValue != NULL )
;            {
	lda	<L534+pulPreviousNotificationValue_0
	ora	<L534+pulPreviousNotificationValue_0+2
	beq	L10706
;                *pulPreviousNotificationValue = pxTCB->ulNotifiedValue[ uxIndexToNotify ];
	lda	<L534+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L535+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	[<L534+pulPreviousNotificationValue_0]
	ldy	#$2
	lda	[<R3],Y
	sta	[<L534+pulPreviousNotificationValue_0],Y
;            }
;
;            ucOriginalNotifyState = pxTCB->ucNotifyState[ uxIndexToNotify ];
L10706:
	lda	#$4a
	clc
	adc	<L534+uxIndexToNotify_0
	tay
	sep	#$20
	longa	off
	lda	[<L535+pxTCB_1],Y
	sta	<L535+ucOriginalNotifyState_1
	rep	#$20
	longa	on
;            pxTCB->ucNotifyState[ uxIndexToNotify ] = taskNOTIFICATION_RECEIVED;
	lda	#$4a
	clc
	adc	<L534+uxIndexToNotify_0
	tay
	sep	#$20
	longa	off
	lda	#$2
	sta	[<L535+pxTCB_1],Y
	rep	#$20
	longa	on
;
;            switch( eAction )
	lda	<L534+eAction_0
	xref	_~~fsw
	jsr	_~~fsw
	dw	0
	dw	5
	dw	L10716-1
	dw	L10708-1
	dw	L10709-1
	dw	L10710-1
	dw	L10711-1
	dw	L10712-1
;            {
;                case eSetBits:
L10709:
;                    pxTCB->ulNotifiedValue[ uxIndexToNotify ] |= ulValue;
	lda	<L534+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	lda	<L535+pxTCB_1
	clc
	adc	<R2
	sta	<R0
	lda	<L535+pxTCB_1+2
	adc	<R2+2
	sta	<R0+2
	lda	<L534+ulValue_0
	ora	[<R0]
	sta	[<R0]
	lda	<L534+ulValue_0+2
	ldy	#$2
	ora	[<R0],Y
	sta	[<R0],Y
;                    break;
;                    break;
L10708:
;
;            traceTASK_NOTIFY_FROM_ISR( uxIndexToNotify );
;
;            /* If the task is in the blocked state specifically to wait for a
;             * notification then unblock it now. */
;            if( ucOriginalNotifyState == taskWAITING_NOTIFICATION )
;            {
	sep	#$20
	longa	off
	lda	<L535+ucOriginalNotifyState_1
	cmp	#<$1
	rep	#$20
	longa	on
	beq	*+5
	brl	L10721
;            }
;                /* The task should not have been on an event list. */
;                configASSERT( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL );
	ldy	#$28
	lda	[<L535+pxTCB_1],Y
	iny
	iny
	ora	[<L535+pxTCB_1],Y
	bne	*+5
	brl	L10722
	asmstart
	sei
	asmend
L10723:
	bra	L10723
;
;                case eIncrement:
L10710:
;                    ( pxTCB->ulNotifiedValue[ uxIndexToNotify ] )++;
	lda	<L534+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L535+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$1
	clc
	adc	[<R3]
	sta	[<R3]
	lda	#$0
	ldy	#$2
	adc	[<R3],Y
L20082:
	ldy	#$2
	sta	[<R3],Y
;                    break;
	bra	L10708
;
;                case eSetValueWithOverwrite:
L10711:
;                    pxTCB->ulNotifiedValue[ uxIndexToNotify ] = ulValue;
	lda	<L534+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L535+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	<L534+ulValue_0
	sta	[<R3]
	lda	<L534+ulValue_0+2
;                    break;
	bra	L20082
;
;                case eSetValueWithoutOverwrite:
L10712:
;
;                    if( ucOriginalNotifyState != taskNOTIFICATION_RECEIVED )
;                    {
	sep	#$20
	longa	off
	lda	<L535+ucOriginalNotifyState_1
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10711
;                        pxTCB->ulNotifiedValue[ uxIndexToNotify ] = ulValue;
;                    }
;                    else
;                    {
;                        /* The value could not be written to the task. */
;                        xReturn = pdFAIL;
	stz	<L535+xReturn_1
;                    }
;
;                    break;
	brl	L10708
;
;                case eNoAction:
;
;                    /* The task is being notified without its notify value being
;                     * updated. */
;                    break;
;
;                default:
L10716:
;
;                    /* Should not get here if all enums are handled.
;                     * Artificially force an assert by testing a value the
;                     * compiler can't assume is const. */
;                    configASSERT( xTickCount == ( TickType_t ) 0 );
	lda	|_~xTickCount	; volatile
	ora	|_~xTickCount+2	; volatile
	bne	*+5
	brl	L10708
	asmstart
	sei
	asmend
L10718:
	bra	L10718
L10722:
;
;                if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;                {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	*+5
	brl	L10744
;                    listREMOVE_ITEM( &( pxTCB->xStateListItem ) );
pxList_2	set	9
	ldy	#$14
	lda	[<L535+pxTCB_1],Y
	sta	<L535+pxList_2
	iny
	iny
	lda	[<L535+pxTCB_1],Y
	sta	<L535+pxList_2+2
	ldy	#$8
	lda	[<L535+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L535+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L535+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L535+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L535+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L535+pxTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L535+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L535+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L535+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L535+pxList_2],Y
	cmp	<R0
	bne	L544
	iny
	iny
	lda	[<L535+pxList_2],Y
	cmp	<R0+2
L544:
	bne	L10730
	ldy	#$c
	lda	[<L535+pxTCB_1],Y
	ldy	#$2
	sta	[<L535+pxList_2],Y
	ldy	#$e
	lda	[<L535+pxTCB_1],Y
	ldy	#$4
	sta	[<L535+pxList_2],Y
L10730:
	lda	#$0
	ldy	#$14
	sta	[<L535+pxTCB_1],Y
	iny
	iny
	sta	[<L535+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L535+pxList_2]
	sta	[<L535+pxList_2]
;                    prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L535+pxTCB_1],Y
	bcs	L10740
	lda	[<L535+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10740:
pxIndex_3	set	9
	ldy	#$2c
	lda	[<L535+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L535+pxIndex_3
	ldy	#$2
	lda	(<R2),Y
	sta	<L535+pxIndex_3+2
	lda	<L535+pxIndex_3
	ldy	#$8
	sta	[<L535+pxTCB_1],Y
	lda	<L535+pxIndex_3+2
	iny
	iny
	sta	[<L535+pxTCB_1],Y
	dey
	dey
	lda	[<L535+pxIndex_3],Y
	ldy	#$c
	sta	[<L535+pxTCB_1],Y
	dey
	dey
	lda	[<L535+pxIndex_3],Y
	ldy	#$e
	sta	[<L535+pxTCB_1],Y
	ldy	#$8
	lda	[<L535+pxIndex_3],Y
	sta	<R0
	iny
	iny
	lda	[<L535+pxIndex_3],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L535+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L535+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L535+pxIndex_3],Y
	lda	<R0+2
	iny
	iny
	sta	[<L535+pxIndex_3],Y
	ldy	#$2c
	lda	[<L535+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L535+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L535+pxTCB_1],Y
	ldy	#$2c
	lda	[<L535+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L535+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;                    #if ( configUSE_TICKLESS_IDLE != 0 )
;                    {
;                        /* If a task is blocked waiting for a notification then
;                         * xNextTaskUnblockTime might be set to the blocked task's time
;                         * out time.  If the task is unblocked for a reason other than
;                         * a timeout xNextTaskUnblockTime is normally left unchanged,
;                         * because it will automatically get reset to a new value when
;                         * the tick count equals xNextTaskUnblockTime.  However if
;                         * tickless idling is used it might be more important to enter
;                         * sleep mode at the earliest possible time - so reset
;                         * xNextTaskUnblockTime here to ensure it is updated at the
;                         * earliest possible time. */
;                        prvResetNextTaskUnblockTime();
;                    }
;                    #endif
;                }
;                else
	brl	L10741
;                {
;                    /* The delayed and ready lists cannot be accessed, so hold
;                     * this task pending until the scheduler is resumed. */
;                    listINSERT_END( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
L10744:
pxIndex_4	set	9
	lda	|_~xPendingReadyList+2
	sta	<L535+pxIndex_4
	lda	|_~xPendingReadyList+2+2
	sta	<L535+pxIndex_4+2
	lda	<L535+pxIndex_4
	ldy	#$1c
	sta	[<L535+pxTCB_1],Y
	lda	<L535+pxIndex_4+2
	iny
	iny
	sta	[<L535+pxTCB_1],Y
	ldy	#$8
	lda	[<L535+pxIndex_4],Y
	ldy	#$20
	sta	[<L535+pxTCB_1],Y
	ldy	#$a
	lda	[<L535+pxIndex_4],Y
	ldy	#$22
	sta	[<L535+pxTCB_1],Y
	ldy	#$8
	lda	[<L535+pxIndex_4],Y
	sta	<R0
	iny
	iny
	lda	[<L535+pxIndex_4],Y
	sta	<R0+2
	lda	#$18
	clc
	adc	<L535+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$18
	clc
	adc	<L535+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L535+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L535+pxIndex_4],Y
	lda	<R0+2
	iny
	iny
	sta	[<L535+pxIndex_4],Y
	lda	#<_~xPendingReadyList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$28
	sta	[<L535+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L535+pxTCB_1],Y
	inc	|_~xPendingReadyList
;                }
L10741:
;
;                #if ( configNUMBER_OF_CORES == 1 )
;                {
;                    if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
;                    {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L535+pxTCB_1],Y
	bcs	L10721
;                        /* The notified task has a priority above the currently
;                         * executing task so a yield is required. */
;                        if( pxHigherPriorityTaskWoken != NULL )
;                        {
	lda	<L534+pxHigherPriorityTaskWoken_0
	ora	<L534+pxHigherPriorityTaskWoken_0+2
	beq	L10746
;                            *pxHigherPriorityTaskWoken = pdTRUE;
	lda	#$1
	sta	[<L534+pxHigherPriorityTaskWoken_0]
;                        }
;
;                        /* Mark that a yield is pending in case the user is not
;                         * using the "xHigherPriorityTaskWoken" parameter to an ISR
;                         * safe FreeRTOS function. */
;                        xYieldPendings[ 0 ] = pdTRUE;
L10746:
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;                    }
;                    else
L10721:
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_xTaskGenericNotifyFromISR( xReturn );
;
;        return xReturn;
	lda	<L535+xReturn_1
	tay
	lda	<L534+1
	sta	<L534+1+20
	pld
	tsc
	clc
	adc	#L534+20
	tcs
	tya
	rts
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                {
;                    #if ( configUSE_PREEMPTION == 1 )
;                    {
;                        prvYieldForTask( pxTCB );
;
;                        if( xYieldPendings[ portGET_CORE_ID() ] == pdTRUE )
;                        {
;                            if( pxHigherPriorityTaskWoken != NULL )
;                            {
;                                *pxHigherPriorityTaskWoken = pdTRUE;
;                            }
;                        }
;                    }
;                    #endif /* if ( configUSE_PREEMPTION == 1 ) */
;                }
;                #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;            }
;        }
;    }
L534	equ	29
L535	equ	17
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    void vTaskGenericNotifyGiveFromISR( TaskHandle_t xTaskToNotify,
;                                        UBaseType_t uxIndexToNotify,
;                                        BaseType_t * pxHigherPriorityTaskWoken )
;    {
	code
	xdef	_~vTaskGenericNotifyGiveFromISR
	func
_~vTaskGenericNotifyGiveFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L550
	tcs
	phd
	tcd
xTaskToNotify_0	set	3
uxIndexToNotify_0	set	7
pxHigherPriorityTaskWoken_0	set	9
;        TCB_t * pxTCB;
;        uint8_t ucOriginalNotifyState;
;        UBaseType_t uxSavedInterruptStatus;
;
;        traceENTER_vTaskGenericNotifyGiveFromISR( xTaskToNotify, uxIndexToNotify, pxHigherPriorityTaskWoken );
pxTCB_1	set	0
ucOriginalNotifyState_1	set	4
uxSavedInterruptStatus_1	set	5
;
;        configASSERT( xTaskToNotify );
	lda	<L550+xTaskToNotify_0
	ora	<L550+xTaskToNotify_0+2
	bne	L10748
	asmstart
	sei
	asmend
L10749:
	bra	L10749
L10748:
;        configASSERT( uxIndexToNotify < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L550+uxIndexToNotify_0
	cmp	#<$1
	bcc	L10752
	asmstart
	sei
	asmend
L10753:
	bra	L10753
L10752:
;
;        /* RTOS ports that support interrupt nesting have the concept of a
;         * maximum  system call (or maximum API call) interrupt priority.
;         * Interrupts that are  above the maximum system call priority are keep
;         * permanently enabled, even when the RTOS kernel is in a critical section,
;         * but cannot make any calls to FreeRTOS API functions.  If configASSERT()
;         * is defined in FreeRTOSConfig.h then
;         * portASSERT_IF_INTERRUPT_PRIORITY_INVALID() will result in an assertion
;         * failure if a FreeRTOS API function is called from an interrupt that has
;         * been assigned a priority above the configured maximum system call
;         * priority.  Only FreeRTOS functions that end in FromISR can be called
;         * from interrupts  that have been assigned a priority at or (logically)
;         * below the maximum system call interrupt priority.  FreeRTOS maintains a
;         * separate interrupt safe API to ensure interrupt entry is as fast and as
;         * simple as possible.  More information (albeit Cortex-M specific) is
;         * provided on the following link:
;         * https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html */
;        portASSERT_IF_INTERRUPT_PRIORITY_INVALID();
;
;        pxTCB = xTaskToNotify;
	lda	<L550+xTaskToNotify_0
	sta	<L551+pxTCB_1
	lda	<L550+xTaskToNotify_0+2
	sta	<L551+pxTCB_1+2
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = ( UBaseType_t ) taskENTER_CRITICAL_FROM_ISR();
	stz	<L551+uxSavedInterruptStatus_1
;        {
;            ucOriginalNotifyState = pxTCB->ucNotifyState[ uxIndexToNotify ];
	lda	#$4a
	clc
	adc	<L550+uxIndexToNotify_0
	tay
	sep	#$20
	longa	off
	lda	[<L551+pxTCB_1],Y
	sta	<L551+ucOriginalNotifyState_1
	rep	#$20
	longa	on
;            pxTCB->ucNotifyState[ uxIndexToNotify ] = taskNOTIFICATION_RECEIVED;
	lda	#$4a
	clc
	adc	<L550+uxIndexToNotify_0
	tay
	sep	#$20
	longa	off
	lda	#$2
	sta	[<L551+pxTCB_1],Y
	rep	#$20
	longa	on
;
;            /* 'Giving' is equivalent to incrementing a count in a counting
;             * semaphore. */
;            ( pxTCB->ulNotifiedValue[ uxIndexToNotify ] )++;
	lda	<L550+uxIndexToNotify_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L551+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L551+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$1
	clc
	adc	[<R3]
	sta	[<R3]
	lda	#$0
	ldy	#$2
	adc	[<R3],Y
	sta	[<R3],Y
;
;            traceTASK_NOTIFY_GIVE_FROM_ISR( uxIndexToNotify );
;
;            /* If the task is in the blocked state specifically to wait for a
;             * notification then unblock it now. */
;            if( ucOriginalNotifyState == taskWAITING_NOTIFICATION )
;            {
	sep	#$20
	longa	off
	lda	<L551+ucOriginalNotifyState_1
	cmp	#<$1
	rep	#$20
	longa	on
	beq	*+5
	brl	L562
;                /* The task should not have been on an event list. */
;                configASSERT( listLIST_ITEM_CONTAINER( &( pxTCB->xEventListItem ) ) == NULL );
	ldy	#$28
	lda	[<L551+pxTCB_1],Y
	iny
	iny
	ora	[<L551+pxTCB_1],Y
	beq	L10757
	asmstart
	sei
	asmend
L10758:
	bra	L10758
L10757:
;
;                if( uxSchedulerSuspended == ( UBaseType_t ) 0U )
;                {
	lda	|_~uxSchedulerSuspended	; volatile
	beq	*+5
	brl	L10779
;                    listREMOVE_ITEM( &( pxTCB->xStateListItem ) );
pxList_2	set	7
	ldy	#$14
	lda	[<L551+pxTCB_1],Y
	sta	<L551+pxList_2
	iny
	iny
	lda	[<L551+pxTCB_1],Y
	sta	<L551+pxList_2+2
	ldy	#$8
	lda	[<L551+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L551+pxTCB_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L551+pxTCB_1],Y
	ldy	#$8
	sta	[<R0],Y
	ldy	#$e
	lda	[<L551+pxTCB_1],Y
	ldy	#$a
	sta	[<R0],Y
	iny
	iny
	lda	[<L551+pxTCB_1],Y
	sta	<R0
	iny
	iny
	lda	[<L551+pxTCB_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L551+pxTCB_1],Y
	ldy	#$4
	sta	[<R0],Y
	ldy	#$a
	lda	[<L551+pxTCB_1],Y
	ldy	#$6
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L551+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L551+pxTCB_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<L551+pxList_2],Y
	cmp	<R0
	bne	L557
	iny
	iny
	lda	[<L551+pxList_2],Y
	cmp	<R0+2
L557:
	bne	L10765
	ldy	#$c
	lda	[<L551+pxTCB_1],Y
	ldy	#$2
	sta	[<L551+pxList_2],Y
	ldy	#$e
	lda	[<L551+pxTCB_1],Y
	ldy	#$4
	sta	[<L551+pxList_2],Y
L10765:
	lda	#$0
	ldy	#$14
	sta	[<L551+pxTCB_1],Y
	iny
	iny
	sta	[<L551+pxTCB_1],Y
	lda	#$ffff
	clc
	adc	[<L551+pxList_2]
	sta	[<L551+pxList_2]
;                    prvAddTaskToReadyList( pxTCB );
	lda	|_~uxTopReadyPriority	; volatile
	ldy	#$2c
	cmp	[<L551+pxTCB_1],Y
	bcs	L10775
	lda	[<L551+pxTCB_1],Y
	sta	|_~uxTopReadyPriority	; volatile
L10775:
pxIndex_3	set	7
	ldy	#$2c
	lda	[<L551+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	lda	#$2
	clc
	adc	#<_~pxReadyTasksLists
	clc
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<L551+pxIndex_3
	ldy	#$2
	lda	(<R2),Y
	sta	<L551+pxIndex_3+2
	lda	<L551+pxIndex_3
	ldy	#$8
	sta	[<L551+pxTCB_1],Y
	lda	<L551+pxIndex_3+2
	iny
	iny
	sta	[<L551+pxTCB_1],Y
	dey
	dey
	lda	[<L551+pxIndex_3],Y
	ldy	#$c
	sta	[<L551+pxTCB_1],Y
	dey
	dey
	lda	[<L551+pxIndex_3],Y
	ldy	#$e
	sta	[<L551+pxTCB_1],Y
	ldy	#$8
	lda	[<L551+pxIndex_3],Y
	sta	<R0
	iny
	iny
	lda	[<L551+pxIndex_3],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L551+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L551+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	<L551+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L551+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L551+pxIndex_3],Y
	lda	<R0+2
	iny
	iny
	sta	[<L551+pxIndex_3],Y
	ldy	#$2c
	lda	[<L551+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	clc
	adc	#<_~pxReadyTasksLists
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L551+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L551+pxTCB_1],Y
	ldy	#$2c
	lda	[<L551+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	sta	<R0
	ldy	#$2c
	lda	[<L551+pxTCB_1],Y
	ldx	#<$12
	xref	_~~mul
	jsr	_~~mul
	tax
	lda	|_~pxReadyTasksLists,X
	ina
	ldx	<R0
	sta	|_~pxReadyTasksLists,X
;
;                    #if ( configUSE_TICKLESS_IDLE != 0 )
;                    {
;                        /* If a task is blocked waiting for a notification then
;                         * xNextTaskUnblockTime might be set to the blocked task's time
;                         * out time.  If the task is unblocked for a reason other than
;                         * a timeout xNextTaskUnblockTime is normally left unchanged,
;                         * because it will automatically get reset to a new value when
;                         * the tick count equals xNextTaskUnblockTime.  However if
;                         * tickless idling is used it might be more important to enter
;                         * sleep mode at the earliest possible time - so reset
;                         * xNextTaskUnblockTime here to ensure it is updated at the
;                         * earliest possible time. */
;                        prvResetNextTaskUnblockTime();
;                    }
;                    #endif
;                }
;                else
	brl	L10776
;                {
;                    /* The delayed and ready lists cannot be accessed, so hold
;                     * this task pending until the scheduler is resumed. */
;                    listINSERT_END( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
L10779:
pxIndex_4	set	7
	lda	|_~xPendingReadyList+2
	sta	<L551+pxIndex_4
	lda	|_~xPendingReadyList+2+2
	sta	<L551+pxIndex_4+2
	lda	<L551+pxIndex_4
	ldy	#$1c
	sta	[<L551+pxTCB_1],Y
	lda	<L551+pxIndex_4+2
	iny
	iny
	sta	[<L551+pxTCB_1],Y
	ldy	#$8
	lda	[<L551+pxIndex_4],Y
	ldy	#$20
	sta	[<L551+pxTCB_1],Y
	ldy	#$a
	lda	[<L551+pxIndex_4],Y
	ldy	#$22
	sta	[<L551+pxTCB_1],Y
	ldy	#$8
	lda	[<L551+pxIndex_4],Y
	sta	<R0
	iny
	iny
	lda	[<L551+pxIndex_4],Y
	sta	<R0+2
	lda	#$18
	clc
	adc	<L551+pxTCB_1
	sta	<R1
	lda	#$0
	adc	<L551+pxTCB_1+2
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$18
	clc
	adc	<L551+pxTCB_1
	sta	<R0
	lda	#$0
	adc	<L551+pxTCB_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L551+pxIndex_4],Y
	lda	<R0+2
	iny
	iny
	sta	[<L551+pxIndex_4],Y
	lda	#<_~xPendingReadyList
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$28
	sta	[<L551+pxTCB_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L551+pxTCB_1],Y
	inc	|_~xPendingReadyList
;                }
L10776:
;
;                #if ( configNUMBER_OF_CORES == 1 )
;                {
;                    if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
;                    {
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	ldy	#$2c
	lda	[<R0],Y
	cmp	[<L551+pxTCB_1],Y
	bcs	L562
;                        /* The notified task has a priority above the currently
;                         * executing task so a yield is required. */
;                        if( pxHigherPriorityTaskWoken != NULL )
;                        {
	lda	<L550+pxHigherPriorityTaskWoken_0
	ora	<L550+pxHigherPriorityTaskWoken_0+2
	beq	L10781
;                            *pxHigherPriorityTaskWoken = pdTRUE;
	lda	#$1
	sta	[<L550+pxHigherPriorityTaskWoken_0]
;                        }
;
;                        /* Mark that a yield is pending in case the user is not
;                         * using the "xHigherPriorityTaskWoken" parameter in an ISR
;                         * safe FreeRTOS function. */
;                        xYieldPendings[ 0 ] = pdTRUE;
L10781:
	lda	#$1
	sta	|_~xYieldPendings	; volatile
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                #else /* #if ( configNUMBER_OF_CORES == 1 ) */
;                {
;                    #if ( configUSE_PREEMPTION == 1 )
;                    {
;                        prvYieldForTask( pxTCB );
;
;                        if( xYieldPendings[ portGET_CORE_ID() ] == pdTRUE )
;                        {
;                            if( pxHigherPriorityTaskWoken != NULL )
;                            {
;                                *pxHigherPriorityTaskWoken = pdTRUE;
;                            }
;                        }
;                    }
;                    #endif /* #if ( configUSE_PREEMPTION == 1 ) */
;                }
;                #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;            }
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_vTaskGenericNotifyGiveFromISR();
;    }
L562:
	lda	<L550+1
	sta	<L550+1+10
	pld
	tsc
	clc
	adc	#L550+10
	tcs
	rts
L550	equ	27
L551	equ	17
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    BaseType_t xTaskGenericNotifyStateClear( TaskHandle_t xTask,
;                                             UBaseType_t uxIndexToClear )
;    {
	code
	xdef	_~xTaskGenericNotifyStateClear
	func
_~xTaskGenericNotifyStateClear:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L563
	tcs
	phd
	tcd
xTask_0	set	3
uxIndexToClear_0	set	7
;        TCB_t * pxTCB;
;        BaseType_t xReturn;
;
;        traceENTER_xTaskGenericNotifyStateClear( xTask, uxIndexToClear );
pxTCB_1	set	0
xReturn_1	set	4
;
;        configASSERT( uxIndexToClear < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L563+uxIndexToClear_0
	cmp	#<$1
	bcc	L10783
	asmstart
	sei
	asmend
L10784:
	bra	L10784
L10783:
;
;        /* If null is passed in here then it is the calling task that is having
;         * its notification state cleared. */
;        pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L563+xTask_0
	ora	<L563+xTask_0+2
	bne	L566
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L568
L566:
	ldx	<L563+xTask_0+2
	lda	<L563+xTask_0
L568:
	stx	<R0+2
	sta	<L564+pxTCB_1
	lda	<R0+2
	sta	<L564+pxTCB_1+2
;        configASSERT( pxTCB != NULL );
	lda	<L564+pxTCB_1
	ora	<L564+pxTCB_1+2
	bne	L10787
	asmstart
	sei
	asmend
L10788:
	bra	L10788
L10787:
;
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            if( pxTCB->ucNotifyState[ uxIndexToClear ] == taskNOTIFICATION_RECEIVED )
;            {
	lda	#$4a
	clc
	adc	<L563+uxIndexToClear_0
	tay
	sep	#$20
	longa	off
	lda	[<L564+pxTCB_1],Y
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10791
;                pxTCB->ucNotifyState[ uxIndexToClear ] = taskNOT_WAITING_NOTIFICATION;
	lda	#$4a
	clc
	adc	<L563+uxIndexToClear_0
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L564+pxTCB_1],Y
	rep	#$20
	longa	on
;                xReturn = pdPASS;
	lda	#$1
	sta	<L564+xReturn_1
;            }
;            else
	bra	L10792
L10791:
;            {
;                xReturn = pdFAIL;
	stz	<L564+xReturn_1
;            }
L10792:
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_xTaskGenericNotifyStateClear( xReturn );
;
;        return xReturn;
	lda	<L564+xReturn_1
	tay
	lda	<L563+1
	sta	<L563+1+6
	pld
	tsc
	clc
	adc	#L563+6
	tcs
	tya
	rts
;    }
L563	equ	10
L564	equ	5
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configUSE_TASK_NOTIFICATIONS == 1 )
;
;    uint32_t ulTaskGenericNotifyValueClear( TaskHandle_t xTask,
;                                            UBaseType_t uxIndexToClear,
;                                            uint32_t ulBitsToClear )
;    {
	code
	xdef	_~ulTaskGenericNotifyValueClear
	func
_~ulTaskGenericNotifyValueClear:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L572
	tcs
	phd
	tcd
xTask_0	set	3
uxIndexToClear_0	set	7
ulBitsToClear_0	set	9
;        TCB_t * pxTCB;
;        uint32_t ulReturn;
;
;        traceENTER_ulTaskGenericNotifyValueClear( xTask, uxIndexToClear, ulBitsToClear );
pxTCB_1	set	0
ulReturn_1	set	4
;
;        configASSERT( uxIndexToClear < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L572+uxIndexToClear_0
	cmp	#<$1
	bcc	L10793
	asmstart
	sei
	asmend
L10794:
	bra	L10794
L10793:
;
;        /* If null is passed in here then it is the calling task that is having
;         * its notification state cleared. */
;        pxTCB = prvGetTCBFromHandle( xTask );
	lda	<L572+xTask_0
	ora	<L572+xTask_0+2
	bne	L575
	ldx	|_~pxCurrentTCB+2	; volatile
	lda	|_~pxCurrentTCB	; volatile
	bra	L577
L575:
	ldx	<L572+xTask_0+2
	lda	<L572+xTask_0
L577:
	stx	<R0+2
	sta	<L573+pxTCB_1
	lda	<R0+2
	sta	<L573+pxTCB_1+2
;        configASSERT( pxTCB != NULL );
	lda	<L573+pxTCB_1
	ora	<L573+pxTCB_1+2
	bne	L10797
	asmstart
	sei
	asmend
L10798:
	bra	L10798
L10797:
;
;        taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;        {
;            /* Return the notification as it was before the bits were cleared,
;             * then clear the bit mask. */
;            ulReturn = pxTCB->ulNotifiedValue[ uxIndexToClear ];
	lda	<L572+uxIndexToClear_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<L573+pxTCB_1
	sta	<R2
	lda	#$0
	adc	<L573+pxTCB_1+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	<L573+ulReturn_1
	ldy	#$2
	lda	[<R3],Y
	sta	<L573+ulReturn_1+2
;            pxTCB->ulNotifiedValue[ uxIndexToClear ] &= ~ulBitsToClear;
	lda	<L572+uxIndexToClear_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	tya
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$46
	clc
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	lda	<L573+pxTCB_1
	clc
	adc	<R2
	sta	<R0
	lda	<L573+pxTCB_1+2
	adc	<R2+2
	sta	<R0+2
	lda	<L572+ulBitsToClear_0
	eor	#<$ffffffff
	sta	<R3
	lda	<L572+ulBitsToClear_0+2
	eor	#^$ffffffff
	sta	<R3+2
	lda	<R3
	and	[<R0]
	sta	[<R0]
	lda	<R3+2
	ldy	#$2
	and	[<R0],Y
	sta	[<R0],Y
;        }
;        taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;
;        traceRETURN_ulTaskGenericNotifyValueClear( ulReturn );
;
;        return ulReturn;
	ldx	<L573+ulReturn_1+2
	lda	<L573+ulReturn_1
	tay
	lda	<L572+1
	sta	<L572+1+10
	pld
	tsc
	clc
	adc	#L572+10
	tcs
	tya
	rts
;    }
L572	equ	24
L573	equ	17
	ends
	efunc
;
;#endif /* configUSE_TASK_NOTIFICATIONS */
;/*-----------------------------------------------------------*/
;
;#if ( configGENERATE_RUN_TIME_STATS == 1 )
;
;    configRUN_TIME_COUNTER_TYPE ulTaskGetRunTimeCounter( const TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;        configRUN_TIME_COUNTER_TYPE ulTotalTime = 0, ulTimeSinceLastSwitchedIn = 0, ulTaskRunTime = 0;
;
;        traceENTER_ulTaskGetRunTimeCounter( xTask );
;
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        taskENTER_CRITICAL();
;        {
;            if( taskTASK_IS_RUNNING( pxTCB ) == pdTRUE )
;            {
;                #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;                    portALT_GET_RUN_TIME_COUNTER_VALUE( ulTotalTime );
;                #else
;                    ulTotalTime = portGET_RUN_TIME_COUNTER_VALUE();
;                #endif
;
;                #if ( configNUMBER_OF_CORES == 1 )
;                    ulTimeSinceLastSwitchedIn = ulTotalTime - ulTaskSwitchedInTime[ 0 ];
;                #else
;                    ulTimeSinceLastSwitchedIn = ulTotalTime - ulTaskSwitchedInTime[ pxTCB->xTaskRunState ];
;                #endif
;            }
;
;            ulTaskRunTime = pxTCB->ulRunTimeCounter + ulTimeSinceLastSwitchedIn;
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_ulTaskGetRunTimeCounter( ulTaskRunTime );
;
;        return ulTaskRunTime;
;    }
;
;#endif /* if ( configGENERATE_RUN_TIME_STATS == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( configGENERATE_RUN_TIME_STATS == 1 )
;
;    configRUN_TIME_COUNTER_TYPE ulTaskGetRunTimePercent( const TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;        configRUN_TIME_COUNTER_TYPE ulTotalTime, ulReturn, ulTaskRunTime;
;
;        traceENTER_ulTaskGetRunTimePercent( xTask );
;
;        ulTaskRunTime = ulTaskGetRunTimeCounter( xTask );
;
;        #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;            portALT_GET_RUN_TIME_COUNTER_VALUE( ulTotalTime );
;        #else
;            ulTotalTime = ( configRUN_TIME_COUNTER_TYPE ) portGET_RUN_TIME_COUNTER_VALUE();
;        #endif
;
;        /* For percentage calculations. */
;        ulTotalTime /= ( configRUN_TIME_COUNTER_TYPE ) 100;
;
;        /* Avoid divide by zero errors. */
;        if( ulTotalTime > ( configRUN_TIME_COUNTER_TYPE ) 0 )
;        {
;            pxTCB = prvGetTCBFromHandle( xTask );
;            configASSERT( pxTCB != NULL );
;
;            ulReturn = ulTaskRunTime / ulTotalTime;
;        }
;        else
;        {
;            ulReturn = 0;
;        }
;
;        traceRETURN_ulTaskGetRunTimePercent( ulReturn );
;
;        return ulReturn;
;    }
;
;#endif /* if ( configGENERATE_RUN_TIME_STATS == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configGENERATE_RUN_TIME_STATS == 1 ) && ( INCLUDE_xTaskGetIdleTaskHandle == 1 ) )
;
;    configRUN_TIME_COUNTER_TYPE ulTaskGetIdleRunTimeCounter( void )
;    {
;        configRUN_TIME_COUNTER_TYPE ulTotalTime = 0, ulTimeSinceLastSwitchedIn = 0, ulIdleTaskRunTime = 0;
;        BaseType_t i;
;
;        traceENTER_ulTaskGetIdleRunTimeCounter();
;
;        taskENTER_CRITICAL();
;        {
;            #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;                portALT_GET_RUN_TIME_COUNTER_VALUE( ulTotalTime );
;            #else
;                ulTotalTime = portGET_RUN_TIME_COUNTER_VALUE();
;            #endif
;
;            for( i = 0; i < ( BaseType_t ) configNUMBER_OF_CORES; i++ )
;            {
;                if( taskTASK_IS_RUNNING( xIdleTaskHandles[ i ] ) == pdTRUE )
;                {
;                    #if ( configNUMBER_OF_CORES == 1 )
;                        ulTimeSinceLastSwitchedIn = ulTotalTime - ulTaskSwitchedInTime[ 0 ];
;                    #else
;                        ulTimeSinceLastSwitchedIn = ulTotalTime - ulTaskSwitchedInTime[ xIdleTaskHandles[ i ]->xTaskRunState ];
;                    #endif
;                }
;                else
;                {
;                    ulTimeSinceLastSwitchedIn = 0;
;                }
;
;                ulIdleTaskRunTime += ( xIdleTaskHandles[ i ]->ulRunTimeCounter + ulTimeSinceLastSwitchedIn );
;            }
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_ulTaskGetIdleRunTimeCounter( ulIdleTaskRunTime );
;
;        return ulIdleTaskRunTime;
;    }
;
;#endif /* if ( ( configGENERATE_RUN_TIME_STATS == 1 ) && ( INCLUDE_xTaskGetIdleTaskHandle == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configGENERATE_RUN_TIME_STATS == 1 ) && ( INCLUDE_xTaskGetIdleTaskHandle == 1 ) )
;
;    configRUN_TIME_COUNTER_TYPE ulTaskGetIdleRunTimePercent( void )
;    {
;        configRUN_TIME_COUNTER_TYPE ulTotalTime, ulReturn;
;        configRUN_TIME_COUNTER_TYPE ulRunTimeCounter = 0;
;
;        traceENTER_ulTaskGetIdleRunTimePercent();
;
;        #ifdef portALT_GET_RUN_TIME_COUNTER_VALUE
;            portALT_GET_RUN_TIME_COUNTER_VALUE( ulTotalTime );
;        #else
;            ulTotalTime = ( configRUN_TIME_COUNTER_TYPE ) portGET_RUN_TIME_COUNTER_VALUE();
;        #endif
;
;        ulTotalTime *= configNUMBER_OF_CORES;
;
;        /* For percentage calculations. */
;        ulTotalTime /= ( configRUN_TIME_COUNTER_TYPE ) 100;
;
;        /* Avoid divide by zero errors. */
;        if( ulTotalTime > ( configRUN_TIME_COUNTER_TYPE ) 0 )
;        {
;            ulRunTimeCounter = ulTaskGetIdleRunTimeCounter();
;            ulReturn = ulRunTimeCounter / ulTotalTime;
;        }
;        else
;        {
;            ulReturn = 0;
;        }
;
;        traceRETURN_ulTaskGetIdleRunTimePercent( ulReturn );
;
;        return ulReturn;
;    }
;
;#endif /* if ( ( configGENERATE_RUN_TIME_STATS == 1 ) && ( INCLUDE_xTaskGetIdleTaskHandle == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;STATIC void prvAddCurrentTaskToDelayedList( TickType_t xTicksToWait,
;                                            const BaseType_t xCanBlockIndefinitely )
;{
	code
	func
_~prvAddCurrentTaskToDelayedList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L580
	tcs
	phd
	tcd
xTicksToWait_0	set	3
xCanBlockIndefinitely_0	set	7
;    TickType_t xTimeToWake;
;    const TickType_t xConstTickCount = xTickCount;
;    List_t * const pxDelayedList = pxDelayedTaskList;
;    List_t * const pxOverflowDelayedList = pxOverflowDelayedTaskList;
;
;    #if ( INCLUDE_xTaskAbortDelay == 1 )
;    {
;        /* About to enter a delayed list, so ensure the ucDelayAborted flag is
;         * reset to pdFALSE so it can be detected as having been set to pdTRUE
;         * when the task leaves the Blocked state. */
;        pxCurrentTCB->ucDelayAborted = ( uint8_t ) pdFALSE;
;    }
;    #endif
;
;    /* Remove the task from the ready list before adding it to the blocked list
;     * as the same list item is used for both lists. */
;    if( uxListRemove( &( pxCurrentTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
xTimeToWake_1	set	0
xConstTickCount_1	set	4
pxDelayedList_1	set	8
pxOverflowDelayedList_1	set	12
	lda	|_~xTickCount	; volatile
	sta	<L581+xConstTickCount_1
	lda	|_~xTickCount+2	; volatile
	sta	<L581+xConstTickCount_1+2
	lda	|_~pxDelayedTaskList	; volatile
	sta	<L581+pxDelayedList_1
	lda	|_~pxDelayedTaskList+2	; volatile
	sta	<L581+pxDelayedList_1+2
	lda	|_~pxOverflowDelayedTaskList	; volatile
	sta	<L581+pxOverflowDelayedList_1
	lda	|_~pxOverflowDelayedTaskList+2	; volatile
	sta	<L581+pxOverflowDelayedList_1+2
;    {
	lda	#$4
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	pha
	pei	<R0
	jsr	_~uxListRemove
	tax
	beq	L10802
;        /* The current task must be in a ready list, so there is no need to
;         * check, and the port reset macro can be called directly. */
;        portRESET_READY_PRIORITY( pxCurrentTCB->uxPriority, uxTopReadyPriority );
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10802:
;
;    #if ( INCLUDE_vTaskSuspend == 1 )
;    {
;        if( ( xTicksToWait == portMAX_DELAY ) && ( xCanBlockIndefinitely != pdFALSE ) )
;        {
	lda	<L580+xTicksToWait_0
	cmp	#<$ffffffff
	bne	L583
	lda	<L580+xTicksToWait_0+2
	cmp	#^$ffffffff
L583:
	beq	*+5
	brl	L10803
	lda	<L580+xCanBlockIndefinitely_0
	bne	*+5
	brl	L10803
;            /* Add the task to the suspended task list instead of a delayed task
;             * list to ensure it is not woken by a timing event.  It will block
;             * indefinitely. */
;            listINSERT_END( &xSuspendedTaskList, &( pxCurrentTCB->xStateListItem ) );
pxIndex_2	set	16
	lda	|_~xSuspendedTaskList+2
	sta	<L581+pxIndex_2
	lda	|_~xSuspendedTaskList+2+2
	sta	<L581+pxIndex_2+2
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<L581+pxIndex_2
	ldy	#$8
	sta	[<R0],Y
	lda	<L581+pxIndex_2+2
	iny
	iny
	sta	[<R0],Y
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	dey
	dey
	lda	[<L581+pxIndex_2],Y
	ldy	#$c
	sta	[<R0],Y
	dey
	dey
	lda	[<L581+pxIndex_2],Y
	ldy	#$e
	sta	[<R0],Y
	ldy	#$8
	lda	[<L581+pxIndex_2],Y
	sta	<R0
	iny
	iny
	lda	[<L581+pxIndex_2],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R1
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R1+2
	lda	<R1
	ldy	#$4
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	lda	#$4
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L581+pxIndex_2],Y
	lda	<R0+2
	iny
	iny
	sta	[<L581+pxIndex_2],Y
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	#<_~xSuspendedTaskList
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R1+2
	lda	<R1
	ldy	#$14
	sta	[<R0],Y
	lda	<R1+2
	iny
	iny
	sta	[<R0],Y
	inc	|_~xSuspendedTaskList
;        }
;        else
L588:
	lda	<L580+1
	sta	<L580+1+6
	pld
	tsc
	clc
	adc	#L580+6
	tcs
	rts
L10803:
;        {
;            /* Calculate the time at which the task should be woken if the event
;             * does not occur.  This may overflow but this doesn't matter, the
;             * kernel will manage it correctly. */
;            xTimeToWake = xConstTickCount + xTicksToWait;
	lda	<L581+xConstTickCount_1
	clc
	adc	<L580+xTicksToWait_0
	sta	<L581+xTimeToWake_1
	lda	<L581+xConstTickCount_1+2
	adc	<L580+xTicksToWait_0+2
	sta	<L581+xTimeToWake_1+2
;
;            /* The list item will be inserted in wake time order. */
;            listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xStateListItem ), xTimeToWake );
	lda	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	|_~pxCurrentTCB+2	; volatile
	sta	<R0+2
	lda	<L581+xTimeToWake_1
	ldy	#$4
	sta	[<R0],Y
	lda	<L581+xTimeToWake_1+2
	iny
	iny
	sta	[<R0],Y
;
;            if( xTimeToWake < xConstTickCount )
;            {
	lda	<L581+xTimeToWake_1
	cmp	<L581+xConstTickCount_1
	lda	<L581+xTimeToWake_1+2
	sbc	<L581+xConstTickCount_1+2
	bcs	L10808
;                /* Wake time has overflowed.  Place this item in the overflow
;                 * list. */
;                traceMOVED_TASK_TO_OVERFLOW_DELAYED_LIST();
;                vListInsert( pxOverflowDelayedList, &( pxCurrentTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	pha
	pei	<R0
	pei	<L581+pxOverflowDelayedList_1+2
	pei	<L581+pxOverflowDelayedList_1
	jsr	_~vListInsert
;            }
;            else
	bra	L588
L10808:
;            {
;                /* The wake time has not overflowed, so the current block list
;                 * is used. */
;                traceMOVED_TASK_TO_DELAYED_LIST();
;                vListInsert( pxDelayedList, &( pxCurrentTCB->xStateListItem ) );
	lda	#$4
	clc
	adc	|_~pxCurrentTCB	; volatile
	sta	<R0
	lda	#$0
	adc	|_~pxCurrentTCB+2	; volatile
	pha
	pei	<R0
	pei	<L581+pxDelayedList_1+2
	pei	<L581+pxDelayedList_1
	jsr	_~vListInsert
;
;                /* If the task entering the blocked state was placed at the
;                 * head of the list of blocked tasks then xNextTaskUnblockTime
;                 * needs to be updated too. */
;                if( xTimeToWake < xNextTaskUnblockTime )
;                {
	lda	<L581+xTimeToWake_1
	cmp	|_~xNextTaskUnblockTime	; volatile
	lda	<L581+xTimeToWake_1+2
	sbc	|_~xNextTaskUnblockTime+2	; volatile
	bcs	L588
;                    xNextTaskUnblockTime = xTimeToWake;
	lda	<L581+xTimeToWake_1
	sta	|_~xNextTaskUnblockTime	; volatile
	lda	<L581+xTimeToWake_1+2
	sta	|_~xNextTaskUnblockTime+2	; volatile
;                }
;                else
	brl	L588
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
;    }
;    #else /* INCLUDE_vTaskSuspend */
;    {
;        /* Calculate the time at which the task should be woken if the event
;         * does not occur.  This may overflow but this doesn't matter, the kernel
;         * will manage it correctly. */
;        xTimeToWake = xConstTickCount + xTicksToWait;
;
;        /* The list item will be inserted in wake time order. */
;        listSET_LIST_ITEM_VALUE( &( pxCurrentTCB->xStateListItem ), xTimeToWake );
;
;        if( xTimeToWake < xConstTickCount )
;        {
;            traceMOVED_TASK_TO_OVERFLOW_DELAYED_LIST();
;            /* Wake time has overflowed.  Place this item in the overflow list. */
;            vListInsert( pxOverflowDelayedList, &( pxCurrentTCB->xStateListItem ) );
;        }
;        else
;        {
;            traceMOVED_TASK_TO_DELAYED_LIST();
;            /* The wake time has not overflowed, so the current block list is used. */
;            vListInsert( pxDelayedList, &( pxCurrentTCB->xStateListItem ) );
;
;            /* If the task entering the blocked state was placed at the head of the
;             * list of blocked tasks then xNextTaskUnblockTime needs to be updated
;             * too. */
;            if( xTimeToWake < xNextTaskUnblockTime )
;            {
;                xNextTaskUnblockTime = xTimeToWake;
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;
;        /* Avoid compiler warning when INCLUDE_vTaskSuspend is not 1. */
;        ( void ) xCanBlockIndefinitely;
;    }
;    #endif /* INCLUDE_vTaskSuspend */
;}
L580	equ	28
L581	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;#if ( portUSING_MPU_WRAPPERS == 1 )
;
;    xMPU_SETTINGS * xTaskGetMPUSettings( TaskHandle_t xTask )
;    {
;        TCB_t * pxTCB;
;
;        traceENTER_xTaskGetMPUSettings( xTask );
;
;        pxTCB = prvGetTCBFromHandle( xTask );
;        configASSERT( pxTCB != NULL );
;
;        traceRETURN_xTaskGetMPUSettings( &( pxTCB->xMPUSettings ) );
;
;        return &( pxTCB->xMPUSettings );
;    }
;
;#endif /* portUSING_MPU_WRAPPERS */
;/*-----------------------------------------------------------*/
;
;/* Code below here allows additional code to be inserted into this source file,
; * especially where access to file scope functions and data is needed (for example
; * when performing module tests). */
;
;#ifdef FREERTOS_MODULE_TEST
;    #include "tasks_test_access_functions.h"
;#endif
;
;
;#if ( configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H == 1 )
;
;    #include "freertos_tasks_c_additions.h"
;
;    #ifdef FREERTOS_TASKS_C_ADDITIONS_INIT
;        STATIC void freertos_tasks_c_additions_init( void )
;        {
;            FREERTOS_TASKS_C_ADDITIONS_INIT();
;        }
;    #endif
;
;#endif /* if ( configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H == 1 ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configKERNEL_PROVIDED_STATIC_MEMORY == 1 ) && ( portUSING_MPU_WRAPPERS == 0 ) )
;
;/*
; * This is the kernel provided implementation of vApplicationGetIdleTaskMemory()
; * to provide the memory that is used by the Idle task. It is used when
; * configKERNEL_PROVIDED_STATIC_MEMORY is set to 1. The application can provide
; * its own implementation of vApplicationGetIdleTaskMemory by setting
; * configKERNEL_PROVIDED_STATIC_MEMORY to 0 or leaving it undefined.
; */
;    void vApplicationGetIdleTaskMemory( StaticTask_t ** ppxIdleTaskTCBBuffer,
;                                        StackType_t ** ppxIdleTaskStackBuffer,
;                                        configSTACK_DEPTH_TYPE * puxIdleTaskStackSize )
;    {
;        static StaticTask_t xIdleTaskTCB;
;        static StackType_t uxIdleTaskStack[ configMINIMAL_STACK_SIZE ];
;
;        *ppxIdleTaskTCBBuffer = &( xIdleTaskTCB );
;        *ppxIdleTaskStackBuffer = &( uxIdleTaskStack[ 0 ] );
;        *puxIdleTaskStackSize = configMINIMAL_STACK_SIZE;
;    }
;
;    #if ( configNUMBER_OF_CORES > 1 )
;
;        void vApplicationGetPassiveIdleTaskMemory( StaticTask_t ** ppxIdleTaskTCBBuffer,
;                                                   StackType_t ** ppxIdleTaskStackBuffer,
;                                                   configSTACK_DEPTH_TYPE * puxIdleTaskStackSize,
;                                                   BaseType_t xPassiveIdleTaskIndex )
;        {
;            static StaticTask_t xIdleTaskTCBs[ configNUMBER_OF_CORES - 1 ];
;            static StackType_t uxIdleTaskStacks[ configNUMBER_OF_CORES - 1 ][ configMINIMAL_STACK_SIZE ];
;
;            *ppxIdleTaskTCBBuffer = &( xIdleTaskTCBs[ xPassiveIdleTaskIndex ] );
;            *ppxIdleTaskStackBuffer = &( uxIdleTaskStacks[ xPassiveIdleTaskIndex ][ 0 ] );
;            *puxIdleTaskStackSize = configMINIMAL_STACK_SIZE;
;        }
;
;    #endif /* #if ( configNUMBER_OF_CORES > 1 ) */
;
;#endif /* #if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configKERNEL_PROVIDED_STATIC_MEMORY == 1 ) && ( portUSING_MPU_WRAPPERS == 0 ) ) */
;/*-----------------------------------------------------------*/
;
;#if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configKERNEL_PROVIDED_STATIC_MEMORY == 1 ) && ( portUSING_MPU_WRAPPERS == 0 ) && ( configUSE_TIMERS == 1 ) )
;
;/*
; * This is the kernel provided implementation of vApplicationGetTimerTaskMemory()
; * to provide the memory that is used by the Timer service task. It is used when
; * configKERNEL_PROVIDED_STATIC_MEMORY is set to 1. The application can provide
; * its own implementation of vApplicationGetTimerTaskMemory by setting
; * configKERNEL_PROVIDED_STATIC_MEMORY to 0 or leaving it undefined.
; */
;    void vApplicationGetTimerTaskMemory( StaticTask_t ** ppxTimerTaskTCBBuffer,
;                                         StackType_t ** ppxTimerTaskStackBuffer,
;                                         configSTACK_DEPTH_TYPE * puxTimerTaskStackSize )
;    {
;        static StaticTask_t xTimerTaskTCB;
;        static StackType_t uxTimerTaskStack[ configTIMER_TASK_STACK_DEPTH ];
;
;        *ppxTimerTaskTCBBuffer = &( xTimerTaskTCB );
;        *ppxTimerTaskStackBuffer = &( uxTimerTaskStack[ 0 ] );
;        *puxTimerTaskStackSize = configTIMER_TASK_STACK_DEPTH;
;    }
;
;#endif /* #if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configKERNEL_PROVIDED_STATIC_MEMORY == 1 ) && ( portUSING_MPU_WRAPPERS == 0 ) && ( configUSE_TIMERS == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;/*
; * Reset the state in this file. This state is normally initialized at start up.
; * This function must be called by the application before restarting the
; * scheduler.
; */
;void vTaskResetState( void )
;{
	code
	xdef	_~vTaskResetState
	func
_~vTaskResetState:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L589
	tcs
	phd
	tcd
;    BaseType_t xCoreID;
;
;    /* Task control block. */
;    #if ( configNUMBER_OF_CORES == 1 )
;    {
xCoreID_1	set	0
;        pxCurrentTCB = NULL;
	stz	|_~pxCurrentTCB	; volatile
	stz	|_~pxCurrentTCB+2	; volatile
;    }
;    #endif /* #if ( configNUMBER_OF_CORES == 1 ) */
;
;    #if ( INCLUDE_vTaskDelete == 1 )
;    {
;        uxDeletedTasksWaitingCleanUp = ( UBaseType_t ) 0U;
	stz	|_~uxDeletedTasksWaitingCleanUp	; volatile
;    }
;    #endif /* #if ( INCLUDE_vTaskDelete == 1 ) */
;
;    #if ( configUSE_POSIX_ERRNO == 1 )
;    {
;        FreeRTOS_errno = 0;
;    }
;    #endif /* #if ( configUSE_POSIX_ERRNO == 1 ) */
;
;    /* Other file private variables. */
;    uxCurrentNumberOfTasks = ( UBaseType_t ) 0U;
	stz	|_~uxCurrentNumberOfTasks	; volatile
;    xTickCount = ( TickType_t ) configINITIAL_TICK_COUNT;
	stz	|_~xTickCount	; volatile
	stz	|_~xTickCount+2	; volatile
;    uxTopReadyPriority = tskIDLE_PRIORITY;
	stz	|_~uxTopReadyPriority	; volatile
;    xSchedulerRunning = pdFALSE;
	stz	|_~xSchedulerRunning	; volatile
;    xPendedTicks = ( TickType_t ) 0U;
	stz	|_~xPendedTicks	; volatile
	stz	|_~xPendedTicks+2	; volatile
;
;    for( xCoreID = 0; xCoreID < configNUMBER_OF_CORES; xCoreID++ )
	stz	<L590+xCoreID_1
L10814:
;    {
;        xYieldPendings[ xCoreID ] = pdFALSE;
	lda	<L590+xCoreID_1
	asl	A
	tax
	lda	#$0
	sta	|_~xYieldPendings,X
;    }
	inc	<L590+xCoreID_1
	lda	<L590+xCoreID_1
	bmi	L10814
	dea
	bmi	L10814
;
;    xNumOfOverflows = ( BaseType_t ) 0;
	stz	|_~xNumOfOverflows	; volatile
;    uxTaskNumber = ( UBaseType_t ) 0U;
	stz	|_~uxTaskNumber
;    xNextTaskUnblockTime = ( TickType_t ) 0U;
	stz	|_~xNextTaskUnblockTime	; volatile
	stz	|_~xNextTaskUnblockTime+2	; volatile
;
;    uxSchedulerSuspended = ( UBaseType_t ) 0U;
	stz	|_~uxSchedulerSuspended	; volatile
;
;    #if ( configGENERATE_RUN_TIME_STATS == 1 )
;    {
;        for( xCoreID = 0; xCoreID < configNUMBER_OF_CORES; xCoreID++ )
;        {
;            ulTaskSwitchedInTime[ xCoreID ] = 0U;
;            ulTotalRunTime[ xCoreID ] = 0U;
;        }
;    }
;    #endif /* #if ( configGENERATE_RUN_TIME_STATS == 1 ) */
;}
	pld
	tsc
	clc
	adc	#L589
	tcs
	rts
L589	equ	6
L590	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
	xref	_~uxListRemove
	xref	_~vListInsertEnd
	xref	_~vListInsert
	xref	_~vListInitialiseItem
	xref	_~vListInitialise
	xref	_~vPortEndScheduler
	xref	_~xPortStartScheduler
	xref	_~vPortFreeStack
	xref	_~pvPortMallocStack
	xref	_~vPortFree
	xref	_~pvPortMalloc
	xref	_~pxPortInitialiseStack
	xref	_~vPortYield
	xref	_~strlen
	xref	_~memset
	udata
_~xIdleTaskHandles
	ds	4
	ends
	udata
_~xSuspendedTaskList
	ds	18
	ends
	udata
_~xTasksWaitingTermination
	ds	18
	ends
	udata
_~xPendingReadyList
	ds	18
	ends
	udata
_~pxOverflowDelayedTaskList
	ds	4
	ends
	udata
_~pxDelayedTaskList
	ds	4
	ends
	udata
_~xDelayedTaskList2
	ds	18
	ends
	udata
_~xDelayedTaskList1
	ds	18
	ends
	udata
_~pxReadyTasksLists
	ds	90
	ends
	xref	_~debug_hex
	xref	_~debug_char

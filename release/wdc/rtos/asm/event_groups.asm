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
;/* Standard includes. */
;#include <stdlib.h>
;
;/* Defining MPU_WRAPPERS_INCLUDED_FROM_API_FILE prevents task.h from redefining
; * all the API functions to use the MPU wrappers. That should only be done when
; * task.h is included from an application file. */
;#define MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;/* FreeRTOS includes. */
;#include "FreeRTOS.h"
;#include "task.h"
;#include "timers.h"
;#include "event_groups.h"
;
;/* The MPU ports require MPU_WRAPPERS_INCLUDED_FROM_API_FILE to be defined
; * for the header files above, but not in this file, in order to generate the
; * correct privileged Vs unprivileged linkage and placement. */
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;/* This entire source file will be skipped if the application is not configured
; * to include event groups functionality. This #if is closed at the very bottom
; * of this file. If you want to include event groups then ensure
; * configUSE_EVENT_GROUPS is set to 1 in FreeRTOSConfig.h. */
;#if ( configUSE_EVENT_GROUPS == 1 )
;
;    typedef struct EventGroupDef_t
;    {
;        EventBits_t uxEventBits;
;        List_t xTasksWaitingForBits; /**< List of tasks waiting for a bit to be set. */
;
;        #if ( configUSE_TRACE_FACILITY == 1 )
;            UBaseType_t uxEventGroupNumber;
;        #endif
;
;        #if ( ( configSUPPORT_STATIC_ALLOCATION == 1 ) && ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) )
;            uint8_t ucStaticallyAllocated; /**< Set to pdTRUE if the event group is statically allocated to ensure no attempt is made to free the memory. */
;        #endif
;    } EventGroup_t;
;
;/*-----------------------------------------------------------*/
;
;/*
; * Test the bits set in uxCurrentEventBits to see if the wait condition is met.
; * The wait condition is defined by xWaitForAllBits.  If xWaitForAllBits is
; * pdTRUE then the wait condition is met if all the bits set in uxBitsToWaitFor
; * are also set in uxCurrentEventBits.  If xWaitForAllBits is pdFALSE then the
; * wait condition is met if any of the bits set in uxBitsToWaitFor are also set
; * in uxCurrentEventBits.
; */
;    static BaseType_t prvTestWaitCondition( const EventBits_t uxCurrentEventBits,
;                                            const EventBits_t uxBitsToWaitFor,
;                                            const BaseType_t xWaitForAllBits ) PRIVILEGED_FUNCTION;
;
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;        EventGroupHandle_t xEventGroupCreateStatic( StaticEventGroup_t * pxEventGroupBuffer )
;        {
;            EventGroup_t * pxEventBits;
;
;            traceENTER_xEventGroupCreateStatic( pxEventGroupBuffer );
;
;            /* A StaticEventGroup_t object must be provided. */
;            configASSERT( pxEventGroupBuffer );
;
;            #if ( configASSERT_DEFINED == 1 )
;            {
;                /* Sanity check that the size of the structure used to declare a
;                 * variable of type StaticEventGroup_t equals the size of the real
;                 * event group structure. */
;                volatile size_t xSize = sizeof( StaticEventGroup_t );
;                configASSERT( xSize == sizeof( EventGroup_t ) );
;            }
;            #endif /* configASSERT_DEFINED */
;
;            /* The user has provided a statically allocated event group - use it. */
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            pxEventBits = ( EventGroup_t * ) pxEventGroupBuffer;
;
;            if( pxEventBits != NULL )
;            {
;                pxEventBits->uxEventBits = 0;
;                vListInitialise( &( pxEventBits->xTasksWaitingForBits ) );
;
;                #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;                {
;                    /* Both static and dynamic allocation can be used, so note that
;                     * this event group was created statically in case the event group
;                     * is later deleted. */
;                    pxEventBits->ucStaticallyAllocated = pdTRUE;
;                }
;                #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;
;                traceEVENT_GROUP_CREATE( pxEventBits );
;            }
;            else
;            {
;                /* xEventGroupCreateStatic should only ever be called with
;                 * pxEventGroupBuffer pointing to a pre-allocated (compile time
;                 * allocated) StaticEventGroup_t variable. */
;                traceEVENT_GROUP_CREATE_FAILED();
;            }
;
;            traceRETURN_xEventGroupCreateStatic( pxEventBits );
;
;            return pxEventBits;
;        }
;
;    #endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;
;        EventGroupHandle_t xEventGroupCreate( void )
;        {
	code
	xdef	_~xEventGroupCreate
	func
_~xEventGroupCreate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
;            EventGroup_t * pxEventBits;
;
;            traceENTER_xEventGroupCreate();
pxEventBits_1	set	0
;
;            /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            pxEventBits = ( EventGroup_t * ) pvPortMalloc( sizeof( EventGroup_t ) );
	pea	#<$16
	jsr	_~pvPortMalloc
	sta	<L3+pxEventBits_1
	stx	<L3+pxEventBits_1+2
;
;            if( pxEventBits != NULL )
;            {
	ora	<L3+pxEventBits_1+2
	beq	L10002
;                pxEventBits->uxEventBits = 0;
	lda	#$0
	sta	[<L3+pxEventBits_1]
	ldy	#$2
	sta	[<L3+pxEventBits_1],Y
;                vListInitialise( &( pxEventBits->xTasksWaitingForBits ) );
	lda	#$4
	clc
	adc	<L3+pxEventBits_1
	sta	<R0
	lda	#$0
	adc	<L3+pxEventBits_1+2
	pha
	pei	<R0
	jsr	_~vListInitialise
;
;                #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;                {
;                    /* Both static and dynamic allocation can be used, so note this
;                     * event group was allocated statically in case the event group is
;                     * later deleted. */
;                    pxEventBits->ucStaticallyAllocated = pdFALSE;
;                }
;                #endif /* configSUPPORT_STATIC_ALLOCATION */
;
;                traceEVENT_GROUP_CREATE( pxEventBits );
;            }
;            else
;            {
;                traceEVENT_GROUP_CREATE_FAILED();
;            }
L10002:
;
;            traceRETURN_xEventGroupCreate( pxEventBits );
;
;            return pxEventBits;
	ldx	<L3+pxEventBits_1+2
	lda	<L3+pxEventBits_1
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rts
;        }
L2	equ	8
L3	equ	5
	ends
	efunc
;
;    #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;    EventBits_t xEventGroupSync( EventGroupHandle_t xEventGroup,
;                                 const EventBits_t uxBitsToSet,
;                                 const EventBits_t uxBitsToWaitFor,
;                                 TickType_t xTicksToWait )
;    {
	code
	xdef	_~xEventGroupSync
	func
_~xEventGroupSync:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
xEventGroup_0	set	3
uxBitsToSet_0	set	7
uxBitsToWaitFor_0	set	11
xTicksToWait_0	set	15
;        EventBits_t uxOriginalBitValue, uxReturn;
;        EventGroup_t * pxEventBits = xEventGroup;
;        BaseType_t xAlreadyYielded;
;        BaseType_t xTimeoutOccurred = pdFALSE;
;
;        traceENTER_xEventGroupSync( xEventGroup, uxBitsToSet, uxBitsToWaitFor, xTicksToWait );
uxOriginalBitValue_1	set	0
uxReturn_1	set	4
pxEventBits_1	set	8
xAlreadyYielded_1	set	12
xTimeoutOccurred_1	set	14
	lda	<L6+xEventGroup_0
	sta	<L7+pxEventBits_1
	lda	<L6+xEventGroup_0+2
	sta	<L7+pxEventBits_1+2
	stz	<L7+xTimeoutOccurred_1
;
;        configASSERT( ( uxBitsToWaitFor & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L6+uxBitsToWaitFor_0+2
	and	#^$ff000000
	beq	L10003
L10007:
	bra	L10007
L10003:
;        configASSERT( uxBitsToWaitFor != 0 );
	lda	<L6+uxBitsToWaitFor_0
	ora	<L6+uxBitsToWaitFor_0+2
	bne	L10010
L10014:
	bra	L10014
L10010:
;        #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;        {
;            configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	bne	L10017
	lda	<L6+xTicksToWait_0
	ora	<L6+xTicksToWait_0+2
	beq	L10017
L10021:
	bra	L10021
L10017:
;        }
;        #endif
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            uxOriginalBitValue = pxEventBits->uxEventBits;
	lda	[<L7+pxEventBits_1]
	sta	<L7+uxOriginalBitValue_1
	ldy	#$2
	lda	[<L7+pxEventBits_1],Y
	sta	<L7+uxOriginalBitValue_1+2
;
;            ( void ) xEventGroupSetBits( xEventGroup, uxBitsToSet );
	pei	<L6+uxBitsToSet_0+2
	pei	<L6+uxBitsToSet_0
	pei	<L6+xEventGroup_0+2
	pei	<L6+xEventGroup_0
	jsr	_~xEventGroupSetBits
;
;            if( ( ( uxOriginalBitValue | uxBitsToSet ) & uxBitsToWaitFor ) == uxBitsToWaitFor )
;            {
	lda	<L6+uxBitsToSet_0
	ora	<L7+uxOriginalBitValue_1
	sta	<R0
	lda	<L6+uxBitsToSet_0+2
	ora	<L7+uxOriginalBitValue_1+2
	sta	<R0+2
	lda	<L6+uxBitsToWaitFor_0
	and	<R0
	sta	<R1
	lda	<L6+uxBitsToWaitFor_0+2
	and	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	<L6+uxBitsToWaitFor_0
	bne	L12
	lda	<R1+2
	cmp	<L6+uxBitsToWaitFor_0+2
L12:
	bne	L10024
;                /* All the rendezvous bits are now set - no need to block. */
;                uxReturn = ( uxOriginalBitValue | uxBitsToSet );
	lda	<L6+uxBitsToSet_0
	ora	<L7+uxOriginalBitValue_1
	sta	<L7+uxReturn_1
	lda	<L6+uxBitsToSet_0+2
	ora	<L7+uxOriginalBitValue_1+2
	sta	<L7+uxReturn_1+2
;
;                /* Rendezvous always clear the bits.  They will have been cleared
;                 * already unless this is the only task in the rendezvous. */
;                pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L6+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L6+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L7+pxEventBits_1]
	and	<R0
	sta	[<L7+pxEventBits_1]
	ldy	#$2
	lda	[<L7+pxEventBits_1],Y
	and	<R0+2
	sta	[<L7+pxEventBits_1],Y
;
;                xTicksToWait = 0;
	stz	<L6+xTicksToWait_0
	stz	<L6+xTicksToWait_0+2
;            }
;            else
	bra	L10025
L10024:
;            {
;                if( xTicksToWait != ( TickType_t ) 0 )
;                {
	lda	<L6+xTicksToWait_0
	ora	<L6+xTicksToWait_0+2
	beq	L10026
;                    traceEVENT_GROUP_SYNC_BLOCK( xEventGroup, uxBitsToSet, uxBitsToWaitFor );
;
;                    /* Store the bits that the calling task is waiting for in the
;                     * task's event list item so the kernel knows when a match is
;                     * found.  Then enter the blocked state. */
;                    vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | eventCLEAR_EVENTS_ON_EXIT_BIT | eventWAIT_FOR_ALL_BITS ), xTicksToWait );
	pei	<L6+xTicksToWait_0+2
	pei	<L6+xTicksToWait_0
	lda	<L6+uxBitsToWaitFor_0
	sta	<R0
	lda	<L6+uxBitsToWaitFor_0+2
	ora	#^$5000000
	pha
	pei	<R0
	lda	#$4
	clc
	adc	<L7+pxEventBits_1
	sta	<R1
	lda	#$0
	adc	<L7+pxEventBits_1+2
	pha
	pei	<R1
	jsr	_~vTaskPlaceOnUnorderedEventList
;
;                    /* This assignment is obsolete as uxReturn will get set after
;                     * the task unblocks, but some compilers mistakenly generate a
;                     * warning about uxReturn being returned without being set if the
;                     * assignment is omitted. */
;                    uxReturn = 0;
	stz	<L7+uxReturn_1
	stz	<L7+uxReturn_1+2
;                }
;                else
	bra	L10025
L10026:
;                {
;                    /* The rendezvous bits were not set, but no block time was
;                     * specified - just return the current event bit value. */
;                    uxReturn = pxEventBits->uxEventBits;
	lda	[<L7+pxEventBits_1]
	sta	<L7+uxReturn_1
	ldy	#$2
	lda	[<L7+pxEventBits_1],Y
	sta	<L7+uxReturn_1+2
;                    xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L7+xTimeoutOccurred_1
;                }
;            }
L10025:
;        }
;        xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L7+xAlreadyYielded_1
;
;        if( xTicksToWait != ( TickType_t ) 0 )
;        {
	lda	<L6+xTicksToWait_0
	ora	<L6+xTicksToWait_0+2
	beq	L10028
;            if( xAlreadyYielded == pdFALSE )
;            {
	lda	<L7+xAlreadyYielded_1
	bne	L10030
;                taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10030:
;
;            /* The task blocked to wait for its required bits to be set - at this
;             * point either the required bits were set or the block time expired.  If
;             * the required bits were set they will have been stored in the task's
;             * event list item, and they should now be retrieved then cleared. */
;            uxReturn = uxTaskResetEventItemValue();
	jsr	_~uxTaskResetEventItemValue
	sta	<L7+uxReturn_1
	stx	<L7+uxReturn_1+2
;
;            if( ( uxReturn & eventUNBLOCKED_DUE_TO_BIT_SET ) == ( EventBits_t ) 0 )
;            {
	lda	<L7+uxReturn_1+2
	and	#^$2000000
	bne	L10040
;                /* The task timed out, just return the current event bit value. */
;                taskENTER_CRITICAL();
;                {
;                    uxReturn = pxEventBits->uxEventBits;
	lda	[<L7+pxEventBits_1]
	sta	<L7+uxReturn_1
	ldy	#$2
	lda	[<L7+pxEventBits_1],Y
	sta	<L7+uxReturn_1+2
;
;                    /* Although the task got here because it timed out before the
;                     * bits it was waiting for were set, it is possible that since it
;                     * unblocked another task has set the bits.  If this is the case
;                     * then it needs to clear the bits before exiting. */
;                    if( ( uxReturn & uxBitsToWaitFor ) == uxBitsToWaitFor )
;                    {
	lda	<L6+uxBitsToWaitFor_0
	and	<L7+uxReturn_1
	sta	<R0
	lda	<L6+uxBitsToWaitFor_0+2
	and	<L7+uxReturn_1+2
	sta	<R0+2
	lda	<R0
	cmp	<L6+uxBitsToWaitFor_0
	bne	L18
	lda	<R0+2
	cmp	<L6+uxBitsToWaitFor_0+2
L18:
	bne	L10038
;                        pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L6+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L6+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L7+pxEventBits_1]
	and	<R0
	sta	[<L7+pxEventBits_1]
	ldy	#$2
	lda	[<L7+pxEventBits_1],Y
	and	<R0+2
	sta	[<L7+pxEventBits_1],Y
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                taskEXIT_CRITICAL();
L10038:
;
;                xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L7+xTimeoutOccurred_1
;            }
;            else
;            {
;                /* The task unblocked because the bits were set. */
;            }
L10040:
;
;            /* Control bits might be set as the task had blocked should not be
;             * returned. */
;            uxReturn &= ~eventEVENT_BITS_CONTROL_BYTES;
	lda	<L7+uxReturn_1+2
	and	#^$ffffff
	sta	<L7+uxReturn_1+2
;        }
;
;        traceEVENT_GROUP_SYNC_END( xEventGroup, uxBitsToSet, uxBitsToWaitFor, xTimeoutOccurred );
L10028:
;
;        /* Prevent compiler warnings when trace macros are not used. */
;        ( void ) xTimeoutOccurred;
;
;        traceRETURN_xEventGroupSync( uxReturn );
;
;        return uxReturn;
	ldx	<L7+uxReturn_1+2
	lda	<L7+uxReturn_1
	tay
	lda	<L6+1
	sta	<L6+1+16
	pld
	tsc
	clc
	adc	#L6+16
	tcs
	tya
	rts
;    }
L6	equ	24
L7	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    EventBits_t xEventGroupWaitBits( EventGroupHandle_t xEventGroup,
;                                     const EventBits_t uxBitsToWaitFor,
;                                     const BaseType_t xClearOnExit,
;                                     const BaseType_t xWaitForAllBits,
;                                     TickType_t xTicksToWait )
;    {
	code
	xdef	_~xEventGroupWaitBits
	func
_~xEventGroupWaitBits:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L21
	tcs
	phd
	tcd
xEventGroup_0	set	3
uxBitsToWaitFor_0	set	7
xClearOnExit_0	set	11
xWaitForAllBits_0	set	13
xTicksToWait_0	set	15
;        EventGroup_t * pxEventBits = xEventGroup;
;        EventBits_t uxReturn, uxControlBits = 0;
;        BaseType_t xWaitConditionMet, xAlreadyYielded;
;        BaseType_t xTimeoutOccurred = pdFALSE;
;
;        traceENTER_xEventGroupWaitBits( xEventGroup, uxBitsToWaitFor, xClearOnExit, xWaitForAllBits, xTicksToWait );
pxEventBits_1	set	0
uxReturn_1	set	4
uxControlBits_1	set	8
xWaitConditionMet_1	set	12
xAlreadyYielded_1	set	14
xTimeoutOccurred_1	set	16
	lda	<L21+xEventGroup_0
	sta	<L22+pxEventBits_1
	lda	<L21+xEventGroup_0+2
	sta	<L22+pxEventBits_1+2
	stz	<L22+uxControlBits_1
	stz	<L22+uxControlBits_1+2
	stz	<L22+xTimeoutOccurred_1
;
;        /* Check the user is not attempting to wait on the bits used by the kernel
;         * itself, and that at least one bit is being requested. */
;        configASSERT( xEventGroup );
	lda	<L21+xEventGroup_0
	ora	<L21+xEventGroup_0+2
	bne	L10041
L10045:
	bra	L10045
L10041:
;        configASSERT( ( uxBitsToWaitFor & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L21+uxBitsToWaitFor_0+2
	and	#^$ff000000
	beq	L10048
L10052:
	bra	L10052
L10048:
;        configASSERT( uxBitsToWaitFor != 0 );
	lda	<L21+uxBitsToWaitFor_0
	ora	<L21+uxBitsToWaitFor_0+2
	bne	L10055
L10059:
	bra	L10059
L10055:
;        #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;        {
;            configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	bne	L10062
	lda	<L21+xTicksToWait_0
	ora	<L21+xTicksToWait_0+2
	beq	L10062
L10066:
	bra	L10066
L10062:
;        }
;        #endif
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            const EventBits_t uxCurrentEventBits = pxEventBits->uxEventBits;
;
;            /* Check to see if the wait condition is already met or not. */
;            xWaitConditionMet = prvTestWaitCondition( uxCurrentEventBits, uxBitsToWaitFor, xWaitForAllBits );
uxCurrentEventBits_2	set	18
	lda	[<L22+pxEventBits_1]
	sta	<L22+uxCurrentEventBits_2
	ldy	#$2
	lda	[<L22+pxEventBits_1],Y
	sta	<L22+uxCurrentEventBits_2+2
	pei	<L21+xWaitForAllBits_0
	pei	<L21+uxBitsToWaitFor_0+2
	pei	<L21+uxBitsToWaitFor_0
	pei	<L22+uxCurrentEventBits_2+2
	pei	<L22+uxCurrentEventBits_2
	jsr	_~prvTestWaitCondition
	sta	<L22+xWaitConditionMet_1
;
;            if( xWaitConditionMet != pdFALSE )
;            {
	lda	<L22+xWaitConditionMet_1
	beq	L10069
;                /* The wait condition has already been met so there is no need to
;                 * block. */
;                uxReturn = uxCurrentEventBits;
	lda	<L22+uxCurrentEventBits_2
	sta	<L22+uxReturn_1
	lda	<L22+uxCurrentEventBits_2+2
	sta	<L22+uxReturn_1+2
;                xTicksToWait = ( TickType_t ) 0;
	stz	<L21+xTicksToWait_0
	stz	<L21+xTicksToWait_0+2
;
;                /* Clear the wait bits if requested to do so. */
;                if( xClearOnExit != pdFALSE )
;                {
	lda	<L21+xClearOnExit_0
	beq	L10072
;                    pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L21+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L21+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L22+pxEventBits_1]
	and	<R0
	sta	[<L22+pxEventBits_1]
	ldy	#$2
	lda	[<L22+pxEventBits_1],Y
	and	<R0+2
	sta	[<L22+pxEventBits_1],Y
;                }
;                else
	bra	L10072
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else if( xTicksToWait == ( TickType_t ) 0 )
L10069:
;            {
	lda	<L21+xTicksToWait_0
	ora	<L21+xTicksToWait_0+2
	bne	L10073
;                /* The wait condition has not been met, but no block time was
;                 * specified, so just return the current value. */
;                uxReturn = uxCurrentEventBits;
	lda	<L22+uxCurrentEventBits_2
	sta	<L22+uxReturn_1
	lda	<L22+uxCurrentEventBits_2+2
	sta	<L22+uxReturn_1+2
;                xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L22+xTimeoutOccurred_1
;            }
;            else
	bra	L10072
L10073:
;            {
;                /* The task is going to block to wait for its required bits to be
;                 * set.  uxControlBits are used to remember the specified behaviour of
;                 * this call to xEventGroupWaitBits() - for use when the event bits
;                 * unblock the task. */
;                if( xClearOnExit != pdFALSE )
;                {
	lda	<L21+xClearOnExit_0
	beq	L10076
;                    uxControlBits |= eventCLEAR_EVENTS_ON_EXIT_BIT;
	lda	<L22+uxControlBits_1+2
	ora	#^$1000000
	sta	<L22+uxControlBits_1+2
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10076:
;
;                if( xWaitForAllBits != pdFALSE )
;                {
	lda	<L21+xWaitForAllBits_0
	beq	L10078
;                    uxControlBits |= eventWAIT_FOR_ALL_BITS;
	lda	<L22+uxControlBits_1+2
	ora	#^$4000000
	sta	<L22+uxControlBits_1+2
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10078:
;
;                /* Store the bits that the calling task is waiting for in the
;                 * task's event list item so the kernel knows when a match is
;                 * found.  Then enter the blocked state. */
;                vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | uxControlBits ), xTicksToWait );
	pei	<L21+xTicksToWait_0+2
	pei	<L21+xTicksToWait_0
	lda	<L22+uxControlBits_1
	ora	<L21+uxBitsToWaitFor_0
	sta	<R0
	lda	<L22+uxControlBits_1+2
	ora	<L21+uxBitsToWaitFor_0+2
	pha
	pei	<R0
	lda	#$4
	clc
	adc	<L22+pxEventBits_1
	sta	<R1
	lda	#$0
	adc	<L22+pxEventBits_1+2
	pha
	pei	<R1
	jsr	_~vTaskPlaceOnUnorderedEventList
;
;                /* This is obsolete as it will get set after the task unblocks, but
;                 * some compilers mistakenly generate a warning about the variable
;                 * being returned without being set if it is not done. */
;                uxReturn = 0;
	stz	<L22+uxReturn_1
	stz	<L22+uxReturn_1+2
;
;                traceEVENT_GROUP_WAIT_BITS_BLOCK( xEventGroup, uxBitsToWaitFor );
;            }
L10072:
;        }
;        xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L22+xAlreadyYielded_1
;
;        if( xTicksToWait != ( TickType_t ) 0 )
;        {
	lda	<L21+xTicksToWait_0
	ora	<L21+xTicksToWait_0+2
	beq	L10079
;            if( xAlreadyYielded == pdFALSE )
;            {
	lda	<L22+xAlreadyYielded_1
	bne	L10081
;                taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10081:
;
;            /* The task blocked to wait for its required bits to be set - at this
;             * point either the required bits were set or the block time expired.  If
;             * the required bits were set they will have been stored in the task's
;             * event list item, and they should now be retrieved then cleared. */
;            uxReturn = uxTaskResetEventItemValue();
	jsr	_~uxTaskResetEventItemValue
	sta	<L22+uxReturn_1
	stx	<L22+uxReturn_1+2
;
;            if( ( uxReturn & eventUNBLOCKED_DUE_TO_BIT_SET ) == ( EventBits_t ) 0 )
;            {
	lda	<L22+uxReturn_1+2
	and	#^$2000000
	bne	L10093
;                taskENTER_CRITICAL();
;                {
;                    /* The task timed out, just return the current event bit value. */
;                    uxReturn = pxEventBits->uxEventBits;
	lda	[<L22+pxEventBits_1]
	sta	<L22+uxReturn_1
	ldy	#$2
	lda	[<L22+pxEventBits_1],Y
	sta	<L22+uxReturn_1+2
;
;                    /* It is possible that the event bits were updated between this
;                     * task leaving the Blocked state and running again. */
;                    if( prvTestWaitCondition( uxReturn, uxBitsToWaitFor, xWaitForAllBits ) != pdFALSE )
;                    {
	pei	<L21+xWaitForAllBits_0
	pei	<L21+uxBitsToWaitFor_0+2
	pei	<L21+uxBitsToWaitFor_0
	pei	<L22+uxReturn_1+2
	pei	<L22+uxReturn_1
	jsr	_~prvTestWaitCondition
	tax
	beq	L10089
;                        if( xClearOnExit != pdFALSE )
;                        {
	lda	<L21+xClearOnExit_0
	beq	L10089
;                            pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L21+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L21+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L22+pxEventBits_1]
	and	<R0
	sta	[<L22+pxEventBits_1]
	ldy	#$2
	lda	[<L22+pxEventBits_1],Y
	and	<R0+2
	sta	[<L22+pxEventBits_1],Y
;                        }
;                        else
L10089:
;
;                    xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L22+xTimeoutOccurred_1
;                }
;                taskEXIT_CRITICAL();
;            }
;            else
L10093:
;
;            /* The task blocked so control bits may have been set. */
;            uxReturn &= ~eventEVENT_BITS_CONTROL_BYTES;
	lda	<L22+uxReturn_1+2
	and	#^$ffffff
	sta	<L22+uxReturn_1+2
;        }
;
;        traceEVENT_GROUP_WAIT_BITS_END( xEventGroup, uxBitsToWaitFor, xTimeoutOccurred );
L10079:
;
;        /* Prevent compiler warnings when trace macros are not used. */
;        ( void ) xTimeoutOccurred;
;
;        traceRETURN_xEventGroupWaitBits( uxReturn );
;
;        return uxReturn;
	ldx	<L22+uxReturn_1+2
	lda	<L22+uxReturn_1
	tay
	lda	<L21+1
	sta	<L21+1+16
	pld
	tsc
	clc
	adc	#L21+16
	tcs
	tya
	rts
;                        {
;                            mtCOVERAGE_TEST_MARKER();
;                        }
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;            {
;                /* The task unblocked because the bits were set. */
;            }
;    }
L21	equ	30
L22	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup,
;                                      const EventBits_t uxBitsToClear )
;    {
	code
	xdef	_~xEventGroupClearBits
	func
_~xEventGroupClearBits:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L39
	tcs
	phd
	tcd
xEventGroup_0	set	3
uxBitsToClear_0	set	7
;        EventGroup_t * pxEventBits = xEventGroup;
;        EventBits_t uxReturn;
;
;        traceENTER_xEventGroupClearBits( xEventGroup, uxBitsToClear );
pxEventBits_1	set	0
uxReturn_1	set	4
	lda	<L39+xEventGroup_0
	sta	<L40+pxEventBits_1
	lda	<L39+xEventGroup_0+2
	sta	<L40+pxEventBits_1+2
;
;        /* Check the user is not attempting to clear the bits used by the kernel
;         * itself. */
;        configASSERT( xEventGroup );
	lda	<L39+xEventGroup_0
	ora	<L39+xEventGroup_0+2
	bne	L10094
L10098:
	bra	L10098
L10094:
;        configASSERT( ( uxBitsToClear & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L39+uxBitsToClear_0+2
	and	#^$ff000000
	beq	L10109
L10105:
	bra	L10105
;
;        taskENTER_CRITICAL();
L10109:
;        {
;            traceEVENT_GROUP_CLEAR_BITS( xEventGroup, uxBitsToClear );
;
;            /* The value returned is the event group value prior to the bits being
;             * cleared. */
;            uxReturn = pxEventBits->uxEventBits;
	lda	[<L40+pxEventBits_1]
	sta	<L40+uxReturn_1
	ldy	#$2
	lda	[<L40+pxEventBits_1],Y
	sta	<L40+uxReturn_1+2
;
;            /* Clear the bits. */
;            pxEventBits->uxEventBits &= ~uxBitsToClear;
	lda	<L39+uxBitsToClear_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L39+uxBitsToClear_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L40+pxEventBits_1]
	and	<R0
	sta	[<L40+pxEventBits_1]
	lda	[<L40+pxEventBits_1],Y
	and	<R0+2
	sta	[<L40+pxEventBits_1],Y
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_xEventGroupClearBits( uxReturn );
;
;        return uxReturn;
	ldx	<L40+uxReturn_1+2
	lda	<L40+uxReturn_1
	tay
	lda	<L39+1
	sta	<L39+1+8
	pld
	tsc
	clc
	adc	#L39+8
	tcs
	tya
	rts
;    }
L39	equ	12
L40	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( ( INCLUDE_xTimerPendFunctionCall == 1 ) && ( configUSE_TIMERS == 1 ) )
;
;        BaseType_t xEventGroupClearBitsFromISR( EventGroupHandle_t xEventGroup,
;                                                const EventBits_t uxBitsToClear )
;        {
;            BaseType_t xReturn;
;
;            traceENTER_xEventGroupClearBitsFromISR( xEventGroup, uxBitsToClear );
;
;            traceEVENT_GROUP_CLEAR_BITS_FROM_ISR( xEventGroup, uxBitsToClear );
;            xReturn = xTimerPendFunctionCallFromISR( &vEventGroupClearBitsCallback, ( void * ) xEventGroup, ( uint32_t ) uxBitsToClear, NULL );
;
;            traceRETURN_xEventGroupClearBitsFromISR( xReturn );
;
;            return xReturn;
;        }
;
;    #endif /* if ( ( INCLUDE_xTimerPendFunctionCall == 1 ) && ( configUSE_TIMERS == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;    EventBits_t xEventGroupGetBitsFromISR( EventGroupHandle_t xEventGroup )
;    {
	code
	xdef	_~xEventGroupGetBitsFromISR
	func
_~xEventGroupGetBitsFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
xEventGroup_0	set	3
;        UBaseType_t uxSavedInterruptStatus;
;        EventGroup_t const * const pxEventBits = xEventGroup;
;        EventBits_t uxReturn;
;
;        traceENTER_xEventGroupGetBitsFromISR( xEventGroup );
uxSavedInterruptStatus_1	set	0
pxEventBits_1	set	2
uxReturn_1	set	6
	lda	<L44+xEventGroup_0
	sta	<L45+pxEventBits_1
	lda	<L44+xEventGroup_0+2
	sta	<L45+pxEventBits_1+2
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L45+uxSavedInterruptStatus_1
;        {
;            uxReturn = pxEventBits->uxEventBits;
	lda	[<L45+pxEventBits_1]
	sta	<L45+uxReturn_1
	ldy	#$2
	lda	[<L45+pxEventBits_1],Y
	sta	<L45+uxReturn_1+2
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_xEventGroupGetBitsFromISR( uxReturn );
;
;        return uxReturn;
	ldx	<L45+uxReturn_1+2
	lda	<L45+uxReturn_1
	tay
	lda	<L44+1
	sta	<L44+1+4
	pld
	tsc
	clc
	adc	#L44+4
	tcs
	tya
	rts
;    }
L44	equ	10
L45	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    EventBits_t xEventGroupSetBits( EventGroupHandle_t xEventGroup,
;                                    const EventBits_t uxBitsToSet )
;    {
	code
	xdef	_~xEventGroupSetBits
	func
_~xEventGroupSetBits:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L47
	tcs
	phd
	tcd
xEventGroup_0	set	3
uxBitsToSet_0	set	7
;        ListItem_t * pxListItem;
;        ListItem_t * pxNext;
;        ListItem_t const * pxListEnd;
;        List_t const * pxList;
;        EventBits_t uxBitsToClear = 0, uxBitsWaitedFor, uxControlBits, uxReturnBits;
;        EventGroup_t * pxEventBits = xEventGroup;
;        BaseType_t xMatchFound = pdFALSE;
;
;        traceENTER_xEventGroupSetBits( xEventGroup, uxBitsToSet );
pxListItem_1	set	0
pxNext_1	set	4
pxListEnd_1	set	8
pxList_1	set	12
uxBitsToClear_1	set	16
uxBitsWaitedFor_1	set	20
uxControlBits_1	set	24
uxReturnBits_1	set	28
pxEventBits_1	set	32
xMatchFound_1	set	36
	stz	<L48+uxBitsToClear_1
	stz	<L48+uxBitsToClear_1+2
	lda	<L47+xEventGroup_0
	sta	<L48+pxEventBits_1
	lda	<L47+xEventGroup_0+2
	sta	<L48+pxEventBits_1+2
	stz	<L48+xMatchFound_1
;
;        /* Check the user is not attempting to set the bits used by the kernel
;         * itself. */
;        configASSERT( xEventGroup );
	lda	<L47+xEventGroup_0
	ora	<L47+xEventGroup_0+2
	bne	L10114
L10118:
	bra	L10118
L10114:
;        configASSERT( ( uxBitsToSet & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L47+uxBitsToSet_0+2
	and	#^$ff000000
	beq	L10121
L10125:
	bra	L10125
L10121:
;
;        pxList = &( pxEventBits->xTasksWaitingForBits );
	lda	#$4
	clc
	adc	<L48+pxEventBits_1
	sta	<L48+pxList_1
	lda	#$0
	adc	<L48+pxEventBits_1+2
	sta	<L48+pxList_1+2
;        pxListEnd = listGET_END_MARKER( pxList );
	lda	#$6
	clc
	adc	<L48+pxList_1
	sta	<L48+pxListEnd_1
	lda	#$0
	adc	<L48+pxList_1+2
	sta	<L48+pxListEnd_1+2
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            traceEVENT_GROUP_SET_BITS( xEventGroup, uxBitsToSet );
;
;            pxListItem = listGET_HEAD_ENTRY( pxList );
	ldy	#$a
	lda	[<L48+pxList_1],Y
	sta	<L48+pxListItem_1
	iny
	iny
	lda	[<L48+pxList_1],Y
	sta	<L48+pxListItem_1+2
;
;            /* Set the bits. */
;            pxEventBits->uxEventBits |= uxBitsToSet;
	lda	<L47+uxBitsToSet_0
	ora	[<L48+pxEventBits_1]
	sta	[<L48+pxEventBits_1]
	lda	<L47+uxBitsToSet_0+2
	ldy	#$2
	ora	[<L48+pxEventBits_1],Y
	sta	[<L48+pxEventBits_1],Y
;
;            /* See if the new bit value should unblock any tasks. */
;            while( pxListItem != pxListEnd )
	brl	L10128
L20004:
;            {
;                pxNext = listGET_NEXT( pxListItem );
	ldy	#$4
	lda	[<L48+pxListItem_1],Y
	sta	<L48+pxNext_1
	iny
	iny
	lda	[<L48+pxListItem_1],Y
	sta	<L48+pxNext_1+2
;                uxBitsWaitedFor = listGET_LIST_ITEM_VALUE( pxListItem );
	lda	[<L48+pxListItem_1]
	sta	<L48+uxBitsWaitedFor_1
	ldy	#$2
	lda	[<L48+pxListItem_1],Y
	sta	<L48+uxBitsWaitedFor_1+2
;                xMatchFound = pdFALSE;
	stz	<L48+xMatchFound_1
;
;                /* Split the bits waited for from the control bits. */
;                uxControlBits = uxBitsWaitedFor & eventEVENT_BITS_CONTROL_BYTES;
	stz	<L48+uxControlBits_1
	lda	<L48+uxBitsWaitedFor_1+2
	and	#^$ff000000
	sta	<L48+uxControlBits_1+2
;                uxBitsWaitedFor &= ~eventEVENT_BITS_CONTROL_BYTES;
	lda	<L48+uxBitsWaitedFor_1+2
	and	#^$ffffff
	sta	<L48+uxBitsWaitedFor_1+2
;
;                if( ( uxControlBits & eventWAIT_FOR_ALL_BITS ) == ( EventBits_t ) 0 )
;                {
	lda	<L48+uxControlBits_1+2
	and	#^$4000000
	beq	*+5
	brl	L10130
;                    /* Just looking for single bit being set. */
;                    if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) != ( EventBits_t ) 0 )
;                    {
	lda	[<L48+pxEventBits_1]
	and	<L48+uxBitsWaitedFor_1
	sta	<R0
	lda	[<L48+pxEventBits_1],Y
	and	<L48+uxBitsWaitedFor_1+2
	sta	<R0+2
	lda	<R0
	ora	<R0+2
	beq	L10133
;                        xMatchFound = pdTRUE;
L20005:
	lda	#$1
	sta	<L48+xMatchFound_1
;                    }
;                    else
L10133:
;
;                if( xMatchFound != pdFALSE )
;                {
	lda	<L48+xMatchFound_1
	beq	L10136
;                {
;                    /* Need all bits to be set, but not all the bits were set. */
;                }
;                    /* The bits match.  Should the bits be cleared on exit? */
;                    if( ( uxControlBits & eventCLEAR_EVENTS_ON_EXIT_BIT ) != ( EventBits_t ) 0 )
;                    {
	lda	<L48+uxControlBits_1+2
	and	#^$1000000
	beq	L10138
;                        uxBitsToClear |= uxBitsWaitedFor;
	lda	<L48+uxBitsWaitedFor_1
	ora	<L48+uxBitsToClear_1
	sta	<L48+uxBitsToClear_1
	lda	<L48+uxBitsWaitedFor_1+2
	ora	<L48+uxBitsToClear_1+2
	sta	<L48+uxBitsToClear_1+2
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10138:
;
;                    /* Store the actual event flag value in the task's event list
;                     * item before removing the task from the event list.  The
;                     * eventUNBLOCKED_DUE_TO_BIT_SET bit is set so the task knows
;                     * that is was unblocked due to its required bits matching, rather
;                     * than because it timed out. */
;                    vTaskRemoveFromUnorderedEventList( pxListItem, pxEventBits->uxEventBits | eventUNBLOCKED_DUE_TO_BIT_SET );
	lda	[<L48+pxEventBits_1]
	sta	<R0
	ldy	#$2
	lda	[<L48+pxEventBits_1],Y
	ora	#^$2000000
	pha
	pei	<R0
	pei	<L48+pxListItem_1+2
	pei	<L48+pxListItem_1
	jsr	_~vTaskRemoveFromUnorderedEventList
;                }
;
;                /* Move onto the next list item.  Note pxListItem->pxNext is not
;                 * used here as the list item may have been removed from the event list
;                 * and inserted into the ready/pending reading list. */
;                pxListItem = pxNext;
L10136:
	lda	<L48+pxNext_1
	sta	<L48+pxListItem_1
	lda	<L48+pxNext_1+2
	sta	<L48+pxListItem_1+2
;            }
L10128:
	lda	<L48+pxListItem_1
	cmp	<L48+pxListEnd_1
	bne	L51
	lda	<L48+pxListItem_1+2
	cmp	<L48+pxListEnd_1+2
L51:
	beq	*+5
	brl	L20004
;
;            /* Clear any bits that matched when the eventCLEAR_EVENTS_ON_EXIT_BIT
;             * bit was set in the control word. */
;            pxEventBits->uxEventBits &= ~uxBitsToClear;
	lda	<L48+uxBitsToClear_1
	eor	#<$ffffffff
	sta	<R0
	lda	<L48+uxBitsToClear_1+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L48+pxEventBits_1]
	and	<R0
	sta	[<L48+pxEventBits_1]
	ldy	#$2
	lda	[<L48+pxEventBits_1],Y
	and	<R0+2
	sta	[<L48+pxEventBits_1],Y
;
;            /* Snapshot resulting bits. */
;            uxReturnBits = pxEventBits->uxEventBits;
	lda	[<L48+pxEventBits_1]
	sta	<L48+uxReturnBits_1
	lda	[<L48+pxEventBits_1],Y
	sta	<L48+uxReturnBits_1+2
;        }
;        ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;        traceRETURN_xEventGroupSetBits( uxReturnBits );
;
;        return uxReturnBits;
	ldx	<L48+uxReturnBits_1+2
	lda	<L48+uxReturnBits_1
	tay
	lda	<L47+1
	sta	<L47+1+8
	pld
	tsc
	clc
	adc	#L47+8
	tcs
	tya
	rts
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) == uxBitsWaitedFor )
L10130:
;                {
	lda	[<L48+pxEventBits_1]
	and	<L48+uxBitsWaitedFor_1
	sta	<R0
	ldy	#$2
	lda	[<L48+pxEventBits_1],Y
	and	<L48+uxBitsWaitedFor_1+2
	sta	<R0+2
	lda	<R0
	cmp	<L48+uxBitsWaitedFor_1
	bne	L55
	lda	<R0+2
	cmp	<L48+uxBitsWaitedFor_1+2
L55:
	beq	*+5
	brl	L10133
;                    /* All bits are set. */
;                    xMatchFound = pdTRUE;
	brl	L20005
;                }
;                else
;    }
L47	equ	42
L48	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    void vEventGroupDelete( EventGroupHandle_t xEventGroup )
;    {
	code
	xdef	_~vEventGroupDelete
	func
_~vEventGroupDelete:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L60
	tcs
	phd
	tcd
xEventGroup_0	set	3
;        EventGroup_t * pxEventBits = xEventGroup;
;        const List_t * pxTasksWaitingForBits;
;
;        traceENTER_vEventGroupDelete( xEventGroup );
pxEventBits_1	set	0
pxTasksWaitingForBits_1	set	4
	lda	<L60+xEventGroup_0
	sta	<L61+pxEventBits_1
	lda	<L60+xEventGroup_0+2
	sta	<L61+pxEventBits_1+2
;
;        configASSERT( pxEventBits );
	lda	<L61+pxEventBits_1
	ora	<L61+pxEventBits_1+2
	bne	L10139
L10143:
	bra	L10143
L10139:
;
;        pxTasksWaitingForBits = &( pxEventBits->xTasksWaitingForBits );
	lda	#$4
	clc
	adc	<L61+pxEventBits_1
	sta	<L61+pxTasksWaitingForBits_1
	lda	#$0
	adc	<L61+pxEventBits_1+2
	sta	<L61+pxTasksWaitingForBits_1+2
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            traceEVENT_GROUP_DELETE( xEventGroup );
;
;            while( listCURRENT_LIST_LENGTH( pxTasksWaitingForBits ) > ( UBaseType_t ) 0 )
	bra	L10146
L20007:
;            {
;                /* Unblock the task, returning 0 as the event list is being deleted
;                 * and cannot therefore have any bits set. */
;                configASSERT( pxTasksWaitingForBits->xListEnd.pxNext != ( const ListItem_t * ) &( pxTasksWaitingForBits->xListEnd ) );
	lda	#$6
	clc
	adc	<L61+pxTasksWaitingForBits_1
	sta	<R0
	lda	#$0
	adc	<L61+pxTasksWaitingForBits_1+2
	sta	<R0+2
	ldy	#$a
	lda	[<L61+pxTasksWaitingForBits_1],Y
	cmp	<R0
	bne	L64
	iny
	iny
	lda	[<L61+pxTasksWaitingForBits_1],Y
	cmp	<R0+2
L64:
	bne	L10148
L10152:
	bra	L10152
L10148:
;                vTaskRemoveFromUnorderedEventList( pxTasksWaitingForBits->xListEnd.pxNext, eventUNBLOCKED_DUE_TO_BIT_SET );
	pea	#^$2000000
	pea	#<$2000000
	ldy	#$c
	lda	[<L61+pxTasksWaitingForBits_1],Y
	pha
	dey
	dey
	lda	[<L61+pxTasksWaitingForBits_1],Y
	pha
	jsr	_~vTaskRemoveFromUnorderedEventList
;            }
L10146:
	lda	#$0
	cmp	[<L61+pxTasksWaitingForBits_1]
	bcc	L20007
;        }
;        ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;        #if ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 0 ) )
;        {
;            /* The event group can only have been allocated dynamically - free
;             * it again. */
;            vPortFree( pxEventBits );
	pei	<L61+pxEventBits_1+2
	pei	<L61+pxEventBits_1
	jsr	_~vPortFree
;        }
;        #elif ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;        {
;            /* The event group could have been allocated statically or
;             * dynamically, so check before attempting to free the memory. */
;            if( pxEventBits->ucStaticallyAllocated == ( uint8_t ) pdFALSE )
;            {
;                vPortFree( pxEventBits );
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;
;        traceRETURN_vEventGroupDelete();
;    }
	lda	<L60+1
	sta	<L60+1+4
	pld
	tsc
	clc
	adc	#L60+4
	tcs
	rts
L60	equ	12
L61	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;        BaseType_t xEventGroupGetStaticBuffer( EventGroupHandle_t xEventGroup,
;                                               StaticEventGroup_t ** ppxEventGroupBuffer )
;        {
;            BaseType_t xReturn;
;            EventGroup_t * pxEventBits = xEventGroup;
;
;            traceENTER_xEventGroupGetStaticBuffer( xEventGroup, ppxEventGroupBuffer );
;
;            configASSERT( pxEventBits );
;            configASSERT( ppxEventGroupBuffer );
;
;            #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;            {
;                /* Check if the event group was statically allocated. */
;                if( pxEventBits->ucStaticallyAllocated == ( uint8_t ) pdTRUE )
;                {
;                    /* MISRA Ref 11.3.1 [Misaligned access] */
;                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;                    /* coverity[misra_c_2012_rule_11_3_violation] */
;                    *ppxEventGroupBuffer = ( StaticEventGroup_t * ) pxEventBits;
;                    xReturn = pdTRUE;
;                }
;                else
;                {
;                    xReturn = pdFALSE;
;                }
;            }
;            #else /* configSUPPORT_DYNAMIC_ALLOCATION */
;            {
;                /* Event group must have been statically allocated. */
;                /* MISRA Ref 11.3.1 [Misaligned access] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;                /* coverity[misra_c_2012_rule_11_3_violation] */
;                *ppxEventGroupBuffer = ( StaticEventGroup_t * ) pxEventBits;
;                xReturn = pdTRUE;
;            }
;            #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;
;            traceRETURN_xEventGroupGetStaticBuffer( xReturn );
;
;            return xReturn;
;        }
;    #endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;/* For internal use only - execute a 'set bits' command that was pended from
; * an interrupt. */
;    void vEventGroupSetBitsCallback( void * pvEventGroup,
;                                     uint32_t ulBitsToSet )
;    {
	code
	xdef	_~vEventGroupSetBitsCallback
	func
_~vEventGroupSetBitsCallback:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L67
	tcs
	phd
	tcd
pvEventGroup_0	set	3
ulBitsToSet_0	set	7
;        traceENTER_vEventGroupSetBitsCallback( pvEventGroup, ulBitsToSet );
;
;        /* MISRA Ref 11.5.4 [Callback function parameter] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        ( void ) xEventGroupSetBits( pvEventGroup, ( EventBits_t ) ulBitsToSet );
	pei	<L67+ulBitsToSet_0+2
	pei	<L67+ulBitsToSet_0
	pei	<L67+pvEventGroup_0+2
	pei	<L67+pvEventGroup_0
	jsr	_~xEventGroupSetBits
;
;        traceRETURN_vEventGroupSetBitsCallback();
;    }
	lda	<L67+1
	sta	<L67+1+8
	pld
	tsc
	clc
	adc	#L67+8
	tcs
	rts
L67	equ	4
L68	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;/* For internal use only - execute a 'clear bits' command that was pended from
; * an interrupt. */
;    void vEventGroupClearBitsCallback( void * pvEventGroup,
;                                       uint32_t ulBitsToClear )
;    {
	code
	xdef	_~vEventGroupClearBitsCallback
	func
_~vEventGroupClearBitsCallback:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L70
	tcs
	phd
	tcd
pvEventGroup_0	set	3
ulBitsToClear_0	set	7
;        traceENTER_vEventGroupClearBitsCallback( pvEventGroup, ulBitsToClear );
;
;        /* MISRA Ref 11.5.4 [Callback function parameter] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        ( void ) xEventGroupClearBits( pvEventGroup, ( EventBits_t ) ulBitsToClear );
	pei	<L70+ulBitsToClear_0+2
	pei	<L70+ulBitsToClear_0
	pei	<L70+pvEventGroup_0+2
	pei	<L70+pvEventGroup_0
	jsr	_~xEventGroupClearBits
;
;        traceRETURN_vEventGroupClearBitsCallback();
;    }
	lda	<L70+1
	sta	<L70+1+8
	pld
	tsc
	clc
	adc	#L70+8
	tcs
	rts
L70	equ	4
L71	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static BaseType_t prvTestWaitCondition( const EventBits_t uxCurrentEventBits,
;                                            const EventBits_t uxBitsToWaitFor,
;                                            const BaseType_t xWaitForAllBits )
;    {
	code
	func
_~prvTestWaitCondition:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L73
	tcs
	phd
	tcd
uxCurrentEventBits_0	set	3
uxBitsToWaitFor_0	set	7
xWaitForAllBits_0	set	11
;        BaseType_t xWaitConditionMet = pdFALSE;
;
;        if( xWaitForAllBits == pdFALSE )
xWaitConditionMet_1	set	0
	stz	<L74+xWaitConditionMet_1
;        {
	lda	<L73+xWaitForAllBits_0
	bne	L10155
;            /* Task only has to wait for one bit within uxBitsToWaitFor to be
;             * set.  Is one already set? */
;            if( ( uxCurrentEventBits & uxBitsToWaitFor ) != ( EventBits_t ) 0 )
;            {
	lda	<L73+uxBitsToWaitFor_0
	and	<L73+uxCurrentEventBits_0
	sta	<R0
	lda	<L73+uxBitsToWaitFor_0+2
	and	<L73+uxCurrentEventBits_0+2
	sta	<R0+2
	lda	<R0
	ora	<R0+2
	beq	L10158
;                xWaitConditionMet = pdTRUE;
L20009:
	lda	#$1
	sta	<L74+xWaitConditionMet_1
;            }
;            else
L10158:
;
;        return xWaitConditionMet;
	lda	<L74+xWaitConditionMet_1
	tay
	lda	<L73+1
	sta	<L73+1+10
	pld
	tsc
	clc
	adc	#L73+10
	tcs
	tya
	rts
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
L10155:
;        {
;            /* Task has to wait for all the bits in uxBitsToWaitFor to be set.
;             * Are they set already? */
;            if( ( uxCurrentEventBits & uxBitsToWaitFor ) == uxBitsToWaitFor )
;            {
	lda	<L73+uxBitsToWaitFor_0
	and	<L73+uxCurrentEventBits_0
	sta	<R0
	lda	<L73+uxBitsToWaitFor_0+2
	and	<L73+uxCurrentEventBits_0+2
	sta	<R0+2
	lda	<R0
	cmp	<L73+uxBitsToWaitFor_0
	bne	L77
	lda	<R0+2
	cmp	<L73+uxBitsToWaitFor_0+2
L77:
	bne	L10158
;                xWaitConditionMet = pdTRUE;
	bra	L20009
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;    }
L73	equ	6
L74	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( ( INCLUDE_xTimerPendFunctionCall == 1 ) && ( configUSE_TIMERS == 1 ) )
;
;        BaseType_t xEventGroupSetBitsFromISR( EventGroupHandle_t xEventGroup,
;                                              const EventBits_t uxBitsToSet,
;                                              BaseType_t * pxHigherPriorityTaskWoken )
;        {
;            BaseType_t xReturn;
;
;            traceENTER_xEventGroupSetBitsFromISR( xEventGroup, uxBitsToSet, pxHigherPriorityTaskWoken );
;
;            traceEVENT_GROUP_SET_BITS_FROM_ISR( xEventGroup, uxBitsToSet );
;            xReturn = xTimerPendFunctionCallFromISR( &vEventGroupSetBitsCallback, ( void * ) xEventGroup, ( uint32_t ) uxBitsToSet, pxHigherPriorityTaskWoken );
;
;            traceRETURN_xEventGroupSetBitsFromISR( xReturn );
;
;            return xReturn;
;        }
;
;    #endif /* if ( ( INCLUDE_xTimerPendFunctionCall == 1 ) && ( configUSE_TIMERS == 1 ) ) */
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;        UBaseType_t uxEventGroupGetNumber( void * xEventGroup )
;        {
;            UBaseType_t xReturn;
;
;            /* MISRA Ref 11.5.2 [Opaque pointer] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            EventGroup_t const * pxEventBits = ( EventGroup_t * ) xEventGroup;
;
;            traceENTER_uxEventGroupGetNumber( xEventGroup );
;
;            if( xEventGroup == NULL )
;            {
;                xReturn = 0;
;            }
;            else
;            {
;                xReturn = pxEventBits->uxEventGroupNumber;
;            }
;
;            traceRETURN_uxEventGroupGetNumber( xReturn );
;
;            return xReturn;
;        }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;        void vEventGroupSetNumber( void * xEventGroup,
;                                   UBaseType_t uxEventGroupNumber )
;        {
;            traceENTER_vEventGroupSetNumber( xEventGroup, uxEventGroupNumber );
;
;            /* MISRA Ref 11.5.2 [Opaque pointer] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            ( ( EventGroup_t * ) xEventGroup )->uxEventGroupNumber = uxEventGroupNumber;
;
;            traceRETURN_vEventGroupSetNumber();
;        }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;/* This entire source file will be skipped if the application is not configured
; * to include event groups functionality. If you want to include event groups
; * then ensure configUSE_EVENT_GROUPS is set to 1 in FreeRTOSConfig.h. */
;#endif /* configUSE_EVENT_GROUPS == 1 */
;
	xref	_~xTaskGetSchedulerState
	xref	_~uxTaskResetEventItemValue
	xref	_~vTaskRemoveFromUnorderedEventList
	xref	_~vTaskPlaceOnUnorderedEventList
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~vListInitialise
	xref	_~vPortFree
	xref	_~pvPortMalloc
	xref	_~vPortYield

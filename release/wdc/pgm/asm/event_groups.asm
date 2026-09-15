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
	code
	xdef	_~xEventGroupCreateStatic
	func
_~xEventGroupCreateStatic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
pxEventGroupBuffer_0	set	3
;            EventGroup_t * pxEventBits;
;
;            traceENTER_xEventGroupCreateStatic( pxEventGroupBuffer );
pxEventBits_1	set	0
;
;            /* A StaticEventGroup_t object must be provided. */
;            configASSERT( pxEventGroupBuffer );
	lda	<L2+pxEventGroupBuffer_0
	ora	<L2+pxEventGroupBuffer_0+2
	bne	L10001
L10005:
	bra	L10005
L10001:
;
;            #if ( configASSERT_DEFINED == 1 )
;            {
;                /* Sanity check that the size of the structure used to declare a
;                 * variable of type StaticEventGroup_t equals the size of the real
;                 * event group structure. */
;                volatile size_t xSize = sizeof( StaticEventGroup_t );
;                configASSERT( xSize == sizeof( EventGroup_t ) );
xSize_2	set	4
	lda	#$17
	sta	<L3+xSize_2
	cmp	#<$17
	beq	L10008
L10012:
	bra	L10012
L10008:
;            }
;            #endif /* configASSERT_DEFINED */
;
;            /* The user has provided a statically allocated event group - use it. */
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            pxEventBits = ( EventGroup_t * ) pxEventGroupBuffer;
	lda	<L2+pxEventGroupBuffer_0
	sta	<L3+pxEventBits_1
	lda	<L2+pxEventGroupBuffer_0+2
	sta	<L3+pxEventBits_1+2
;
;            if( pxEventBits != NULL )
;            {
	lda	<L3+pxEventBits_1
	ora	<L3+pxEventBits_1+2
	beq	L10016
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
;                #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;                {
;                    /* Both static and dynamic allocation can be used, so note that
;                     * this event group was created statically in case the event group
;                     * is later deleted. */
;                    pxEventBits->ucStaticallyAllocated = pdTRUE;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$16
	sta	[<L3+pxEventBits_1],Y
	rep	#$20
	longa	on
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
L10016:
;
;            traceRETURN_xEventGroupCreateStatic( pxEventBits );
;
;            return pxEventBits;
	ldx	<L3+pxEventBits_1+2
	lda	<L3+pxEventBits_1
	tay
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	tya
	rts
;        }
L2	equ	10
L3	equ	5
	ends
	efunc
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
	sbc	#L8
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
	pea	#<$17
	jsr	_~pvPortMalloc
	sta	<L9+pxEventBits_1
	stx	<L9+pxEventBits_1+2
;
;            if( pxEventBits != NULL )
;            {
	ora	<L9+pxEventBits_1+2
	beq	L10018
;                pxEventBits->uxEventBits = 0;
	lda	#$0
	sta	[<L9+pxEventBits_1]
	ldy	#$2
	sta	[<L9+pxEventBits_1],Y
;                vListInitialise( &( pxEventBits->xTasksWaitingForBits ) );
	lda	#$4
	clc
	adc	<L9+pxEventBits_1
	sta	<R0
	lda	#$0
	adc	<L9+pxEventBits_1+2
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
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$16
	sta	[<L9+pxEventBits_1],Y
	rep	#$20
	longa	on
;                }
;                #endif /* configSUPPORT_STATIC_ALLOCATION */
;
;                traceEVENT_GROUP_CREATE( pxEventBits );
;            }
;            else
;            {
;                traceEVENT_GROUP_CREATE_FAILED();
;            }
L10018:
;
;            traceRETURN_xEventGroupCreate( pxEventBits );
;
;            return pxEventBits;
	ldx	<L9+pxEventBits_1+2
	lda	<L9+pxEventBits_1
	tay
	pld
	tsc
	clc
	adc	#L8
	tcs
	tya
	rts
;        }
L8	equ	8
L9	equ	5
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
	sbc	#L12
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
	lda	<L12+xEventGroup_0
	sta	<L13+pxEventBits_1
	lda	<L12+xEventGroup_0+2
	sta	<L13+pxEventBits_1+2
	stz	<L13+xTimeoutOccurred_1
;
;        configASSERT( ( uxBitsToWaitFor & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L12+uxBitsToWaitFor_0+2
	and	#^$ff000000
	beq	L10019
L10023:
	bra	L10023
L10019:
;        configASSERT( uxBitsToWaitFor != 0 );
	lda	<L12+uxBitsToWaitFor_0
	ora	<L12+uxBitsToWaitFor_0+2
	bne	L10026
L10030:
	bra	L10030
L10026:
;        #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;        {
;            configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	bne	L10033
	lda	<L12+xTicksToWait_0
	ora	<L12+xTicksToWait_0+2
	beq	L10033
L10037:
	bra	L10037
L10033:
;        }
;        #endif
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            uxOriginalBitValue = pxEventBits->uxEventBits;
	lda	[<L13+pxEventBits_1]
	sta	<L13+uxOriginalBitValue_1
	ldy	#$2
	lda	[<L13+pxEventBits_1],Y
	sta	<L13+uxOriginalBitValue_1+2
;
;            ( void ) xEventGroupSetBits( xEventGroup, uxBitsToSet );
	pei	<L12+uxBitsToSet_0+2
	pei	<L12+uxBitsToSet_0
	pei	<L12+xEventGroup_0+2
	pei	<L12+xEventGroup_0
	jsr	_~xEventGroupSetBits
;
;            if( ( ( uxOriginalBitValue | uxBitsToSet ) & uxBitsToWaitFor ) == uxBitsToWaitFor )
;            {
	lda	<L12+uxBitsToSet_0
	ora	<L13+uxOriginalBitValue_1
	sta	<R0
	lda	<L12+uxBitsToSet_0+2
	ora	<L13+uxOriginalBitValue_1+2
	sta	<R0+2
	lda	<L12+uxBitsToWaitFor_0
	and	<R0
	sta	<R1
	lda	<L12+uxBitsToWaitFor_0+2
	and	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	<L12+uxBitsToWaitFor_0
	bne	L18
	lda	<R1+2
	cmp	<L12+uxBitsToWaitFor_0+2
L18:
	bne	L10040
;                /* All the rendezvous bits are now set - no need to block. */
;                uxReturn = ( uxOriginalBitValue | uxBitsToSet );
	lda	<L12+uxBitsToSet_0
	ora	<L13+uxOriginalBitValue_1
	sta	<L13+uxReturn_1
	lda	<L12+uxBitsToSet_0+2
	ora	<L13+uxOriginalBitValue_1+2
	sta	<L13+uxReturn_1+2
;
;                /* Rendezvous always clear the bits.  They will have been cleared
;                 * already unless this is the only task in the rendezvous. */
;                pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L12+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L12+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L13+pxEventBits_1]
	and	<R0
	sta	[<L13+pxEventBits_1]
	ldy	#$2
	lda	[<L13+pxEventBits_1],Y
	and	<R0+2
	sta	[<L13+pxEventBits_1],Y
;
;                xTicksToWait = 0;
	stz	<L12+xTicksToWait_0
	stz	<L12+xTicksToWait_0+2
;            }
;            else
	bra	L10041
L10040:
;            {
;                if( xTicksToWait != ( TickType_t ) 0 )
;                {
	lda	<L12+xTicksToWait_0
	ora	<L12+xTicksToWait_0+2
	beq	L10042
;                    traceEVENT_GROUP_SYNC_BLOCK( xEventGroup, uxBitsToSet, uxBitsToWaitFor );
;
;                    /* Store the bits that the calling task is waiting for in the
;                     * task's event list item so the kernel knows when a match is
;                     * found.  Then enter the blocked state. */
;                    vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | eventCLEAR_EVENTS_ON_EXIT_BIT | eventWAIT_FOR_ALL_BITS ), xTicksToWait );
	pei	<L12+xTicksToWait_0+2
	pei	<L12+xTicksToWait_0
	lda	<L12+uxBitsToWaitFor_0
	sta	<R0
	lda	<L12+uxBitsToWaitFor_0+2
	ora	#^$5000000
	pha
	pei	<R0
	lda	#$4
	clc
	adc	<L13+pxEventBits_1
	sta	<R1
	lda	#$0
	adc	<L13+pxEventBits_1+2
	pha
	pei	<R1
	jsr	_~vTaskPlaceOnUnorderedEventList
;
;                    /* This assignment is obsolete as uxReturn will get set after
;                     * the task unblocks, but some compilers mistakenly generate a
;                     * warning about uxReturn being returned without being set if the
;                     * assignment is omitted. */
;                    uxReturn = 0;
	stz	<L13+uxReturn_1
	stz	<L13+uxReturn_1+2
;                }
;                else
	bra	L10041
L10042:
;                {
;                    /* The rendezvous bits were not set, but no block time was
;                     * specified - just return the current event bit value. */
;                    uxReturn = pxEventBits->uxEventBits;
	lda	[<L13+pxEventBits_1]
	sta	<L13+uxReturn_1
	ldy	#$2
	lda	[<L13+pxEventBits_1],Y
	sta	<L13+uxReturn_1+2
;                    xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L13+xTimeoutOccurred_1
;                }
;            }
L10041:
;        }
;        xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L13+xAlreadyYielded_1
;
;        if( xTicksToWait != ( TickType_t ) 0 )
;        {
	lda	<L12+xTicksToWait_0
	ora	<L12+xTicksToWait_0+2
	beq	L10044
;            if( xAlreadyYielded == pdFALSE )
;            {
	lda	<L13+xAlreadyYielded_1
	bne	L10046
;                taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10046:
;
;            /* The task blocked to wait for its required bits to be set - at this
;             * point either the required bits were set or the block time expired.  If
;             * the required bits were set they will have been stored in the task's
;             * event list item, and they should now be retrieved then cleared. */
;            uxReturn = uxTaskResetEventItemValue();
	jsr	_~uxTaskResetEventItemValue
	sta	<L13+uxReturn_1
	stx	<L13+uxReturn_1+2
;
;            if( ( uxReturn & eventUNBLOCKED_DUE_TO_BIT_SET ) == ( EventBits_t ) 0 )
;            {
	lda	<L13+uxReturn_1+2
	and	#^$2000000
	bne	L10056
;                /* The task timed out, just return the current event bit value. */
;                taskENTER_CRITICAL();
;                {
;                    uxReturn = pxEventBits->uxEventBits;
	lda	[<L13+pxEventBits_1]
	sta	<L13+uxReturn_1
	ldy	#$2
	lda	[<L13+pxEventBits_1],Y
	sta	<L13+uxReturn_1+2
;
;                    /* Although the task got here because it timed out before the
;                     * bits it was waiting for were set, it is possible that since it
;                     * unblocked another task has set the bits.  If this is the case
;                     * then it needs to clear the bits before exiting. */
;                    if( ( uxReturn & uxBitsToWaitFor ) == uxBitsToWaitFor )
;                    {
	lda	<L12+uxBitsToWaitFor_0
	and	<L13+uxReturn_1
	sta	<R0
	lda	<L12+uxBitsToWaitFor_0+2
	and	<L13+uxReturn_1+2
	sta	<R0+2
	lda	<R0
	cmp	<L12+uxBitsToWaitFor_0
	bne	L24
	lda	<R0+2
	cmp	<L12+uxBitsToWaitFor_0+2
L24:
	bne	L10054
;                        pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L12+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L12+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L13+pxEventBits_1]
	and	<R0
	sta	[<L13+pxEventBits_1]
	ldy	#$2
	lda	[<L13+pxEventBits_1],Y
	and	<R0+2
	sta	[<L13+pxEventBits_1],Y
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                taskEXIT_CRITICAL();
L10054:
;
;                xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L13+xTimeoutOccurred_1
;            }
;            else
;            {
;                /* The task unblocked because the bits were set. */
;            }
L10056:
;
;            /* Control bits might be set as the task had blocked should not be
;             * returned. */
;            uxReturn &= ~eventEVENT_BITS_CONTROL_BYTES;
	lda	<L13+uxReturn_1+2
	and	#^$ffffff
	sta	<L13+uxReturn_1+2
;        }
;
;        traceEVENT_GROUP_SYNC_END( xEventGroup, uxBitsToSet, uxBitsToWaitFor, xTimeoutOccurred );
L10044:
;
;        /* Prevent compiler warnings when trace macros are not used. */
;        ( void ) xTimeoutOccurred;
;
;        traceRETURN_xEventGroupSync( uxReturn );
;
;        return uxReturn;
	ldx	<L13+uxReturn_1+2
	lda	<L13+uxReturn_1
	tay
	lda	<L12+1
	sta	<L12+1+16
	pld
	tsc
	clc
	adc	#L12+16
	tcs
	tya
	rts
;    }
L12	equ	24
L13	equ	9
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
	sbc	#L27
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
	lda	<L27+xEventGroup_0
	sta	<L28+pxEventBits_1
	lda	<L27+xEventGroup_0+2
	sta	<L28+pxEventBits_1+2
	stz	<L28+uxControlBits_1
	stz	<L28+uxControlBits_1+2
	stz	<L28+xTimeoutOccurred_1
;
;        /* Check the user is not attempting to wait on the bits used by the kernel
;         * itself, and that at least one bit is being requested. */
;        configASSERT( xEventGroup );
	lda	<L27+xEventGroup_0
	ora	<L27+xEventGroup_0+2
	bne	L10057
L10061:
	bra	L10061
L10057:
;        configASSERT( ( uxBitsToWaitFor & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L27+uxBitsToWaitFor_0+2
	and	#^$ff000000
	beq	L10064
L10068:
	bra	L10068
L10064:
;        configASSERT( uxBitsToWaitFor != 0 );
	lda	<L27+uxBitsToWaitFor_0
	ora	<L27+uxBitsToWaitFor_0+2
	bne	L10071
L10075:
	bra	L10075
L10071:
;        #if ( ( INCLUDE_xTaskGetSchedulerState == 1 ) || ( configUSE_TIMERS == 1 ) )
;        {
;            configASSERT( !( ( xTaskGetSchedulerState() == taskSCHEDULER_SUSPENDED ) && ( xTicksToWait != 0 ) ) );
	jsr	_~xTaskGetSchedulerState
	tax
	bne	L10078
	lda	<L27+xTicksToWait_0
	ora	<L27+xTicksToWait_0+2
	beq	L10078
L10082:
	bra	L10082
L10078:
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
	lda	[<L28+pxEventBits_1]
	sta	<L28+uxCurrentEventBits_2
	ldy	#$2
	lda	[<L28+pxEventBits_1],Y
	sta	<L28+uxCurrentEventBits_2+2
	pei	<L27+xWaitForAllBits_0
	pei	<L27+uxBitsToWaitFor_0+2
	pei	<L27+uxBitsToWaitFor_0
	pei	<L28+uxCurrentEventBits_2+2
	pei	<L28+uxCurrentEventBits_2
	jsr	_~prvTestWaitCondition
	sta	<L28+xWaitConditionMet_1
;
;            if( xWaitConditionMet != pdFALSE )
;            {
	lda	<L28+xWaitConditionMet_1
	beq	L10085
;                /* The wait condition has already been met so there is no need to
;                 * block. */
;                uxReturn = uxCurrentEventBits;
	lda	<L28+uxCurrentEventBits_2
	sta	<L28+uxReturn_1
	lda	<L28+uxCurrentEventBits_2+2
	sta	<L28+uxReturn_1+2
;                xTicksToWait = ( TickType_t ) 0;
	stz	<L27+xTicksToWait_0
	stz	<L27+xTicksToWait_0+2
;
;                /* Clear the wait bits if requested to do so. */
;                if( xClearOnExit != pdFALSE )
;                {
	lda	<L27+xClearOnExit_0
	beq	L10088
;                    pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L27+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L27+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L28+pxEventBits_1]
	and	<R0
	sta	[<L28+pxEventBits_1]
	ldy	#$2
	lda	[<L28+pxEventBits_1],Y
	and	<R0+2
	sta	[<L28+pxEventBits_1],Y
;                }
;                else
	bra	L10088
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            else if( xTicksToWait == ( TickType_t ) 0 )
L10085:
;            {
	lda	<L27+xTicksToWait_0
	ora	<L27+xTicksToWait_0+2
	bne	L10089
;                /* The wait condition has not been met, but no block time was
;                 * specified, so just return the current value. */
;                uxReturn = uxCurrentEventBits;
	lda	<L28+uxCurrentEventBits_2
	sta	<L28+uxReturn_1
	lda	<L28+uxCurrentEventBits_2+2
	sta	<L28+uxReturn_1+2
;                xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L28+xTimeoutOccurred_1
;            }
;            else
	bra	L10088
L10089:
;            {
;                /* The task is going to block to wait for its required bits to be
;                 * set.  uxControlBits are used to remember the specified behaviour of
;                 * this call to xEventGroupWaitBits() - for use when the event bits
;                 * unblock the task. */
;                if( xClearOnExit != pdFALSE )
;                {
	lda	<L27+xClearOnExit_0
	beq	L10092
;                    uxControlBits |= eventCLEAR_EVENTS_ON_EXIT_BIT;
	lda	<L28+uxControlBits_1+2
	ora	#^$1000000
	sta	<L28+uxControlBits_1+2
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10092:
;
;                if( xWaitForAllBits != pdFALSE )
;                {
	lda	<L27+xWaitForAllBits_0
	beq	L10094
;                    uxControlBits |= eventWAIT_FOR_ALL_BITS;
	lda	<L28+uxControlBits_1+2
	ora	#^$4000000
	sta	<L28+uxControlBits_1+2
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
L10094:
;
;                /* Store the bits that the calling task is waiting for in the
;                 * task's event list item so the kernel knows when a match is
;                 * found.  Then enter the blocked state. */
;                vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | uxControlBits ), xTicksToWait );
	pei	<L27+xTicksToWait_0+2
	pei	<L27+xTicksToWait_0
	lda	<L28+uxControlBits_1
	ora	<L27+uxBitsToWaitFor_0
	sta	<R0
	lda	<L28+uxControlBits_1+2
	ora	<L27+uxBitsToWaitFor_0+2
	pha
	pei	<R0
	lda	#$4
	clc
	adc	<L28+pxEventBits_1
	sta	<R1
	lda	#$0
	adc	<L28+pxEventBits_1+2
	pha
	pei	<R1
	jsr	_~vTaskPlaceOnUnorderedEventList
;
;                /* This is obsolete as it will get set after the task unblocks, but
;                 * some compilers mistakenly generate a warning about the variable
;                 * being returned without being set if it is not done. */
;                uxReturn = 0;
	stz	<L28+uxReturn_1
	stz	<L28+uxReturn_1+2
;
;                traceEVENT_GROUP_WAIT_BITS_BLOCK( xEventGroup, uxBitsToWaitFor );
;            }
L10088:
;        }
;        xAlreadyYielded = xTaskResumeAll();
	jsr	_~xTaskResumeAll
	sta	<L28+xAlreadyYielded_1
;
;        if( xTicksToWait != ( TickType_t ) 0 )
;        {
	lda	<L27+xTicksToWait_0
	ora	<L27+xTicksToWait_0+2
	beq	L10095
;            if( xAlreadyYielded == pdFALSE )
;            {
	lda	<L28+xAlreadyYielded_1
	bne	L10097
;                taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10097:
;
;            /* The task blocked to wait for its required bits to be set - at this
;             * point either the required bits were set or the block time expired.  If
;             * the required bits were set they will have been stored in the task's
;             * event list item, and they should now be retrieved then cleared. */
;            uxReturn = uxTaskResetEventItemValue();
	jsr	_~uxTaskResetEventItemValue
	sta	<L28+uxReturn_1
	stx	<L28+uxReturn_1+2
;
;            if( ( uxReturn & eventUNBLOCKED_DUE_TO_BIT_SET ) == ( EventBits_t ) 0 )
;            {
	lda	<L28+uxReturn_1+2
	and	#^$2000000
	bne	L10109
;                taskENTER_CRITICAL();
;                {
;                    /* The task timed out, just return the current event bit value. */
;                    uxReturn = pxEventBits->uxEventBits;
	lda	[<L28+pxEventBits_1]
	sta	<L28+uxReturn_1
	ldy	#$2
	lda	[<L28+pxEventBits_1],Y
	sta	<L28+uxReturn_1+2
;
;                    /* It is possible that the event bits were updated between this
;                     * task leaving the Blocked state and running again. */
;                    if( prvTestWaitCondition( uxReturn, uxBitsToWaitFor, xWaitForAllBits ) != pdFALSE )
;                    {
	pei	<L27+xWaitForAllBits_0
	pei	<L27+uxBitsToWaitFor_0+2
	pei	<L27+uxBitsToWaitFor_0
	pei	<L28+uxReturn_1+2
	pei	<L28+uxReturn_1
	jsr	_~prvTestWaitCondition
	tax
	beq	L10105
;                        if( xClearOnExit != pdFALSE )
;                        {
	lda	<L27+xClearOnExit_0
	beq	L10105
;                            pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
	lda	<L27+uxBitsToWaitFor_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L27+uxBitsToWaitFor_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L28+pxEventBits_1]
	and	<R0
	sta	[<L28+pxEventBits_1]
	ldy	#$2
	lda	[<L28+pxEventBits_1],Y
	and	<R0+2
	sta	[<L28+pxEventBits_1],Y
;                        }
;                        else
L10105:
;
;                    xTimeoutOccurred = pdTRUE;
	lda	#$1
	sta	<L28+xTimeoutOccurred_1
;                }
;                taskEXIT_CRITICAL();
;            }
;            else
L10109:
;
;            /* The task blocked so control bits may have been set. */
;            uxReturn &= ~eventEVENT_BITS_CONTROL_BYTES;
	lda	<L28+uxReturn_1+2
	and	#^$ffffff
	sta	<L28+uxReturn_1+2
;        }
;
;        traceEVENT_GROUP_WAIT_BITS_END( xEventGroup, uxBitsToWaitFor, xTimeoutOccurred );
L10095:
;
;        /* Prevent compiler warnings when trace macros are not used. */
;        ( void ) xTimeoutOccurred;
;
;        traceRETURN_xEventGroupWaitBits( uxReturn );
;
;        return uxReturn;
	ldx	<L28+uxReturn_1+2
	lda	<L28+uxReturn_1
	tay
	lda	<L27+1
	sta	<L27+1+16
	pld
	tsc
	clc
	adc	#L27+16
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
L27	equ	30
L28	equ	9
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
	sbc	#L45
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
	lda	<L45+xEventGroup_0
	sta	<L46+pxEventBits_1
	lda	<L45+xEventGroup_0+2
	sta	<L46+pxEventBits_1+2
;
;        /* Check the user is not attempting to clear the bits used by the kernel
;         * itself. */
;        configASSERT( xEventGroup );
	lda	<L45+xEventGroup_0
	ora	<L45+xEventGroup_0+2
	bne	L10110
L10114:
	bra	L10114
L10110:
;        configASSERT( ( uxBitsToClear & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L45+uxBitsToClear_0+2
	and	#^$ff000000
	beq	L10125
L10121:
	bra	L10121
;
;        taskENTER_CRITICAL();
L10125:
;        {
;            traceEVENT_GROUP_CLEAR_BITS( xEventGroup, uxBitsToClear );
;
;            /* The value returned is the event group value prior to the bits being
;             * cleared. */
;            uxReturn = pxEventBits->uxEventBits;
	lda	[<L46+pxEventBits_1]
	sta	<L46+uxReturn_1
	ldy	#$2
	lda	[<L46+pxEventBits_1],Y
	sta	<L46+uxReturn_1+2
;
;            /* Clear the bits. */
;            pxEventBits->uxEventBits &= ~uxBitsToClear;
	lda	<L45+uxBitsToClear_0
	eor	#<$ffffffff
	sta	<R0
	lda	<L45+uxBitsToClear_0+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L46+pxEventBits_1]
	and	<R0
	sta	[<L46+pxEventBits_1]
	lda	[<L46+pxEventBits_1],Y
	and	<R0+2
	sta	[<L46+pxEventBits_1],Y
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_xEventGroupClearBits( uxReturn );
;
;        return uxReturn;
	ldx	<L46+uxReturn_1+2
	lda	<L46+uxReturn_1
	tay
	lda	<L45+1
	sta	<L45+1+8
	pld
	tsc
	clc
	adc	#L45+8
	tcs
	tya
	rts
;    }
L45	equ	12
L46	equ	5
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
	sbc	#L50
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
	lda	<L50+xEventGroup_0
	sta	<L51+pxEventBits_1
	lda	<L50+xEventGroup_0+2
	sta	<L51+pxEventBits_1+2
;
;        /* MISRA Ref 4.7.1 [Return value shall be checked] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;        /* coverity[misra_c_2012_directive_4_7_violation] */
;        uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L51+uxSavedInterruptStatus_1
;        {
;            uxReturn = pxEventBits->uxEventBits;
	lda	[<L51+pxEventBits_1]
	sta	<L51+uxReturn_1
	ldy	#$2
	lda	[<L51+pxEventBits_1],Y
	sta	<L51+uxReturn_1+2
;        }
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;        traceRETURN_xEventGroupGetBitsFromISR( uxReturn );
;
;        return uxReturn;
	ldx	<L51+uxReturn_1+2
	lda	<L51+uxReturn_1
	tay
	lda	<L50+1
	sta	<L50+1+4
	pld
	tsc
	clc
	adc	#L50+4
	tcs
	tya
	rts
;    }
L50	equ	10
L51	equ	1
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
	sbc	#L53
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
	stz	<L54+uxBitsToClear_1
	stz	<L54+uxBitsToClear_1+2
	lda	<L53+xEventGroup_0
	sta	<L54+pxEventBits_1
	lda	<L53+xEventGroup_0+2
	sta	<L54+pxEventBits_1+2
	stz	<L54+xMatchFound_1
;
;        /* Check the user is not attempting to set the bits used by the kernel
;         * itself. */
;        configASSERT( xEventGroup );
	lda	<L53+xEventGroup_0
	ora	<L53+xEventGroup_0+2
	bne	L10130
L10134:
	bra	L10134
L10130:
;        configASSERT( ( uxBitsToSet & eventEVENT_BITS_CONTROL_BYTES ) == 0 );
	lda	<L53+uxBitsToSet_0+2
	and	#^$ff000000
	beq	L10137
L10141:
	bra	L10141
L10137:
;
;        pxList = &( pxEventBits->xTasksWaitingForBits );
	lda	#$4
	clc
	adc	<L54+pxEventBits_1
	sta	<L54+pxList_1
	lda	#$0
	adc	<L54+pxEventBits_1+2
	sta	<L54+pxList_1+2
;        pxListEnd = listGET_END_MARKER( pxList );
	lda	#$6
	clc
	adc	<L54+pxList_1
	sta	<L54+pxListEnd_1
	lda	#$0
	adc	<L54+pxList_1+2
	sta	<L54+pxListEnd_1+2
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            traceEVENT_GROUP_SET_BITS( xEventGroup, uxBitsToSet );
;
;            pxListItem = listGET_HEAD_ENTRY( pxList );
	ldy	#$a
	lda	[<L54+pxList_1],Y
	sta	<L54+pxListItem_1
	iny
	iny
	lda	[<L54+pxList_1],Y
	sta	<L54+pxListItem_1+2
;
;            /* Set the bits. */
;            pxEventBits->uxEventBits |= uxBitsToSet;
	lda	<L53+uxBitsToSet_0
	ora	[<L54+pxEventBits_1]
	sta	[<L54+pxEventBits_1]
	lda	<L53+uxBitsToSet_0+2
	ldy	#$2
	ora	[<L54+pxEventBits_1],Y
	sta	[<L54+pxEventBits_1],Y
;
;            /* See if the new bit value should unblock any tasks. */
;            while( pxListItem != pxListEnd )
	brl	L10144
L20004:
;            {
;                pxNext = listGET_NEXT( pxListItem );
	ldy	#$4
	lda	[<L54+pxListItem_1],Y
	sta	<L54+pxNext_1
	iny
	iny
	lda	[<L54+pxListItem_1],Y
	sta	<L54+pxNext_1+2
;                uxBitsWaitedFor = listGET_LIST_ITEM_VALUE( pxListItem );
	lda	[<L54+pxListItem_1]
	sta	<L54+uxBitsWaitedFor_1
	ldy	#$2
	lda	[<L54+pxListItem_1],Y
	sta	<L54+uxBitsWaitedFor_1+2
;                xMatchFound = pdFALSE;
	stz	<L54+xMatchFound_1
;
;                /* Split the bits waited for from the control bits. */
;                uxControlBits = uxBitsWaitedFor & eventEVENT_BITS_CONTROL_BYTES;
	stz	<L54+uxControlBits_1
	lda	<L54+uxBitsWaitedFor_1+2
	and	#^$ff000000
	sta	<L54+uxControlBits_1+2
;                uxBitsWaitedFor &= ~eventEVENT_BITS_CONTROL_BYTES;
	lda	<L54+uxBitsWaitedFor_1+2
	and	#^$ffffff
	sta	<L54+uxBitsWaitedFor_1+2
;
;                if( ( uxControlBits & eventWAIT_FOR_ALL_BITS ) == ( EventBits_t ) 0 )
;                {
	lda	<L54+uxControlBits_1+2
	and	#^$4000000
	beq	*+5
	brl	L10146
;                    /* Just looking for single bit being set. */
;                    if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) != ( EventBits_t ) 0 )
;                    {
	lda	[<L54+pxEventBits_1]
	and	<L54+uxBitsWaitedFor_1
	sta	<R0
	lda	[<L54+pxEventBits_1],Y
	and	<L54+uxBitsWaitedFor_1+2
	sta	<R0+2
	lda	<R0
	ora	<R0+2
	beq	L10149
;                        xMatchFound = pdTRUE;
L20005:
	lda	#$1
	sta	<L54+xMatchFound_1
;                    }
;                    else
L10149:
;
;                if( xMatchFound != pdFALSE )
;                {
	lda	<L54+xMatchFound_1
	beq	L10152
;                {
;                    /* Need all bits to be set, but not all the bits were set. */
;                }
;                    /* The bits match.  Should the bits be cleared on exit? */
;                    if( ( uxControlBits & eventCLEAR_EVENTS_ON_EXIT_BIT ) != ( EventBits_t ) 0 )
;                    {
	lda	<L54+uxControlBits_1+2
	and	#^$1000000
	beq	L10154
;                        uxBitsToClear |= uxBitsWaitedFor;
	lda	<L54+uxBitsWaitedFor_1
	ora	<L54+uxBitsToClear_1
	sta	<L54+uxBitsToClear_1
	lda	<L54+uxBitsWaitedFor_1+2
	ora	<L54+uxBitsToClear_1+2
	sta	<L54+uxBitsToClear_1+2
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10154:
;
;                    /* Store the actual event flag value in the task's event list
;                     * item before removing the task from the event list.  The
;                     * eventUNBLOCKED_DUE_TO_BIT_SET bit is set so the task knows
;                     * that is was unblocked due to its required bits matching, rather
;                     * than because it timed out. */
;                    vTaskRemoveFromUnorderedEventList( pxListItem, pxEventBits->uxEventBits | eventUNBLOCKED_DUE_TO_BIT_SET );
	lda	[<L54+pxEventBits_1]
	sta	<R0
	ldy	#$2
	lda	[<L54+pxEventBits_1],Y
	ora	#^$2000000
	pha
	pei	<R0
	pei	<L54+pxListItem_1+2
	pei	<L54+pxListItem_1
	jsr	_~vTaskRemoveFromUnorderedEventList
;                }
;
;                /* Move onto the next list item.  Note pxListItem->pxNext is not
;                 * used here as the list item may have been removed from the event list
;                 * and inserted into the ready/pending reading list. */
;                pxListItem = pxNext;
L10152:
	lda	<L54+pxNext_1
	sta	<L54+pxListItem_1
	lda	<L54+pxNext_1+2
	sta	<L54+pxListItem_1+2
;            }
L10144:
	lda	<L54+pxListItem_1
	cmp	<L54+pxListEnd_1
	bne	L57
	lda	<L54+pxListItem_1+2
	cmp	<L54+pxListEnd_1+2
L57:
	beq	*+5
	brl	L20004
;
;            /* Clear any bits that matched when the eventCLEAR_EVENTS_ON_EXIT_BIT
;             * bit was set in the control word. */
;            pxEventBits->uxEventBits &= ~uxBitsToClear;
	lda	<L54+uxBitsToClear_1
	eor	#<$ffffffff
	sta	<R0
	lda	<L54+uxBitsToClear_1+2
	eor	#^$ffffffff
	sta	<R0+2
	lda	[<L54+pxEventBits_1]
	and	<R0
	sta	[<L54+pxEventBits_1]
	ldy	#$2
	lda	[<L54+pxEventBits_1],Y
	and	<R0+2
	sta	[<L54+pxEventBits_1],Y
;
;            /* Snapshot resulting bits. */
;            uxReturnBits = pxEventBits->uxEventBits;
	lda	[<L54+pxEventBits_1]
	sta	<L54+uxReturnBits_1
	lda	[<L54+pxEventBits_1],Y
	sta	<L54+uxReturnBits_1+2
;        }
;        ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;        traceRETURN_xEventGroupSetBits( uxReturnBits );
;
;        return uxReturnBits;
	ldx	<L54+uxReturnBits_1+2
	lda	<L54+uxReturnBits_1
	tay
	lda	<L53+1
	sta	<L53+1+8
	pld
	tsc
	clc
	adc	#L53+8
	tcs
	tya
	rts
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                else if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) == uxBitsWaitedFor )
L10146:
;                {
	lda	[<L54+pxEventBits_1]
	and	<L54+uxBitsWaitedFor_1
	sta	<R0
	ldy	#$2
	lda	[<L54+pxEventBits_1],Y
	and	<L54+uxBitsWaitedFor_1+2
	sta	<R0+2
	lda	<R0
	cmp	<L54+uxBitsWaitedFor_1
	bne	L61
	lda	<R0+2
	cmp	<L54+uxBitsWaitedFor_1+2
L61:
	beq	*+5
	brl	L10149
;                    /* All bits are set. */
;                    xMatchFound = pdTRUE;
	brl	L20005
;                }
;                else
;    }
L53	equ	42
L54	equ	5
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
	sbc	#L66
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
	lda	<L66+xEventGroup_0
	sta	<L67+pxEventBits_1
	lda	<L66+xEventGroup_0+2
	sta	<L67+pxEventBits_1+2
;
;        configASSERT( pxEventBits );
	lda	<L67+pxEventBits_1
	ora	<L67+pxEventBits_1+2
	bne	L10155
L10159:
	bra	L10159
L10155:
;
;        pxTasksWaitingForBits = &( pxEventBits->xTasksWaitingForBits );
	lda	#$4
	clc
	adc	<L67+pxEventBits_1
	sta	<L67+pxTasksWaitingForBits_1
	lda	#$0
	adc	<L67+pxEventBits_1+2
	sta	<L67+pxTasksWaitingForBits_1+2
;
;        vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;        {
;            traceEVENT_GROUP_DELETE( xEventGroup );
;
;            while( listCURRENT_LIST_LENGTH( pxTasksWaitingForBits ) > ( UBaseType_t ) 0 )
	bra	L10162
L20007:
;            {
;                /* Unblock the task, returning 0 as the event list is being deleted
;                 * and cannot therefore have any bits set. */
;                configASSERT( pxTasksWaitingForBits->xListEnd.pxNext != ( const ListItem_t * ) &( pxTasksWaitingForBits->xListEnd ) );
	lda	#$6
	clc
	adc	<L67+pxTasksWaitingForBits_1
	sta	<R0
	lda	#$0
	adc	<L67+pxTasksWaitingForBits_1+2
	sta	<R0+2
	ldy	#$a
	lda	[<L67+pxTasksWaitingForBits_1],Y
	cmp	<R0
	bne	L70
	iny
	iny
	lda	[<L67+pxTasksWaitingForBits_1],Y
	cmp	<R0+2
L70:
	bne	L10164
L10168:
	bra	L10168
L10164:
;                vTaskRemoveFromUnorderedEventList( pxTasksWaitingForBits->xListEnd.pxNext, eventUNBLOCKED_DUE_TO_BIT_SET );
	pea	#^$2000000
	pea	#<$2000000
	ldy	#$c
	lda	[<L67+pxTasksWaitingForBits_1],Y
	pha
	dey
	dey
	lda	[<L67+pxTasksWaitingForBits_1],Y
	pha
	jsr	_~vTaskRemoveFromUnorderedEventList
;            }
L10162:
	lda	#$0
	cmp	[<L67+pxTasksWaitingForBits_1]
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
;        }
;        #elif ( ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) && ( configSUPPORT_STATIC_ALLOCATION == 1 ) )
;        {
;            /* The event group could have been allocated statically or
;             * dynamically, so check before attempting to free the memory. */
;            if( pxEventBits->ucStaticallyAllocated == ( uint8_t ) pdFALSE )
;            {
	ldy	#$16
	lda	[<L67+pxEventBits_1],Y
	and	#$ff
	bne	L73
;                vPortFree( pxEventBits );
	pei	<L67+pxEventBits_1+2
	pei	<L67+pxEventBits_1
	jsr	_~vPortFree
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
L73:
	lda	<L66+1
	sta	<L66+1+4
	pld
	tsc
	clc
	adc	#L66+4
	tcs
	rts
L66	equ	12
L67	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;        BaseType_t xEventGroupGetStaticBuffer( EventGroupHandle_t xEventGroup,
;                                               StaticEventGroup_t ** ppxEventGroupBuffer )
;        {
	code
	xdef	_~xEventGroupGetStaticBuffer
	func
_~xEventGroupGetStaticBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L74
	tcs
	phd
	tcd
xEventGroup_0	set	3
ppxEventGroupBuffer_0	set	7
;            BaseType_t xReturn;
;            EventGroup_t * pxEventBits = xEventGroup;
;
;            traceENTER_xEventGroupGetStaticBuffer( xEventGroup, ppxEventGroupBuffer );
xReturn_1	set	0
pxEventBits_1	set	2
	lda	<L74+xEventGroup_0
	sta	<L75+pxEventBits_1
	lda	<L74+xEventGroup_0+2
	sta	<L75+pxEventBits_1+2
;
;            configASSERT( pxEventBits );
	lda	<L75+pxEventBits_1
	ora	<L75+pxEventBits_1+2
	bne	L10173
L10177:
	bra	L10177
L10173:
;            configASSERT( ppxEventGroupBuffer );
	lda	<L74+ppxEventGroupBuffer_0
	ora	<L74+ppxEventGroupBuffer_0+2
	bne	L10180
L10184:
	bra	L10184
L10180:
;
;            #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;            {
;                /* Check if the event group was statically allocated. */
;                if( pxEventBits->ucStaticallyAllocated == ( uint8_t ) pdTRUE )
;                {
	sep	#$20
	longa	off
	ldy	#$16
	lda	[<L75+pxEventBits_1],Y
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10187
;                    /* MISRA Ref 11.3.1 [Misaligned access] */
;                    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;                    /* coverity[misra_c_2012_rule_11_3_violation] */
;                    *ppxEventGroupBuffer = ( StaticEventGroup_t * ) pxEventBits;
	lda	<L75+pxEventBits_1
	sta	[<L74+ppxEventGroupBuffer_0]
	lda	<L75+pxEventBits_1+2
	ldy	#$2
	sta	[<L74+ppxEventGroupBuffer_0],Y
;                    xReturn = pdTRUE;
	lda	#$1
	sta	<L75+xReturn_1
;                }
;                else
	bra	L10188
L10187:
;                {
;                    xReturn = pdFALSE;
	stz	<L75+xReturn_1
;                }
L10188:
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
	lda	<L75+xReturn_1
	tay
	lda	<L74+1
	sta	<L74+1+8
	pld
	tsc
	clc
	adc	#L74+8
	tcs
	tya
	rts
;        }
L74	equ	6
L75	equ	1
	ends
	efunc
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
	sbc	#L80
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
	pei	<L80+ulBitsToSet_0+2
	pei	<L80+ulBitsToSet_0
	pei	<L80+pvEventGroup_0+2
	pei	<L80+pvEventGroup_0
	jsr	_~xEventGroupSetBits
;
;        traceRETURN_vEventGroupSetBitsCallback();
;    }
	lda	<L80+1
	sta	<L80+1+8
	pld
	tsc
	clc
	adc	#L80+8
	tcs
	rts
L80	equ	4
L81	equ	5
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
	sbc	#L83
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
	pei	<L83+ulBitsToClear_0+2
	pei	<L83+ulBitsToClear_0
	pei	<L83+pvEventGroup_0+2
	pei	<L83+pvEventGroup_0
	jsr	_~xEventGroupClearBits
;
;        traceRETURN_vEventGroupClearBitsCallback();
;    }
	lda	<L83+1
	sta	<L83+1+8
	pld
	tsc
	clc
	adc	#L83+8
	tcs
	rts
L83	equ	4
L84	equ	5
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
	sbc	#L86
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
	stz	<L87+xWaitConditionMet_1
;        {
	lda	<L86+xWaitForAllBits_0
	bne	L10189
;            /* Task only has to wait for one bit within uxBitsToWaitFor to be
;             * set.  Is one already set? */
;            if( ( uxCurrentEventBits & uxBitsToWaitFor ) != ( EventBits_t ) 0 )
;            {
	lda	<L86+uxBitsToWaitFor_0
	and	<L86+uxCurrentEventBits_0
	sta	<R0
	lda	<L86+uxBitsToWaitFor_0+2
	and	<L86+uxCurrentEventBits_0+2
	sta	<R0+2
	lda	<R0
	ora	<R0+2
	beq	L10192
;                xWaitConditionMet = pdTRUE;
L20009:
	lda	#$1
	sta	<L87+xWaitConditionMet_1
;            }
;            else
L10192:
;
;        return xWaitConditionMet;
	lda	<L87+xWaitConditionMet_1
	tay
	lda	<L86+1
	sta	<L86+1+10
	pld
	tsc
	clc
	adc	#L86+10
	tcs
	tya
	rts
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        else
L10189:
;        {
;            /* Task has to wait for all the bits in uxBitsToWaitFor to be set.
;             * Are they set already? */
;            if( ( uxCurrentEventBits & uxBitsToWaitFor ) == uxBitsToWaitFor )
;            {
	lda	<L86+uxBitsToWaitFor_0
	and	<L86+uxCurrentEventBits_0
	sta	<R0
	lda	<L86+uxBitsToWaitFor_0+2
	and	<L86+uxCurrentEventBits_0+2
	sta	<R0+2
	lda	<R0
	cmp	<L86+uxBitsToWaitFor_0
	bne	L90
	lda	<R0+2
	cmp	<L86+uxBitsToWaitFor_0+2
L90:
	bne	L10192
;                xWaitConditionMet = pdTRUE;
	bra	L20009
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;    }
L86	equ	6
L87	equ	5
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

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
;
;#include <stdlib.h>
;
;/* Defining MPU_WRAPPERS_INCLUDED_FROM_API_FILE prevents task.h from redefining
; * all the API functions to use the MPU wrappers.  That should only be done when
; * task.h is included from an application file. */
;#define MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;#include "FreeRTOS.h"
;#include "list.h"
;
;/* The MPU ports require MPU_WRAPPERS_INCLUDED_FROM_API_FILE to be
; * defined for the header files above, but not in this file, in order to
; * generate the correct privileged Vs unprivileged linkage and placement. */
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;/*-----------------------------------------------------------
;* PUBLIC LIST API documented in list.h
;*----------------------------------------------------------*/
;
;void vListInitialise( List_t * const pxList )
;{
	code
	xdef	_~vListInitialise
	func
_~vListInitialise:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
pxList_0	set	3
;    traceENTER_vListInitialise( pxList );
;
;    /* The list structure contains a list item which is used to mark the
;     * end of the list.  To initialise the list the list end is inserted
;     * as the only list entry. */
;    pxList->pxIndex = ( ListItem_t * ) &( pxList->xListEnd );
	lda	#$6
	clc
	adc	<L2+pxList_0
	sta	<R0
	lda	#$0
	adc	<L2+pxList_0+2
	sta	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L2+pxList_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L2+pxList_0],Y
;
;    listSET_FIRST_LIST_ITEM_INTEGRITY_CHECK_VALUE( &( pxList->xListEnd ) );
;
;    /* The list end value is the highest possible value in the list to
;     * ensure it remains at the end of the list. */
;    pxList->xListEnd.xItemValue = portMAX_DELAY;
	lda	#$ffff
	iny
	iny
	sta	[<L2+pxList_0],Y
	iny
	iny
	sta	[<L2+pxList_0],Y
;
;    /* The list end next and previous pointers point to itself so we know
;     * when the list is empty. */
;    pxList->xListEnd.pxNext = ( ListItem_t * ) &( pxList->xListEnd );
	lda	#$6
	clc
	adc	<L2+pxList_0
	sta	<R0
	lda	#$0
	adc	<L2+pxList_0+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L2+pxList_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L2+pxList_0],Y
;    pxList->xListEnd.pxPrevious = ( ListItem_t * ) &( pxList->xListEnd );
	lda	#$6
	clc
	adc	<L2+pxList_0
	sta	<R0
	lda	#$0
	adc	<L2+pxList_0+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L2+pxList_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L2+pxList_0],Y
;
;    /* Initialize the remaining fields of xListEnd when it is a proper ListItem_t */
;    #if ( configUSE_MINI_LIST_ITEM == 0 )
;    {
;        pxList->xListEnd.pvOwner = NULL;
;        pxList->xListEnd.pxContainer = NULL;
;        listSET_SECOND_LIST_ITEM_INTEGRITY_CHECK_VALUE( &( pxList->xListEnd ) );
;    }
;    #endif
;
;    pxList->uxNumberOfItems = ( UBaseType_t ) 0U;
	lda	#$0
	sta	[<L2+pxList_0]
;
;    /* Write known values into the list if
;     * configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES is set to 1. */
;    listSET_LIST_INTEGRITY_CHECK_1_VALUE( pxList );
;    listSET_LIST_INTEGRITY_CHECK_2_VALUE( pxList );
;
;    traceRETURN_vListInitialise();
;}
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	rts
L2	equ	4
L3	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vListInitialiseItem( ListItem_t * const pxItem )
;{
	code
	xdef	_~vListInitialiseItem
	func
_~vListInitialiseItem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
pxItem_0	set	3
;    traceENTER_vListInitialiseItem( pxItem );
;
;    /* Make sure the list item is not recorded as being on a list. */
;    pxItem->pxContainer = NULL;
	lda	#$0
	ldy	#$10
	sta	[<L5+pxItem_0],Y
	iny
	iny
	sta	[<L5+pxItem_0],Y
;
;    /* Write known values into the list item if
;     * configUSE_LIST_DATA_INTEGRITY_CHECK_BYTES is set to 1. */
;    listSET_FIRST_LIST_ITEM_INTEGRITY_CHECK_VALUE( pxItem );
;    listSET_SECOND_LIST_ITEM_INTEGRITY_CHECK_VALUE( pxItem );
;
;    traceRETURN_vListInitialiseItem();
;}
	lda	<L5+1
	sta	<L5+1+4
	pld
	tsc
	clc
	adc	#L5+4
	tcs
	rts
L5	equ	0
L6	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vListInsertEnd( List_t * const pxList,
;                     ListItem_t * const pxNewListItem )
;{
	code
	xdef	_~vListInsertEnd
	func
_~vListInsertEnd:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
pxList_0	set	3
pxNewListItem_0	set	7
;    ListItem_t * const pxIndex = pxList->pxIndex;
;
;    traceENTER_vListInsertEnd( pxList, pxNewListItem );
pxIndex_1	set	0
	ldy	#$2
	lda	[<L8+pxList_0],Y
	sta	<L9+pxIndex_1
	iny
	iny
	lda	[<L8+pxList_0],Y
	sta	<L9+pxIndex_1+2
;
;    /* Only effective when configASSERT() is also defined, these tests may catch
;     * the list data structures being overwritten in memory.  They will not catch
;     * data errors caused by incorrect configuration or use of FreeRTOS. */
;    listTEST_LIST_INTEGRITY( pxList );
;    listTEST_LIST_ITEM_INTEGRITY( pxNewListItem );
;
;    /* Insert a new list item into pxList, but rather than sort the list,
;     * makes the new list item the last item to be removed by a call to
;     * listGET_OWNER_OF_NEXT_ENTRY(). */
;    pxNewListItem->pxNext = pxIndex;
	lda	<L9+pxIndex_1
	sta	[<L8+pxNewListItem_0],Y
	lda	<L9+pxIndex_1+2
	iny
	iny
	sta	[<L8+pxNewListItem_0],Y
;    pxNewListItem->pxPrevious = pxIndex->pxPrevious;
	iny
	iny
	lda	[<L9+pxIndex_1],Y
	sta	[<L8+pxNewListItem_0],Y
	iny
	iny
	lda	[<L9+pxIndex_1],Y
	sta	[<L8+pxNewListItem_0],Y
;
;    /* Only used during decision coverage testing. */
;    mtCOVERAGE_TEST_DELAY();
;
;    pxIndex->pxPrevious->pxNext = pxNewListItem;
	dey
	dey
	lda	[<L9+pxIndex_1],Y
	sta	<R0
	iny
	iny
	lda	[<L9+pxIndex_1],Y
	sta	<R0+2
	lda	<L8+pxNewListItem_0
	ldy	#$4
	sta	[<R0],Y
	lda	<L8+pxNewListItem_0+2
	iny
	iny
	sta	[<R0],Y
;    pxIndex->pxPrevious = pxNewListItem;
	lda	<L8+pxNewListItem_0
	iny
	iny
	sta	[<L9+pxIndex_1],Y
	lda	<L8+pxNewListItem_0+2
	iny
	iny
	sta	[<L9+pxIndex_1],Y
;
;    /* Remember which list the item is in. */
;    pxNewListItem->pxContainer = pxList;
	lda	<L8+pxList_0
	ldy	#$10
	sta	[<L8+pxNewListItem_0],Y
	lda	<L8+pxList_0+2
	iny
	iny
	sta	[<L8+pxNewListItem_0],Y
;
;    ( pxList->uxNumberOfItems ) = ( UBaseType_t ) ( pxList->uxNumberOfItems + 1U );
	lda	[<L8+pxList_0]
	ina
	sta	[<L8+pxList_0]
;
;    traceRETURN_vListInsertEnd();
;}
	lda	<L8+1
	sta	<L8+1+8
	pld
	tsc
	clc
	adc	#L8+8
	tcs
	rts
L8	equ	8
L9	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vListInsert( List_t * const pxList,
;                  ListItem_t * const pxNewListItem )
;{
	code
	xdef	_~vListInsert
	func
_~vListInsert:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
pxList_0	set	3
pxNewListItem_0	set	7
;    ListItem_t * pxIterator;
;    const TickType_t xValueOfInsertion = pxNewListItem->xItemValue;
;
;    traceENTER_vListInsert( pxList, pxNewListItem );
pxIterator_1	set	0
xValueOfInsertion_1	set	4
	lda	[<L11+pxNewListItem_0]
	sta	<L12+xValueOfInsertion_1
	ldy	#$2
	lda	[<L11+pxNewListItem_0],Y
	sta	<L12+xValueOfInsertion_1+2
;
;    /* Only effective when configASSERT() is also defined, these tests may catch
;     * the list data structures being overwritten in memory.  They will not catch
;     * data errors caused by incorrect configuration or use of FreeRTOS. */
;    listTEST_LIST_INTEGRITY( pxList );
;    listTEST_LIST_ITEM_INTEGRITY( pxNewListItem );
;
;    /* Insert the new list item into the list, sorted in xItemValue order.
;     *
;     * If the list already contains a list item with the same item value then the
;     * new list item should be placed after it.  This ensures that TCBs which are
;     * stored in ready lists (all of which have the same xItemValue value) get a
;     * share of the CPU.  However, if the xItemValue is the same as the back marker
;     * the iteration loop below will not end.  Therefore the value is checked
;     * first, and the algorithm slightly modified if necessary. */
;    if( xValueOfInsertion == portMAX_DELAY )
;    {
	lda	<L12+xValueOfInsertion_1
	cmp	#<$ffffffff
	bne	L13
	lda	<L12+xValueOfInsertion_1+2
	cmp	#^$ffffffff
L13:
	bne	L10001
;        pxIterator = pxList->xListEnd.pxPrevious;
	ldy	#$e
	lda	[<L11+pxList_0],Y
	sta	<L12+pxIterator_1
	iny
	iny
	lda	[<L11+pxList_0],Y
	sta	<L12+pxIterator_1+2
;    }
;    else
L10002:
;
;    pxNewListItem->pxNext = pxIterator->pxNext;
	ldy	#$4
	lda	[<L12+pxIterator_1],Y
	sta	[<L11+pxNewListItem_0],Y
	iny
	iny
	lda	[<L12+pxIterator_1],Y
	sta	[<L11+pxNewListItem_0],Y
;    pxNewListItem->pxNext->pxPrevious = pxNewListItem;
	dey
	dey
	lda	[<L11+pxNewListItem_0],Y
	sta	<R0
	iny
	iny
	lda	[<L11+pxNewListItem_0],Y
	sta	<R0+2
	lda	<L11+pxNewListItem_0
	iny
	iny
	sta	[<R0],Y
	lda	<L11+pxNewListItem_0+2
	iny
	iny
	sta	[<R0],Y
;    pxNewListItem->pxPrevious = pxIterator;
	lda	<L12+pxIterator_1
	dey
	dey
	sta	[<L11+pxNewListItem_0],Y
	lda	<L12+pxIterator_1+2
	iny
	iny
	sta	[<L11+pxNewListItem_0],Y
;    pxIterator->pxNext = pxNewListItem;
	lda	<L11+pxNewListItem_0
	ldy	#$4
	sta	[<L12+pxIterator_1],Y
	lda	<L11+pxNewListItem_0+2
	iny
	iny
	sta	[<L12+pxIterator_1],Y
;
;    /* Remember which list the item is in.  This allows fast removal of the
;     * item later. */
;    pxNewListItem->pxContainer = pxList;
	lda	<L11+pxList_0
	ldy	#$10
	sta	[<L11+pxNewListItem_0],Y
	lda	<L11+pxList_0+2
	iny
	iny
	sta	[<L11+pxNewListItem_0],Y
;
;    ( pxList->uxNumberOfItems ) = ( UBaseType_t ) ( pxList->uxNumberOfItems + 1U );
	lda	[<L11+pxList_0]
	ina
	sta	[<L11+pxList_0]
;
;    traceRETURN_vListInsert();
;}
	lda	<L11+1
	sta	<L11+1+8
	pld
	tsc
	clc
	adc	#L11+8
	tcs
	rts
L10001:
;    {
;        /* *** NOTE ***********************************************************
;        *  If you find your application is crashing here then likely causes are
;        *  listed below.  In addition see https://www.freertos.org/Why-FreeRTOS/FAQs for
;        *  more tips, and ensure configASSERT() is defined!
;        *  https://www.FreeRTOS.org/a00110.html#configASSERT
;        *
;        *   1) Stack overflow -
;        *      see https://www.FreeRTOS.org/Stacks-and-stack-overflow-checking.html
;        *   2) Incorrect interrupt priority assignment, especially on Cortex-M
;        *      parts where numerically high priority values denote low actual
;        *      interrupt priorities, which can seem counter intuitive.  See
;        *      https://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html and the definition
;        *      of configMAX_SYSCALL_INTERRUPT_PRIORITY on
;        *      https://www.FreeRTOS.org/a00110.html
;        *   3) Calling an API function from within a critical section or when
;        *      the scheduler is suspended, or calling an API function that does
;        *      not end in "FromISR" from an interrupt.
;        *   4) Using a queue or semaphore before it has been initialised or
;        *      before the scheduler has been started (are interrupts firing
;        *      before vTaskStartScheduler() has been called?).
;        *   5) If the FreeRTOS port supports interrupt nesting then ensure that
;        *      the priority of the tick interrupt is at or below
;        *      configMAX_SYSCALL_INTERRUPT_PRIORITY.
;        **********************************************************************/
;
;        for( pxIterator = ( ListItem_t * ) &( pxList->xListEnd ); pxIterator->pxNext->xItemValue <= xValueOfInsertion; pxIterator = pxIterator->pxNext )
	lda	#$6
	clc
	adc	<L11+pxList_0
	sta	<L12+pxIterator_1
	lda	#$0
	adc	<L11+pxList_0+2
	bra	L20000
;        {
;            /* There is nothing to do here, just iterating to the wanted
;             * insertion position.
;             * IF YOU FIND YOUR CODE STUCK HERE, SEE THE NOTE JUST ABOVE.
;             */
;        }
L10003:
	ldy	#$4
	lda	[<L12+pxIterator_1],Y
	sta	<R0
	iny
	iny
	lda	[<L12+pxIterator_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L12+pxIterator_1
	lda	<R0+2
L20000:
	sta	<L12+pxIterator_1+2
	ldy	#$4
	lda	[<L12+pxIterator_1],Y
	sta	<R0
	iny
	iny
	lda	[<L12+pxIterator_1],Y
	sta	<R0+2
	lda	<L12+xValueOfInsertion_1
	cmp	[<R0]
	lda	<L12+xValueOfInsertion_1+2
	ldy	#$2
	sbc	[<R0],Y
	bcs	L10003
	brl	L10002
;    }
L11	equ	12
L12	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;
;UBaseType_t uxListRemove( ListItem_t * const pxItemToRemove )
;{
	code
	xdef	_~uxListRemove
	func
_~uxListRemove:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
pxItemToRemove_0	set	3
;    /* The list item knows which list it is in.  Obtain the list from the list
;     * item. */
;    List_t * const pxList = pxItemToRemove->pxContainer;
;
;    traceENTER_uxListRemove( pxItemToRemove );
pxList_1	set	0
	ldy	#$10
	lda	[<L17+pxItemToRemove_0],Y
	sta	<L18+pxList_1
	iny
	iny
	lda	[<L17+pxItemToRemove_0],Y
	sta	<L18+pxList_1+2
;
;    pxItemToRemove->pxNext->pxPrevious = pxItemToRemove->pxPrevious;
	ldy	#$4
	lda	[<L17+pxItemToRemove_0],Y
	sta	<R0
	iny
	iny
	lda	[<L17+pxItemToRemove_0],Y
	sta	<R0+2
	iny
	iny
	lda	[<L17+pxItemToRemove_0],Y
	sta	[<R0],Y
	iny
	iny
	lda	[<L17+pxItemToRemove_0],Y
	sta	[<R0],Y
;    pxItemToRemove->pxPrevious->pxNext = pxItemToRemove->pxNext;
	dey
	dey
	lda	[<L17+pxItemToRemove_0],Y
	sta	<R0
	iny
	iny
	lda	[<L17+pxItemToRemove_0],Y
	sta	<R0+2
	ldy	#$4
	lda	[<L17+pxItemToRemove_0],Y
	sta	[<R0],Y
	iny
	iny
	lda	[<L17+pxItemToRemove_0],Y
	sta	[<R0],Y
;
;    /* Only used during decision coverage testing. */
;    mtCOVERAGE_TEST_DELAY();
;
;    /* Make sure the index is left pointing to a valid item. */
;    if( pxList->pxIndex == pxItemToRemove )
;    {
	ldy	#$2
	lda	[<L18+pxList_1],Y
	cmp	<L17+pxItemToRemove_0
	bne	L19
	iny
	iny
	lda	[<L18+pxList_1],Y
	cmp	<L17+pxItemToRemove_0+2
L19:
	bne	L10008
;        pxList->pxIndex = pxItemToRemove->pxPrevious;
	ldy	#$8
	lda	[<L17+pxItemToRemove_0],Y
	ldy	#$2
	sta	[<L18+pxList_1],Y
	ldy	#$a
	lda	[<L17+pxItemToRemove_0],Y
	ldy	#$4
	sta	[<L18+pxList_1],Y
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10008:
;
;    pxItemToRemove->pxContainer = NULL;
	lda	#$0
	ldy	#$10
	sta	[<L17+pxItemToRemove_0],Y
	iny
	iny
	sta	[<L17+pxItemToRemove_0],Y
;    ( pxList->uxNumberOfItems ) = ( UBaseType_t ) ( pxList->uxNumberOfItems - 1U );
	lda	#$ffff
	clc
	adc	[<L18+pxList_1]
	sta	[<L18+pxList_1]
;
;    traceRETURN_uxListRemove( pxList->uxNumberOfItems );
;
;    return pxList->uxNumberOfItems;
	tay
	lda	<L17+1
	sta	<L17+1+4
	pld
	tsc
	clc
	adc	#L17+4
	tcs
	tya
	rts
;}
L17	equ	8
L18	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;

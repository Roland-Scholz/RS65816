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
;/*
; * A sample implementation of pvPortMalloc() that allows the heap to be defined
; * across multiple non-contiguous blocks and combines (coalescences) adjacent
; * memory blocks as they are freed.
; *
; * See heap_1.c, heap_2.c, heap_3.c and heap_4.c for alternative
; * implementations, and the memory management pages of https://www.FreeRTOS.org
; * for more information.
; *
; * Usage notes:
; *
; * vPortDefineHeapRegions() ***must*** be called before pvPortMalloc().
; * pvPortMalloc() will be called if any task objects (tasks, queues, event
; * groups, etc.) are created, therefore vPortDefineHeapRegions() ***must*** be
; * called before any other objects are defined.
; *
; * vPortDefineHeapRegions() takes a single parameter.  The parameter is an array
; * of HeapRegion_t structures.  HeapRegion_t is defined in portable.h as
; *
; * typedef struct HeapRegion
; * {
; *  uint8_t *pucStartAddress; << Start address of a block of memory that will be part of the heap.
; *  size_t xSizeInBytes;      << Size of the block of memory.
; * } HeapRegion_t;
; *
; * The array is terminated using a NULL zero sized region definition, and the
; * memory regions defined in the array ***must*** appear in address order from
; * low address to high address.  So the following is a valid example of how
; * to use the function.
; *
; * HeapRegion_t xHeapRegions[] =
; * {
; *  { ( uint8_t * ) 0x80000000UL, 0x10000 }, << Defines a block of 0x10000 bytes starting at address 0x80000000
; *  { ( uint8_t * ) 0x90000000UL, 0xa0000 }, << Defines a block of 0xa0000 bytes starting at address of 0x90000000
; *  { NULL, 0 }                << Terminates the array.
; * };
; *
; * vPortDefineHeapRegions( xHeapRegions ); << Pass the array into vPortDefineHeapRegions().
; *
; * Note 0x80000000 is the lower address so appears in the array first.
; *
; */
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
;
;
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;#if ( configSUPPORT_DYNAMIC_ALLOCATION == 0 )
;    #error This file must not be used if configSUPPORT_DYNAMIC_ALLOCATION is 0
;#endif
;
;#ifndef configHEAP_CLEAR_MEMORY_ON_FREE
;    #define configHEAP_CLEAR_MEMORY_ON_FREE    0
;#endif
;
;/* Block sizes must not get too small. */
;#define heapMINIMUM_BLOCK_SIZE    ( ( size_t ) ( xHeapStructSize << 1 ) )
;
;/* Assumes 8bit bytes! */
;#define heapBITS_PER_BYTE         ( ( size_t ) 8 )
;
;/* Max value that fits in a size_t type. */
;#define heapSIZE_MAX              ( ~( ( size_t ) 0 ) )
;
;/* Check if multiplying a and b will result in overflow. */
;#define heapMULTIPLY_WILL_OVERFLOW( a, b )     ( ( ( a ) > 0 ) && ( ( b ) > ( heapSIZE_MAX / ( a ) ) ) )
;
;/* Check if adding a and b will result in overflow. */
;#define heapADD_WILL_OVERFLOW( a, b )          ( ( a ) > ( heapSIZE_MAX - ( b ) ) )
;
;/* Check if the subtraction operation ( a - b ) will result in underflow. */
;#define heapSUBTRACT_WILL_UNDERFLOW( a, b )    ( ( a ) < ( b ) )
;
;/* MSB of the xBlockSize member of an BlockLink_t structure is used to track
; * the allocation status of a block.  When MSB of the xBlockSize member of
; * an BlockLink_t structure is set then the block belongs to the application.
; * When the bit is free the block is still part of the free heap space. */
;#define heapBLOCK_ALLOCATED_BITMASK    ( ( ( unsigned long ) 1 ) << ( ( sizeof( unsigned long ) * heapBITS_PER_BYTE ) - 1 ) )
;#define heapBLOCK_SIZE_IS_VALID( xBlockSize )    ( ( ( xBlockSize ) & heapBLOCK_ALLOCATED_BITMASK ) == 0 )
;#define heapBLOCK_IS_ALLOCATED( pxBlock )        ( ( ( pxBlock->xBlockSize ) & heapBLOCK_ALLOCATED_BITMASK ) != 0 )
;#define heapALLOCATE_BLOCK( pxBlock )            ( ( pxBlock->xBlockSize ) |= heapBLOCK_ALLOCATED_BITMASK )
;#define heapFREE_BLOCK( pxBlock )                ( ( pxBlock->xBlockSize ) &= ~heapBLOCK_ALLOCATED_BITMASK )
;
;/* Setting configENABLE_HEAP_PROTECTOR to 1 enables heap block pointers
; * protection using an application supplied canary value to catch heap
; * corruption should a heap buffer overflow occur.
; */
;#if ( configENABLE_HEAP_PROTECTOR == 1 )
;
;/* Macro to load/store BlockLink_t pointers to memory. By XORing the
; * pointers with a random canary value, heap overflows will result
; * in randomly unpredictable pointer values which will be caught by
; * heapVALIDATE_BLOCK_POINTER assert. */
;    #define heapPROTECT_BLOCK_POINTER( pxBlock )    ( ( BlockLink_t * ) ( ( ( portPOINTER_SIZE_TYPE ) ( pxBlock ) ) ^ xHeapCanary ) )
;
;/* Assert that a heap block pointer is within the heap bounds.
; * Setting configVALIDATE_HEAP_BLOCK_POINTER to 1 enables customized heap block pointers
; * protection on heap_5. */
;    #ifndef configVALIDATE_HEAP_BLOCK_POINTER
;        #define heapVALIDATE_BLOCK_POINTER( pxBlock )                           \
;            configASSERT( ( pucHeapHighAddress != NULL ) &&                     \
;                          ( pucHeapLowAddress != NULL ) &&                      \
;                          ( ( uint8_t * ) ( pxBlock ) >= pucHeapLowAddress ) && \
;                          ( ( uint8_t * ) ( pxBlock ) < pucHeapHighAddress ) )
;    #else /* ifndef configVALIDATE_HEAP_BLOCK_POINTER */
;        #define heapVALIDATE_BLOCK_POINTER( pxBlock )                           \
;            configVALIDATE_HEAP_BLOCK_POINTER( pxBlock )
;    #endif /* configVALIDATE_HEAP_BLOCK_POINTER */
;
;#else /* if ( configENABLE_HEAP_PROTECTOR == 1 ) */
;
;    #define heapPROTECT_BLOCK_POINTER( pxBlock )    ( pxBlock )
;
;    #define heapVALIDATE_BLOCK_POINTER( pxBlock )
;
;#endif /* configENABLE_HEAP_PROTECTOR */
;
;/*-----------------------------------------------------------*/
;
;/* Define the linked list structure.  This is used to link free blocks in order
; * of their memory address. */
;typedef struct A_BLOCK_LINK
;{
;    struct A_BLOCK_LINK * pxNextFreeBlock; /**< The next free block in the list. */
;    unsigned long xBlockSize;                     /**< The size of the free block. */
;} BlockLink_t;
;
;/*-----------------------------------------------------------*/
;
;/*
; * Inserts a block of memory that is being freed into the correct position in
; * the list of free memory blocks.  The block being freed will be merged with
; * the block in front it and/or the block behind it if the memory blocks are
; * adjacent to each other.
; */
;static void prvInsertBlockIntoFreeList( BlockLink_t * pxBlockToInsert ) PRIVILEGED_FUNCTION;
;void vPortDefineHeapRegions( const HeapRegion_t * const pxHeapRegions ) PRIVILEGED_FUNCTION;
;
;#if ( configENABLE_HEAP_PROTECTOR == 1 )
;
;/**
; * @brief Application provided function to get a random value to be used as canary.
; *
; * @param pxHeapCanary [out] Output parameter to return the canary value.
; */
;    extern void vApplicationGetRandomHeapCanary( portPOINTER_SIZE_TYPE * pxHeapCanary );
;#endif /* configENABLE_HEAP_PROTECTOR */
;
;/*-----------------------------------------------------------*/
;
;/* The size of the structure placed at the beginning of each allocated memory
; * block must by correctly byte aligned. */
;static const size_t xHeapStructSize = ( sizeof( BlockLink_t ) + ( ( size_t ) ( portBYTE_ALIGNMENT - 1 ) ) ) & ~( ( size_t ) portBYTE_ALIGNMENT_MASK );
	data
_~xHeapStructSize:
	dw	$8
	ends
;
;/* Create a couple of list links to mark the start and end of the list. */
;PRIVILEGED_DATA static BlockLink_t xStart;
;PRIVILEGED_DATA static BlockLink_t * pxEnd = NULL;
	data
_~pxEnd:
	dl	$0
	ends
;
;/* Keeps track of the number of calls to allocate and free memory as well as the
; * number of free bytes remaining, but says nothing about fragmentation. */
;PRIVILEGED_DATA static unsigned long xFreeBytesRemaining = ( unsigned long ) 0U;
	data
_~xFreeBytesRemaining:
	dl	$0
	ends
;PRIVILEGED_DATA static unsigned long xMinimumEverFreeBytesRemaining = ( unsigned long ) 0U;
	data
_~xMinimumEverFreeBytesRemaining:
	dl	$0
	ends
;PRIVILEGED_DATA static unsigned long xNumberOfSuccessfulAllocations = ( unsigned long ) 0U;
	data
_~xNumberOfSuccessfulAllocations:
	dl	$0
	ends
;PRIVILEGED_DATA static unsigned long xNumberOfSuccessfulFrees = ( unsigned long ) 0U;
	data
_~xNumberOfSuccessfulFrees:
	dl	$0
	ends
;
;#if ( configENABLE_HEAP_PROTECTOR == 1 )
;
;/* Canary value for protecting internal heap pointers. */
;    PRIVILEGED_DATA static portPOINTER_SIZE_TYPE xHeapCanary;
;
;/* Highest and lowest heap addresses used for heap block bounds checking. */
;    PRIVILEGED_DATA static uint8_t * pucHeapHighAddress = NULL;
;    PRIVILEGED_DATA static uint8_t * pucHeapLowAddress = NULL;
;
;#endif /* configENABLE_HEAP_PROTECTOR */
;
;/*-----------------------------------------------------------*/
;extern volatile char* debug_char;
;extern volatile char* debug_hex;
;/*-----------------------------------------------------------*/
;
;void * farmalloc( unsigned long xWantedSize )
;{
	code
	xdef	_~farmalloc
	func
_~farmalloc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
xWantedSize_0	set	3
;    BlockLink_t * pxBlock;
;    BlockLink_t * pxPreviousBlock;
;    BlockLink_t * pxNewBlockLink;
;    void * pvReturn = NULL;
;    unsigned long xAdditionalRequiredSize;
;    unsigned long xAllocatedBlockSize = 0;
;
;    /* The heap must be initialised before the first call to
;     * pvPortMalloc(). */
;    configASSERT( pxEnd );
pxBlock_1	set	0
pxPreviousBlock_1	set	4
pxNewBlockLink_1	set	8
pvReturn_1	set	12
xAdditionalRequiredSize_1	set	16
xAllocatedBlockSize_1	set	20
	stz	<L3+pvReturn_1
	stz	<L3+pvReturn_1+2
	stz	<L3+xAllocatedBlockSize_1
	stz	<L3+xAllocatedBlockSize_1+2
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	bne	L10001
	asmstart
	sei
	asmend
L10002:
	bra	L10002
L10001:
;
;    if( xWantedSize > 0 )
;    {
	lda	#$0
	cmp	<L2+xWantedSize_0
	sbc	<L2+xWantedSize_0+2
	bcs	L10012
;        /* The wanted size must be increased so it can contain a BlockLink_t
;         * structure in addition to the requested amount of bytes. */
;        if( heapADD_WILL_OVERFLOW( xWantedSize, xHeapStructSize ) == 0 )
;        {
	lda	#$fff7
	cmp	<L2+xWantedSize_0
	lda	#$0
	sbc	<L2+xWantedSize_0+2
	bcc	L10006
;            xWantedSize += xHeapStructSize;
	lda	#$8
	clc
	adc	<L2+xWantedSize_0
	sta	<L2+xWantedSize_0
	bcc	L10012
	inc	<L2+xWantedSize_0+2
;
;            /* Ensure that blocks are always aligned to the required number
;             * of bytes. */
;            if( ( xWantedSize & portBYTE_ALIGNMENT_MASK ) != 0x00 )
;            {
	bra	L10012
;                /* Byte alignment required. */
;                xAdditionalRequiredSize = portBYTE_ALIGNMENT - ( xWantedSize & portBYTE_ALIGNMENT_MASK );
;
;                if( heapADD_WILL_OVERFLOW( xWantedSize, xAdditionalRequiredSize ) == 0 )
;                {
;                    xWantedSize += xAdditionalRequiredSize;
;                }
;                else
;                {
;                    xWantedSize = 0;
;                }
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
L10006:
;        {
;            xWantedSize = 0;
	stz	<L2+xWantedSize_0
	stz	<L2+xWantedSize_0+2
;        }
;    }
;    else
;        }
;        else
L10012:
;
;    vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;    {
;        /* Check the block size we are trying to allocate is not so large that the
;         * top bit is set.  The top bit of the block size member of the BlockLink_t
;         * structure is used to determine who owns the block - the application or
;         * the kernel, so it must be free. */
;        if( heapBLOCK_SIZE_IS_VALID( xWantedSize ) != 0 )
;        {
	lda	<L2+xWantedSize_0+2
	and	#^$80000000
	beq	L9
L10033:
;
;        traceMALLOC( pvReturn, xAllocatedBlockSize );
;
;        /* Prevent compiler warnings when trace macros are not used. */
;        ( void ) xAllocatedBlockSize;
;    }
;    ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;    #if ( configUSE_MALLOC_FAILED_HOOK == 1 )
;    {
;        if( pvReturn == NULL )
;        {
;            vApplicationMallocFailedHook();
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    #endif /* if ( configUSE_MALLOC_FAILED_HOOK == 1 ) */
;
;    configASSERT( ( ( ( uint32_t ) pvReturn ) & ( uint32_t ) portBYTE_ALIGNMENT_MASK ) == 0 );
;    return pvReturn;
	ldx	<L3+pvReturn_1+2
	lda	<L3+pvReturn_1
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
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L9:
;            if( ( xWantedSize > 0 ) && ( xWantedSize <= xFreeBytesRemaining ) )
;            {
	lda	#$0
	cmp	<L2+xWantedSize_0
	sbc	<L2+xWantedSize_0+2
	bcs	L10033
	lda	|_~xFreeBytesRemaining
	cmp	<L2+xWantedSize_0
	lda	|_~xFreeBytesRemaining+2
	sbc	<L2+xWantedSize_0+2
	bcc	L10033
;                /* Traverse the list from the start (lowest address) block until
;                 * one of adequate size is found. */
;                pxPreviousBlock = &xStart;
	lda	#<_~xStart
	sta	<L3+pxPreviousBlock_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L3+pxPreviousBlock_1+2
;                pxBlock = heapPROTECT_BLOCK_POINTER( xStart.pxNextFreeBlock );
	lda	|_~xStart
	sta	<L3+pxBlock_1
	lda	|_~xStart+2
	sta	<L3+pxBlock_1+2
;                heapVALIDATE_BLOCK_POINTER( pxBlock );
;
;                while( ( pxBlock->xBlockSize < xWantedSize ) && ( pxBlock->pxNextFreeBlock != heapPROTECT_BLOCK_POINTER( NULL ) ) )
	bra	L10015
L20001:
	lda	[<L3+pxBlock_1]
	ldy	#$2
	ora	[<L3+pxBlock_1],Y
	beq	L10016
;                {
;                    pxPreviousBlock = pxBlock;
	lda	<L3+pxBlock_1
	sta	<L3+pxPreviousBlock_1
	lda	<L3+pxBlock_1+2
	sta	<L3+pxPreviousBlock_1+2
;                    pxBlock = heapPROTECT_BLOCK_POINTER( pxBlock->pxNextFreeBlock );
	lda	[<L3+pxBlock_1]
	sta	<R0
	lda	[<L3+pxBlock_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L3+pxBlock_1
	lda	<R0+2
	sta	<L3+pxBlock_1+2
;
;                    /* pxEnd is the end marker of the free list. It is located at
;                     * pucHeapHighAddress and is not part of the usable heap, so it
;                     * must be excluded from the heap block pointer validation. */
;                    if( pxBlock != pxEnd )
;                    {
	lda	<L3+pxBlock_1
	cmp	|_~pxEnd
	bne	L14
	lda	<L3+pxBlock_1+2
	cmp	|_~pxEnd+2
L14:
	bne	L10015
L10015:
	ldy	#$4
	lda	[<L3+pxBlock_1],Y
	cmp	<L2+xWantedSize_0
	iny
	iny
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0+2
	bcc	L20001
;                        heapVALIDATE_BLOCK_POINTER( pxBlock );
;                    }
;                }
L10016:
;
;                /* If the end marker was reached then a block of adequate size
;                 * was not found. */
;                if( pxBlock != pxEnd )
;                {
	lda	<L3+pxBlock_1
	cmp	|_~pxEnd
	bne	L16
	lda	<L3+pxBlock_1+2
	cmp	|_~pxEnd+2
L16:
	bne	*+5
	brl	L10033
;                    /* Return the memory space pointed to - jumping over the
;                     * BlockLink_t structure at its start. */
;                    pvReturn = ( void * ) ( ( ( uint8_t * ) heapPROTECT_BLOCK_POINTER( pxPreviousBlock->pxNextFreeBlock ) ) + xHeapStructSize );
	lda	#$8
	clc
	adc	[<L3+pxPreviousBlock_1]
	sta	<L3+pvReturn_1
	lda	#$0
	ldy	#$2
	adc	[<L3+pxPreviousBlock_1],Y
	sta	<L3+pvReturn_1+2
;                    heapVALIDATE_BLOCK_POINTER( pvReturn );
;
;                    /* This block is being returned for use so must be taken out
;                     * of the list of free blocks. */
;                    pxPreviousBlock->pxNextFreeBlock = pxBlock->pxNextFreeBlock;
	lda	[<L3+pxBlock_1]
	sta	[<L3+pxPreviousBlock_1]
	lda	[<L3+pxBlock_1],Y
	sta	[<L3+pxPreviousBlock_1],Y
;
;                    /* If the block is larger than required it can be split into
;                     * two. */
;                    configASSERT( heapSUBTRACT_WILL_UNDERFLOW( pxBlock->xBlockSize, xWantedSize ) == 0 );
	iny
	iny
	lda	[<L3+pxBlock_1],Y
	cmp	<L2+xWantedSize_0
	iny
	iny
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0+2
	bcs	L10019
	asmstart
	sei
	asmend
L10020:
	bra	L10020
L10019:
;
;                    if( ( pxBlock->xBlockSize - xWantedSize ) > heapMINIMUM_BLOCK_SIZE )
;                    {
	sec
	ldy	#$4
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0
	sta	<R0
	iny
	iny
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0+2
	sta	<R0+2
	lda	#$10
	cmp	<R0
	lda	#$0
	sbc	<R0+2
	bcs	L10028
;                        /* This block is to be split into two.  Create a new
;                         * block following the number of bytes requested. The void
;                         * cast is used to prevent byte alignment warnings from the
;                         * compiler. */
;                        pxNewBlockLink = ( void * ) ( ( ( uint8_t * ) pxBlock ) + xWantedSize );
	lda	<L3+pxBlock_1
	clc
	adc	<L2+xWantedSize_0
	sta	<L3+pxNewBlockLink_1
	lda	<L3+pxBlock_1+2
	adc	<L2+xWantedSize_0+2
	sta	<L3+pxNewBlockLink_1+2
;                        configASSERT( ( ( ( uint32_t ) pxNewBlockLink ) & ( uint32_t ) portBYTE_ALIGNMENT_MASK ) == 0 );
;
;                        /* Calculate the sizes of two blocks split from the
;                         * single block. */
;                        pxNewBlockLink->xBlockSize = pxBlock->xBlockSize - xWantedSize;
	sec
	dey
	dey
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0
	sta	<R0
	iny
	iny
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0+2
	sta	<R0+2
	lda	<R0
	dey
	dey
	sta	[<L3+pxNewBlockLink_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L3+pxNewBlockLink_1],Y
;                        pxBlock->xBlockSize = xWantedSize;
	lda	<L2+xWantedSize_0
	dey
	dey
	sta	[<L3+pxBlock_1],Y
	lda	<L2+xWantedSize_0+2
	iny
	iny
	sta	[<L3+pxBlock_1],Y
;
;                        /* Insert the new block into the list of free blocks. */
;                        pxNewBlockLink->pxNextFreeBlock = pxPreviousBlock->pxNextFreeBlock;
	lda	[<L3+pxPreviousBlock_1]
	sta	[<L3+pxNewBlockLink_1]
	ldy	#$2
	lda	[<L3+pxPreviousBlock_1],Y
	sta	[<L3+pxNewBlockLink_1],Y
;                        pxPreviousBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxNewBlockLink );
	lda	<L3+pxNewBlockLink_1
	sta	[<L3+pxPreviousBlock_1]
	lda	<L3+pxNewBlockLink_1+2
	sta	[<L3+pxPreviousBlock_1],Y
;                    }
;                    else
L10028:
;
;                    xFreeBytesRemaining -= pxBlock->xBlockSize;
	sec
	lda	|_~xFreeBytesRemaining
	ldy	#$4
	sbc	[<L3+pxBlock_1],Y
	sta	|_~xFreeBytesRemaining
	lda	|_~xFreeBytesRemaining+2
	iny
	iny
	sbc	[<L3+pxBlock_1],Y
	sta	|_~xFreeBytesRemaining+2
;
;                    if( xFreeBytesRemaining < xMinimumEverFreeBytesRemaining )
;                    {
	lda	|_~xFreeBytesRemaining
	cmp	|_~xMinimumEverFreeBytesRemaining
	lda	|_~xFreeBytesRemaining+2
	sbc	|_~xMinimumEverFreeBytesRemaining+2
	bcc	L20
L10030:
;
;                    xAllocatedBlockSize = pxBlock->xBlockSize;
	ldy	#$4
	lda	[<L3+pxBlock_1],Y
	sta	<L3+xAllocatedBlockSize_1
	iny
	iny
	lda	[<L3+pxBlock_1],Y
	sta	<L3+xAllocatedBlockSize_1+2
;
;                    /* The block is being returned - it is allocated and owned
;                     * by the application and has no "next" block. */
;                    heapALLOCATE_BLOCK( pxBlock );
	lda	#$4
	clc
	adc	<L3+pxBlock_1
	sta	<R0
	lda	#$0
	adc	<L3+pxBlock_1+2
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	ora	#^$80000000
	sta	[<R0],Y
;                    pxBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( NULL );
	lda	#$0
	sta	[<L3+pxBlock_1]
	sta	[<L3+pxBlock_1],Y
;                    xNumberOfSuccessfulAllocations++;
	inc	|_~xNumberOfSuccessfulAllocations
	beq	*+5
	brl	L10033
	inc	|_~xNumberOfSuccessfulAllocations+2
;                }
;                else
;        }
;        else
	brl	L10033
L10025:
	bra	L10025
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L20:
;                        xMinimumEverFreeBytesRemaining = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	|_~xMinimumEverFreeBytesRemaining
	lda	|_~xFreeBytesRemaining+2
	sta	|_~xMinimumEverFreeBytesRemaining+2
;                    }
;                    else
	bra	L10030
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
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
L10035:
	bra	L10035
;}
L2	equ	28
L3	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void farfree( void * pv )
;{
	code
	xdef	_~farfree
	func
_~farfree:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
pv_0	set	3
;    uint8_t * puc = ( uint8_t * ) pv;
;    BlockLink_t * pxLink;
;
;    if( pv != NULL )
puc_1	set	0
pxLink_1	set	4
	lda	<L23+pv_0
	sta	<L24+puc_1
	lda	<L23+pv_0+2
	sta	<L24+puc_1+2
;    {
	lda	<L23+pv_0
	ora	<L23+pv_0+2
	bne	*+5
	brl	L32
;        /* The memory being freed will have an BlockLink_t structure immediately
;         * before it. */
;        puc -= xHeapStructSize;
	lda	#$fff8
	clc
	adc	<L24+puc_1
	sta	<L24+puc_1
	lda	#$ffff
	adc	<L24+puc_1+2
	sta	<L24+puc_1+2
;
;        /* This casting is to keep the compiler from issuing warnings. */
;        pxLink = ( void * ) puc;
	lda	<L24+puc_1
	sta	<L24+pxLink_1
	lda	<L24+puc_1+2
	sta	<L24+pxLink_1+2
;
;        heapVALIDATE_BLOCK_POINTER( pxLink );
;        configASSERT( heapBLOCK_IS_ALLOCATED( pxLink ) != 0 );
	ldy	#$6
	lda	[<L24+pxLink_1],Y
	and	#^$80000000
	bne	L10039
	asmstart
	sei
	asmend
L10040:
	bra	L10040
L10039:
;        configASSERT( pxLink->pxNextFreeBlock == heapPROTECT_BLOCK_POINTER( NULL ) );
	lda	[<L24+pxLink_1]
	ldy	#$2
	ora	[<L24+pxLink_1],Y
	beq	L10043
	asmstart
	sei
	asmend
L10044:
	bra	L10044
L10043:
;
;        if( heapBLOCK_IS_ALLOCATED( pxLink ) != 0 )
;        {
	ldy	#$6
	lda	[<L24+pxLink_1],Y
	and	#^$80000000
	bne	*+5
	brl	L32
;            if( pxLink->pxNextFreeBlock == heapPROTECT_BLOCK_POINTER( NULL ) )
;            {
	lda	[<L24+pxLink_1]
	ldy	#$2
	ora	[<L24+pxLink_1],Y
	beq	*+5
	brl	L32
;                /* The block is being returned to the heap - it is no longer
;                 * allocated. */
;                heapFREE_BLOCK( pxLink );
	lda	#$4
	clc
	adc	<L24+pxLink_1
	sta	<R0
	lda	#$0
	adc	<L24+pxLink_1+2
	sta	<R0+2
	lda	[<R0],Y
	and	#^$7fffffff
	sta	[<R0],Y
;                #if ( configHEAP_CLEAR_MEMORY_ON_FREE == 1 )
;                {
;                    /* Check for underflow as this can occur if xBlockSize is
;                     * overwritten in a heap block. */
;                    if( heapSUBTRACT_WILL_UNDERFLOW( pxLink->xBlockSize, xHeapStructSize ) == 0 )
;                    {
	iny
	iny
	lda	[<L24+pxLink_1],Y
	cmp	#<$8
	iny
	iny
	lda	[<L24+pxLink_1],Y
	sbc	#^$8
	bcc	L10049
;                        ( void ) memset( puc + xHeapStructSize, 0, pxLink->xBlockSize - xHeapStructSize );
	clc
	lda	#$fff8
	dey
	dey
	adc	[<L24+pxLink_1],Y
	sta	<R0
	lda	#$ffff
	iny
	iny
	adc	[<L24+pxLink_1],Y
	sta	<R0+2
	pei	<R0
	pea	#<$0
	lda	#$8
	clc
	adc	<L24+puc_1
	sta	<R1
	lda	#$0
	adc	<L24+puc_1+2
	pha
	pei	<R1
	jsr	_~memset
	sta	<R2
	stx	<R2+2
;                    }
;                }
L10049:
;                #endif
;
;                vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;                {
;                    /* Add this block to the list of free blocks. */
;                    xFreeBytesRemaining += pxLink->xBlockSize;
	clc
	lda	|_~xFreeBytesRemaining
	ldy	#$4
	adc	[<L24+pxLink_1],Y
	sta	|_~xFreeBytesRemaining
	lda	|_~xFreeBytesRemaining+2
	iny
	iny
	adc	[<L24+pxLink_1],Y
	sta	|_~xFreeBytesRemaining+2
;                    traceFREE( pv, pxLink->xBlockSize );
;                    prvInsertBlockIntoFreeList( ( ( BlockLink_t * ) pxLink ) );
	pei	<L24+pxLink_1+2
	pei	<L24+pxLink_1
	jsr	_~prvInsertBlockIntoFreeList
;                    xNumberOfSuccessfulFrees++;
	inc	|_~xNumberOfSuccessfulFrees
	bne	L31
	inc	|_~xNumberOfSuccessfulFrees+2
L31:
;                }
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;            else
L32:
	lda	<L23+1
	sta	<L23+1+4
	pld
	tsc
	clc
	adc	#L23+4
	tcs
	rts
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
L23	equ	20
L24	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;unsigned long xPortGetFreeFarHeapSize( void )
;{
	code
	xdef	_~xPortGetFreeFarHeapSize
	func
_~xPortGetFreeFarHeapSize:
	longa	on
	longi	on
;    return xFreeBytesRemaining;
	ldx	|_~xFreeBytesRemaining+2
	lda	|_~xFreeBytesRemaining
	rts
;}
L33	equ	0
L34	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;unsigned long xPortGetMinimumEverFreeFarHeapSize( void )
;{
	code
	xdef	_~xPortGetMinimumEverFreeFarHeapSize
	func
_~xPortGetMinimumEverFreeFarHeapSize:
	longa	on
	longi	on
;    return xMinimumEverFreeBytesRemaining;
	ldx	|_~xMinimumEverFreeBytesRemaining+2
	lda	|_~xMinimumEverFreeBytesRemaining
	rts
;}
L36	equ	0
L37	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void xPortResetHeapMinimumEverFreeFarHeapSize( void )
;{
	code
	xdef	_~xPortResetHeapMinimumEverFreeFarHeapSize
	func
_~xPortResetHeapMinimumEverFreeFarHeapSize:
	longa	on
	longi	on
;    xMinimumEverFreeBytesRemaining = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	|_~xMinimumEverFreeBytesRemaining
	lda	|_~xFreeBytesRemaining+2
	sta	|_~xMinimumEverFreeBytesRemaining+2
;}
	rts
L39	equ	0
L40	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void * farcalloc( unsigned long xNum,
;                  unsigned long xSize )
;{
	code
	xdef	_~farcalloc
	func
_~farcalloc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L42
	tcs
	phd
	tcd
xNum_0	set	3
xSize_0	set	7
;    void * pv = NULL;
;	char * pv0 = NULL;
;	
;    if( heapMULTIPLY_WILL_OVERFLOW( xNum, xSize ) == 0 )
pv_1	set	0
pv0_1	set	4
	stz	<L43+pv_1
	stz	<L43+pv_1+2
	stz	<L43+pv0_1
	stz	<L43+pv0_1+2
;    {
	lda	#$0
	cmp	<L42+xNum_0
	sbc	<L42+xNum_0+2
	bcs	L44
	pei	<L42+xNum_0+2
	pei	<L42+xNum_0
	pea	#^$ffff
	pea	#<$ffff
	xref	_~~ludv
	jsr	_~~ludv
	stx	<R0+2
	cmp	<L42+xSize_0
	lda	<R0+2
	sbc	<L42+xSize_0+2
	bcc	L10052
L44:
;        pv = farmalloc( xNum * xSize );
	pei	<L42+xSize_0+2
	pei	<L42+xSize_0
	pei	<L42+xNum_0+2
	pei	<L42+xNum_0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	jsr	_~farmalloc
	sta	<L43+pv_1
	stx	<L43+pv_1+2
;
;        if( pv != NULL )
;        {
	ora	<L43+pv_1+2
	beq	L10052
;            //( void ) memset( pv, 0, xNum * xSize );
;			pv0 = (char *)pv;
	lda	<L43+pv_1
	sta	<L43+pv0_1
	lda	<L43+pv_1+2
	sta	<L43+pv0_1+2
;			for(; xSize; xSize--) {
	bra	L10057
L10056:
;				*pv0 = 0;
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L43+pv0_1]
	rep	#$20
	longa	on
;				++pv0;
	inc	<L43+pv0_1
	bne	L10054
	inc	<L43+pv0_1+2
;			}
L10054:
	lda	<L42+xSize_0
	bne	L49
	dec	<L42+xSize_0+2
L49:
	dec	<L42+xSize_0
L10057:
	lda	<L42+xSize_0
	ora	<L42+xSize_0+2
	bne	L10056
;        }
;    }
;
;    return pv;
L10052:
	ldx	<L43+pv_1+2
	lda	<L43+pv_1
	tay
	lda	<L42+1
	sta	<L42+1+8
	pld
	tsc
	clc
	adc	#L42+8
	tcs
	tya
	rts
;}
L42	equ	12
L43	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static void prvInsertBlockIntoFreeList( BlockLink_t * pxBlockToInsert ) /* PRIVILEGED_FUNCTION */
;{
	code
	func
_~prvInsertBlockIntoFreeList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
pxBlockToInsert_0	set	3
;    BlockLink_t * pxIterator;
;    uint8_t * puc;
;
;    /* Iterate through the list until a block is found that has a higher address
;     * than the block being inserted. */
;    for( pxIterator = &xStart; heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) < pxBlockToInsert; pxIterator = heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) )
pxIterator_1	set	0
puc_1	set	4
	lda	#<_~xStart
	sta	<L53+pxIterator_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	bra	L20002
;    {
;        /* Nothing to do here, just iterate to the right position. */
;    }
L10058:
	lda	[<L53+pxIterator_1]
	sta	<R0
	ldy	#$2
	lda	[<L53+pxIterator_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L53+pxIterator_1
	lda	<R0+2
L20002:
	sta	<L53+pxIterator_1+2
	lda	[<L53+pxIterator_1]
	cmp	<L52+pxBlockToInsert_0
	ldy	#$2
	lda	[<L53+pxIterator_1],Y
	sbc	<L52+pxBlockToInsert_0+2
	bcc	L10058
;
;    if( pxIterator != &xStart )
;    {
	lda	#<_~xStart
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<L53+pxIterator_1
	cmp	<R0
	bne	L55
	lda	<L53+pxIterator_1+2
	cmp	<R0+2
L55:
	beq	L10062
;        heapVALIDATE_BLOCK_POINTER( pxIterator );
;    }
;
;    /* Do the block being inserted, and the block it is being inserted after
;     * make a contiguous block of memory? */
;    puc = ( uint8_t * ) pxIterator;
L10062:
	lda	<L53+pxIterator_1
	sta	<L53+puc_1
	lda	<L53+pxIterator_1+2
	sta	<L53+puc_1+2
;
;    if( ( puc + pxIterator->xBlockSize ) == ( uint8_t * ) pxBlockToInsert )
;    {
	clc
	lda	<L53+puc_1
	ldy	#$4
	adc	[<L53+pxIterator_1],Y
	sta	<R0
	lda	<L53+puc_1+2
	iny
	iny
	adc	[<L53+pxIterator_1],Y
	sta	<R0+2
	lda	<L52+pxBlockToInsert_0
	cmp	<R0
	bne	L57
	lda	<L52+pxBlockToInsert_0+2
	cmp	<R0+2
L57:
	bne	L10064
;        pxIterator->xBlockSize += pxBlockToInsert->xBlockSize;
	lda	#$4
	clc
	adc	<L53+pxIterator_1
	sta	<R0
	lda	#$0
	adc	<L53+pxIterator_1+2
	sta	<R0+2
	clc
	lda	[<R0]
	ldy	#$4
	adc	[<L52+pxBlockToInsert_0],Y
	sta	[<R0]
	dey
	dey
	lda	[<R0],Y
	ldy	#$6
	adc	[<L52+pxBlockToInsert_0],Y
	ldy	#$2
	sta	[<R0],Y
;        pxBlockToInsert = pxIterator;
	lda	<L53+pxIterator_1
	sta	<L52+pxBlockToInsert_0
	lda	<L53+pxIterator_1+2
	sta	<L52+pxBlockToInsert_0+2
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10064:
;
;    /* Do the block being inserted, and the block it is being inserted before
;     * make a contiguous block of memory? */
;    puc = ( uint8_t * ) pxBlockToInsert;
	lda	<L52+pxBlockToInsert_0
	sta	<L53+puc_1
	lda	<L52+pxBlockToInsert_0+2
	sta	<L53+puc_1+2
;
;    if( ( puc + pxBlockToInsert->xBlockSize ) == ( uint8_t * ) heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) )
;    {
	clc
	lda	<L53+puc_1
	ldy	#$4
	adc	[<L52+pxBlockToInsert_0],Y
	sta	<R0
	lda	<L53+puc_1+2
	iny
	iny
	adc	[<L52+pxBlockToInsert_0],Y
	sta	<R0+2
	lda	[<L53+pxIterator_1]
	cmp	<R0
	bne	L59
	ldy	#$2
	lda	[<L53+pxIterator_1],Y
	cmp	<R0+2
L59:
	bne	L10065
;        if( heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) != pxEnd )
;        {
	lda	[<L53+pxIterator_1]
	cmp	|_~pxEnd
	bne	L61
	ldy	#$2
	lda	[<L53+pxIterator_1],Y
	cmp	|_~pxEnd+2
L61:
	beq	L10066
;            /* Form one big block from the two blocks. */
;            pxBlockToInsert->xBlockSize += heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock )->xBlockSize;
	lda	[<L53+pxIterator_1]
	sta	<R0
	ldy	#$2
	lda	[<L53+pxIterator_1],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L52+pxBlockToInsert_0
	sta	<R1
	lda	#$0
	adc	<L52+pxBlockToInsert_0+2
	sta	<R1+2
	clc
	lda	[<R1]
	iny
	iny
	adc	[<R0],Y
	sta	[<R1]
	dey
	dey
	lda	[<R1],Y
	ldy	#$6
	adc	[<R0],Y
	ldy	#$2
	sta	[<R1],Y
;            pxBlockToInsert->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock )->pxNextFreeBlock;
	lda	[<L53+pxIterator_1]
	sta	<R0
	lda	[<L53+pxIterator_1],Y
	sta	<R0+2
	lda	[<R0]
	sta	[<L52+pxBlockToInsert_0]
	lda	[<R0],Y
	bra	L20004
;        }
;        else
L10066:
;        {
;            pxBlockToInsert->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxEnd );
	lda	|_~pxEnd
	sta	[<L52+pxBlockToInsert_0]
	lda	|_~pxEnd+2
	bra	L20004
;        }
;    }
;    else
L10065:
;    {
;        pxBlockToInsert->pxNextFreeBlock = pxIterator->pxNextFreeBlock;
	lda	[<L53+pxIterator_1]
	sta	[<L52+pxBlockToInsert_0]
	ldy	#$2
	lda	[<L53+pxIterator_1],Y
L20004:
	ldy	#$2
	sta	[<L52+pxBlockToInsert_0],Y
;    }
;
;    /* If the block being inserted plugged a gap, so was merged with the block
;     * before and the block after, then it's pxNextFreeBlock pointer will have
;     * already been set, and should not be set here as that would make it point
;     * to itself. */
;    if( pxIterator != pxBlockToInsert )
;    {
	lda	<L53+pxIterator_1
	cmp	<L52+pxBlockToInsert_0
	bne	L63
	lda	<L53+pxIterator_1+2
	cmp	<L52+pxBlockToInsert_0+2
L63:
	beq	L65
;        pxIterator->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxBlockToInsert );
	lda	<L52+pxBlockToInsert_0
	sta	[<L53+pxIterator_1]
	lda	<L52+pxBlockToInsert_0+2
	ldy	#$2
	sta	[<L53+pxIterator_1],Y
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L65:
	lda	<L52+1
	sta	<L52+1+4
	pld
	tsc
	clc
	adc	#L52+4
	tcs
	rts
L52	equ	16
L53	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static void debug_ptr(void *p) {
	code
	func
_~debug_ptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L66
	tcs
	phd
	tcd
p_0	set	3
;	*debug_hex = (char)((unsigned long)p >> 16);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	pei	<L66+p_0+2
	pei	<L66+p_0
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
;	*debug_hex = (char)((unsigned long)p >> 8);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	pei	<L66+p_0+2
	pei	<L66+p_0
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
	lda	<L66+p_0
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
	lda	<L66+1
	sta	<L66+1+4
	pld
	tsc
	clc
	adc	#L66+4
	tcs
	rts
L66	equ	8
L67	equ	9
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
	sbc	#L69
	tcs
	phd
	tcd
i_0	set	3
;	*debug_hex = (char)((unsigned long)i >> 8);
	lda	|_~debug_hex
	sta	<R0
	lda	|_~debug_hex+2
	sta	<R0+2
	lda	<L69+i_0
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
	lda	<L69+i_0
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
	lda	<L69+1
	sta	<L69+1+2
	pld
	tsc
	clc
	adc	#L69+2
	tcs
	rts
L69	equ	12
L70	equ	13
	ends
	efunc
;
;void vPortDefineFarHeapRegions( const HeapRegion_t * const pxHeapRegions ) /* PRIVILEGED_FUNCTION */
;{
	code
	xdef	_~vPortDefineFarHeapRegions
	func
_~vPortDefineFarHeapRegions:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L72
	tcs
	phd
	tcd
pxHeapRegions_0	set	3
;    BlockLink_t * pxPreviousFreeBlock;
;    portPOINTER_SIZE_TYPE xAlignedHeap;
;    portPOINTER_SIZE_TYPE xAddress;
;    const HeapRegion_t * pxHeapRegion;
;    BlockLink_t * pxFirstFreeBlockInRegion;
;    unsigned long xTotalRegionSize;
;	unsigned long xTotalHeapSize;
;    BaseType_t xDefinedRegions;
;
;	pxFirstFreeBlockInRegion = NULL;
pxPreviousFreeBlock_1	set	0
xAlignedHeap_1	set	4
xAddress_1	set	8
pxHeapRegion_1	set	12
pxFirstFreeBlockInRegion_1	set	16
xTotalRegionSize_1	set	20
xTotalHeapSize_1	set	24
xDefinedRegions_1	set	28
	stz	<L73+pxFirstFreeBlockInRegion_1
	stz	<L73+pxFirstFreeBlockInRegion_1+2
;	xTotalHeapSize = 0;
	stz	<L73+xTotalHeapSize_1
	stz	<L73+xTotalHeapSize_1+2
;	xDefinedRegions = 0;
	stz	<L73+xDefinedRegions_1
;	
;    /* Can only call once! */
;	
;    configASSERT( pxEnd == NULL );
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	beq	L10071
	asmstart
	sei
	asmend
L10072:
	bra	L10072
L10071:
;
;    #if ( configENABLE_HEAP_PROTECTOR == 1 )
;    {
;        vApplicationGetRandomHeapCanary( &( xHeapCanary ) );
;    }
;    #endif
;
;    //pxHeapRegion = &( pxHeapRegions[ xDefinedRegions ] );
;	pxHeapRegion = pxHeapRegions;
	lda	<L72+pxHeapRegions_0
	sta	<L73+pxHeapRegion_1
	lda	<L72+pxHeapRegions_0+2
L20005:
	sta	<L73+pxHeapRegion_1+2
;	
;    while( pxHeapRegion->xSizeInBytes > 0 )
	lda	#$0
	ldy	#$4
	cmp	[<L73+pxHeapRegion_1],Y
	iny
	iny
	sbc	[<L73+pxHeapRegion_1],Y
	bcc	L20007
;
;    xMinimumEverFreeBytesRemaining = xTotalHeapSize;
	lda	<L73+xTotalHeapSize_1
	sta	|_~xMinimumEverFreeBytesRemaining
	lda	<L73+xTotalHeapSize_1+2
	sta	|_~xMinimumEverFreeBytesRemaining+2
;    xFreeBytesRemaining = xTotalHeapSize;
	lda	<L73+xTotalHeapSize_1
	sta	|_~xFreeBytesRemaining
	lda	<L73+xTotalHeapSize_1+2
	sta	|_~xFreeBytesRemaining+2
;
;    /* Check something was actually defined before it is accessed. */
;    configASSERT( xTotalHeapSize );
	lda	<L73+xTotalHeapSize_1
	ora	<L73+xTotalHeapSize_1+2
	beq	*+5
	brl	L82
	asmstart
	sei
	asmend
L10090:
	bra	L10090
L20007:
;    {
;		
;        xTotalRegionSize = pxHeapRegion->xSizeInBytes;
	ldy	#$4
	lda	[<L73+pxHeapRegion_1],Y
	sta	<L73+xTotalRegionSize_1
	iny
	iny
	lda	[<L73+pxHeapRegion_1],Y
	sta	<L73+xTotalRegionSize_1+2
;		
;		/*
;		debug_word(xDefinedRegions);
;		debug_ptr(pxHeapRegion->pucStartAddress);
;		debug_word(xTotalRegionSize);
;		*/
;		
;        /* Ensure the heap region starts on a correctly aligned boundary. */
;        xAddress = ( portPOINTER_SIZE_TYPE ) pxHeapRegion->pucStartAddress;
	lda	[<L73+pxHeapRegion_1]
	sta	<L73+xAddress_1
	ldy	#$2
	lda	[<L73+pxHeapRegion_1],Y
	sta	<L73+xAddress_1+2
;
;        if( ( xAddress & portBYTE_ALIGNMENT_MASK ) != 0 )
;        {
;            xAddress += ( portBYTE_ALIGNMENT - 1 );
;            xAddress &= ~( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK;
;
;            /* Adjust the size for the bytes lost to alignment. */
;            xTotalRegionSize -= ( unsigned long ) ( xAddress - ( portPOINTER_SIZE_TYPE ) pxHeapRegion->pucStartAddress );
;        }
;
;        xAlignedHeap = xAddress;
	lda	<L73+xAddress_1
	sta	<L73+xAlignedHeap_1
	lda	<L73+xAddress_1+2
	sta	<L73+xAlignedHeap_1+2
;
;        /* Set xStart if it has not already been set. */
;        if( xDefinedRegions == 0 )
;        {
	lda	<L73+xDefinedRegions_1
	beq	*+5
	brl	L10078
;            /* xStart is used to hold a pointer to the first item in the list of
;             *  free blocks.  The void cast is used to prevent compiler warnings. */
;            xStart.pxNextFreeBlock = ( BlockLink_t * ) heapPROTECT_BLOCK_POINTER( xAlignedHeap );
	lda	<L73+xAlignedHeap_1
	sta	|_~xStart
	lda	<L73+xAlignedHeap_1+2
	sta	|_~xStart+2
;            xStart.xBlockSize = ( unsigned long ) 0;
	stz	|_~xStart+4
	stz	|_~xStart+4+2
;        }
;        else
L10079:
;
;        #if ( configENABLE_HEAP_PROTECTOR == 1 )
;        {
;            if( ( pucHeapLowAddress == NULL ) ||
;                ( ( uint8_t * ) xAlignedHeap < pucHeapLowAddress ) )
;            {
;                pucHeapLowAddress = ( uint8_t * ) xAlignedHeap;
;            }
;        }
;        #endif /* configENABLE_HEAP_PROTECTOR */
;
;        /* Remember the location of the end marker in the previous region, if
;         * any. */
;        pxPreviousFreeBlock = pxEnd;
	lda	|_~pxEnd
	sta	<L73+pxPreviousFreeBlock_1
	lda	|_~pxEnd+2
	sta	<L73+pxPreviousFreeBlock_1+2
;
;        /* pxEnd is used to mark the end of the list of free blocks and is
;         * inserted at the end of the region space. */
;        xAddress = xAlignedHeap + ( portPOINTER_SIZE_TYPE ) xTotalRegionSize;
	lda	<L73+xAlignedHeap_1
	clc
	adc	<L73+xTotalRegionSize_1
	sta	<L73+xAddress_1
	lda	<L73+xAlignedHeap_1+2
	adc	<L73+xTotalRegionSize_1+2
	sta	<L73+xAddress_1+2
;        xAddress -= ( portPOINTER_SIZE_TYPE ) xHeapStructSize;
	lda	#$fff8
	clc
	adc	<L73+xAddress_1
	sta	<L73+xAddress_1
	lda	#$ffff
	adc	<L73+xAddress_1+2
	sta	<L73+xAddress_1+2
;        xAddress &= ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK );
	lda	<L73+xAddress_1
	sta	<L73+xAddress_1
	lda	<L73+xAddress_1+2
	sta	<L73+xAddress_1+2
;        pxEnd = ( BlockLink_t * ) xAddress;
	lda	<L73+xAddress_1
	sta	|_~pxEnd
	lda	<L73+xAddress_1+2
	sta	|_~pxEnd+2
;        pxEnd->xBlockSize = 0;
	lda	|_~pxEnd
	sta	<R0
	lda	|_~pxEnd+2
	sta	<R0+2
	lda	#$0
	ldy	#$4
	sta	[<R0],Y
	iny
	iny
	sta	[<R0],Y
;        pxEnd->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( NULL );
	lda	|_~pxEnd
	sta	<R0
	lda	|_~pxEnd+2
	sta	<R0+2
	lda	#$0
	sta	[<R0]
	ldy	#$2
	sta	[<R0],Y
;
;        /* To start with there is a single free block in this region that is
;         * sized to take up the entire heap region minus the space taken by the
;         * free block structure. */
;        pxFirstFreeBlockInRegion = ( BlockLink_t * ) xAlignedHeap;
	lda	<L73+xAlignedHeap_1
	sta	<L73+pxFirstFreeBlockInRegion_1
	lda	<L73+xAlignedHeap_1+2
	sta	<L73+pxFirstFreeBlockInRegion_1+2
;        pxFirstFreeBlockInRegion->xBlockSize = ( unsigned long ) ( xAddress - ( portPOINTER_SIZE_TYPE ) pxFirstFreeBlockInRegion );
	sec
	lda	<L73+xAddress_1
	sbc	<L73+pxFirstFreeBlockInRegion_1
	sta	<R0
	lda	<L73+xAddress_1+2
	sbc	<L73+pxFirstFreeBlockInRegion_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L73+pxFirstFreeBlockInRegion_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L73+pxFirstFreeBlockInRegion_1],Y
;        pxFirstFreeBlockInRegion->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxEnd );
	lda	|_~pxEnd
	sta	[<L73+pxFirstFreeBlockInRegion_1]
	lda	|_~pxEnd+2
	ldy	#$2
	sta	[<L73+pxFirstFreeBlockInRegion_1],Y
;
;        /* If this is not the first region that makes up the entire heap space
;         * then link the previous region to this region. */
;        if( pxPreviousFreeBlock != NULL )
;        {
	lda	<L73+pxPreviousFreeBlock_1
	ora	<L73+pxPreviousFreeBlock_1+2
	bne	L79
	bra	L10088
L10078:
;        {
;            /* Should only get here if one region has already been added to the
;             * heap. */
;            configASSERT( pxEnd != heapPROTECT_BLOCK_POINTER( NULL ) );
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	bne	L10080
	asmstart
	sei
	asmend
L10081:
	bra	L10081
L10080:
;
;            /* Check blocks are passed in with increasing start addresses. */
;            configASSERT( ( uint32_t ) xAddress > ( uint32_t ) pxEnd );
	lda	|_~pxEnd
	cmp	<L73+xAddress_1
	lda	|_~pxEnd+2
	sbc	<L73+xAddress_1+2
	bcs	*+5
	brl	L10079
	asmstart
	sei
	asmend
L10085:
	bra	L10085
;        }
L79:
;            pxPreviousFreeBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxFirstFreeBlockInRegion );
	lda	<L73+pxFirstFreeBlockInRegion_1
	sta	[<L73+pxPreviousFreeBlock_1]
	lda	<L73+pxFirstFreeBlockInRegion_1+2
	ldy	#$2
	sta	[<L73+pxPreviousFreeBlock_1],Y
;        }
;
;        xTotalHeapSize += pxFirstFreeBlockInRegion->xBlockSize;
L10088:
	clc
	lda	<L73+xTotalHeapSize_1
	ldy	#$4
	adc	[<L73+pxFirstFreeBlockInRegion_1],Y
	sta	<L73+xTotalHeapSize_1
	lda	<L73+xTotalHeapSize_1+2
	iny
	iny
	adc	[<L73+pxFirstFreeBlockInRegion_1],Y
	sta	<L73+xTotalHeapSize_1+2
;		//debug_ptr((void *)xTotalHeapSize);
;
;        #if ( configENABLE_HEAP_PROTECTOR == 1 )
;        {
;            if( ( pucHeapHighAddress == NULL ) ||
;                ( ( ( ( uint8_t * ) pxFirstFreeBlockInRegion ) + pxFirstFreeBlockInRegion->xBlockSize ) > pucHeapHighAddress ) )
;            {
;                pucHeapHighAddress = ( ( uint8_t * ) pxFirstFreeBlockInRegion ) + pxFirstFreeBlockInRegion->xBlockSize;
;            }
;        }
;        #endif
;
;        /* Move onto the next HeapRegion_t structure. */
;        xDefinedRegions++;
	inc	<L73+xDefinedRegions_1
;        pxHeapRegion = &( pxHeapRegions[ xDefinedRegions ] );
	ldy	#$0
	lda	<L73+xDefinedRegions_1
	bpl	L80
	dey
L80:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	_~~lasl
	jsr	_~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L72+pxHeapRegions_0
	clc
	adc	<R0
	sta	<L73+pxHeapRegion_1
	lda	<L72+pxHeapRegions_0+2
	adc	<R0+2
	brl	L20005
;    }
;}
L82:
	lda	<L72+1
	sta	<L72+1+4
	pld
	tsc
	clc
	adc	#L72+4
	tcs
	rts
L72	equ	38
L73	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortGetFarHeapStats( HeapStats_t * pxHeapStats )
;{
	code
	xdef	_~vPortGetFarHeapStats
	func
_~vPortGetFarHeapStats:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L83
	tcs
	phd
	tcd
pxHeapStats_0	set	3
;    BlockLink_t * pxBlock;
;    size_t xBlocks = 0, xMaxSize = 0, xMinSize = SIZE_MAX;
;
;    vTaskSuspendAll();
pxBlock_1	set	0
xBlocks_1	set	4
xMaxSize_1	set	6
xMinSize_1	set	8
	stz	<L84+xBlocks_1
	stz	<L84+xMaxSize_1
	lda	#$ffff
	sta	<L84+xMinSize_1
	jsr	_~vTaskSuspendAll
;    {
;        pxBlock = heapPROTECT_BLOCK_POINTER( xStart.pxNextFreeBlock );
	lda	|_~xStart
	sta	<L84+pxBlock_1
	lda	|_~xStart+2
	sta	<L84+pxBlock_1+2
;
;        /* pxBlock will be NULL if the heap has not been initialised.  The heap
;         * is initialised automatically when the first allocation is made. */
;        if( pxBlock != NULL )
;        {
	lda	<L84+pxBlock_1
	ora	<L84+pxBlock_1+2
	bne	L10094
;            while( pxBlock != pxEnd )
	bra	L10093
L20009:
;            {
;                /* Increment the number of blocks and record the largest block seen
;                 * so far. */
;                xBlocks++;
	inc	<L84+xBlocks_1
;
;                if( pxBlock->xBlockSize > xMaxSize )
;                {
	lda	<L84+xMaxSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	ldy	#$4
	cmp	[<L84+pxBlock_1],Y
	lda	<R0+2
	iny
	iny
	sbc	[<L84+pxBlock_1],Y
	bcs	L10096
;                    xMaxSize = pxBlock->xBlockSize;
	dey
	dey
	lda	[<L84+pxBlock_1],Y
	sta	<L84+xMaxSize_1
;                }
;
;                /* Heap five will have a zero sized block at the end of each
;                 * each region - the block is only used to link to the next
;                 * heap region so it not a real block. */
;                if( pxBlock->xBlockSize != 0 )
L10096:
;                {
	ldy	#$4
	lda	[<L84+pxBlock_1],Y
	iny
	iny
	ora	[<L84+pxBlock_1],Y
	beq	L10097
;                    if( pxBlock->xBlockSize < xMinSize )
;                    {
	lda	<L84+xMinSize_1
	sta	<R0
	stz	<R0+2
	dey
	dey
	lda	[<L84+pxBlock_1],Y
	cmp	<R0
	iny
	iny
	lda	[<L84+pxBlock_1],Y
	sbc	<R0+2
	bcs	L10097
;                        xMinSize = pxBlock->xBlockSize;
	dey
	dey
	lda	[<L84+pxBlock_1],Y
	sta	<L84+xMinSize_1
;                    }
;                }
;
;                /* Move to the next block in the chain until the last block is
;                 * reached. */
;                pxBlock = heapPROTECT_BLOCK_POINTER( pxBlock->pxNextFreeBlock );
L10097:
	lda	[<L84+pxBlock_1]
	sta	<R0
	ldy	#$2
	lda	[<L84+pxBlock_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L84+pxBlock_1
	lda	<R0+2
	sta	<L84+pxBlock_1+2
;            }
L10094:
	lda	<L84+pxBlock_1
	cmp	|_~pxEnd
	bne	L86
	lda	<L84+pxBlock_1+2
	cmp	|_~pxEnd+2
L86:
	bne	L20009
;        }
;    }
L10093:
;    ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;    pxHeapStats->xSizeOfLargestFreeBlockInBytes = xMaxSize;
	lda	<L84+xMaxSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L83+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
;    pxHeapStats->xSizeOfSmallestFreeBlockInBytes = xMinSize;
	lda	<L84+xMinSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
;    pxHeapStats->xNumberOfFreeBlocks = xBlocks;
	lda	<L84+xBlocks_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
;
;    taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;    {
;        pxHeapStats->xAvailableHeapSpaceInBytes = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	[<L83+pxHeapStats_0]
	lda	|_~xFreeBytesRemaining+2
	ldy	#$2
	sta	[<L83+pxHeapStats_0],Y
;        pxHeapStats->xNumberOfSuccessfulAllocations = xNumberOfSuccessfulAllocations;
	lda	|_~xNumberOfSuccessfulAllocations
	ldy	#$14
	sta	[<L83+pxHeapStats_0],Y
	lda	|_~xNumberOfSuccessfulAllocations+2
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
;        pxHeapStats->xNumberOfSuccessfulFrees = xNumberOfSuccessfulFrees;
	lda	|_~xNumberOfSuccessfulFrees
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
	lda	|_~xNumberOfSuccessfulFrees+2
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
;        pxHeapStats->xMinimumEverFreeBytesRemaining = xMinimumEverFreeBytesRemaining;
	lda	|_~xMinimumEverFreeBytesRemaining
	ldy	#$10
	sta	[<L83+pxHeapStats_0],Y
	lda	|_~xMinimumEverFreeBytesRemaining+2
	iny
	iny
	sta	[<L83+pxHeapStats_0],Y
;    }
;    taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;}
	lda	<L83+1
	sta	<L83+1+4
	pld
	tsc
	clc
	adc	#L83+4
	tcs
	rts
L83	equ	14
L84	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;/*
; * Reset the state in this file. This state is normally initialized at start up.
; * This function must be called by the application before restarting the
; * scheduler.
; */
;void vPortFarHeapResetState( void )
;{
	code
	xdef	_~vPortFarHeapResetState
	func
_~vPortFarHeapResetState:
	longa	on
	longi	on
;    pxEnd = NULL;
	stz	|_~pxEnd
	stz	|_~pxEnd+2
;
;    xFreeBytesRemaining = ( unsigned long ) 0U;
	stz	|_~xFreeBytesRemaining
	stz	|_~xFreeBytesRemaining+2
;    xMinimumEverFreeBytesRemaining = ( unsigned long ) 0U;
	stz	|_~xMinimumEverFreeBytesRemaining
	stz	|_~xMinimumEverFreeBytesRemaining+2
;    xNumberOfSuccessfulAllocations = ( unsigned long ) 0U;
	stz	|_~xNumberOfSuccessfulAllocations
	stz	|_~xNumberOfSuccessfulAllocations+2
;    xNumberOfSuccessfulFrees = ( unsigned long ) 0U;
	stz	|_~xNumberOfSuccessfulFrees
	stz	|_~xNumberOfSuccessfulFrees+2
;
;    #if ( configENABLE_HEAP_PROTECTOR == 1 )
;        pucHeapHighAddress = NULL;
;        pucHeapLowAddress = NULL;
;    #endif /* #if ( configENABLE_HEAP_PROTECTOR == 1 ) */
;}
	rts
L92	equ	0
L93	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~memset
	xref	_~debug_hex
	xref	_~debug_char
	udata
_~xStart
	ds	8
	ends

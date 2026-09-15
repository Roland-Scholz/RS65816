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
;#define heapBLOCK_ALLOCATED_BITMASK    ( ( ( size_t ) 1 ) << ( ( sizeof( size_t ) * heapBITS_PER_BYTE ) - 1 ) )
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
;    size_t xBlockSize;                     /**< The size of the free block. */
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
	dw	$6
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
;PRIVILEGED_DATA static size_t xFreeBytesRemaining = ( size_t ) 0U;
	data
_~xFreeBytesRemaining:
	dw	$0
	ends
;PRIVILEGED_DATA static size_t xMinimumEverFreeBytesRemaining = ( size_t ) 0U;
	data
_~xMinimumEverFreeBytesRemaining:
	dw	$0
	ends
;PRIVILEGED_DATA static size_t xNumberOfSuccessfulAllocations = ( size_t ) 0U;
	data
_~xNumberOfSuccessfulAllocations:
	dw	$0
	ends
;PRIVILEGED_DATA static size_t xNumberOfSuccessfulFrees = ( size_t ) 0U;
	data
_~xNumberOfSuccessfulFrees:
	dw	$0
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
;
;void * pvPortMalloc( size_t xWantedSize )
;{
	code
	xdef	_~pvPortMalloc
	func
_~pvPortMalloc:
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
;    size_t xAdditionalRequiredSize;
;    size_t xAllocatedBlockSize = 0;
;
;    /* The heap must be initialised before the first call to
;     * pvPortMalloc(). */
;    configASSERT( pxEnd );
pxBlock_1	set	0
pxPreviousBlock_1	set	4
pxNewBlockLink_1	set	8
pvReturn_1	set	12
xAdditionalRequiredSize_1	set	16
xAllocatedBlockSize_1	set	18
	stz	<L3+pvReturn_1
	stz	<L3+pvReturn_1+2
	stz	<L3+xAllocatedBlockSize_1
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	bne	L10001
L10005:
	bra	L10005
L10001:
;
;    if( xWantedSize > 0 )
;    {
	lda	#$0
	cmp	<L2+xWantedSize_0
	bcs	L10015
;        /* The wanted size must be increased so it can contain a BlockLink_t
;         * structure in addition to the requested amount of bytes. */
;        if( heapADD_WILL_OVERFLOW( xWantedSize, xHeapStructSize ) == 0 )
;        {
	lda	<L2+xWantedSize_0
	sta	<R0
	stz	<R0+2
	sec
	lda	#$fff9
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L6
	eor	#$8000
L6:
	bpl	L10009
;            xWantedSize += xHeapStructSize;
	lda	#$6
	clc
	adc	<L2+xWantedSize_0
	sta	<L2+xWantedSize_0
;
;            /* Ensure that blocks are always aligned to the required number
;             * of bytes. */
;            if( ( xWantedSize & portBYTE_ALIGNMENT_MASK ) != 0x00 )
;            {
	bra	L10015
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
;        }
;        else
L10009:
;        {
;            xWantedSize = 0;
	stz	<L2+xWantedSize_0
;        }
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10015:
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
	lda	<L2+xWantedSize_0
	and	#<$8000
	beq	*+5
	brl	L10042
;            if( ( xWantedSize > 0 ) && ( xWantedSize <= xFreeBytesRemaining ) )
;            {
	lda	#$0
	cmp	<L2+xWantedSize_0
	bcc	*+5
	brl	L10042
	lda	|_~xFreeBytesRemaining
	cmp	<L2+xWantedSize_0
	bcs	*+5
	brl	L10042
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
	bra	L10018
L20001:
	lda	[<L3+pxBlock_1]
	ldy	#$2
	ora	[<L3+pxBlock_1],Y
	beq	L10019
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
	bne	L10018
L10018:
	ldy	#$4
	lda	[<L3+pxBlock_1],Y
	cmp	<L2+xWantedSize_0
	bcc	L20001
;                        heapVALIDATE_BLOCK_POINTER( pxBlock );
;                    }
;                }
L10019:
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
	brl	L10042
;                    /* Return the memory space pointed to - jumping over the
;                     * BlockLink_t structure at its start. */
;                    pvReturn = ( void * ) ( ( ( uint8_t * ) heapPROTECT_BLOCK_POINTER( pxPreviousBlock->pxNextFreeBlock ) ) + xHeapStructSize );
	lda	#$6
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
	bcs	L10022
L10026:
	bra	L10026
L10022:
;
;                    if( ( pxBlock->xBlockSize - xWantedSize ) > heapMINIMUM_BLOCK_SIZE )
;                    {
	sec
	ldy	#$4
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0
	sta	<R0
	lda	#$c
	cmp	<R0
	bcs	L10037
;                        /* This block is to be split into two.  Create a new
;                         * block following the number of bytes requested. The void
;                         * cast is used to prevent byte alignment warnings from the
;                         * compiler. */
;                        pxNewBlockLink = ( void * ) ( ( ( uint8_t * ) pxBlock ) + xWantedSize );
	lda	<L2+xWantedSize_0
	sta	<R0
	stz	<R0+2
	lda	<L3+pxBlock_1
	clc
	adc	<R0
	sta	<L3+pxNewBlockLink_1
	lda	<L3+pxBlock_1+2
	adc	<R0+2
	sta	<L3+pxNewBlockLink_1+2
;                        configASSERT( ( ( ( uint32_t ) pxNewBlockLink ) & ( uint32_t ) portBYTE_ALIGNMENT_MASK ) == 0 );
;
;                        /* Calculate the sizes of two blocks split from the
;                         * single block. */
;                        pxNewBlockLink->xBlockSize = pxBlock->xBlockSize - xWantedSize;
	sec
	lda	[<L3+pxBlock_1],Y
	sbc	<L2+xWantedSize_0
	sta	[<L3+pxNewBlockLink_1],Y
;                        pxBlock->xBlockSize = xWantedSize;
	lda	<L2+xWantedSize_0
	sta	[<L3+pxBlock_1],Y
;
;                        /* Insert the new block into the list of free blocks. */
;                        pxNewBlockLink->pxNextFreeBlock = pxPreviousBlock->pxNextFreeBlock;
	lda	[<L3+pxPreviousBlock_1]
	sta	[<L3+pxNewBlockLink_1]
	dey
	dey
	lda	[<L3+pxPreviousBlock_1],Y
	sta	[<L3+pxNewBlockLink_1],Y
;                        pxPreviousBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxNewBlockLink );
	lda	<L3+pxNewBlockLink_1
	sta	[<L3+pxPreviousBlock_1]
	lda	<L3+pxNewBlockLink_1+2
	sta	[<L3+pxPreviousBlock_1],Y
;                    }
;                    else
L10037:
;
;                    xFreeBytesRemaining -= pxBlock->xBlockSize;
	sec
	lda	|_~xFreeBytesRemaining
	ldy	#$4
	sbc	[<L3+pxBlock_1],Y
	sta	|_~xFreeBytesRemaining
;
;                    if( xFreeBytesRemaining < xMinimumEverFreeBytesRemaining )
;                    {
	cmp	|_~xMinimumEverFreeBytesRemaining
	bcc	L20
L10039:
;
;                    xAllocatedBlockSize = pxBlock->xBlockSize;
	ldy	#$4
	lda	[<L3+pxBlock_1],Y
	sta	<L3+xAllocatedBlockSize_1
;
;                    /* The block is being returned - it is allocated and owned
;                     * by the application and has no "next" block. */
;                    heapALLOCATE_BLOCK( pxBlock );
	tya
	clc
	adc	<L3+pxBlock_1
	sta	<R0
	lda	#$0
	adc	<L3+pxBlock_1+2
	sta	<R0+2
	lda	[<R0]
	ora	#<$8000
	sta	[<R0]
;                    pxBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( NULL );
	lda	#$0
	sta	[<L3+pxBlock_1]
	dey
	dey
	sta	[<L3+pxBlock_1],Y
;                    xNumberOfSuccessfulAllocations++;
	inc	|_~xNumberOfSuccessfulAllocations
;                }
;                else
;        }
;        else
L10042:
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
	sta	<L2+1+2
	pld
	tsc
	clc
	adc	#L2+2
	tcs
	tya
	rts
L10034:
	bra	L10034
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L20:
;                        xMinimumEverFreeBytesRemaining = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	|_~xMinimumEverFreeBytesRemaining
;                    }
;                    else
	bra	L10039
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
L10047:
	bra	L10047
;}
L2	equ	24
L3	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortFree( void * pv )
;{
	code
	xdef	_~vPortFree
	func
_~vPortFree:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
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
	lda	<L22+pv_0
	sta	<L23+puc_1
	lda	<L22+pv_0+2
	sta	<L23+puc_1+2
;    {
	lda	<L22+pv_0
	ora	<L22+pv_0+2
	bne	*+5
	brl	L31
;        /* The memory being freed will have an BlockLink_t structure immediately
;         * before it. */
;        puc -= xHeapStructSize;
	lda	#$fffa
	clc
	adc	<L23+puc_1
	sta	<L23+puc_1
	lda	#$ffff
	adc	<L23+puc_1+2
	sta	<L23+puc_1+2
;
;        /* This casting is to keep the compiler from issuing warnings. */
;        pxLink = ( void * ) puc;
	lda	<L23+puc_1
	sta	<L23+pxLink_1
	lda	<L23+puc_1+2
	sta	<L23+pxLink_1+2
;
;        heapVALIDATE_BLOCK_POINTER( pxLink );
;        configASSERT( heapBLOCK_IS_ALLOCATED( pxLink ) != 0 );
	ldy	#$4
	lda	[<L23+pxLink_1],Y
	and	#<$8000
	bne	L10051
L10055:
	bra	L10055
L10051:
;        configASSERT( pxLink->pxNextFreeBlock == heapPROTECT_BLOCK_POINTER( NULL ) );
	lda	[<L23+pxLink_1]
	ldy	#$2
	ora	[<L23+pxLink_1],Y
	beq	L10058
L10062:
	bra	L10062
L10058:
;
;        if( heapBLOCK_IS_ALLOCATED( pxLink ) != 0 )
;        {
	ldy	#$4
	lda	[<L23+pxLink_1],Y
	and	#<$8000
	beq	L31
;            if( pxLink->pxNextFreeBlock == heapPROTECT_BLOCK_POINTER( NULL ) )
;            {
	lda	[<L23+pxLink_1]
	dey
	dey
	ora	[<L23+pxLink_1],Y
	bne	L31
;                /* The block is being returned to the heap - it is no longer
;                 * allocated. */
;                heapFREE_BLOCK( pxLink );
	lda	#$4
	clc
	adc	<L23+pxLink_1
	sta	<R0
	lda	#$0
	adc	<L23+pxLink_1+2
	sta	<R0+2
	lda	[<R0]
	and	#<$7fff
	sta	[<R0]
;                #if ( configHEAP_CLEAR_MEMORY_ON_FREE == 1 )
;                {
;                    /* Check for underflow as this can occur if xBlockSize is
;                     * overwritten in a heap block. */
;                    if( heapSUBTRACT_WILL_UNDERFLOW( pxLink->xBlockSize, xHeapStructSize ) == 0 )
;                    {
	sec
	iny
	iny
	lda	[<L23+pxLink_1],Y
	sbc	#<$6
	bvs	L29
	eor	#$8000
L29:
	bpl	L10067
;                        ( void ) memset( puc + xHeapStructSize, 0, pxLink->xBlockSize - xHeapStructSize );
	ldy	#$4
	lda	[<L23+pxLink_1],Y
	sta	<R0
	stz	<R0+2
	lda	#$fffa
	clc
	adc	<R0
	sta	<R1
	lda	#$ffff
	adc	<R0+2
	sta	<R1+2
	pei	<R1
	pea	#<$0
	lda	#$6
	clc
	adc	<L23+puc_1
	sta	<R0
	lda	#$0
	adc	<L23+puc_1+2
	pha
	pei	<R0
	jsr	_~memset
	sta	<R2
	stx	<R2+2
;                    }
;                }
L10067:
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
	adc	[<L23+pxLink_1],Y
	sta	|_~xFreeBytesRemaining
;                    traceFREE( pv, pxLink->xBlockSize );
;                    prvInsertBlockIntoFreeList( ( ( BlockLink_t * ) pxLink ) );
	pei	<L23+pxLink_1+2
	pei	<L23+pxLink_1
	jsr	_~prvInsertBlockIntoFreeList
;                    xNumberOfSuccessfulFrees++;
	inc	|_~xNumberOfSuccessfulFrees
;                }
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;            else
L31:
	lda	<L22+1
	sta	<L22+1+4
	pld
	tsc
	clc
	adc	#L22+4
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
L22	equ	20
L23	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xPortGetFreeHeapSize( void )
;{
	code
	xdef	_~xPortGetFreeHeapSize
	func
_~xPortGetFreeHeapSize:
	longa	on
	longi	on
;    return xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	rts
;}
L32	equ	0
L33	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xPortGetMinimumEverFreeHeapSize( void )
;{
	code
	xdef	_~xPortGetMinimumEverFreeHeapSize
	func
_~xPortGetMinimumEverFreeHeapSize:
	longa	on
	longi	on
;    return xMinimumEverFreeBytesRemaining;
	lda	|_~xMinimumEverFreeBytesRemaining
	rts
;}
L35	equ	0
L36	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void xPortResetHeapMinimumEverFreeHeapSize( void )
;{
	code
	xdef	_~xPortResetHeapMinimumEverFreeHeapSize
	func
_~xPortResetHeapMinimumEverFreeHeapSize:
	longa	on
	longi	on
;    xMinimumEverFreeBytesRemaining = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	|_~xMinimumEverFreeBytesRemaining
;}
	rts
L38	equ	0
L39	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void * pvPortCalloc( size_t xNum,
;                     size_t xSize )
;{
	code
	xdef	_~pvPortCalloc
	func
_~pvPortCalloc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L41
	tcs
	phd
	tcd
xNum_0	set	3
xSize_0	set	5
;    void * pv = NULL;
;
;    if( heapMULTIPLY_WILL_OVERFLOW( xNum, xSize ) == 0 )
pv_1	set	0
	stz	<L42+pv_1
	stz	<L42+pv_1+2
;    {
	lda	#$0
	cmp	<L41+xNum_0
	bcs	L43
	lda	#$ffff
	ldx	<L41+xNum_0
	xref	_~~udv
	jsr	_~~udv
	cmp	<L41+xSize_0
	bcc	L10070
L43:
;        pv = pvPortMalloc( xNum * xSize );
	lda	<L41+xNum_0
	ldx	<L41+xSize_0
	xref	_~~mul
	jsr	_~~mul
	pha
	jsr	_~pvPortMalloc
	sta	<L42+pv_1
	stx	<L42+pv_1+2
;
;        if( pv != NULL )
;        {
	ora	<L42+pv_1+2
	beq	L10070
;            ( void ) memset( pv, 0, xNum * xSize );
	lda	<L41+xNum_0
	ldx	<L41+xSize_0
	xref	_~~mul
	jsr	_~~mul
	pha
	pea	#<$0
	pei	<L42+pv_1+2
	pei	<L42+pv_1
	jsr	_~memset
;        }
;    }
;
;    return pv;
L10070:
	ldx	<L42+pv_1+2
	lda	<L42+pv_1
	tay
	lda	<L41+1
	sta	<L41+1+4
	pld
	tsc
	clc
	adc	#L41+4
	tcs
	tya
	rts
;}
L41	equ	8
L42	equ	5
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
	sbc	#L48
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
	sta	<L49+pxIterator_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	bra	L20002
;    {
;        /* Nothing to do here, just iterate to the right position. */
;    }
L10072:
	lda	[<L49+pxIterator_1]
	sta	<R0
	ldy	#$2
	lda	[<L49+pxIterator_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L49+pxIterator_1
	lda	<R0+2
L20002:
	sta	<L49+pxIterator_1+2
	lda	[<L49+pxIterator_1]
	cmp	<L48+pxBlockToInsert_0
	ldy	#$2
	lda	[<L49+pxIterator_1],Y
	sbc	<L48+pxBlockToInsert_0+2
	bcc	L10072
;
;    if( pxIterator != &xStart )
;    {
	lda	#<_~xStart
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<L49+pxIterator_1
	cmp	<R0
	bne	L51
	lda	<L49+pxIterator_1+2
	cmp	<R0+2
L51:
	beq	L10076
;        heapVALIDATE_BLOCK_POINTER( pxIterator );
;    }
;
;    /* Do the block being inserted, and the block it is being inserted after
;     * make a contiguous block of memory? */
;    puc = ( uint8_t * ) pxIterator;
L10076:
	lda	<L49+pxIterator_1
	sta	<L49+puc_1
	lda	<L49+pxIterator_1+2
	sta	<L49+puc_1+2
;
;    if( ( puc + pxIterator->xBlockSize ) == ( uint8_t * ) pxBlockToInsert )
;    {
	ldy	#$4
	lda	[<L49+pxIterator_1],Y
	sta	<R0
	stz	<R0+2
	lda	<L49+puc_1
	clc
	adc	<R0
	sta	<R1
	lda	<L49+puc_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<L48+pxBlockToInsert_0
	cmp	<R1
	bne	L53
	lda	<L48+pxBlockToInsert_0+2
	cmp	<R1+2
L53:
	bne	L10078
;        pxIterator->xBlockSize += pxBlockToInsert->xBlockSize;
	lda	#$4
	clc
	adc	<L49+pxIterator_1
	sta	<R0
	lda	#$0
	adc	<L49+pxIterator_1+2
	sta	<R0+2
	clc
	lda	[<R0]
	ldy	#$4
	adc	[<L48+pxBlockToInsert_0],Y
	sta	[<R0]
;        pxBlockToInsert = pxIterator;
	lda	<L49+pxIterator_1
	sta	<L48+pxBlockToInsert_0
	lda	<L49+pxIterator_1+2
	sta	<L48+pxBlockToInsert_0+2
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10078:
;
;    /* Do the block being inserted, and the block it is being inserted before
;     * make a contiguous block of memory? */
;    puc = ( uint8_t * ) pxBlockToInsert;
	lda	<L48+pxBlockToInsert_0
	sta	<L49+puc_1
	lda	<L48+pxBlockToInsert_0+2
	sta	<L49+puc_1+2
;
;    if( ( puc + pxBlockToInsert->xBlockSize ) == ( uint8_t * ) heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) )
;    {
	ldy	#$4
	lda	[<L48+pxBlockToInsert_0],Y
	sta	<R0
	stz	<R0+2
	lda	<L49+puc_1
	clc
	adc	<R0
	sta	<R1
	lda	<L49+puc_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<L49+pxIterator_1]
	cmp	<R1
	bne	L55
	dey
	dey
	lda	[<L49+pxIterator_1],Y
	cmp	<R1+2
L55:
	bne	L10079
;        if( heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) != pxEnd )
;        {
	lda	[<L49+pxIterator_1]
	cmp	|_~pxEnd
	bne	L57
	ldy	#$2
	lda	[<L49+pxIterator_1],Y
	cmp	|_~pxEnd+2
L57:
	beq	L10080
;            /* Form one big block from the two blocks. */
;            pxBlockToInsert->xBlockSize += heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock )->xBlockSize;
	lda	[<L49+pxIterator_1]
	sta	<R0
	ldy	#$2
	lda	[<L49+pxIterator_1],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L48+pxBlockToInsert_0
	sta	<R1
	lda	#$0
	adc	<L48+pxBlockToInsert_0+2
	sta	<R1+2
	clc
	lda	[<R1]
	iny
	iny
	adc	[<R0],Y
	sta	[<R1]
;            pxBlockToInsert->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock )->pxNextFreeBlock;
	lda	[<L49+pxIterator_1]
	sta	<R0
	dey
	dey
	lda	[<L49+pxIterator_1],Y
	sta	<R0+2
	lda	[<R0]
	sta	[<L48+pxBlockToInsert_0]
	lda	[<R0],Y
	bra	L20004
;        }
;        else
L10080:
;        {
;            pxBlockToInsert->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxEnd );
	lda	|_~pxEnd
	sta	[<L48+pxBlockToInsert_0]
	lda	|_~pxEnd+2
	bra	L20004
;        }
;    }
;    else
L10079:
;    {
;        pxBlockToInsert->pxNextFreeBlock = pxIterator->pxNextFreeBlock;
	lda	[<L49+pxIterator_1]
	sta	[<L48+pxBlockToInsert_0]
	ldy	#$2
	lda	[<L49+pxIterator_1],Y
L20004:
	ldy	#$2
	sta	[<L48+pxBlockToInsert_0],Y
;    }
;
;    /* If the block being inserted plugged a gap, so was merged with the block
;     * before and the block after, then it's pxNextFreeBlock pointer will have
;     * already been set, and should not be set here as that would make it point
;     * to itself. */
;    if( pxIterator != pxBlockToInsert )
;    {
	lda	<L49+pxIterator_1
	cmp	<L48+pxBlockToInsert_0
	bne	L59
	lda	<L49+pxIterator_1+2
	cmp	<L48+pxBlockToInsert_0+2
L59:
	beq	L61
;        pxIterator->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxBlockToInsert );
	lda	<L48+pxBlockToInsert_0
	sta	[<L49+pxIterator_1]
	lda	<L48+pxBlockToInsert_0+2
	ldy	#$2
	sta	[<L49+pxIterator_1],Y
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L61:
	lda	<L48+1
	sta	<L48+1+4
	pld
	tsc
	clc
	adc	#L48+4
	tcs
	rts
L48	equ	16
L49	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortDefineHeapRegions( const HeapRegion_t * const pxHeapRegions ) /* PRIVILEGED_FUNCTION */
;{
	code
	xdef	_~vPortDefineHeapRegions
	func
_~vPortDefineHeapRegions:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L62
	tcs
	phd
	tcd
pxHeapRegions_0	set	3
;    BlockLink_t * pxFirstFreeBlockInRegion = NULL;
;    BlockLink_t * pxPreviousFreeBlock;
;    portPOINTER_SIZE_TYPE xAlignedHeap;
;    size_t xTotalRegionSize, xTotalHeapSize = 0;
;    BaseType_t xDefinedRegions = 0;
;    portPOINTER_SIZE_TYPE xAddress;
;    const HeapRegion_t * pxHeapRegion;
;
;    /* Can only call once! */
;    configASSERT( pxEnd == NULL );
pxFirstFreeBlockInRegion_1	set	0
pxPreviousFreeBlock_1	set	4
xAlignedHeap_1	set	8
xTotalRegionSize_1	set	12
xTotalHeapSize_1	set	14
xDefinedRegions_1	set	16
xAddress_1	set	18
pxHeapRegion_1	set	22
	stz	<L63+pxFirstFreeBlockInRegion_1
	stz	<L63+pxFirstFreeBlockInRegion_1+2
	stz	<L63+xTotalHeapSize_1
	stz	<L63+xDefinedRegions_1
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	bne	*+5
	brl	L10085
L10089:
	bra	L10089
L10116:
	bra	L10116
L20007:
;    {
;        xTotalRegionSize = pxHeapRegion->xSizeInBytes;
	ldy	#$4
	lda	[<L63+pxHeapRegion_1],Y
	sta	<L63+xTotalRegionSize_1
;
;        /* Ensure the heap region starts on a correctly aligned boundary. */
;        xAddress = ( portPOINTER_SIZE_TYPE ) pxHeapRegion->pucStartAddress;
	lda	[<L63+pxHeapRegion_1]
	sta	<L63+xAddress_1
	dey
	dey
	lda	[<L63+pxHeapRegion_1],Y
	sta	<L63+xAddress_1+2
;
;        if( ( xAddress & portBYTE_ALIGNMENT_MASK ) != 0 )
;        {
;            xAddress += ( portBYTE_ALIGNMENT - 1 );
;            xAddress &= ~( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK;
;
;            /* Adjust the size for the bytes lost to alignment. */
;            xTotalRegionSize -= ( size_t ) ( xAddress - ( portPOINTER_SIZE_TYPE ) pxHeapRegion->pucStartAddress );
;        }
;
;        xAlignedHeap = xAddress;
	lda	<L63+xAddress_1
	sta	<L63+xAlignedHeap_1
	lda	<L63+xAddress_1+2
	sta	<L63+xAlignedHeap_1+2
;
;        /* Set xStart if it has not already been set. */
;        if( xDefinedRegions == 0 )
;        {
	lda	<L63+xDefinedRegions_1
	beq	*+5
	brl	L10095
;            /* xStart is used to hold a pointer to the first item in the list of
;             *  free blocks.  The void cast is used to prevent compiler warnings. */
;            xStart.pxNextFreeBlock = ( BlockLink_t * ) heapPROTECT_BLOCK_POINTER( xAlignedHeap );
	lda	<L63+xAlignedHeap_1
	sta	|_~xStart
	lda	<L63+xAlignedHeap_1+2
	sta	|_~xStart+2
;            xStart.xBlockSize = ( size_t ) 0;
	stz	|_~xStart+4
;        }
;        else
L10096:
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
	sta	<L63+pxPreviousFreeBlock_1
	lda	|_~pxEnd+2
	sta	<L63+pxPreviousFreeBlock_1+2
;
;        /* pxEnd is used to mark the end of the list of free blocks and is
;         * inserted at the end of the region space. */
;        xAddress = xAlignedHeap + ( portPOINTER_SIZE_TYPE ) xTotalRegionSize;
	lda	<L63+xTotalRegionSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L63+xAlignedHeap_1
	sta	<L63+xAddress_1
	lda	<R0+2
	adc	<L63+xAlignedHeap_1+2
	sta	<L63+xAddress_1+2
;        xAddress -= ( portPOINTER_SIZE_TYPE ) xHeapStructSize;
	lda	#$fffa
	clc
	adc	<L63+xAddress_1
	sta	<L63+xAddress_1
	lda	#$ffff
	adc	<L63+xAddress_1+2
	sta	<L63+xAddress_1+2
;        xAddress &= ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK );
	lda	<L63+xAddress_1
	sta	<L63+xAddress_1
	lda	<L63+xAddress_1+2
	sta	<L63+xAddress_1+2
;        pxEnd = ( BlockLink_t * ) xAddress;
	lda	<L63+xAddress_1
	sta	|_~pxEnd
	lda	<L63+xAddress_1+2
	sta	|_~pxEnd+2
;        pxEnd->xBlockSize = 0;
	lda	|_~pxEnd
	sta	<R0
	lda	|_~pxEnd+2
	sta	<R0+2
	lda	#$0
	ldy	#$4
	sta	[<R0],Y
;        pxEnd->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( NULL );
	lda	|_~pxEnd
	sta	<R0
	lda	|_~pxEnd+2
	sta	<R0+2
	lda	#$0
	sta	[<R0]
	dey
	dey
	sta	[<R0],Y
;
;        /* To start with there is a single free block in this region that is
;         * sized to take up the entire heap region minus the space taken by the
;         * free block structure. */
;        pxFirstFreeBlockInRegion = ( BlockLink_t * ) xAlignedHeap;
	lda	<L63+xAlignedHeap_1
	sta	<L63+pxFirstFreeBlockInRegion_1
	lda	<L63+xAlignedHeap_1+2
	sta	<L63+pxFirstFreeBlockInRegion_1+2
;        pxFirstFreeBlockInRegion->xBlockSize = ( size_t ) ( xAddress - ( portPOINTER_SIZE_TYPE ) pxFirstFreeBlockInRegion );
	sec
	lda	<L63+xAddress_1
	sbc	<L63+pxFirstFreeBlockInRegion_1
	sta	<R0
	lda	<L63+xAddress_1+2
	sbc	<L63+pxFirstFreeBlockInRegion_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L63+pxFirstFreeBlockInRegion_1],Y
;        pxFirstFreeBlockInRegion->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxEnd );
	lda	|_~pxEnd
	sta	[<L63+pxFirstFreeBlockInRegion_1]
	lda	|_~pxEnd+2
	dey
	dey
	sta	[<L63+pxFirstFreeBlockInRegion_1],Y
;
;        /* If this is not the first region that makes up the entire heap space
;         * then link the previous region to this region. */
;        if( pxPreviousFreeBlock != NULL )
;        {
	lda	<L63+pxPreviousFreeBlock_1
	ora	<L63+pxPreviousFreeBlock_1+2
	bne	L70
	bra	L10111
L10095:
;        {
;            /* Should only get here if one region has already been added to the
;             * heap. */
;            configASSERT( pxEnd != heapPROTECT_BLOCK_POINTER( NULL ) );
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	bne	L10097
L10101:
	bra	L10101
L10097:
;
;            /* Check blocks are passed in with increasing start addresses. */
;            configASSERT( ( uint32_t ) xAddress > ( uint32_t ) pxEnd );
	lda	|_~pxEnd
	cmp	<L63+xAddress_1
	lda	|_~pxEnd+2
	sbc	<L63+xAddress_1+2
	bcs	*+5
	brl	L10096
L10108:
	bra	L10108
;        }
L70:
;            pxPreviousFreeBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxFirstFreeBlockInRegion );
	lda	<L63+pxFirstFreeBlockInRegion_1
	sta	[<L63+pxPreviousFreeBlock_1]
	lda	<L63+pxFirstFreeBlockInRegion_1+2
	ldy	#$2
	sta	[<L63+pxPreviousFreeBlock_1],Y
;        }
;
;        xTotalHeapSize += pxFirstFreeBlockInRegion->xBlockSize;
L10111:
	clc
	lda	<L63+xTotalHeapSize_1
	ldy	#$4
	adc	[<L63+pxFirstFreeBlockInRegion_1],Y
	sta	<L63+xTotalHeapSize_1
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
	inc	<L63+xDefinedRegions_1
;        pxHeapRegion = &( pxHeapRegions[ xDefinedRegions ] );
L10085:
;
;    #if ( configENABLE_HEAP_PROTECTOR == 1 )
;    {
;        vApplicationGetRandomHeapCanary( &( xHeapCanary ) );
;    }
;    #endif
;
;    pxHeapRegion = &( pxHeapRegions[ xDefinedRegions ] );
	ldy	#$0
	lda	<L63+xDefinedRegions_1
	bpl	L65
	dey
L65:
	sta	<R0
	sty	<R0+2
	pea	#^$6
	pea	#<$6
	pei	<R0+2
	pei	<R0
	xref	_~~lmul
	jsr	_~~lmul
	sta	<R0
	stx	<R0+2
	lda	<L62+pxHeapRegions_0
	clc
	adc	<R0
	sta	<L63+pxHeapRegion_1
	lda	<L62+pxHeapRegions_0+2
	adc	<R0+2
	sta	<L63+pxHeapRegion_1+2
;
;    while( pxHeapRegion->xSizeInBytes > 0 )
	lda	#$0
	ldy	#$4
	cmp	[<L63+pxHeapRegion_1],Y
	bcs	*+5
	brl	L20007
;
;    xMinimumEverFreeBytesRemaining = xTotalHeapSize;
	lda	<L63+xTotalHeapSize_1
	sta	|_~xMinimumEverFreeBytesRemaining
;    xFreeBytesRemaining = xTotalHeapSize;
	lda	<L63+xTotalHeapSize_1
	sta	|_~xFreeBytesRemaining
;
;    /* Check something was actually defined before it is accessed. */
;    configASSERT( xTotalHeapSize );
	lda	<L63+xTotalHeapSize_1
	bne	*+5
	brl	L10116
;    }
;}
	lda	<L62+1
	sta	<L62+1+4
	pld
	tsc
	clc
	adc	#L62+4
	tcs
	rts
L62	equ	30
L63	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortGetHeapStats( HeapStats_t * pxHeapStats )
;{
	code
	xdef	_~vPortGetHeapStats
	func
_~vPortGetHeapStats:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L74
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
	stz	<L75+xBlocks_1
	stz	<L75+xMaxSize_1
	lda	#$ffff
	sta	<L75+xMinSize_1
	jsr	_~vTaskSuspendAll
;    {
;        pxBlock = heapPROTECT_BLOCK_POINTER( xStart.pxNextFreeBlock );
	lda	|_~xStart
	sta	<L75+pxBlock_1
	lda	|_~xStart+2
	sta	<L75+pxBlock_1+2
;
;        /* pxBlock will be NULL if the heap has not been initialised.  The heap
;         * is initialised automatically when the first allocation is made. */
;        if( pxBlock != NULL )
;        {
	lda	<L75+pxBlock_1
	ora	<L75+pxBlock_1+2
	bne	L10120
;            while( pxBlock != pxEnd )
	bra	L10119
L20028:
;            {
;                /* Increment the number of blocks and record the largest block seen
;                 * so far. */
;                xBlocks++;
	inc	<L75+xBlocks_1
;
;                if( pxBlock->xBlockSize > xMaxSize )
;                {
	lda	<L75+xMaxSize_1
	ldy	#$4
	cmp	[<L75+pxBlock_1],Y
	bcs	L10122
;                    xMaxSize = pxBlock->xBlockSize;
	lda	[<L75+pxBlock_1],Y
	sta	<L75+xMaxSize_1
;                }
;
;                /* Heap five will have a zero sized block at the end of each
;                 * each region - the block is only used to link to the next
;                 * heap region so it not a real block. */
;                if( pxBlock->xBlockSize != 0 )
L10122:
;                {
	ldy	#$4
	lda	[<L75+pxBlock_1],Y
	beq	L10123
;                    if( pxBlock->xBlockSize < xMinSize )
;                    {
	lda	[<L75+pxBlock_1],Y
	cmp	<L75+xMinSize_1
	bcs	L10123
;                        xMinSize = pxBlock->xBlockSize;
	lda	[<L75+pxBlock_1],Y
	sta	<L75+xMinSize_1
;                    }
;                }
;
;                /* Move to the next block in the chain until the last block is
;                 * reached. */
;                pxBlock = heapPROTECT_BLOCK_POINTER( pxBlock->pxNextFreeBlock );
L10123:
	lda	[<L75+pxBlock_1]
	sta	<R0
	ldy	#$2
	lda	[<L75+pxBlock_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L75+pxBlock_1
	lda	<R0+2
	sta	<L75+pxBlock_1+2
;            }
L10120:
	lda	<L75+pxBlock_1
	cmp	|_~pxEnd
	bne	L77
	lda	<L75+pxBlock_1+2
	cmp	|_~pxEnd+2
L77:
	bne	L20028
;        }
;    }
L10119:
;    ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;    pxHeapStats->xSizeOfLargestFreeBlockInBytes = xMaxSize;
	lda	<L75+xMaxSize_1
	ldy	#$2
	sta	[<L74+pxHeapStats_0],Y
;    pxHeapStats->xSizeOfSmallestFreeBlockInBytes = xMinSize;
	lda	<L75+xMinSize_1
	iny
	iny
	sta	[<L74+pxHeapStats_0],Y
;    pxHeapStats->xNumberOfFreeBlocks = xBlocks;
	lda	<L75+xBlocks_1
	iny
	iny
	sta	[<L74+pxHeapStats_0],Y
;
;    taskENTER_CRITICAL();
;    {
;        pxHeapStats->xAvailableHeapSpaceInBytes = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	[<L74+pxHeapStats_0]
;        pxHeapStats->xNumberOfSuccessfulAllocations = xNumberOfSuccessfulAllocations;
	lda	|_~xNumberOfSuccessfulAllocations
	ldy	#$a
	sta	[<L74+pxHeapStats_0],Y
;        pxHeapStats->xNumberOfSuccessfulFrees = xNumberOfSuccessfulFrees;
	lda	|_~xNumberOfSuccessfulFrees
	iny
	iny
	sta	[<L74+pxHeapStats_0],Y
;        pxHeapStats->xMinimumEverFreeBytesRemaining = xMinimumEverFreeBytesRemaining;
	lda	|_~xMinimumEverFreeBytesRemaining
	ldy	#$8
	sta	[<L74+pxHeapStats_0],Y
;    }
;    taskEXIT_CRITICAL();
;}
	lda	<L74+1
	sta	<L74+1+4
	pld
	tsc
	clc
	adc	#L74+4
	tcs
	rts
L74	equ	14
L75	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;/*
; * Reset the state in this file. This state is normally initialized at start up.
; * This function must be called by the application before restarting the
; * scheduler.
; */
;void vPortHeapResetState( void )
;{
	code
	xdef	_~vPortHeapResetState
	func
_~vPortHeapResetState:
	longa	on
	longi	on
;    pxEnd = NULL;
	stz	|_~pxEnd
	stz	|_~pxEnd+2
;
;    xFreeBytesRemaining = ( size_t ) 0U;
	stz	|_~xFreeBytesRemaining
;    xMinimumEverFreeBytesRemaining = ( size_t ) 0U;
	stz	|_~xMinimumEverFreeBytesRemaining
;    xNumberOfSuccessfulAllocations = ( size_t ) 0U;
	stz	|_~xNumberOfSuccessfulAllocations
;    xNumberOfSuccessfulFrees = ( size_t ) 0U;
	stz	|_~xNumberOfSuccessfulFrees
;
;    #if ( configENABLE_HEAP_PROTECTOR == 1 )
;        pucHeapHighAddress = NULL;
;        pucHeapLowAddress = NULL;
;    #endif /* #if ( configENABLE_HEAP_PROTECTOR == 1 ) */
;}
	rts
L83	equ	0
L84	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~memset
	udata
_~xStart
	ds	6
	ends

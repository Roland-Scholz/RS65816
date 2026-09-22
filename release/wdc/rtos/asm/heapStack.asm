;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#define configTOTAL_HEAP_SIZE_STACK (56*1024U)
;#define configAPPLICATION_ALLOCATED_STACK 1
;
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
; * A sample implementation of pvPortMalloc() and vPortFree() that combines
; * (coalescences) adjacent memory blocks as they are freed, and in so doing
; * limits memory fragmentation.
; *
; * See heap_1.c, heap_2.c and heap_3.c for alternative implementations, and the
; * memory management pages of https://www.FreeRTOS.org for more information.
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
;/*-----------------------------------------------------------*/
;
;/* Allocate the memory for the heap. */
;#if ( configAPPLICATION_ALLOCATED_STACK == 1 )
;
;/* The application writer has already defined the array used for the RTOS
; * heap - probably so it can be placed in a special segment or address. */
;//    extern uint8_t ucHeapStack[ configTOTAL_HEAP_SIZE_STACK ];
;	  extern uint8_t *ucHeapStack;
;#else
;    PRIVILEGED_DATA static uint8_t ucHeapStack[ configTOTAL_HEAP_SIZE_STACK ];
;#endif /* configAPPLICATION_ALLOCATED_STACK */
;
;/* Define the linked list structure.  This is used to link free blocks in order
; * of their memory address. */
;typedef struct A_BLOCK_LINK
;{
;    struct A_BLOCK_LINK * pxNextFreeBlock; /**< The next free block in the list. */
;    size_t xBlockSize;                     /**< The size of the free block. */
;} BlockLink_t;
;
;/* Setting configENABLE_HEAP_PROTECTOR to 1 enables heap block pointers
; * protection using an application supplied canary value to catch heap
; * corruption should a heap buffer overflow occur.
; */
;#if ( configENABLE_HEAP_PROTECTOR == 1 )
;
;/**
; * @brief Application provided function to get a random value to be used as canary.
; *
; * @param pxHeapCanary [out] Output parameter to return the canary value.
; */
;    extern void vApplicationGetRandomHeapCanary( portPOINTER_SIZE_TYPE * pxHeapCanary );
;
;/* Canary value for protecting internal heap pointers. */
;    PRIVILEGED_DATA static portPOINTER_SIZE_TYPE xHeapCanary;
;
;/* Macro to load/store BlockLink_t pointers to memory. By XORing the
; * pointers with a random canary value, heap overflows will result
; * in randomly unpredictable pointer values which will be caught by
; * heapVALIDATE_BLOCK_POINTER assert. */
;    #define heapPROTECT_BLOCK_POINTER( pxBlock )    ( ( BlockLink_t * ) ( ( ( portPOINTER_SIZE_TYPE ) ( pxBlock ) ) ^ xHeapCanary ) )
;#else
;
;    #define heapPROTECT_BLOCK_POINTER( pxBlock )    ( pxBlock )
;
;#endif /* configENABLE_HEAP_PROTECTOR */
;
;/* Assert that a heap block pointer is within the heap bounds. */
;#define heapVALIDATE_BLOCK_POINTER( pxBlock )                          \
;    configASSERT( ( ( uint8_t * ) ( pxBlock ) >= &( ucHeapStack[ 0 ] ) ) && \
;                  ( ( uint8_t * ) ( pxBlock ) <= &( ucHeapStack[ configTOTAL_HEAP_SIZE_STACK - 1 ] ) ) )
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
;
;/*
; * Called automatically to setup the required heap structures the first time
; * pvPortMalloc() is called.
; */
;static void prvHeapInit( void ) PRIVILEGED_FUNCTION;
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
;/*-----------------------------------------------------------*/
;
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
;void * pvPortMallocStack( size_t xWantedSize )
;{
	code
	xdef	_~pvPortMallocStack
	func
_~pvPortMallocStack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
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
;    if( xWantedSize > 0 )
pxBlock_1	set	0
pxPreviousBlock_1	set	4
pxNewBlockLink_1	set	8
pvReturn_1	set	12
xAdditionalRequiredSize_1	set	16
xAllocatedBlockSize_1	set	18
	stz	<L9+pvReturn_1
	stz	<L9+pvReturn_1+2
	stz	<L9+xAllocatedBlockSize_1
;    {
	lda	#$0
	cmp	<L8+xWantedSize_0
	bcs	L10008
;        /* The wanted size must be increased so it can contain a BlockLink_t
;         * structure in addition to the requested amount of bytes. */
;        if( heapADD_WILL_OVERFLOW( xWantedSize, xHeapStructSize ) == 0 )
;        {
	lda	<L8+xWantedSize_0
	sta	<R0
	stz	<R0+2
	sec
	lda	#$fff9
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L11
	eor	#$8000
L11:
	bpl	L10002
;            xWantedSize += xHeapStructSize;
	lda	#$6
	clc
	adc	<L8+xWantedSize_0
	sta	<L8+xWantedSize_0
;
;            /* Ensure that blocks are always aligned to the required number
;             * of bytes. */
;            if( ( xWantedSize & portBYTE_ALIGNMENT_MASK ) != 0x00 )
;            {
	bra	L10008
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
L10002:
;        {
;            xWantedSize = 0;
	stz	<L8+xWantedSize_0
;        }
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10008:
;
;    vTaskSuspendAll();
	jsr	_~vTaskSuspendAll
;    {
;        /* If this is the first call to malloc then the heap will require
;         * initialisation to setup the list of free blocks. */
;        if( pxEnd == NULL )
;        {
	lda	|_~pxEnd
	ora	|_~pxEnd+2
	bne	L10010
;            prvHeapInit();
	jsr	_~prvHeapInit
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10010:
;		//debug_word(xWantedSize);
;        /* Check the block size we are trying to allocate is not so large that the
;         * top bit is set.  The top bit of the block size member of the BlockLink_t
;         * structure is used to determine who owns the block - the application or
;         * the kernel, so it must be free. */
;        if( heapBLOCK_SIZE_IS_VALID( xWantedSize ) != 0 )
;        {		
	lda	<L8+xWantedSize_0
	and	#<$8000
	beq	*+5
	brl	L10042
;            if( ( xWantedSize > 0 ) && ( xWantedSize <= xFreeBytesRemaining ) )
;            {
	lda	#$0
	cmp	<L8+xWantedSize_0
	bcc	*+5
	brl	L10042
	lda	|_~xFreeBytesRemaining
	cmp	<L8+xWantedSize_0
	bcs	*+5
	brl	L10042
;                /* Traverse the list from the start (lowest address) block until
;                 * one of adequate size is found. */
;				 
;				//debug_word(xWantedSize);
;				
;                pxPreviousBlock = &xStart;
	lda	#<_~xStart
	sta	<L9+pxPreviousBlock_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L9+pxPreviousBlock_1+2
;                pxBlock = heapPROTECT_BLOCK_POINTER( xStart.pxNextFreeBlock );
	lda	|_~xStart
	sta	<L9+pxBlock_1
	lda	|_~xStart+2
	sta	<L9+pxBlock_1+2
;                heapVALIDATE_BLOCK_POINTER( pxBlock );
	lda	<L9+pxBlock_1
	cmp	|_~ucHeapStack
	lda	<L9+pxBlock_1+2
	sbc	|_~ucHeapStack+2
	bcc	L18
	lda	#$dfff
	clc
	adc	|_~ucHeapStack
	sta	<R0
	lda	#$0
	adc	|_~ucHeapStack+2
	sta	<R0+2
	lda	<R0
	cmp	<L9+pxBlock_1
	lda	<R0+2
	sbc	<L9+pxBlock_1+2
	bcs	L10017
L18:
	asmstart
	sei
	asmend
L10014:
	bra	L10014
;				
;				//debug_ptr(pxPreviousBlock);
;				//debug_ptr(pxBlock);
;				
;                while( ( pxBlock->xBlockSize < xWantedSize ) && ( pxBlock->pxNextFreeBlock != heapPROTECT_BLOCK_POINTER( NULL ) ) )
;                }
L10017:
	ldy	#$4
	lda	[<L9+pxBlock_1],Y
	cmp	<L8+xWantedSize_0
	bcs	L10018
	lda	[<L9+pxBlock_1]
	dey
	dey
	ora	[<L9+pxBlock_1],Y
	beq	L10018
;                {
;                    pxPreviousBlock = pxBlock;
	lda	<L9+pxBlock_1
	sta	<L9+pxPreviousBlock_1
	lda	<L9+pxBlock_1+2
	sta	<L9+pxPreviousBlock_1+2
;                    pxBlock = heapPROTECT_BLOCK_POINTER( pxBlock->pxNextFreeBlock );
	lda	[<L9+pxBlock_1]
	sta	<R0
	lda	[<L9+pxBlock_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L9+pxBlock_1
	lda	<R0+2
	sta	<L9+pxBlock_1+2
;                    heapVALIDATE_BLOCK_POINTER( pxBlock );
	lda	<L9+pxBlock_1
	cmp	|_~ucHeapStack
	lda	<L9+pxBlock_1+2
	sbc	|_~ucHeapStack+2
	bcc	L23
	lda	#$dfff
	clc
	adc	|_~ucHeapStack
	sta	<R0
	lda	#$0
	adc	|_~ucHeapStack+2
	sta	<R0+2
	lda	<R0
	cmp	<L9+pxBlock_1
	lda	<R0+2
	sbc	<L9+pxBlock_1+2
	bcs	L10017
L23:
	asmstart
	sei
	asmend
L10020:
	bra	L10020
L10018:
;
;                /* If the end marker was reached then a block of adequate size
;                 * was not found. */
;                if( pxBlock != pxEnd )
;                {
	lda	<L9+pxBlock_1
	cmp	|_~pxEnd
	bne	L26
	lda	<L9+pxBlock_1+2
	cmp	|_~pxEnd+2
L26:
	bne	*+5
	brl	L10042
;                    /* Return the memory space pointed to - jumping over the
;                     * BlockLink_t structure at its start. */
;                    pvReturn = ( void * ) ( ( ( uint8_t * ) heapPROTECT_BLOCK_POINTER( pxPreviousBlock->pxNextFreeBlock ) ) + xHeapStructSize );
	lda	#$6
	clc
	adc	[<L9+pxPreviousBlock_1]
	sta	<L9+pvReturn_1
	lda	#$0
	ldy	#$2
	adc	[<L9+pxPreviousBlock_1],Y
	sta	<L9+pvReturn_1+2
;                    heapVALIDATE_BLOCK_POINTER( pvReturn );
	lda	<L9+pvReturn_1
	cmp	|_~ucHeapStack
	lda	<L9+pvReturn_1+2
	sbc	|_~ucHeapStack+2
	bcc	L28
	lda	#$dfff
	clc
	adc	|_~ucHeapStack
	sta	<R0
	lda	#$0
	adc	|_~ucHeapStack+2
	sta	<R0+2
	lda	<R0
	cmp	<L9+pvReturn_1
	lda	<R0+2
	sbc	<L9+pvReturn_1+2
	bcs	L10024
L28:
	asmstart
	sei
	asmend
L10025:
	bra	L10025
L10024:
;					
;					//debug_ptr(pvReturn);
;					
;                    /* This block is being returned for use so must be taken out
;                     * of the list of free blocks. */
;                    pxPreviousBlock->pxNextFreeBlock = pxBlock->pxNextFreeBlock;
	lda	[<L9+pxBlock_1]
	sta	[<L9+pxPreviousBlock_1]
	ldy	#$2
	lda	[<L9+pxBlock_1],Y
	sta	[<L9+pxPreviousBlock_1],Y
;
;                    /* If the block is larger than required it can be split into
;                     * two. */
;                    configASSERT( heapSUBTRACT_WILL_UNDERFLOW( pxBlock->xBlockSize, xWantedSize ) == 0 );
	iny
	iny
	lda	[<L9+pxBlock_1],Y
	cmp	<L8+xWantedSize_0
	bcs	L10028
	asmstart
	sei
	asmend
L10029:
	bra	L10029
L10028:
;
;                    if( ( pxBlock->xBlockSize - xWantedSize ) > heapMINIMUM_BLOCK_SIZE )
;                    {
	sec
	ldy	#$4
	lda	[<L9+pxBlock_1],Y
	sbc	<L8+xWantedSize_0
	sta	<R0
	lda	#$c
	cmp	<R0
	bcs	L10037
;                        /* This block is to be split into two.  Create a new
;                         * block following the number of bytes requested. The void
;                         * cast is used to prevent byte alignment warnings from the
;                         * compiler. */
;                        pxNewBlockLink = ( void * ) ( ( ( uint8_t * ) pxBlock ) + xWantedSize );
	lda	<L8+xWantedSize_0
	sta	<R0
	stz	<R0+2
	lda	<L9+pxBlock_1
	clc
	adc	<R0
	sta	<L9+pxNewBlockLink_1
	lda	<L9+pxBlock_1+2
	adc	<R0+2
	sta	<L9+pxNewBlockLink_1+2
;                        //configASSERT( ( ( ( size_t ) pxNewBlockLink ) & portBYTE_ALIGNMENT_MASK ) == 0 );
;                        configASSERT( ( ( ( uint32_t ) pxNewBlockLink ) & (uint32_t)portBYTE_ALIGNMENT_MASK ) == 0 );
;
;                        /* Calculate the sizes of two blocks split from the
;                         * single block. */
;                        pxNewBlockLink->xBlockSize = pxBlock->xBlockSize - xWantedSize;
	sec
	lda	[<L9+pxBlock_1],Y
	sbc	<L8+xWantedSize_0
	sta	[<L9+pxNewBlockLink_1],Y
;                        pxBlock->xBlockSize = xWantedSize;
	lda	<L8+xWantedSize_0
	sta	[<L9+pxBlock_1],Y
;
;                        /* Insert the new block into the list of free blocks. */
;                        pxNewBlockLink->pxNextFreeBlock = pxPreviousBlock->pxNextFreeBlock;
	lda	[<L9+pxPreviousBlock_1]
	sta	[<L9+pxNewBlockLink_1]
	dey
	dey
	lda	[<L9+pxPreviousBlock_1],Y
	sta	[<L9+pxNewBlockLink_1],Y
;                        pxPreviousBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxNewBlockLink );
	lda	<L9+pxNewBlockLink_1
	sta	[<L9+pxPreviousBlock_1]
	lda	<L9+pxNewBlockLink_1+2
	sta	[<L9+pxPreviousBlock_1],Y
;                    }
;                    else
L10037:
;
;                    xFreeBytesRemaining -= pxBlock->xBlockSize;
	sec
	lda	|_~xFreeBytesRemaining
	ldy	#$4
	sbc	[<L9+pxBlock_1],Y
	sta	|_~xFreeBytesRemaining
;
;                    if( xFreeBytesRemaining < xMinimumEverFreeBytesRemaining )
;                    {
	cmp	|_~xMinimumEverFreeBytesRemaining
	bcc	L33
L10039:
;
;                    xAllocatedBlockSize = pxBlock->xBlockSize;
	ldy	#$4
	lda	[<L9+pxBlock_1],Y
	sta	<L9+xAllocatedBlockSize_1
;
;                    /* The block is being returned - it is allocated and owned
;                     * by the application and has no "next" block. */
;                    heapALLOCATE_BLOCK( pxBlock );
	tya
	clc
	adc	<L9+pxBlock_1
	sta	<R0
	lda	#$0
	adc	<L9+pxBlock_1+2
	sta	<R0+2
	lda	[<R0]
	ora	#<$8000
	sta	[<R0]
;                    pxBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( NULL );
	lda	#$0
	sta	[<L9+pxBlock_1]
	dey
	dey
	sta	[<L9+pxBlock_1],Y
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
;    //configASSERT( ( ( ( size_t ) pvReturn ) & ( size_t ) portBYTE_ALIGNMENT_MASK ) == 0 );
;    configASSERT( ( ( ( uint32_t ) pvReturn ) & ( uint32_t ) portBYTE_ALIGNMENT_MASK ) == 0 );
;    return pvReturn;
	ldx	<L9+pvReturn_1+2
	lda	<L9+pvReturn_1
	tay
	lda	<L8+1
	sta	<L8+1+2
	pld
	tsc
	clc
	adc	#L8+2
	tcs
	tya
	rts
L10034:
	bra	L10034
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L33:
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
L10044:
	bra	L10044
;}
L8	equ	24
L9	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortFreeStack( void * pv )
;{
	code
	xdef	_~vPortFreeStack
	func
_~vPortFreeStack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
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
	lda	<L35+pv_0
	sta	<L36+puc_1
	lda	<L35+pv_0+2
	sta	<L36+puc_1+2
;    {
	lda	<L35+pv_0
	ora	<L35+pv_0+2
	bne	*+5
	brl	L47
;        /* The memory being freed will have an BlockLink_t structure immediately
;         * before it. */
;        puc -= xHeapStructSize;
	lda	#$fffa
	clc
	adc	<L36+puc_1
	sta	<L36+puc_1
	lda	#$ffff
	adc	<L36+puc_1+2
	sta	<L36+puc_1+2
;
;        /* This casting is to keep the compiler from issuing warnings. */
;        pxLink = ( void * ) puc;
	lda	<L36+puc_1
	sta	<L36+pxLink_1
	lda	<L36+puc_1+2
	sta	<L36+pxLink_1+2
;
;        heapVALIDATE_BLOCK_POINTER( pxLink );
	lda	<L36+pxLink_1
	cmp	|_~ucHeapStack
	lda	<L36+pxLink_1+2
	sbc	|_~ucHeapStack+2
	bcc	L38
	lda	#$dfff
	clc
	adc	|_~ucHeapStack
	sta	<R0
	lda	#$0
	adc	|_~ucHeapStack+2
	sta	<R0+2
	lda	<R0
	cmp	<L36+pxLink_1
	lda	<R0+2
	sbc	<L36+pxLink_1+2
	bcs	L10048
L38:
	asmstart
	sei
	asmend
L10049:
	bra	L10049
L10048:
;        configASSERT( heapBLOCK_IS_ALLOCATED( pxLink ) != 0 );
	ldy	#$4
	lda	[<L36+pxLink_1],Y
	and	#<$8000
	bne	L10052
	asmstart
	sei
	asmend
L10053:
	bra	L10053
L10052:
;        configASSERT( pxLink->pxNextFreeBlock == heapPROTECT_BLOCK_POINTER( NULL ) );
	lda	[<L36+pxLink_1]
	ldy	#$2
	ora	[<L36+pxLink_1],Y
	beq	L10056
	asmstart
	sei
	asmend
L10057:
	bra	L10057
L10056:
;
;        if( heapBLOCK_IS_ALLOCATED( pxLink ) != 0 )
;        {
	ldy	#$4
	lda	[<L36+pxLink_1],Y
	and	#<$8000
	beq	L47
;            if( pxLink->pxNextFreeBlock == heapPROTECT_BLOCK_POINTER( NULL ) )
;            {
	lda	[<L36+pxLink_1]
	dey
	dey
	ora	[<L36+pxLink_1],Y
	bne	L47
;                /* The block is being returned to the heap - it is no longer
;                 * allocated. */
;                heapFREE_BLOCK( pxLink );
	lda	#$4
	clc
	adc	<L36+pxLink_1
	sta	<R0
	lda	#$0
	adc	<L36+pxLink_1+2
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
	lda	[<L36+pxLink_1],Y
	sbc	#<$6
	bvs	L45
	eor	#$8000
L45:
	bpl	L10062
;                        ( void ) memset( puc + xHeapStructSize, 0, pxLink->xBlockSize - xHeapStructSize );
	ldy	#$4
	lda	[<L36+pxLink_1],Y
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
	adc	<L36+puc_1
	sta	<R0
	lda	#$0
	adc	<L36+puc_1+2
	pha
	pei	<R0
	jsr	_~memset
	sta	<R2
	stx	<R2+2
;                    }
;                }
L10062:
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
	adc	[<L36+pxLink_1],Y
	sta	|_~xFreeBytesRemaining
;                    traceFREE( pv, pxLink->xBlockSize );
;                    prvInsertBlockIntoFreeList( ( ( BlockLink_t * ) pxLink ) );
	pei	<L36+pxLink_1+2
	pei	<L36+pxLink_1
	jsr	_~prvInsertBlockIntoFreeList
;                    xNumberOfSuccessfulFrees++;
	inc	|_~xNumberOfSuccessfulFrees
;                }
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;            else
L47:
	lda	<L35+1
	sta	<L35+1+4
	pld
	tsc
	clc
	adc	#L35+4
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
L35	equ	20
L36	equ	13
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xPortGetFreeHeapSizeStack( void )
;{
	code
	xdef	_~xPortGetFreeHeapSizeStack
	func
_~xPortGetFreeHeapSizeStack:
	longa	on
	longi	on
;    return xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	rts
;}
L48	equ	0
L49	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xPortGetMinimumEverFreeHeapSizeStack( void )
;{
	code
	xdef	_~xPortGetMinimumEverFreeHeapSizeStack
	func
_~xPortGetMinimumEverFreeHeapSizeStack:
	longa	on
	longi	on
;    return xMinimumEverFreeBytesRemaining;
	lda	|_~xMinimumEverFreeBytesRemaining
	rts
;}
L51	equ	0
L52	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void xPortResetHeapMinimumEverFreeHeapSizeStack( void )
;{
	code
	xdef	_~xPortResetHeapMinimumEverFreeHeapSizeStack
	func
_~xPortResetHeapMinimumEverFreeHeapSizeStack:
	longa	on
	longi	on
;    xMinimumEverFreeBytesRemaining = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	|_~xMinimumEverFreeBytesRemaining
;}
	rts
L54	equ	0
L55	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortInitialiseBlocksStack( void )
;{
	code
	xdef	_~vPortInitialiseBlocksStack
	func
_~vPortInitialiseBlocksStack:
	longa	on
	longi	on
;    /* This just exists to keep the linker quiet. */
;}
	rts
L57	equ	0
L58	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void * pvPortCallocStack( size_t xNum,
;                     size_t xSize )
;{
	code
	xdef	_~pvPortCallocStack
	func
_~pvPortCallocStack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L60
	tcs
	phd
	tcd
xNum_0	set	3
xSize_0	set	5
;    void * pv = NULL;
;
;    if( heapMULTIPLY_WILL_OVERFLOW( xNum, xSize ) == 0 )
pv_1	set	0
	stz	<L61+pv_1
	stz	<L61+pv_1+2
;    {
	lda	#$0
	cmp	<L60+xNum_0
	bcs	L62
	lda	#$ffff
	ldx	<L60+xNum_0
	xref	_~~udv
	jsr	_~~udv
	cmp	<L60+xSize_0
	bcc	L10065
L62:
;        pv = pvPortMalloc( xNum * xSize );
	lda	<L60+xNum_0
	ldx	<L60+xSize_0
	xref	_~~mul
	jsr	_~~mul
	pha
	jsr	_~pvPortMalloc
	sta	<L61+pv_1
	stx	<L61+pv_1+2
;
;        if( pv != NULL )
;        {
	ora	<L61+pv_1+2
	beq	L10065
;            ( void ) memset( pv, 0, xNum * xSize );
	lda	<L60+xNum_0
	ldx	<L60+xSize_0
	xref	_~~mul
	jsr	_~~mul
	pha
	pea	#<$0
	pei	<L61+pv_1+2
	pei	<L61+pv_1
	jsr	_~memset
;        }
;    }
;
;    return pv;
L10065:
	ldx	<L61+pv_1+2
	lda	<L61+pv_1
	tay
	lda	<L60+1
	sta	<L60+1+4
	pld
	tsc
	clc
	adc	#L60+4
	tcs
	tya
	rts
;}
L60	equ	8
L61	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static void prvHeapInit( void ) /* PRIVILEGED_FUNCTION */
;{
	code
	func
_~prvHeapInit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L67
	tcs
	phd
	tcd
;    BlockLink_t * pxFirstFreeBlock;
;    portPOINTER_SIZE_TYPE uxStartAddress, uxEndAddress;
;    size_t xTotalHeapSize = configTOTAL_HEAP_SIZE_STACK;
;
;    /* Ensure the heap starts on a correctly aligned boundary. */
;    uxStartAddress = ( portPOINTER_SIZE_TYPE ) ucHeapStack;
pxFirstFreeBlock_1	set	0
uxStartAddress_1	set	4
uxEndAddress_1	set	8
xTotalHeapSize_1	set	12
	lda	#$e000
	sta	<L68+xTotalHeapSize_1
	lda	|_~ucHeapStack
	sta	<L68+uxStartAddress_1
	lda	|_~ucHeapStack+2
	sta	<L68+uxStartAddress_1+2
;
;    if( ( uxStartAddress & portBYTE_ALIGNMENT_MASK ) != 0 )
;    {
;        uxStartAddress += ( portBYTE_ALIGNMENT - 1 );
;        uxStartAddress &= ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK );
;        xTotalHeapSize -= ( size_t ) ( uxStartAddress - ( portPOINTER_SIZE_TYPE ) ucHeapStack );
;    }
;
;    #if ( configENABLE_HEAP_PROTECTOR == 1 )
;    {
;        vApplicationGetRandomHeapCanary( &( xHeapCanary ) );
;    }
;    #endif
;
;    /* xStart is used to hold a pointer to the first item in the list of free
;     * blocks.  The void cast is used to prevent compiler warnings. */
;    xStart.pxNextFreeBlock = ( void * ) heapPROTECT_BLOCK_POINTER( uxStartAddress );
	lda	<L68+uxStartAddress_1
	sta	|_~xStart
	lda	<L68+uxStartAddress_1+2
	sta	|_~xStart+2
;    xStart.xBlockSize = ( size_t ) 0;
	stz	|_~xStart+4
;	
;    /* pxEnd is used to mark the end of the list of free blocks and is inserted
;     * at the end of the heap space. */
;    uxEndAddress = uxStartAddress + ( portPOINTER_SIZE_TYPE ) xTotalHeapSize;
	lda	<L68+xTotalHeapSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L68+uxStartAddress_1
	sta	<L68+uxEndAddress_1
	lda	<R0+2
	adc	<L68+uxStartAddress_1+2
	sta	<L68+uxEndAddress_1+2
;    uxEndAddress -= ( portPOINTER_SIZE_TYPE ) xHeapStructSize;
	lda	#$fffa
	clc
	adc	<L68+uxEndAddress_1
	sta	<L68+uxEndAddress_1
	lda	#$ffff
	adc	<L68+uxEndAddress_1+2
	sta	<L68+uxEndAddress_1+2
;    uxEndAddress &= ~( ( portPOINTER_SIZE_TYPE ) portBYTE_ALIGNMENT_MASK );
	lda	<L68+uxEndAddress_1
	sta	<L68+uxEndAddress_1
	lda	<L68+uxEndAddress_1+2
	sta	<L68+uxEndAddress_1+2
;    pxEnd = ( BlockLink_t * ) uxEndAddress;
	lda	<L68+uxEndAddress_1
	sta	|_~pxEnd
	lda	<L68+uxEndAddress_1+2
	sta	|_~pxEnd+2
;    pxEnd->xBlockSize = 0;
	lda	|_~pxEnd
	sta	<R0
	lda	|_~pxEnd+2
	sta	<R0+2
	lda	#$0
	ldy	#$4
	sta	[<R0],Y
;    pxEnd->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( NULL );
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
;    /* To start with there is a single free block that is sized to take up the
;     * entire heap space, minus the space taken by pxEnd. */
;    pxFirstFreeBlock = ( BlockLink_t * ) uxStartAddress;
	lda	<L68+uxStartAddress_1
	sta	<L68+pxFirstFreeBlock_1
	lda	<L68+uxStartAddress_1+2
	sta	<L68+pxFirstFreeBlock_1+2
;    pxFirstFreeBlock->xBlockSize = ( size_t ) ( uxEndAddress - ( portPOINTER_SIZE_TYPE ) pxFirstFreeBlock );
	sec
	lda	<L68+uxEndAddress_1
	sbc	<L68+pxFirstFreeBlock_1
	sta	<R0
	lda	<L68+uxEndAddress_1+2
	sbc	<L68+pxFirstFreeBlock_1+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L68+pxFirstFreeBlock_1],Y
;    pxFirstFreeBlock->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxEnd );
	lda	|_~pxEnd
	sta	[<L68+pxFirstFreeBlock_1]
	lda	|_~pxEnd+2
	dey
	dey
	sta	[<L68+pxFirstFreeBlock_1],Y
;
;    /* Only one block exists - and it covers the entire usable heap space. */
;    xMinimumEverFreeBytesRemaining = pxFirstFreeBlock->xBlockSize;
	iny
	iny
	lda	[<L68+pxFirstFreeBlock_1],Y
	sta	|_~xMinimumEverFreeBytesRemaining
;    xFreeBytesRemaining = pxFirstFreeBlock->xBlockSize;
	lda	[<L68+pxFirstFreeBlock_1],Y
	sta	|_~xFreeBytesRemaining
;}
	pld
	tsc
	clc
	adc	#L67
	tcs
	rts
L67	equ	18
L68	equ	5
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
	sbc	#L70
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
	sta	<L71+pxIterator_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	bra	L20000
;    {
;        /* Nothing to do here, just iterate to the right position. */
;    }
L10068:
	lda	[<L71+pxIterator_1]
	sta	<R0
	ldy	#$2
	lda	[<L71+pxIterator_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L71+pxIterator_1
	lda	<R0+2
L20000:
	sta	<L71+pxIterator_1+2
	lda	[<L71+pxIterator_1]
	cmp	<L70+pxBlockToInsert_0
	ldy	#$2
	lda	[<L71+pxIterator_1],Y
	sbc	<L70+pxBlockToInsert_0+2
	bcc	L10068
;
;    if( pxIterator != &xStart )
;    {
	lda	#<_~xStart
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<L71+pxIterator_1
	cmp	<R0
	bne	L73
	lda	<L71+pxIterator_1+2
	cmp	<R0+2
L73:
	beq	L10072
;        heapVALIDATE_BLOCK_POINTER( pxIterator );
	lda	<L71+pxIterator_1
	cmp	|_~ucHeapStack
	lda	<L71+pxIterator_1+2
	sbc	|_~ucHeapStack+2
	bcc	L75
	lda	#$dfff
	clc
	adc	|_~ucHeapStack
	sta	<R0
	lda	#$0
	adc	|_~ucHeapStack+2
	sta	<R0+2
	lda	<R0
	cmp	<L71+pxIterator_1
	lda	<R0+2
	sbc	<L71+pxIterator_1+2
	bcs	L10072
L75:
	asmstart
	sei
	asmend
L10074:
	bra	L10074
;    }
;
;    /* Do the block being inserted, and the block it is being inserted after
;     * make a contiguous block of memory? */
;    puc = ( uint8_t * ) pxIterator;
L10072:
	lda	<L71+pxIterator_1
	sta	<L71+puc_1
	lda	<L71+pxIterator_1+2
	sta	<L71+puc_1+2
;
;    if( ( puc + pxIterator->xBlockSize ) == ( uint8_t * ) pxBlockToInsert )
;    {
	ldy	#$4
	lda	[<L71+pxIterator_1],Y
	sta	<R0
	stz	<R0+2
	lda	<L71+puc_1
	clc
	adc	<R0
	sta	<R1
	lda	<L71+puc_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<L70+pxBlockToInsert_0
	cmp	<R1
	bne	L78
	lda	<L70+pxBlockToInsert_0+2
	cmp	<R1+2
L78:
	bne	L10078
;        pxIterator->xBlockSize += pxBlockToInsert->xBlockSize;
	lda	#$4
	clc
	adc	<L71+pxIterator_1
	sta	<R0
	lda	#$0
	adc	<L71+pxIterator_1+2
	sta	<R0+2
	clc
	lda	[<R0]
	ldy	#$4
	adc	[<L70+pxBlockToInsert_0],Y
	sta	[<R0]
;        pxBlockToInsert = pxIterator;
	lda	<L71+pxIterator_1
	sta	<L70+pxBlockToInsert_0
	lda	<L71+pxIterator_1+2
	sta	<L70+pxBlockToInsert_0+2
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
	lda	<L70+pxBlockToInsert_0
	sta	<L71+puc_1
	lda	<L70+pxBlockToInsert_0+2
	sta	<L71+puc_1+2
;
;    if( ( puc + pxBlockToInsert->xBlockSize ) == ( uint8_t * ) heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) )
;    {
	ldy	#$4
	lda	[<L70+pxBlockToInsert_0],Y
	sta	<R0
	stz	<R0+2
	lda	<L71+puc_1
	clc
	adc	<R0
	sta	<R1
	lda	<L71+puc_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<L71+pxIterator_1]
	cmp	<R1
	bne	L80
	dey
	dey
	lda	[<L71+pxIterator_1],Y
	cmp	<R1+2
L80:
	bne	L10079
;        if( heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock ) != pxEnd )
;        {
	lda	[<L71+pxIterator_1]
	cmp	|_~pxEnd
	bne	L82
	ldy	#$2
	lda	[<L71+pxIterator_1],Y
	cmp	|_~pxEnd+2
L82:
	beq	L10080
;            /* Form one big block from the two blocks. */
;            pxBlockToInsert->xBlockSize += heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock )->xBlockSize;
	lda	[<L71+pxIterator_1]
	sta	<R0
	ldy	#$2
	lda	[<L71+pxIterator_1],Y
	sta	<R0+2
	lda	#$4
	clc
	adc	<L70+pxBlockToInsert_0
	sta	<R1
	lda	#$0
	adc	<L70+pxBlockToInsert_0+2
	sta	<R1+2
	clc
	lda	[<R1]
	iny
	iny
	adc	[<R0],Y
	sta	[<R1]
;            pxBlockToInsert->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxIterator->pxNextFreeBlock )->pxNextFreeBlock;
	lda	[<L71+pxIterator_1]
	sta	<R0
	dey
	dey
	lda	[<L71+pxIterator_1],Y
	sta	<R0+2
	lda	[<R0]
	sta	[<L70+pxBlockToInsert_0]
	lda	[<R0],Y
	bra	L20002
;        }
;        else
L10080:
;        {
;            pxBlockToInsert->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxEnd );
	lda	|_~pxEnd
	sta	[<L70+pxBlockToInsert_0]
	lda	|_~pxEnd+2
	bra	L20002
;        }
;    }
;    else
L10079:
;    {
;        pxBlockToInsert->pxNextFreeBlock = pxIterator->pxNextFreeBlock;
	lda	[<L71+pxIterator_1]
	sta	[<L70+pxBlockToInsert_0]
	ldy	#$2
	lda	[<L71+pxIterator_1],Y
L20002:
	ldy	#$2
	sta	[<L70+pxBlockToInsert_0],Y
;    }
;
;    /* If the block being inserted plugged a gap, so was merged with the block
;     * before and the block after, then it's pxNextFreeBlock pointer will have
;     * already been set, and should not be set here as that would make it point
;     * to itself. */
;    if( pxIterator != pxBlockToInsert )
;    {
	lda	<L71+pxIterator_1
	cmp	<L70+pxBlockToInsert_0
	bne	L84
	lda	<L71+pxIterator_1+2
	cmp	<L70+pxBlockToInsert_0+2
L84:
	beq	L86
;        pxIterator->pxNextFreeBlock = heapPROTECT_BLOCK_POINTER( pxBlockToInsert );
	lda	<L70+pxBlockToInsert_0
	sta	[<L71+pxIterator_1]
	lda	<L70+pxBlockToInsert_0+2
	ldy	#$2
	sta	[<L71+pxIterator_1],Y
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L86:
	lda	<L70+1
	sta	<L70+1+4
	pld
	tsc
	clc
	adc	#L70+4
	tcs
	rts
L70	equ	16
L71	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vPortGetHeapStatsStack( HeapStats_t * pxHeapStats )
;{
	code
	xdef	_~vPortGetHeapStatsStack
	func
_~vPortGetHeapStatsStack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L87
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
	stz	<L88+xBlocks_1
	stz	<L88+xMaxSize_1
	lda	#$ffff
	sta	<L88+xMinSize_1
	jsr	_~vTaskSuspendAll
;    {
;        pxBlock = heapPROTECT_BLOCK_POINTER( xStart.pxNextFreeBlock );
	lda	|_~xStart
	sta	<L88+pxBlock_1
	lda	|_~xStart+2
	sta	<L88+pxBlock_1+2
;
;        /* pxBlock will be NULL if the heap has not been initialised.  The heap
;         * is initialised automatically when the first allocation is made. */
;        if( pxBlock != NULL )
;        {
	lda	<L88+pxBlock_1
	ora	<L88+pxBlock_1+2
	bne	L10086
;            while( pxBlock != pxEnd )
	bra	L10085
L20004:
;            {
;                /* Increment the number of blocks and record the largest block seen
;                 * so far. */
;                xBlocks++;
	inc	<L88+xBlocks_1
;
;                if( pxBlock->xBlockSize > xMaxSize )
;                {
	lda	<L88+xMaxSize_1
	ldy	#$4
	cmp	[<L88+pxBlock_1],Y
	bcs	L10088
;                    xMaxSize = pxBlock->xBlockSize;
	lda	[<L88+pxBlock_1],Y
	sta	<L88+xMaxSize_1
;                }
;
;                if( pxBlock->xBlockSize < xMinSize )
L10088:
;                {
	ldy	#$4
	lda	[<L88+pxBlock_1],Y
	cmp	<L88+xMinSize_1
	bcs	L10089
;                    xMinSize = pxBlock->xBlockSize;
	lda	[<L88+pxBlock_1],Y
	sta	<L88+xMinSize_1
;                }
;
;                /* Move to the next block in the chain until the last block is
;                 * reached. */
;                pxBlock = heapPROTECT_BLOCK_POINTER( pxBlock->pxNextFreeBlock );
L10089:
	lda	[<L88+pxBlock_1]
	sta	<R0
	ldy	#$2
	lda	[<L88+pxBlock_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L88+pxBlock_1
	lda	<R0+2
	sta	<L88+pxBlock_1+2
;            }
L10086:
	lda	<L88+pxBlock_1
	cmp	|_~pxEnd
	bne	L90
	lda	<L88+pxBlock_1+2
	cmp	|_~pxEnd+2
L90:
	bne	L20004
;        }
;    }
L10085:
;    ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;
;    pxHeapStats->xSizeOfLargestFreeBlockInBytes = xMaxSize;
	lda	<L88+xMaxSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L87+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
;    pxHeapStats->xSizeOfSmallestFreeBlockInBytes = xMinSize;
	lda	<L88+xMinSize_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
;    pxHeapStats->xNumberOfFreeBlocks = xBlocks;
	lda	<L88+xBlocks_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
;
;    taskENTER_CRITICAL();
	asmstart
	sei
	asmend
;    {
;        pxHeapStats->xAvailableHeapSpaceInBytes = xFreeBytesRemaining;
	lda	|_~xFreeBytesRemaining
	sta	<R0
	stz	<R0+2
	lda	<R0
	sta	[<L87+pxHeapStats_0]
	lda	<R0+2
	ldy	#$2
	sta	[<L87+pxHeapStats_0],Y
;        pxHeapStats->xNumberOfSuccessfulAllocations = xNumberOfSuccessfulAllocations;
	lda	|_~xNumberOfSuccessfulAllocations
	sta	<R0
	stz	<R0+2
	lda	<R0
	ldy	#$14
	sta	[<L87+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
;        pxHeapStats->xNumberOfSuccessfulFrees = xNumberOfSuccessfulFrees;
	lda	|_~xNumberOfSuccessfulFrees
	sta	<R0
	stz	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
;        pxHeapStats->xMinimumEverFreeBytesRemaining = xMinimumEverFreeBytesRemaining;
	lda	|_~xMinimumEverFreeBytesRemaining
	sta	<R0
	stz	<R0+2
	lda	<R0
	ldy	#$10
	sta	[<L87+pxHeapStats_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L87+pxHeapStats_0],Y
;    }
;    taskEXIT_CRITICAL();
	asmstart
	cli
	asmend
;}
	lda	<L87+1
	sta	<L87+1+4
	pld
	tsc
	clc
	adc	#L87+4
	tcs
	rts
L87	equ	14
L88	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;/*
; * Reset the state in this file. This state is normally initialized at start up.
; * This function must be called by the application before restarting the
; * scheduler.
; */
;void vPortHeapResetStateStack( void )
;{
	code
	xdef	_~vPortHeapResetStateStack
	func
_~vPortHeapResetStateStack:
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
;}
	rts
L95	equ	0
L96	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~pvPortMalloc
	xref	_~memset
	xref	_~debug_hex
	xref	_~debug_char
	udata
_~xStart
	ds	6
	ends
	xref	_~ucHeapStack

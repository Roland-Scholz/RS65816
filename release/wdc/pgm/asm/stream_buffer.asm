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
;#include "stream_buffer.h"
;
;/* The MPU ports require MPU_WRAPPERS_INCLUDED_FROM_API_FILE to be defined
; * for the header files above, but not in this file, in order to generate the
; * correct privileged Vs unprivileged linkage and placement. */
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;/* This entire source file will be skipped if the application is not configured
; * to include stream buffer functionality. This #if is closed at the very bottom
; * of this file. If you want to include stream buffers then ensure
; * configUSE_STREAM_BUFFERS is set to 1 in FreeRTOSConfig.h. */
;#if ( configUSE_STREAM_BUFFERS == 1 )
;
;    #if ( configUSE_TASK_NOTIFICATIONS != 1 )
;        #error configUSE_TASK_NOTIFICATIONS must be set to 1 to build stream_buffer.c
;    #endif
;
;    #if ( INCLUDE_xTaskGetCurrentTaskHandle != 1 )
;        #error INCLUDE_xTaskGetCurrentTaskHandle must be set to 1 to build stream_buffer.c
;    #endif
;
;/* If the user has not provided application specific Rx notification macros,
; * or #defined the notification macros away, then provide default implementations
; * that uses task notifications. */
;    #ifndef sbRECEIVE_COMPLETED
;        #define sbRECEIVE_COMPLETED( pxStreamBuffer )                                 \
;    do                                                                                \
;    {                                                                                 \
;        vTaskSuspendAll();                                                            \
;        {                                                                             \
;            if( ( pxStreamBuffer )->xTaskWaitingToSend != NULL )                      \
;            {                                                                         \
;                ( void ) xTaskNotifyIndexed( ( pxStreamBuffer )->xTaskWaitingToSend,  \
;                                             ( pxStreamBuffer )->uxNotificationIndex, \
;                                             ( uint32_t ) 0,                          \
;                                             eNoAction );                             \
;                ( pxStreamBuffer )->xTaskWaitingToSend = NULL;                        \
;            }                                                                         \
;        }                                                                             \
;        ( void ) xTaskResumeAll();                                                    \
;    } while( 0 )
;    #endif /* sbRECEIVE_COMPLETED */
;
;/* If user has provided a per-instance receive complete callback, then
; * invoke the callback else use the receive complete macro which is provided by default for all instances.
; */
;    #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;        #define prvRECEIVE_COMPLETED( pxStreamBuffer )                                           \
;    do {                                                                                         \
;        if( ( pxStreamBuffer )->pxReceiveCompletedCallback != NULL )                             \
;        {                                                                                        \
;            ( pxStreamBuffer )->pxReceiveCompletedCallback( ( pxStreamBuffer ), pdFALSE, NULL ); \
;        }                                                                                        \
;        else                                                                                     \
;        {                                                                                        \
;            sbRECEIVE_COMPLETED( ( pxStreamBuffer ) );                                           \
;        }                                                                                        \
;    } while( 0 )
;    #else /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;        #define prvRECEIVE_COMPLETED( pxStreamBuffer )    sbRECEIVE_COMPLETED( ( pxStreamBuffer ) )
;    #endif /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;
;    #ifndef sbRECEIVE_COMPLETED_FROM_ISR
;        #define sbRECEIVE_COMPLETED_FROM_ISR( pxStreamBuffer,                                \
;                                              pxHigherPriorityTaskWoken )                    \
;    do {                                                                                     \
;        UBaseType_t uxSavedInterruptStatus;                                                  \
;                                                                                             \
;        uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();                              \
;        {                                                                                    \
;            if( ( pxStreamBuffer )->xTaskWaitingToSend != NULL )                             \
;            {                                                                                \
;                ( void ) xTaskNotifyIndexedFromISR( ( pxStreamBuffer )->xTaskWaitingToSend,  \
;                                                    ( pxStreamBuffer )->uxNotificationIndex, \
;                                                    ( uint32_t ) 0,                          \
;                                                    eNoAction,                               \
;                                                    ( pxHigherPriorityTaskWoken ) );         \
;                ( pxStreamBuffer )->xTaskWaitingToSend = NULL;                               \
;            }                                                                                \
;        }                                                                                    \
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );                                \
;    } while( 0 )
;    #endif /* sbRECEIVE_COMPLETED_FROM_ISR */
;
;    #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;        #define prvRECEIVE_COMPLETED_FROM_ISR( pxStreamBuffer,                                                           \
;                                               pxHigherPriorityTaskWoken )                                               \
;    do {                                                                                                                 \
;        if( ( pxStreamBuffer )->pxReceiveCompletedCallback != NULL )                                                     \
;        {                                                                                                                \
;            ( pxStreamBuffer )->pxReceiveCompletedCallback( ( pxStreamBuffer ), pdTRUE, ( pxHigherPriorityTaskWoken ) ); \
;        }                                                                                                                \
;        else                                                                                                             \
;        {                                                                                                                \
;            sbRECEIVE_COMPLETED_FROM_ISR( ( pxStreamBuffer ), ( pxHigherPriorityTaskWoken ) );                           \
;        }                                                                                                                \
;    } while( 0 )
;    #else /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;        #define prvRECEIVE_COMPLETED_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken ) \
;    sbRECEIVE_COMPLETED_FROM_ISR( ( pxStreamBuffer ), ( pxHigherPriorityTaskWoken ) )
;    #endif /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;
;/* If the user has not provided an application specific Tx notification macro,
; * or #defined the notification macro away, then provide a default
; * implementation that uses task notifications.
; */
;    #ifndef sbSEND_COMPLETED
;        #define sbSEND_COMPLETED( pxStreamBuffer )                                  \
;    vTaskSuspendAll();                                                              \
;    {                                                                               \
;        if( ( pxStreamBuffer )->xTaskWaitingToReceive != NULL )                     \
;        {                                                                           \
;            ( void ) xTaskNotifyIndexed( ( pxStreamBuffer )->xTaskWaitingToReceive, \
;                                         ( pxStreamBuffer )->uxNotificationIndex,   \
;                                         ( uint32_t ) 0,                            \
;                                         eNoAction );                               \
;            ( pxStreamBuffer )->xTaskWaitingToReceive = NULL;                       \
;        }                                                                           \
;    }                                                                               \
;    ( void ) xTaskResumeAll()
;    #endif /* sbSEND_COMPLETED */
;
;/* If user has provided a per-instance send completed callback, then
; * invoke the callback else use the send complete macro which is provided by default for all instances.
; */
;    #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;        #define prvSEND_COMPLETED( pxStreamBuffer )                                           \
;    do {                                                                                      \
;        if( ( pxStreamBuffer )->pxSendCompletedCallback != NULL )                             \
;        {                                                                                     \
;            ( pxStreamBuffer )->pxSendCompletedCallback( ( pxStreamBuffer ), pdFALSE, NULL ); \
;        }                                                                                     \
;        else                                                                                  \
;        {                                                                                     \
;            sbSEND_COMPLETED( ( pxStreamBuffer ) );                                           \
;        }                                                                                     \
;    } while( 0 )
;    #else /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;        #define prvSEND_COMPLETED( pxStreamBuffer )    sbSEND_COMPLETED( ( pxStreamBuffer ) )
;    #endif /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;
;
;    #ifndef sbSEND_COMPLETE_FROM_ISR
;        #define sbSEND_COMPLETE_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken )          \
;    do {                                                                                       \
;        UBaseType_t uxSavedInterruptStatus;                                                    \
;                                                                                               \
;        uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();                                \
;        {                                                                                      \
;            if( ( pxStreamBuffer )->xTaskWaitingToReceive != NULL )                            \
;            {                                                                                  \
;                ( void ) xTaskNotifyIndexedFromISR( ( pxStreamBuffer )->xTaskWaitingToReceive, \
;                                                    ( pxStreamBuffer )->uxNotificationIndex,   \
;                                                    ( uint32_t ) 0,                            \
;                                                    eNoAction,                                 \
;                                                    ( pxHigherPriorityTaskWoken ) );           \
;                ( pxStreamBuffer )->xTaskWaitingToReceive = NULL;                              \
;            }                                                                                  \
;        }                                                                                      \
;        taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );                                  \
;    } while( 0 )
;    #endif /* sbSEND_COMPLETE_FROM_ISR */
;
;
;    #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;        #define prvSEND_COMPLETE_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken )                                \
;    do {                                                                                                              \
;        if( ( pxStreamBuffer )->pxSendCompletedCallback != NULL )                                                     \
;        {                                                                                                             \
;            ( pxStreamBuffer )->pxSendCompletedCallback( ( pxStreamBuffer ), pdTRUE, ( pxHigherPriorityTaskWoken ) ); \
;        }                                                                                                             \
;        else                                                                                                          \
;        {                                                                                                             \
;            sbSEND_COMPLETE_FROM_ISR( ( pxStreamBuffer ), ( pxHigherPriorityTaskWoken ) );                            \
;        }                                                                                                             \
;    } while( 0 )
;    #else /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;        #define prvSEND_COMPLETE_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken ) \
;    sbSEND_COMPLETE_FROM_ISR( ( pxStreamBuffer ), ( pxHigherPriorityTaskWoken ) )
;    #endif /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;
;/* The number of bytes used to hold the length of a message in the buffer. */
;    #define sbBYTES_TO_STORE_MESSAGE_LENGTH    ( sizeof( configMESSAGE_BUFFER_LENGTH_TYPE ) )
;
;/* Bits stored in the ucFlags field of the stream buffer. */
;    #define sbFLAGS_IS_MESSAGE_BUFFER          ( ( uint8_t ) 1 ) /* Set if the stream buffer was created as a message buffer, in which case it holds discrete messages rather than a stream. */
;    #define sbFLAGS_IS_STATICALLY_ALLOCATED    ( ( uint8_t ) 2 ) /* Set if the stream buffer was created using statically allocated memory. */
;    #define sbFLAGS_IS_BATCHING_BUFFER         ( ( uint8_t ) 4 ) /* Set if the stream buffer was created as a batching buffer, meaning the receiver task will only unblock when the trigger level exceededs. */
;
;/*-----------------------------------------------------------*/
;
;/* Structure that hold state information on the buffer. */
;typedef struct StreamBufferDef_t
;{
;    volatile size_t xTail;                       /* Index to the next item to read within the buffer. */
;    volatile size_t xHead;                       /* Index to the next item to write within the buffer. */
;    size_t xLength;                              /* The length of the buffer pointed to by pucBuffer. */
;    size_t xTriggerLevelBytes;                   /* The number of bytes that must be in the stream buffer before a task that is waiting for data is unblocked. */
;    volatile TaskHandle_t xTaskWaitingToReceive; /* Holds the handle of a task waiting for data, or NULL if no tasks are waiting. */
;    volatile TaskHandle_t xTaskWaitingToSend;    /* Holds the handle of a task waiting to send data to a message buffer that is full. */
;    uint8_t * pucBuffer;                         /* Points to the buffer itself - that is - the RAM that stores the data passed through the buffer. */
;    uint8_t ucFlags;
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;        UBaseType_t uxStreamBufferNumber; /* Used for tracing purposes. */
;    #endif
;
;    #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;        StreamBufferCallbackFunction_t pxSendCompletedCallback;    /* Optional callback called on send complete. sbSEND_COMPLETED is called if this is NULL. */
;        StreamBufferCallbackFunction_t pxReceiveCompletedCallback; /* Optional callback called on receive complete.  sbRECEIVE_COMPLETED is called if this is NULL. */
;    #endif
;    UBaseType_t uxNotificationIndex;                               /* The index we are using for notification, by default tskDEFAULT_INDEX_TO_NOTIFY. */
;} StreamBuffer_t;
;
;/*
; * The number of bytes available to be read from the buffer.
; */
;static size_t prvBytesInBuffer( const StreamBuffer_t * const pxStreamBuffer ) PRIVILEGED_FUNCTION;
;
;/*
; * Returns pdTRUE when the amount of buffered data should unblock a task that
; * is waiting to receive data. Stream batching buffers require the buffered
; * data to exceed the trigger level, whereas stream and message buffers unblock
; * when the trigger level is reached.
; */
;static BaseType_t prvBytesInBufferMeetTriggerLevel( const StreamBuffer_t * const pxStreamBuffer,
;                                                    size_t xBytesInBuffer ) PRIVILEGED_FUNCTION;
;
;/*
; * Add xCount bytes from pucData into the pxStreamBuffer's data storage area.
; * This function does not update the buffer's xHead pointer, so multiple writes
; * may be chained together "atomically". This is useful for Message Buffers where
; * the length and data bytes are written in two separate chunks, and we don't want
; * the reader to see the buffer as having grown until after all data is copied over.
; * This function takes a custom xHead value to indicate where to write to (necessary
; * for chaining) and returns the resulting xHead position.
; * To mark the write as complete, manually set the buffer's xHead field with the
; * returned xHead from this function.
; */
;static size_t prvWriteBytesToBuffer( StreamBuffer_t * const pxStreamBuffer,
;                                     const uint8_t * pucData,
;                                     size_t xCount,
;                                     size_t xHead ) PRIVILEGED_FUNCTION;
;
;/*
; * If the stream buffer is being used as a message buffer, then reads an entire
; * message out of the buffer.  If the stream buffer is being used as a stream
; * buffer then read as many bytes as possible from the buffer.
; * prvReadBytesFromBuffer() is called to actually extract the bytes from the
; * buffer's data storage area.
; */
;static size_t prvReadMessageFromBuffer( StreamBuffer_t * pxStreamBuffer,
;                                        void * pvRxData,
;                                        size_t xBufferLengthBytes,
;                                        size_t xBytesAvailable ) PRIVILEGED_FUNCTION;
;
;/*
; * If the stream buffer is being used as a message buffer, then writes an entire
; * message to the buffer.  If the stream buffer is being used as a stream
; * buffer then write as many bytes as possible to the buffer.
; * prvWriteBytestoBuffer() is called to actually send the bytes to the buffer's
; * data storage area.
; */
;static size_t prvWriteMessageToBuffer( StreamBuffer_t * const pxStreamBuffer,
;                                       const void * pvTxData,
;                                       size_t xDataLengthBytes,
;                                       size_t xSpace,
;                                       size_t xRequiredSpace ) PRIVILEGED_FUNCTION;
;
;/*
; * Copies xCount bytes from the pxStreamBuffer's data storage area to pucData.
; * This function does not update the buffer's xTail pointer, so multiple reads
; * may be chained together "atomically". This is useful for Message Buffers where
; * the length and data bytes are read in two separate chunks, and we don't want
; * the writer to see the buffer as having more free space until after all data is
; * copied over, especially if we have to abort the read due to insufficient receiving space.
; * This function takes a custom xTail value to indicate where to read from (necessary
; * for chaining) and returns the resulting xTail position.
; * To mark the read as complete, manually set the buffer's xTail field with the
; * returned xTail from this function.
; */
;static size_t prvReadBytesFromBuffer( StreamBuffer_t * pxStreamBuffer,
;                                      uint8_t * pucData,
;                                      size_t xCount,
;                                      size_t xTail ) PRIVILEGED_FUNCTION;
;
;/*
; * Called by both pxStreamBufferCreate() and pxStreamBufferCreateStatic() to
; * initialise the members of the newly created stream buffer structure.
; */
;static void prvInitialiseNewStreamBuffer( StreamBuffer_t * const pxStreamBuffer,
;                                          uint8_t * const pucBuffer,
;                                          size_t xBufferSizeBytes,
;                                          size_t xTriggerLevelBytes,
;                                          uint8_t ucFlags,
;                                          StreamBufferCallbackFunction_t pxSendCompletedCallback,
;                                          StreamBufferCallbackFunction_t pxReceiveCompletedCallback ) PRIVILEGED_FUNCTION;
;
;/*-----------------------------------------------------------*/
;    #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;    StreamBufferHandle_t xStreamBufferGenericCreate( size_t xBufferSizeBytes,
;                                                     size_t xTriggerLevelBytes,
;                                                     BaseType_t xStreamBufferType,
;                                                     StreamBufferCallbackFunction_t pxSendCompletedCallback,
;                                                     StreamBufferCallbackFunction_t pxReceiveCompletedCallback )
;    {
	code
	xdef	_~xStreamBufferGenericCreate
	func
_~xStreamBufferGenericCreate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
xBufferSizeBytes_0	set	3
xTriggerLevelBytes_0	set	5
xStreamBufferType_0	set	7
pxSendCompletedCallback_0	set	9
pxReceiveCompletedCallback_0	set	11
;        void * pvAllocatedMemory;
;        uint8_t ucFlags;
;
;        traceENTER_xStreamBufferGenericCreate( xBufferSizeBytes, xTriggerLevelBytes, xStreamBufferType, pxSendCompletedCallback, pxReceiveCompletedCallback );
pvAllocatedMemory_1	set	0
ucFlags_1	set	4
;
;        /* In case the stream buffer is going to be used as a message buffer
;         * (that is, it will hold discrete messages with a little meta data that
;         * says how big the next message is) check the buffer will be large enough
;         * to hold at least one message. */
;        if( xStreamBufferType == sbTYPE_MESSAGE_BUFFER )
;        {
	lda	<L2+xStreamBufferType_0
	cmp	#<$1
	bne	L10001
;            /* Is a message buffer but not statically allocated. */
;            ucFlags = sbFLAGS_IS_MESSAGE_BUFFER;
	sep	#$20
	longa	off
	lda	#$1
	sta	<L3+ucFlags_1
	rep	#$20
	longa	on
;            configASSERT( xBufferSizeBytes > sbBYTES_TO_STORE_MESSAGE_LENGTH );
	lda	#$2
	cmp	<L2+xBufferSizeBytes_0
	bcc	L10009
L10006:
	bra	L10006
L10001:
;        {
	lda	<L2+xStreamBufferType_0
	cmp	#<$2
	bne	L10010
;            /* Is a batching buffer but not statically allocated. */
;            ucFlags = sbFLAGS_IS_BATCHING_BUFFER;
	sep	#$20
	longa	off
	lda	#$4
	sta	<L3+ucFlags_1
	rep	#$20
	longa	on
;            configASSERT( xBufferSizeBytes > 0 );
	lda	#$0
	cmp	<L2+xBufferSizeBytes_0
	bcc	L10009
L10015:
	bra	L10015
;        }
;        else
;        }
;        else if( xStreamBufferType == sbTYPE_STREAM_BATCHING_BUFFER )
L10009:
;
;        configASSERT( xTriggerLevelBytes <= xBufferSizeBytes );
	lda	<L2+xBufferSizeBytes_0
	cmp	<L2+xTriggerLevelBytes_0
	bcc	L10030
;
;        /* A trigger level of 0 would cause a waiting task to unblock even when
;         * the buffer was empty. */
;        if( xTriggerLevelBytes == ( size_t ) 0 )
;        {
	lda	<L2+xTriggerLevelBytes_0
	beq	L10
	bra	L10033
L10010:
;        {
;            /* Not a message buffer and not statically allocated. */
;            ucFlags = 0;
	sep	#$20
	longa	off
	stz	<L3+ucFlags_1
	rep	#$20
	longa	on
;            configASSERT( xBufferSizeBytes > 0 );
	lda	#$0
	cmp	<L2+xBufferSizeBytes_0
	bcc	L10009
L10023:
	bra	L10023
;        }
L10030:
	bra	L10030
L10:
;            xTriggerLevelBytes = ( size_t ) 1;
	lda	#$1
	sta	<L2+xTriggerLevelBytes_0
;        }
;
;        /* A stream buffer requires a StreamBuffer_t structure and a buffer.
;         * Both are allocated in a single call to pvPortMalloc().  The
;         * StreamBuffer_t structure is placed at the start of the allocated memory
;         * and the buffer follows immediately after.  The requested size is
;         * incremented so the free space is returned as the user would expect -
;         * this is a quirk of the implementation that means otherwise the free
;         * space would be reported as one byte smaller than would be logically
;         * expected. */
;        if( xBufferSizeBytes < ( xBufferSizeBytes + 1U + sizeof( StreamBuffer_t ) ) )
L10033:
;        {
	lda	#$18
	clc
	adc	<L2+xBufferSizeBytes_0
	sta	<R0
	lda	<L2+xBufferSizeBytes_0
	cmp	<R0
	bcs	L10034
;            xBufferSizeBytes++;
	inc	<L2+xBufferSizeBytes_0
;            pvAllocatedMemory = pvPortMalloc( xBufferSizeBytes + sizeof( StreamBuffer_t ) );
	lda	#$17
	clc
	adc	<L2+xBufferSizeBytes_0
	pha
	jsr	_~pvPortMalloc
	sta	<L3+pvAllocatedMemory_1
	stx	<L3+pvAllocatedMemory_1+2
;        }
;        else
	bra	L10035
L10034:
;        {
;            pvAllocatedMemory = NULL;
	stz	<L3+pvAllocatedMemory_1
	stz	<L3+pvAllocatedMemory_1+2
;        }
L10035:
;
;        if( pvAllocatedMemory != NULL )
;        {
	lda	<L3+pvAllocatedMemory_1
	ora	<L3+pvAllocatedMemory_1+2
	beq	L10037
;            /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            prvInitialiseNewStreamBuffer( ( StreamBuffer_t * ) pvAllocatedMemory,                         /* Structure at the start of the allocated memory. */
;                                                                                                          /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;                                                                                                          /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;                                                                                                          /* coverity[misra_c_2012_rule_11_5_violation] */
;                                          ( ( uint8_t * ) pvAllocatedMemory ) + sizeof( StreamBuffer_t ), /* Storage area follows. */
;                                          xBufferSizeBytes,
;                                          xTriggerLevelBytes,
;                                          ucFlags,
;                                          pxSendCompletedCallback,
;                                          pxReceiveCompletedCallback );
	pei	<L2+pxReceiveCompletedCallback_0
	pei	<L2+pxSendCompletedCallback_0
	pei	<L3+ucFlags_1
	pei	<L2+xTriggerLevelBytes_0
	pei	<L2+xBufferSizeBytes_0
	lda	#$17
	clc
	adc	<L3+pvAllocatedMemory_1
	sta	<R0
	lda	#$0
	adc	<L3+pvAllocatedMemory_1+2
	pha
	pei	<R0
	pei	<L3+pvAllocatedMemory_1+2
	pei	<L3+pvAllocatedMemory_1
	jsr	_~prvInitialiseNewStreamBuffer
;
;            traceSTREAM_BUFFER_CREATE( ( ( StreamBuffer_t * ) pvAllocatedMemory ), xStreamBufferType );
;        }
;        else
;        {
;            traceSTREAM_BUFFER_CREATE_FAILED( xStreamBufferType );
;        }
L10037:
;
;        traceRETURN_xStreamBufferGenericCreate( pvAllocatedMemory );
;
;        /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        return ( StreamBufferHandle_t ) pvAllocatedMemory;
	ldx	<L3+pvAllocatedMemory_1+2
	lda	<L3+pvAllocatedMemory_1
	tay
	lda	<L2+1
	sta	<L2+1+10
	pld
	tsc
	clc
	adc	#L2+10
	tcs
	tya
	rts
;    }
L2	equ	9
L3	equ	5
	ends
	efunc
;    #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;    StreamBufferHandle_t xStreamBufferGenericCreateStatic( size_t xBufferSizeBytes,
;                                                           size_t xTriggerLevelBytes,
;                                                           BaseType_t xStreamBufferType,
;                                                           uint8_t * const pucStreamBufferStorageArea,
;                                                           StaticStreamBuffer_t * const pxStaticStreamBuffer,
;                                                           StreamBufferCallbackFunction_t pxSendCompletedCallback,
;                                                           StreamBufferCallbackFunction_t pxReceiveCompletedCallback )
;    {
	code
	xdef	_~xStreamBufferGenericCreateStatic
	func
_~xStreamBufferGenericCreateStatic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L14
	tcs
	phd
	tcd
xBufferSizeBytes_0	set	3
xTriggerLevelBytes_0	set	5
xStreamBufferType_0	set	7
pucStreamBufferStorageArea_0	set	9
pxStaticStreamBuffer_0	set	13
pxSendCompletedCallback_0	set	17
pxReceiveCompletedCallback_0	set	19
;        /* MISRA Ref 11.3.1 [Misaligned access] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;        /* coverity[misra_c_2012_rule_11_3_violation] */
;        StreamBuffer_t * const pxStreamBuffer = ( StreamBuffer_t * ) pxStaticStreamBuffer;
;        StreamBufferHandle_t xReturn;
;        uint8_t ucFlags;
;
;        traceENTER_xStreamBufferGenericCreateStatic( xBufferSizeBytes, xTriggerLevelBytes, xStreamBufferType, pucStreamBufferStorageArea, pxStaticStreamBuffer, pxSendCompletedCallback, pxReceiveCompletedCallback );
pxStreamBuffer_1	set	0
xReturn_1	set	4
ucFlags_1	set	8
	lda	<L14+pxStaticStreamBuffer_0
	sta	<L15+pxStreamBuffer_1
	lda	<L14+pxStaticStreamBuffer_0+2
	sta	<L15+pxStreamBuffer_1+2
;
;        configASSERT( pucStreamBufferStorageArea );
	lda	<L14+pucStreamBufferStorageArea_0
	ora	<L14+pucStreamBufferStorageArea_0+2
	bne	L10038
L10042:
	bra	L10042
L10038:
;        configASSERT( pxStaticStreamBuffer );
	lda	<L14+pxStaticStreamBuffer_0
	ora	<L14+pxStaticStreamBuffer_0+2
	bne	L10045
L10049:
	bra	L10049
L10045:
;        configASSERT( xTriggerLevelBytes <= xBufferSizeBytes );
	lda	<L14+xBufferSizeBytes_0
	cmp	<L14+xTriggerLevelBytes_0
	bcs	L10052
L10056:
	bra	L10056
L10052:
;
;        /* A trigger level of 0 would cause a waiting task to unblock even when
;         * the buffer was empty. */
;        if( xTriggerLevelBytes == ( size_t ) 0 )
;        {
	lda	<L14+xTriggerLevelBytes_0
	bne	L10059
;            xTriggerLevelBytes = ( size_t ) 1;
	lda	#$1
	sta	<L14+xTriggerLevelBytes_0
;        }
;
;        /* In case the stream buffer is going to be used as a message buffer
;         * (that is, it will hold discrete messages with a little meta data that
;         * says how big the next message is) check the buffer will be large enough
;         * to hold at least one message. */
;
;        if( xStreamBufferType == sbTYPE_MESSAGE_BUFFER )
L10059:
;        {
	lda	<L14+xStreamBufferType_0
	cmp	#<$1
	bne	L10060
;            /* Statically allocated message buffer. */
;            ucFlags = sbFLAGS_IS_MESSAGE_BUFFER | sbFLAGS_IS_STATICALLY_ALLOCATED;
	sep	#$20
	longa	off
	lda	#$3
	sta	<L15+ucFlags_1
	rep	#$20
	longa	on
;            configASSERT( xBufferSizeBytes > sbBYTES_TO_STORE_MESSAGE_LENGTH );
	lda	#$2
	cmp	<L14+xBufferSizeBytes_0
	bcc	L10068
L10065:
	bra	L10065
;        }
;        else if( xStreamBufferType == sbTYPE_STREAM_BATCHING_BUFFER )
L10060:
;        {
	lda	<L14+xStreamBufferType_0
	cmp	#<$2
	bne	L10069
;            /* Statically allocated batching buffer. */
;            ucFlags = sbFLAGS_IS_BATCHING_BUFFER | sbFLAGS_IS_STATICALLY_ALLOCATED;
	sep	#$20
	longa	off
	lda	#$6
	sta	<L15+ucFlags_1
	rep	#$20
	longa	on
;            configASSERT( xBufferSizeBytes > 0 );
	lda	#$0
	cmp	<L14+xBufferSizeBytes_0
	bcc	L10068
L10074:
	bra	L10074
;        }
;        else
L10069:
;        {
;            /* Statically allocated stream buffer. */
;            ucFlags = sbFLAGS_IS_STATICALLY_ALLOCATED;
	sep	#$20
	longa	off
	lda	#$2
	sta	<L15+ucFlags_1
	rep	#$20
	longa	on
;        }
L10068:
;
;        #if ( configASSERT_DEFINED == 1 )
;        {
;            /* Sanity check that the size of the structure used to declare a
;             * variable of type StaticStreamBuffer_t equals the size of the real
;             * message buffer structure. */
;            volatile size_t xSize = sizeof( StaticStreamBuffer_t );
;            configASSERT( xSize == sizeof( StreamBuffer_t ) );
xSize_2	set	9
	lda	#$17
	sta	<L15+xSize_2
	cmp	#<$17
	beq	L10078
L10082:
	bra	L10082
L10078:
;        }
;        #endif /* configASSERT_DEFINED */
;
;        if( ( pucStreamBufferStorageArea != NULL ) && ( pxStaticStreamBuffer != NULL ) )
;        {
	lda	<L14+pucStreamBufferStorageArea_0
	ora	<L14+pucStreamBufferStorageArea_0+2
	beq	L10085
	lda	<L14+pxStaticStreamBuffer_0
	ora	<L14+pxStaticStreamBuffer_0+2
	beq	L10085
;            prvInitialiseNewStreamBuffer( pxStreamBuffer,
;                                          pucStreamBufferStorageArea,
;                                          xBufferSizeBytes,
;                                          xTriggerLevelBytes,
;                                          ucFlags,
;                                          pxSendCompletedCallback,
;                                          pxReceiveCompletedCallback );
	pei	<L14+pxReceiveCompletedCallback_0
	pei	<L14+pxSendCompletedCallback_0
	pei	<L15+ucFlags_1
	pei	<L14+xTriggerLevelBytes_0
	pei	<L14+xBufferSizeBytes_0
	pei	<L14+pucStreamBufferStorageArea_0+2
	pei	<L14+pucStreamBufferStorageArea_0
	pei	<L15+pxStreamBuffer_1+2
	pei	<L15+pxStreamBuffer_1
	jsr	_~prvInitialiseNewStreamBuffer
;
;            /* Remember this was statically allocated in case it is ever deleted
;             * again. */
;            pxStreamBuffer->ucFlags |= sbFLAGS_IS_STATICALLY_ALLOCATED;
	lda	#$14
	clc
	adc	<L15+pxStreamBuffer_1
	sta	<R0
	lda	#$0
	adc	<L15+pxStreamBuffer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$2
	sta	[<R0]
	rep	#$20
	longa	on
;
;            traceSTREAM_BUFFER_CREATE( pxStreamBuffer, xStreamBufferType );
;
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            xReturn = ( StreamBufferHandle_t ) pxStaticStreamBuffer;
	lda	<L14+pxStaticStreamBuffer_0
	sta	<L15+xReturn_1
	lda	<L14+pxStaticStreamBuffer_0+2
	sta	<L15+xReturn_1+2
;        }
;        else
	bra	L10086
L10085:
;        {
;            xReturn = NULL;
	stz	<L15+xReturn_1
	stz	<L15+xReturn_1+2
;            traceSTREAM_BUFFER_CREATE_STATIC_FAILED( xReturn, xStreamBufferType );
;        }
L10086:
;
;        traceRETURN_xStreamBufferGenericCreateStatic( xReturn );
;
;        return xReturn;
	ldx	<L15+xReturn_1+2
	lda	<L15+xReturn_1
	tay
	lda	<L14+1
	sta	<L14+1+18
	pld
	tsc
	clc
	adc	#L14+18
	tcs
	tya
	rts
;    }
L14	equ	15
L15	equ	5
	ends
	efunc
;    #endif /* ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;    BaseType_t xStreamBufferGetStaticBuffers( StreamBufferHandle_t xStreamBuffer,
;                                              uint8_t ** ppucStreamBufferStorageArea,
;                                              StaticStreamBuffer_t ** ppxStaticStreamBuffer )
;    {
	code
	xdef	_~xStreamBufferGetStaticBuffers
	func
_~xStreamBufferGetStaticBuffers:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
ppucStreamBufferStorageArea_0	set	7
ppxStaticStreamBuffer_0	set	11
;        BaseType_t xReturn;
;        StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;        traceENTER_xStreamBufferGetStaticBuffers( xStreamBuffer, ppucStreamBufferStorageArea, ppxStaticStreamBuffer );
xReturn_1	set	0
pxStreamBuffer_1	set	2
	lda	<L28+xStreamBuffer_0
	sta	<L29+pxStreamBuffer_1
	lda	<L28+xStreamBuffer_0+2
	sta	<L29+pxStreamBuffer_1+2
;
;        configASSERT( pxStreamBuffer );
	lda	<L29+pxStreamBuffer_1
	ora	<L29+pxStreamBuffer_1+2
	bne	L10087
L10091:
	bra	L10091
L10087:
;        configASSERT( ppucStreamBufferStorageArea );
	lda	<L28+ppucStreamBufferStorageArea_0
	ora	<L28+ppucStreamBufferStorageArea_0+2
	bne	L10094
L10098:
	bra	L10098
L10094:
;        configASSERT( ppxStaticStreamBuffer );
	lda	<L28+ppxStaticStreamBuffer_0
	ora	<L28+ppxStaticStreamBuffer_0+2
	bne	L10101
L10105:
	bra	L10105
L10101:
;
;        if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_STATICALLY_ALLOCATED ) != ( uint8_t ) 0 )
;        {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L29+pxStreamBuffer_1],Y
	and	#<$2
	rep	#$20
	longa	on
	beq	L10108
;            *ppucStreamBufferStorageArea = pxStreamBuffer->pucBuffer;
	ldy	#$10
	lda	[<L29+pxStreamBuffer_1],Y
	sta	[<L28+ppucStreamBufferStorageArea_0]
	iny
	iny
	lda	[<L29+pxStreamBuffer_1],Y
	ldy	#$2
	sta	[<L28+ppucStreamBufferStorageArea_0],Y
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            *ppxStaticStreamBuffer = ( StaticStreamBuffer_t * ) pxStreamBuffer;
	lda	<L29+pxStreamBuffer_1
	sta	[<L28+ppxStaticStreamBuffer_0]
	lda	<L29+pxStreamBuffer_1+2
	sta	[<L28+ppxStaticStreamBuffer_0],Y
;            xReturn = pdTRUE;
	lda	#$1
	sta	<L29+xReturn_1
;        }
;        else
	bra	L10109
L10108:
;        {
;            xReturn = pdFALSE;
	stz	<L29+xReturn_1
;        }
L10109:
;
;        traceRETURN_xStreamBufferGetStaticBuffers( xReturn );
;
;        return xReturn;
	lda	<L29+xReturn_1
	tay
	lda	<L28+1
	sta	<L28+1+12
	pld
	tsc
	clc
	adc	#L28+12
	tcs
	tya
	rts
;    }
L28	equ	6
L29	equ	1
	ends
	efunc
;    #endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;void vStreamBufferDelete( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~vStreamBufferDelete
	func
_~vStreamBufferDelete:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_vStreamBufferDelete( xStreamBuffer );
pxStreamBuffer_1	set	0
	lda	<L35+xStreamBuffer_0
	sta	<L36+pxStreamBuffer_1
	lda	<L35+xStreamBuffer_0+2
	sta	<L36+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L36+pxStreamBuffer_1
	ora	<L36+pxStreamBuffer_1+2
	bne	L10110
L10114:
	bra	L10114
L10110:
;
;    traceSTREAM_BUFFER_DELETE( xStreamBuffer );
;
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_STATICALLY_ALLOCATED ) == ( uint8_t ) pdFALSE )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L36+pxStreamBuffer_1],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10117
;        #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;        {
;            /* Both the structure and the buffer were allocated using a single call
;            * to pvPortMalloc(), hence only one call to vPortFree() is required. */
;            vPortFree( ( void * ) pxStreamBuffer );
	pei	<L36+pxStreamBuffer_1+2
	pei	<L36+pxStreamBuffer_1
	jsr	_~vPortFree
;        }
;        #else
;        {
;            /* Should not be possible to get here, ucFlags must be corrupt.
;             * Force an assert. */
;            configASSERT( xStreamBuffer == ( StreamBufferHandle_t ) ~0 );
;        }
;        #endif
;    }
;    else
	bra	L39
L10117:
;    {
;        /* The structure and buffer were not allocated dynamically and cannot be
;         * freed - just scrub the structure so future use will assert. */
;        ( void ) memset( pxStreamBuffer, 0x00, sizeof( StreamBuffer_t ) );
	pea	#<$17
	pea	#<$0
	pei	<L36+pxStreamBuffer_1+2
	pei	<L36+pxStreamBuffer_1
	jsr	_~memset
;    }
;
;    traceRETURN_vStreamBufferDelete();
;}
L39:
	lda	<L35+1
	sta	<L35+1+4
	pld
	tsc
	clc
	adc	#L35+4
	tcs
	rts
L35	equ	8
L36	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferReset( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferReset
	func
_~xStreamBufferReset:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    BaseType_t xReturn = pdFAIL;
;    StreamBufferCallbackFunction_t pxSendCallback;
;	StreamBufferCallbackFunction_t pxReceiveCallback;
;	
;	
;	pxSendCallback = (StreamBufferCallbackFunction_t)0;
pxStreamBuffer_1	set	0
xReturn_1	set	4
pxSendCallback_1	set	6
pxReceiveCallback_1	set	8
	lda	<L40+xStreamBuffer_0
	sta	<L41+pxStreamBuffer_1
	lda	<L40+xStreamBuffer_0+2
	sta	<L41+pxStreamBuffer_1+2
	stz	<L41+xReturn_1
	stz	<L41+pxSendCallback_1
;	pxReceiveCallback = (StreamBufferCallbackFunction_t)0;
	stz	<L41+pxReceiveCallback_1
;	
;    #if ( configUSE_TRACE_FACILITY == 1 )
;        UBaseType_t uxStreamBufferNumber;
;    #endif
;
;    traceENTER_xStreamBufferReset( xStreamBuffer );
;
;    configASSERT( pxStreamBuffer );
	lda	<L41+pxStreamBuffer_1
	ora	<L41+pxStreamBuffer_1+2
	bne	L10127
L10123:
	bra	L10123
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;    {
;        /* Store the stream buffer number so it can be restored after the
;         * reset. */
;        uxStreamBufferNumber = pxStreamBuffer->uxStreamBufferNumber;
;    }
;    #endif
;
;    /* Can only reset a message buffer if there are no tasks blocked on it. */
;    taskENTER_CRITICAL();
L10127:
;    {
;        if( ( pxStreamBuffer->xTaskWaitingToReceive == NULL ) && ( pxStreamBuffer->xTaskWaitingToSend == NULL ) )
;        {
	ldy	#$8
	lda	[<L41+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L41+pxStreamBuffer_1],Y
	bne	L10131
	iny
	iny
	lda	[<L41+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L41+pxStreamBuffer_1],Y
	bne	L10131
;            #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;            {
;                pxSendCallback = pxStreamBuffer->pxSendCompletedCallback;
;                pxReceiveCallback = pxStreamBuffer->pxReceiveCompletedCallback;
;            }
;            #endif
;
;            prvInitialiseNewStreamBuffer( pxStreamBuffer,
;                                          pxStreamBuffer->pucBuffer,
;                                          pxStreamBuffer->xLength,
;                                          pxStreamBuffer->xTriggerLevelBytes,
;                                          pxStreamBuffer->ucFlags,
;                                          pxSendCallback,
;                                          pxReceiveCallback );
	pei	<L41+pxReceiveCallback_1
	pei	<L41+pxSendCallback_1
	ldy	#$14
	lda	[<L41+pxStreamBuffer_1],Y
	pha
	ldy	#$6
	lda	[<L41+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L41+pxStreamBuffer_1],Y
	pha
	ldy	#$12
	lda	[<L41+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L41+pxStreamBuffer_1],Y
	pha
	pei	<L41+pxStreamBuffer_1+2
	pei	<L41+pxStreamBuffer_1
	jsr	_~prvInitialiseNewStreamBuffer
;
;            #if ( configUSE_TRACE_FACILITY == 1 )
;            {
;                pxStreamBuffer->uxStreamBufferNumber = uxStreamBufferNumber;
;            }
;            #endif
;
;            traceSTREAM_BUFFER_RESET( xStreamBuffer );
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L41+xReturn_1
;        }
;    }
;    taskEXIT_CRITICAL();
L10131:
;
;    traceRETURN_xStreamBufferReset( xReturn );
;
;    return xReturn;
	lda	<L41+xReturn_1
	tay
	lda	<L40+1
	sta	<L40+1+4
	pld
	tsc
	clc
	adc	#L40+4
	tcs
	tya
	rts
;}
L40	equ	10
L41	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferResetFromISR( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferResetFromISR
	func
_~xStreamBufferResetFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L46
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    BaseType_t xReturn = pdFAIL;
;//    StreamBufferCallbackFunction_t pxSendCallback = NULL, pxReceiveCallback = NULL;
;    StreamBufferCallbackFunction_t pxSendCallback = 0, pxReceiveCallback = 0;
;    UBaseType_t uxSavedInterruptStatus;
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;        UBaseType_t uxStreamBufferNumber;
;    #endif
;
;    traceENTER_xStreamBufferResetFromISR( xStreamBuffer );
pxStreamBuffer_1	set	0
xReturn_1	set	4
pxSendCallback_1	set	6
pxReceiveCallback_1	set	8
uxSavedInterruptStatus_1	set	10
	lda	<L46+xStreamBuffer_0
	sta	<L47+pxStreamBuffer_1
	lda	<L46+xStreamBuffer_0+2
	sta	<L47+pxStreamBuffer_1+2
	stz	<L47+xReturn_1
	stz	<L47+pxSendCallback_1
	stz	<L47+pxReceiveCallback_1
;
;    configASSERT( pxStreamBuffer );
	lda	<L47+pxStreamBuffer_1
	ora	<L47+pxStreamBuffer_1+2
	bne	L10133
L10137:
	bra	L10137
L10133:
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;    {
;        /* Store the stream buffer number so it can be restored after the
;         * reset. */
;        uxStreamBufferNumber = pxStreamBuffer->uxStreamBufferNumber;
;    }
;    #endif
;
;    /* Can only reset a message buffer if there are no tasks blocked on it. */
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L47+uxSavedInterruptStatus_1
;    {
;        if( ( pxStreamBuffer->xTaskWaitingToReceive == NULL ) && ( pxStreamBuffer->xTaskWaitingToSend == NULL ) )
;        {
	ldy	#$8
	lda	[<L47+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L47+pxStreamBuffer_1],Y
	bne	L10140
	iny
	iny
	lda	[<L47+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L47+pxStreamBuffer_1],Y
	bne	L10140
;            #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;            {
;                pxSendCallback = pxStreamBuffer->pxSendCompletedCallback;
;                pxReceiveCallback = pxStreamBuffer->pxReceiveCompletedCallback;
;            }
;            #endif
;
;            prvInitialiseNewStreamBuffer( pxStreamBuffer,
;                                          pxStreamBuffer->pucBuffer,
;                                          pxStreamBuffer->xLength,
;                                          pxStreamBuffer->xTriggerLevelBytes,
;                                          pxStreamBuffer->ucFlags,
;                                          pxSendCallback,
;                                          pxReceiveCallback );
	pei	<L47+pxReceiveCallback_1
	pei	<L47+pxSendCallback_1
	ldy	#$14
	lda	[<L47+pxStreamBuffer_1],Y
	pha
	ldy	#$6
	lda	[<L47+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L47+pxStreamBuffer_1],Y
	pha
	ldy	#$12
	lda	[<L47+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L47+pxStreamBuffer_1],Y
	pha
	pei	<L47+pxStreamBuffer_1+2
	pei	<L47+pxStreamBuffer_1
	jsr	_~prvInitialiseNewStreamBuffer
;
;            #if ( configUSE_TRACE_FACILITY == 1 )
;            {
;                pxStreamBuffer->uxStreamBufferNumber = uxStreamBufferNumber;
;            }
;            #endif
;
;            traceSTREAM_BUFFER_RESET_FROM_ISR( xStreamBuffer );
;
;            xReturn = pdPASS;
	lda	#$1
	sta	<L47+xReturn_1
;        }
;    }
L10140:
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xStreamBufferResetFromISR( xReturn );
;
;    return xReturn;
	lda	<L47+xReturn_1
	tay
	lda	<L46+1
	sta	<L46+1+4
	pld
	tsc
	clc
	adc	#L46+4
	tcs
	tya
	rts
;}
L46	equ	12
L47	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferSetTriggerLevel( StreamBufferHandle_t xStreamBuffer,
;                                         size_t xTriggerLevel )
;{
	code
	xdef	_~xStreamBufferSetTriggerLevel
	func
_~xStreamBufferSetTriggerLevel:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
xTriggerLevel_0	set	7
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    BaseType_t xReturn;
;
;    traceENTER_xStreamBufferSetTriggerLevel( xStreamBuffer, xTriggerLevel );
pxStreamBuffer_1	set	0
xReturn_1	set	4
	lda	<L52+xStreamBuffer_0
	sta	<L53+pxStreamBuffer_1
	lda	<L52+xStreamBuffer_0+2
	sta	<L53+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L53+pxStreamBuffer_1
	ora	<L53+pxStreamBuffer_1+2
	bne	L10141
L10145:
	bra	L10145
L10141:
;
;    /* It is not valid for the trigger level to be 0. */
;    if( xTriggerLevel == ( size_t ) 0 )
;    {
	lda	<L52+xTriggerLevel_0
	bne	L10148
;        xTriggerLevel = ( size_t ) 1;
	lda	#$1
	sta	<L52+xTriggerLevel_0
;    }
;
;    /* The trigger level is the number of bytes that must be in the stream
;     * buffer before a task that is waiting for data is unblocked. */
;    if( xTriggerLevel < pxStreamBuffer->xLength )
L10148:
;    {
	lda	<L52+xTriggerLevel_0
	ldy	#$4
	cmp	[<L53+pxStreamBuffer_1],Y
	bcs	L10149
;        pxStreamBuffer->xTriggerLevelBytes = xTriggerLevel;
	lda	<L52+xTriggerLevel_0
	iny
	iny
	sta	[<L53+pxStreamBuffer_1],Y
;        xReturn = pdPASS;
	lda	#$1
	sta	<L53+xReturn_1
;    }
;    else
	bra	L10150
L10149:
;    {
;        xReturn = pdFALSE;
	stz	<L53+xReturn_1
;    }
L10150:
;
;    traceRETURN_xStreamBufferSetTriggerLevel( xReturn );
;
;    return xReturn;
	lda	<L53+xReturn_1
	tay
	lda	<L52+1
	sta	<L52+1+6
	pld
	tsc
	clc
	adc	#L52+6
	tcs
	tya
	rts
;}
L52	equ	6
L53	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferSpacesAvailable( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferSpacesAvailable
	func
_~xStreamBufferSpacesAvailable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L58
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    const StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xSpace;
;    size_t xOriginalTail;
;
;    traceENTER_xStreamBufferSpacesAvailable( xStreamBuffer );
pxStreamBuffer_1	set	0
xSpace_1	set	4
xOriginalTail_1	set	6
	lda	<L58+xStreamBuffer_0
	sta	<L59+pxStreamBuffer_1
	lda	<L58+xStreamBuffer_0+2
	sta	<L59+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L59+pxStreamBuffer_1
	ora	<L59+pxStreamBuffer_1+2
	bne	L10160
L10155:
	bra	L10155
;
;    /* The code below reads xTail and then xHead.  This is safe if the stream
;     * buffer is updated once between the two reads - but not if the stream buffer
;     * is updated more than once between the two reads - hence the loop. */
;    do
L10160:
;    {
;        xOriginalTail = pxStreamBuffer->xTail;
	lda	[<L59+pxStreamBuffer_1]
	sta	<L59+xOriginalTail_1
;        xSpace = pxStreamBuffer->xLength + pxStreamBuffer->xTail;
	clc
	ldy	#$4
	lda	[<L59+pxStreamBuffer_1],Y
	adc	[<L59+pxStreamBuffer_1]
	sta	<L59+xSpace_1
;        xSpace -= pxStreamBuffer->xHead;
	sec
	dey
	dey
	sbc	[<L59+pxStreamBuffer_1],Y
	sta	<L59+xSpace_1
;    } while( xOriginalTail != pxStreamBuffer->xTail );
	lda	<L59+xOriginalTail_1
	cmp	[<L59+pxStreamBuffer_1]
	bne	L10160
;
;    xSpace -= ( size_t ) 1;
	dec	<L59+xSpace_1
;
;    if( xSpace >= pxStreamBuffer->xLength )
;    {
	lda	<L59+xSpace_1
	iny
	iny
	cmp	[<L59+pxStreamBuffer_1],Y
	bcc	L10162
;        xSpace -= pxStreamBuffer->xLength;
	sec
	lda	<L59+xSpace_1
	sbc	[<L59+pxStreamBuffer_1],Y
	sta	<L59+xSpace_1
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10162:
;
;    traceRETURN_xStreamBufferSpacesAvailable( xSpace );
;
;    return xSpace;
	lda	<L59+xSpace_1
	tay
	lda	<L58+1
	sta	<L58+1+4
	pld
	tsc
	clc
	adc	#L58+4
	tcs
	tya
	rts
;}
L58	equ	8
L59	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferBytesAvailable( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferBytesAvailable
	func
_~xStreamBufferBytesAvailable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L64
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    const StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xReturn;
;
;    traceENTER_xStreamBufferBytesAvailable( xStreamBuffer );
pxStreamBuffer_1	set	0
xReturn_1	set	4
	lda	<L64+xStreamBuffer_0
	sta	<L65+pxStreamBuffer_1
	lda	<L64+xStreamBuffer_0+2
	sta	<L65+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L65+pxStreamBuffer_1
	ora	<L65+pxStreamBuffer_1+2
	bne	L10163
L10167:
	bra	L10167
L10163:
;
;    xReturn = prvBytesInBuffer( pxStreamBuffer );
	pei	<L65+pxStreamBuffer_1+2
	pei	<L65+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L65+xReturn_1
;
;    traceRETURN_xStreamBufferBytesAvailable( xReturn );
;
;    return xReturn;
	tay
	lda	<L64+1
	sta	<L64+1+4
	pld
	tsc
	clc
	adc	#L64+4
	tcs
	tya
	rts
;}
L64	equ	6
L65	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferSend( StreamBufferHandle_t xStreamBuffer,
;                          const void * pvTxData,
;                          size_t xDataLengthBytes,
;                          TickType_t xTicksToWait )
;{
	code
	xdef	_~xStreamBufferSend
	func
_~xStreamBufferSend:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L68
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
pvTxData_0	set	7
xDataLengthBytes_0	set	11
xTicksToWait_0	set	13
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xReturn, xSpace = 0;
;    size_t xRequiredSpace = xDataLengthBytes;
;    TimeOut_t xTimeOut;
;    size_t xMaxReportedSpace = 0;
;
;    traceENTER_xStreamBufferSend( xStreamBuffer, pvTxData, xDataLengthBytes, xTicksToWait );
pxStreamBuffer_1	set	0
xReturn_1	set	4
xSpace_1	set	6
xRequiredSpace_1	set	8
xTimeOut_1	set	10
xMaxReportedSpace_1	set	16
	lda	<L68+xStreamBuffer_0
	sta	<L69+pxStreamBuffer_1
	lda	<L68+xStreamBuffer_0+2
	sta	<L69+pxStreamBuffer_1+2
	stz	<L69+xSpace_1
	lda	<L68+xDataLengthBytes_0
	sta	<L69+xRequiredSpace_1
	stz	<L69+xMaxReportedSpace_1
;
;    configASSERT( pvTxData );
	lda	<L68+pvTxData_0
	ora	<L68+pvTxData_0+2
	bne	L10170
L10174:
	bra	L10174
L10170:
;    configASSERT( pxStreamBuffer );
	lda	<L69+pxStreamBuffer_1
	ora	<L69+pxStreamBuffer_1+2
	bne	L10177
L10181:
	bra	L10181
L10177:
;
;    /* The maximum amount of space a stream buffer will ever report is its length
;     * minus 1. */
;    xMaxReportedSpace = pxStreamBuffer->xLength - ( size_t ) 1;
	clc
	lda	#$ffff
	ldy	#$4
	adc	[<L69+pxStreamBuffer_1],Y
	sta	<L69+xMaxReportedSpace_1
;
;    /* This send function is used to write to both message buffers and stream
;     * buffers.  If this is a message buffer then the space needed must be
;     * increased by the amount of bytes needed to store the length of the
;     * message. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L69+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10184
;        xRequiredSpace += sbBYTES_TO_STORE_MESSAGE_LENGTH;
	inc	<L69+xRequiredSpace_1
	inc	<L69+xRequiredSpace_1
;
;        /* Overflow? */
;        configASSERT( xRequiredSpace > xDataLengthBytes );
	lda	<L68+xDataLengthBytes_0
	cmp	<L69+xRequiredSpace_1
	bcc	L10185
L10189:
	bra	L10189
L10185:
;
;        /* If this is a message buffer then it must be possible to write the
;         * whole message. */
;        if( xRequiredSpace > xMaxReportedSpace )
;        {
	lda	<L69+xMaxReportedSpace_1
	cmp	<L69+xRequiredSpace_1
	bcs	L10194
;            /* The message would not fit even if the entire buffer was empty,
;             * so don't wait for space. */
;            xTicksToWait = ( TickType_t ) 0;
	stz	<L68+xTicksToWait_0
	stz	<L68+xTicksToWait_0+2
;        }
;        else
	bra	L10194
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
L10184:
;    {
;        /* If this is a stream buffer then it is acceptable to write only part
;         * of the message to the buffer.  Cap the length to the total length of
;         * the buffer. */
;        if( xRequiredSpace > xMaxReportedSpace )
;        {
	lda	<L69+xMaxReportedSpace_1
	cmp	<L69+xRequiredSpace_1
	bcs	L10194
;            xRequiredSpace = xMaxReportedSpace;
	lda	<L69+xMaxReportedSpace_1
	sta	<L69+xRequiredSpace_1
;        }
;        else
L10194:
;
;    if( xTicksToWait != ( TickType_t ) 0 )
;    {
	lda	<L68+xTicksToWait_0
	ora	<L68+xTicksToWait_0+2
	bne	*+5
	brl	L10219
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;        vTaskSetTimeOutState( &xTimeOut );
	pea	#0
	clc
	tdc
	adc	#<L69+xTimeOut_1
	pha
	jsr	_~vTaskSetTimeOutState
;
;        do
;        {
;            /* Wait until the required number of bytes are free in the message
;             * buffer. */
;            taskENTER_CRITICAL();
	bra	L10202
L20002:
;                    /* Clear notification state as going to wait for space. */
;                    ( void ) xTaskNotifyStateClearIndexed( NULL, pxStreamBuffer->uxNotificationIndex );
	ldy	#$15
	lda	[<L69+pxStreamBuffer_1],Y
	pha
	pea	#^$0
	pea	#<$0
	jsr	_~xTaskGenericNotifyStateClear
	sta	<R0
;
;                    /* Should only be one writer. */
;                    configASSERT( pxStreamBuffer->xTaskWaitingToSend == NULL );
	ldy	#$c
	lda	[<L69+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L69+pxStreamBuffer_1],Y
	beq	L10205
L10209:
	bra	L10209
L10205:
;                    pxStreamBuffer->xTaskWaitingToSend = xTaskGetCurrentTaskHandle();
	jsr	_~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$c
	sta	[<L69+pxStreamBuffer_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L69+pxStreamBuffer_1],Y
;                }
;                else
;
;            traceBLOCKING_ON_STREAM_BUFFER_SEND( xStreamBuffer );
;            ( void ) xTaskNotifyWaitIndexed( pxStreamBuffer->uxNotificationIndex, ( uint32_t ) 0, ( uint32_t ) 0, NULL, xTicksToWait );
	pei	<L68+xTicksToWait_0+2
	pei	<L68+xTicksToWait_0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L69+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyWait
	sta	<R0
;            pxStreamBuffer->xTaskWaitingToSend = NULL;
	lda	#$0
	ldy	#$c
	sta	[<L69+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L69+pxStreamBuffer_1],Y
;        } while( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE );
	pea	#0
	clc
	tdc
	adc	#<L68+xTicksToWait_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L69+xTimeOut_1
	pha
	jsr	_~xTaskCheckForTimeOut
	tax
	bne	L10219
L10202:
;            {
;                xSpace = xStreamBufferSpacesAvailable( pxStreamBuffer );
	pei	<L69+pxStreamBuffer_1+2
	pei	<L69+pxStreamBuffer_1
	jsr	_~xStreamBufferSpacesAvailable
	sta	<L69+xSpace_1
;
;                if( xSpace < xRequiredSpace )
;                {
	cmp	<L69+xRequiredSpace_1
	bcs	*+5
	brl	L20002
;                {
;                    taskEXIT_CRITICAL();
;                    break;
L10219:
;
;    if( xSpace == ( size_t ) 0 )
;    {
	lda	<L69+xSpace_1
	bne	L10221
;                }
;            }
;            taskEXIT_CRITICAL();
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;        xSpace = xStreamBufferSpacesAvailable( pxStreamBuffer );
	pei	<L69+pxStreamBuffer_1+2
	pei	<L69+pxStreamBuffer_1
	jsr	_~xStreamBufferSpacesAvailable
	sta	<L69+xSpace_1
;    }
;    else
L10221:
;
;    xReturn = prvWriteMessageToBuffer( pxStreamBuffer, pvTxData, xDataLengthBytes, xSpace, xRequiredSpace );
	pei	<L69+xRequiredSpace_1
	pei	<L69+xSpace_1
	pei	<L68+xDataLengthBytes_0
	pei	<L68+pvTxData_0+2
	pei	<L68+pvTxData_0
	pei	<L69+pxStreamBuffer_1+2
	pei	<L69+pxStreamBuffer_1
	jsr	_~prvWriteMessageToBuffer
	sta	<L69+xReturn_1
;
;    if( xReturn > ( size_t ) 0 )
;    {
	lda	#$0
	cmp	<L69+xReturn_1
	bcs	L10226
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;        traceSTREAM_BUFFER_SEND( xStreamBuffer, xReturn );
;
;        /* Was a task waiting for the data? */
;        if( prvBytesInBufferMeetTriggerLevel( pxStreamBuffer, prvBytesInBuffer( pxStreamBuffer ) ) != pdFALSE )
;        {
	pei	<L69+pxStreamBuffer_1+2
	pei	<L69+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	pha
	pei	<L69+pxStreamBuffer_1+2
	pei	<L69+pxStreamBuffer_1
	jsr	_~prvBytesInBufferMeetTriggerLevel
	tax
	beq	L10226
;            prvSEND_COMPLETED( pxStreamBuffer );
	jsr	_~vTaskSuspendAll
	ldy	#$8
	lda	[<L69+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L69+pxStreamBuffer_1],Y
	beq	L10224
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L69+pxStreamBuffer_1],Y
	pha
	ldy	#$a
	lda	[<L69+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L69+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotify
	sta	<R0
	lda	#$0
	ldy	#$8
	sta	[<L69+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L69+pxStreamBuffer_1],Y
L10224:
	jsr	_~xTaskResumeAll
;        }
;        else
L10226:
;
;    traceRETURN_xStreamBufferSend( xReturn );
;
;    return xReturn;
	lda	<L69+xReturn_1
	tay
	lda	<L68+1
	sta	<L68+1+14
	pld
	tsc
	clc
	adc	#L68+14
	tcs
	tya
	rts
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;        traceSTREAM_BUFFER_SEND_FAILED( xStreamBuffer );
;    }
;}
L68	equ	22
L69	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferSendFromISR( StreamBufferHandle_t xStreamBuffer,
;                                 const void * pvTxData,
;                                 size_t xDataLengthBytes,
;                                 BaseType_t * const pxHigherPriorityTaskWoken )
;{
	code
	xdef	_~xStreamBufferSendFromISR
	func
_~xStreamBufferSendFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L85
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
pvTxData_0	set	7
xDataLengthBytes_0	set	11
pxHigherPriorityTaskWoken_0	set	13
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xReturn, xSpace;
;    size_t xRequiredSpace = xDataLengthBytes;
;
;    traceENTER_xStreamBufferSendFromISR( xStreamBuffer, pvTxData, xDataLengthBytes, pxHigherPriorityTaskWoken );
pxStreamBuffer_1	set	0
xReturn_1	set	4
xSpace_1	set	6
xRequiredSpace_1	set	8
	lda	<L85+xStreamBuffer_0
	sta	<L86+pxStreamBuffer_1
	lda	<L85+xStreamBuffer_0+2
	sta	<L86+pxStreamBuffer_1+2
	lda	<L85+xDataLengthBytes_0
	sta	<L86+xRequiredSpace_1
;
;    configASSERT( pvTxData );
	lda	<L85+pvTxData_0
	ora	<L85+pvTxData_0+2
	bne	L10227
L10231:
	bra	L10231
L10227:
;    configASSERT( pxStreamBuffer );
	lda	<L86+pxStreamBuffer_1
	ora	<L86+pxStreamBuffer_1+2
	bne	L10234
L10238:
	bra	L10238
L10234:
;
;    /* This send function is used to write to both message buffers and stream
;     * buffers.  If this is a message buffer then the space needed must be
;     * increased by the amount of bytes needed to store the length of the
;     * message. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L86+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10249
;        xRequiredSpace += sbBYTES_TO_STORE_MESSAGE_LENGTH;
	inc	<L86+xRequiredSpace_1
	inc	<L86+xRequiredSpace_1
;
;        /* Overflow? */
;        configASSERT( xRequiredSpace > xDataLengthBytes );
	lda	<L85+xDataLengthBytes_0
	cmp	<L86+xRequiredSpace_1
	bcc	L10249
L10246:
	bra	L10246
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10249:
;
;    xSpace = xStreamBufferSpacesAvailable( pxStreamBuffer );
	pei	<L86+pxStreamBuffer_1+2
	pei	<L86+pxStreamBuffer_1
	jsr	_~xStreamBufferSpacesAvailable
	sta	<L86+xSpace_1
;    xReturn = prvWriteMessageToBuffer( pxStreamBuffer, pvTxData, xDataLengthBytes, xSpace, xRequiredSpace );
	pei	<L86+xRequiredSpace_1
	pei	<L86+xSpace_1
	pei	<L85+xDataLengthBytes_0
	pei	<L85+pvTxData_0+2
	pei	<L85+pvTxData_0
	pei	<L86+pxStreamBuffer_1+2
	pei	<L86+pxStreamBuffer_1
	jsr	_~prvWriteMessageToBuffer
	sta	<L86+xReturn_1
;
;    if( xReturn > ( size_t ) 0 )
;    {
	lda	#$0
	cmp	<L86+xReturn_1
	bcs	L10257
;        /* Was a task waiting for the data? */
;        if( prvBytesInBufferMeetTriggerLevel( pxStreamBuffer, prvBytesInBuffer( pxStreamBuffer ) ) != pdFALSE )
;        {
	pei	<L86+pxStreamBuffer_1+2
	pei	<L86+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	pha
	pei	<L86+pxStreamBuffer_1+2
	pei	<L86+pxStreamBuffer_1
	jsr	_~prvBytesInBufferMeetTriggerLevel
	tax
	beq	L10257
;            /* MISRA Ref 4.7.1 [Return value shall be checked] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;            /* coverity[misra_c_2012_directive_4_7_violation] */
;            prvSEND_COMPLETE_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken );
uxSavedInterruptStatus_2	set	10
	stz	<L86+uxSavedInterruptStatus_2
	ldy	#$8
	lda	[<L86+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L86+pxStreamBuffer_1],Y
	beq	L10257
	pei	<L85+pxHigherPriorityTaskWoken_0+2
	pei	<L85+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L86+pxStreamBuffer_1],Y
	pha
	ldy	#$a
	lda	[<L86+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L86+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
	lda	#$0
	ldy	#$8
	sta	[<L86+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L86+pxStreamBuffer_1],Y
;        }
;        else
L10257:
;
;    traceSTREAM_BUFFER_SEND_FROM_ISR( xStreamBuffer, xReturn );
;    traceRETURN_xStreamBufferSendFromISR( xReturn );
;
;    return xReturn;
	lda	<L86+xReturn_1
	tay
	lda	<L85+1
	sta	<L85+1+14
	pld
	tsc
	clc
	adc	#L85+14
	tcs
	tya
	rts
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L85	equ	16
L86	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static size_t prvWriteMessageToBuffer( StreamBuffer_t * const pxStreamBuffer,
;                                       const void * pvTxData,
;                                       size_t xDataLengthBytes,
;                                       size_t xSpace,
;                                       size_t xRequiredSpace )
;{
	code
	func
_~prvWriteMessageToBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L95
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
pvTxData_0	set	7
xDataLengthBytes_0	set	11
xSpace_0	set	13
xRequiredSpace_0	set	15
;    size_t xNextHead = pxStreamBuffer->xHead;
;    configMESSAGE_BUFFER_LENGTH_TYPE xMessageLength;
;
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
xNextHead_1	set	0
xMessageLength_1	set	2
	ldy	#$2
	lda	[<L95+pxStreamBuffer_0],Y
	sta	<L96+xNextHead_1
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L95+pxStreamBuffer_0],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10258
;        /* This is a message buffer, as opposed to a stream buffer. */
;
;        /* Convert xDataLengthBytes to the message length type. */
;        xMessageLength = ( configMESSAGE_BUFFER_LENGTH_TYPE ) xDataLengthBytes;
	lda	<L95+xDataLengthBytes_0
	sta	<L96+xMessageLength_1
;
;        /* Ensure the data length given fits within configMESSAGE_BUFFER_LENGTH_TYPE. */
;        configASSERT( ( size_t ) xMessageLength == xDataLengthBytes );
	cmp	<L95+xDataLengthBytes_0
	beq	L10259
L10263:
	bra	L10263
L10259:
;
;        if( xSpace >= xRequiredSpace )
;        {
	lda	<L95+xSpace_0
	cmp	<L95+xRequiredSpace_0
	bcc	L10266
;            /* There is enough space to write both the message length and the message
;             * itself into the buffer.  Start by writing the length of the data, the data
;             * itself will be written later in this function. */
;            xNextHead = prvWriteBytesToBuffer( pxStreamBuffer, ( const uint8_t * ) &( xMessageLength ), sbBYTES_TO_STORE_MESSAGE_LENGTH, xNextHead );
	pei	<L96+xNextHead_1
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L96+xMessageLength_1
	pha
	pei	<L95+pxStreamBuffer_0+2
	pei	<L95+pxStreamBuffer_0
	jsr	_~prvWriteBytesToBuffer
	sta	<L96+xNextHead_1
;        }
;        else
	bra	L10268
L10266:
;        {
;            /* Not enough space, so do not write data to the buffer. */
;            xDataLengthBytes = 0;
	stz	<L95+xDataLengthBytes_0
;        }
;    }
;    else
	bra	L10268
L10258:
;    {
;        /* This is a stream buffer, as opposed to a message buffer, so writing a
;         * stream of bytes rather than discrete messages.  Plan to write as many
;         * bytes as possible. */
;        xDataLengthBytes = configMIN( xDataLengthBytes, xSpace );
	lda	<L95+xDataLengthBytes_0
	cmp	<L95+xSpace_0
	bcs	L100
	lda	<L95+xDataLengthBytes_0
	bra	L102
L100:
	lda	<L95+xSpace_0
L102:
	sta	<L95+xDataLengthBytes_0
;    }
L10268:
;
;    if( xDataLengthBytes != ( size_t ) 0 )
;    {
	lda	<L95+xDataLengthBytes_0
	beq	L10269
;        /* Write the data to the buffer. */
;        /* MISRA Ref 11.5.5 [Void pointer assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        pxStreamBuffer->xHead = prvWriteBytesToBuffer( pxStreamBuffer, ( const uint8_t * ) pvTxData, xDataLengthBytes, xNextHead );
	pei	<L96+xNextHead_1
	pei	<L95+xDataLengthBytes_0
	pei	<L95+pvTxData_0+2
	pei	<L95+pvTxData_0
	pei	<L95+pxStreamBuffer_0+2
	pei	<L95+pxStreamBuffer_0
	jsr	_~prvWriteBytesToBuffer
	ldy	#$2
	sta	[<L95+pxStreamBuffer_0],Y
;    }
;
;    return xDataLengthBytes;
L10269:
	lda	<L95+xDataLengthBytes_0
	tay
	lda	<L95+1
	sta	<L95+1+14
	pld
	tsc
	clc
	adc	#L95+14
	tcs
	tya
	rts
;}
L95	equ	4
L96	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferReceive( StreamBufferHandle_t xStreamBuffer,
;                             void * pvRxData,
;                             size_t xBufferLengthBytes,
;                             TickType_t xTicksToWait )
;{
	code
	xdef	_~xStreamBufferReceive
	func
_~xStreamBufferReceive:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L105
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
pvRxData_0	set	7
xBufferLengthBytes_0	set	11
xTicksToWait_0	set	13
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xReceivedLength = 0, xBytesAvailable, xBytesToStoreMessageLength;
;
;    traceENTER_xStreamBufferReceive( xStreamBuffer, pvRxData, xBufferLengthBytes, xTicksToWait );
pxStreamBuffer_1	set	0
xReceivedLength_1	set	4
xBytesAvailable_1	set	6
xBytesToStoreMessageLength_1	set	8
	lda	<L105+xStreamBuffer_0
	sta	<L106+pxStreamBuffer_1
	lda	<L105+xStreamBuffer_0+2
	sta	<L106+pxStreamBuffer_1+2
	stz	<L106+xReceivedLength_1
;
;    configASSERT( pvRxData );
	lda	<L105+pvRxData_0
	ora	<L105+pvRxData_0+2
	bne	L10270
L10274:
	bra	L10274
L10270:
;    configASSERT( pxStreamBuffer );
	lda	<L106+pxStreamBuffer_1
	ora	<L106+pxStreamBuffer_1+2
	bne	L10277
L10281:
	bra	L10281
L10277:
;
;    /* This receive function is used by both message buffers, which store
;     * discrete messages, and stream buffers, which store a continuous stream of
;     * bytes.  Discrete messages include an additional
;     * sbBYTES_TO_STORE_MESSAGE_LENGTH bytes that hold the length of the
;     * message. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L106+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10284
;        xBytesToStoreMessageLength = sbBYTES_TO_STORE_MESSAGE_LENGTH;
	lda	#$2
	bra	L20007
L20009:
;        /* Force task to block if the batching buffer contains less bytes than
;         * the trigger level. */
;        xBytesToStoreMessageLength = pxStreamBuffer->xTriggerLevelBytes;
	ldy	#$6
	lda	[<L106+pxStreamBuffer_1],Y
;    }
;    else
L20007:
	sta	<L106+xBytesToStoreMessageLength_1
;    }
;    else if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_BATCHING_BUFFER ) != ( uint8_t ) 0 )
	bra	L10285
L10284:
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L106+pxStreamBuffer_1],Y
	and	#<$4
	rep	#$20
	longa	on
	bne	L20009
;    {
;        xBytesToStoreMessageLength = 0;
	stz	<L106+xBytesToStoreMessageLength_1
;    }
L10285:
;
;    if( xTicksToWait != ( TickType_t ) 0 )
;    {
	lda	<L105+xTicksToWait_0
	ora	<L105+xTicksToWait_0+2
	beq	L10288
;        /* Checking if there is data and clearing the notification state must be
;         * performed atomically. */
;        taskENTER_CRITICAL();
;        {
;            xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L106+pxStreamBuffer_1+2
	pei	<L106+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L106+xBytesAvailable_1
;
;            /* If this function was invoked by a message buffer read then
;             * xBytesToStoreMessageLength holds the number of bytes used to hold
;             * the length of the next discrete message.  If this function was
;             * invoked by a stream buffer read then xBytesToStoreMessageLength will
;             * be 0. If this function was invoked by a stream batch buffer read
;             * then xBytesToStoreMessageLength will be xTriggerLevelBytes value
;             * for the buffer.*/
;            if( xBytesAvailable <= xBytesToStoreMessageLength )
;            {
	lda	<L106+xBytesToStoreMessageLength_1
	cmp	<L106+xBytesAvailable_1
	bcc	L10302
;                /* Clear notification state as going to wait for data. */
;                ( void ) xTaskNotifyStateClearIndexed( NULL, pxStreamBuffer->uxNotificationIndex );
	ldy	#$15
	lda	[<L106+pxStreamBuffer_1],Y
	pha
	pea	#^$0
	pea	#<$0
	jsr	_~xTaskGenericNotifyStateClear
	sta	<R0
;
;                /* Should only be one reader. */
;                configASSERT( pxStreamBuffer->xTaskWaitingToReceive == NULL );
	ldy	#$8
	lda	[<L106+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L106+pxStreamBuffer_1],Y
	beq	L10293
L10297:
	bra	L10297
L10293:
;                pxStreamBuffer->xTaskWaitingToReceive = xTaskGetCurrentTaskHandle();
	jsr	_~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$8
	sta	[<L106+pxStreamBuffer_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L106+pxStreamBuffer_1],Y
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        taskEXIT_CRITICAL();
L10302:
;
;        if( xBytesAvailable <= xBytesToStoreMessageLength )
;        {
	lda	<L106+xBytesToStoreMessageLength_1
	cmp	<L106+xBytesAvailable_1
	bcc	L10306
;            /* Wait for data to be available. */
;            traceBLOCKING_ON_STREAM_BUFFER_RECEIVE( xStreamBuffer );
;            ( void ) xTaskNotifyWaitIndexed( pxStreamBuffer->uxNotificationIndex, ( uint32_t ) 0, ( uint32_t ) 0, NULL, xTicksToWait );
	pei	<L105+xTicksToWait_0+2
	pei	<L105+xTicksToWait_0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L106+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyWait
	sta	<R0
;            pxStreamBuffer->xTaskWaitingToReceive = NULL;
	lda	#$0
	ldy	#$8
	sta	[<L106+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L106+pxStreamBuffer_1],Y
;
;            /* Recheck the data available after blocking. */
;            xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
L10288:
;    {
;        xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L106+pxStreamBuffer_1+2
	pei	<L106+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L106+xBytesAvailable_1
;    }
L10306:
;
;    /* Whether receiving a discrete message (where xBytesToStoreMessageLength
;     * holds the number of bytes used to store the message length) or a stream of
;     * bytes (where xBytesToStoreMessageLength is zero), the number of bytes
;     * available must be greater than xBytesToStoreMessageLength to be able to
;     * read bytes from the buffer. */
;    if( xBytesAvailable > xBytesToStoreMessageLength )
;    {
	lda	<L106+xBytesToStoreMessageLength_1
	cmp	<L106+xBytesAvailable_1
	bcs	L10314
;        xReceivedLength = prvReadMessageFromBuffer( pxStreamBuffer, pvRxData, xBufferLengthBytes, xBytesAvailable );
	pei	<L106+xBytesAvailable_1
	pei	<L105+xBufferLengthBytes_0
	pei	<L105+pvRxData_0+2
	pei	<L105+pvRxData_0
	pei	<L106+pxStreamBuffer_1+2
	pei	<L106+pxStreamBuffer_1
	jsr	_~prvReadMessageFromBuffer
	sta	<L106+xReceivedLength_1
;
;        /* Was a task waiting for space in the buffer? */
;        if( xReceivedLength != ( size_t ) 0 )
;        {
	lda	<L106+xReceivedLength_1
	beq	L10314
;            traceSTREAM_BUFFER_RECEIVE( xStreamBuffer, xReceivedLength );
;            prvRECEIVE_COMPLETED( xStreamBuffer );
	jsr	_~vTaskSuspendAll
	ldy	#$c
	lda	[<L105+xStreamBuffer_0],Y
	iny
	iny
	ora	[<L105+xStreamBuffer_0],Y
	beq	L10312
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L105+xStreamBuffer_0],Y
	pha
	ldy	#$e
	lda	[<L105+xStreamBuffer_0],Y
	pha
	dey
	dey
	lda	[<L105+xStreamBuffer_0],Y
	pha
	jsr	_~xTaskGenericNotify
	sta	<R0
	lda	#$0
	ldy	#$c
	sta	[<L105+xStreamBuffer_0],Y
	iny
	iny
	sta	[<L105+xStreamBuffer_0],Y
L10312:
	jsr	_~xTaskResumeAll
;        }
;        else
L10314:
;
;    traceRETURN_xStreamBufferReceive( xReceivedLength );
;
;    return xReceivedLength;
	lda	<L106+xReceivedLength_1
	tay
	lda	<L105+1
	sta	<L105+1+14
	pld
	tsc
	clc
	adc	#L105+14
	tcs
	tya
	rts
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
;    {
;        traceSTREAM_BUFFER_RECEIVE_FAILED( xStreamBuffer );
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L105	equ	14
L106	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferNextMessageLengthBytes( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferNextMessageLengthBytes
	func
_~xStreamBufferNextMessageLengthBytes:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L119
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xReturn, xBytesAvailable;
;    configMESSAGE_BUFFER_LENGTH_TYPE xTempReturn;
;
;    traceENTER_xStreamBufferNextMessageLengthBytes( xStreamBuffer );
pxStreamBuffer_1	set	0
xReturn_1	set	4
xBytesAvailable_1	set	6
xTempReturn_1	set	8
	lda	<L119+xStreamBuffer_0
	sta	<L120+pxStreamBuffer_1
	lda	<L119+xStreamBuffer_0+2
	sta	<L120+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L120+pxStreamBuffer_1
	ora	<L120+pxStreamBuffer_1+2
	bne	L10315
L10319:
	bra	L10319
L10315:
;
;    /* Ensure the stream buffer is being used as a message buffer. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L120+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10322
;        xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L120+pxStreamBuffer_1+2
	pei	<L120+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L120+xBytesAvailable_1
;
;        if( xBytesAvailable > sbBYTES_TO_STORE_MESSAGE_LENGTH )
;        {
	lda	#$2
	cmp	<L120+xBytesAvailable_1
	bcs	L10323
;            /* The number of bytes available is greater than the number of bytes
;             * required to hold the length of the next message, so another message
;             * is available. */
;            ( void ) prvReadBytesFromBuffer( pxStreamBuffer, ( uint8_t * ) &xTempReturn, sbBYTES_TO_STORE_MESSAGE_LENGTH, pxStreamBuffer->xTail );
	lda	[<L120+pxStreamBuffer_1]
	pha
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L120+xTempReturn_1
	pha
	pei	<L120+pxStreamBuffer_1+2
	pei	<L120+pxStreamBuffer_1
	jsr	_~prvReadBytesFromBuffer
	sta	<R0
;            xReturn = ( size_t ) xTempReturn;
	lda	<L120+xTempReturn_1
	sta	<L120+xReturn_1
;        }
;        else
	bra	L10332
L10323:
;        {
;            /* The minimum amount of bytes in a message buffer is
;             * ( sbBYTES_TO_STORE_MESSAGE_LENGTH + 1 ), so if xBytesAvailable is
;             * less than sbBYTES_TO_STORE_MESSAGE_LENGTH the only other valid
;             * value is 0. */
;            configASSERT( xBytesAvailable == 0 );
	lda	<L120+xBytesAvailable_1
	beq	L10322
L10329:
	bra	L10329
;            xReturn = 0;
;        }
;    }
;    else
L10322:
;    {
;        xReturn = 0;
	stz	<L120+xReturn_1
;    }
L10332:
;
;    traceRETURN_xStreamBufferNextMessageLengthBytes( xReturn );
;
;    return xReturn;
	lda	<L120+xReturn_1
	tay
	lda	<L119+1
	sta	<L119+1+4
	pld
	tsc
	clc
	adc	#L119+4
	tcs
	tya
	rts
;}
L119	equ	14
L120	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;size_t xStreamBufferReceiveFromISR( StreamBufferHandle_t xStreamBuffer,
;                                    void * pvRxData,
;                                    size_t xBufferLengthBytes,
;                                    BaseType_t * const pxHigherPriorityTaskWoken )
;{
	code
	xdef	_~xStreamBufferReceiveFromISR
	func
_~xStreamBufferReceiveFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L126
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
pvRxData_0	set	7
xBufferLengthBytes_0	set	11
pxHigherPriorityTaskWoken_0	set	13
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    size_t xReceivedLength = 0, xBytesAvailable, xBytesToStoreMessageLength;
;
;    traceENTER_xStreamBufferReceiveFromISR( xStreamBuffer, pvRxData, xBufferLengthBytes, pxHigherPriorityTaskWoken );
pxStreamBuffer_1	set	0
xReceivedLength_1	set	4
xBytesAvailable_1	set	6
xBytesToStoreMessageLength_1	set	8
	lda	<L126+xStreamBuffer_0
	sta	<L127+pxStreamBuffer_1
	lda	<L126+xStreamBuffer_0+2
	sta	<L127+pxStreamBuffer_1+2
	stz	<L127+xReceivedLength_1
;
;    configASSERT( pvRxData );
	lda	<L126+pvRxData_0
	ora	<L126+pvRxData_0+2
	bne	L10333
L10337:
	bra	L10337
L10333:
;    configASSERT( pxStreamBuffer );
	lda	<L127+pxStreamBuffer_1
	ora	<L127+pxStreamBuffer_1+2
	bne	L10340
L10344:
	bra	L10344
L10340:
;
;    /* This receive function is used by both message buffers, which store
;     * discrete messages, and stream buffers, which store a continuous stream of
;     * bytes.  Discrete messages include an additional
;     * sbBYTES_TO_STORE_MESSAGE_LENGTH bytes that hold the length of the
;     * message. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L127+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10347
;        xBytesToStoreMessageLength = sbBYTES_TO_STORE_MESSAGE_LENGTH;
	lda	#$2
	sta	<L127+xBytesToStoreMessageLength_1
;    }
;    else
	bra	L10348
L10347:
;    {
;        xBytesToStoreMessageLength = 0;
	stz	<L127+xBytesToStoreMessageLength_1
;    }
L10348:
;
;    xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L127+pxStreamBuffer_1+2
	pei	<L127+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L127+xBytesAvailable_1
;
;    /* Whether receiving a discrete message (where xBytesToStoreMessageLength
;     * holds the number of bytes used to store the message length) or a stream of
;     * bytes (where xBytesToStoreMessageLength is zero), the number of bytes
;     * available must be greater than xBytesToStoreMessageLength to be able to
;     * read bytes from the buffer. */
;    if( xBytesAvailable > xBytesToStoreMessageLength )
;    {
	lda	<L127+xBytesToStoreMessageLength_1
	cmp	<L127+xBytesAvailable_1
	bcs	L10356
;        xReceivedLength = prvReadMessageFromBuffer( pxStreamBuffer, pvRxData, xBufferLengthBytes, xBytesAvailable );
	pei	<L127+xBytesAvailable_1
	pei	<L126+xBufferLengthBytes_0
	pei	<L126+pvRxData_0+2
	pei	<L126+pvRxData_0
	pei	<L127+pxStreamBuffer_1+2
	pei	<L127+pxStreamBuffer_1
	jsr	_~prvReadMessageFromBuffer
	sta	<L127+xReceivedLength_1
;
;        /* Was a task waiting for space in the buffer? */
;        if( xReceivedLength != ( size_t ) 0 )
;        {
	lda	<L127+xReceivedLength_1
	beq	L10356
;            /* MISRA Ref 4.7.1 [Return value shall be checked] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;            /* coverity[misra_c_2012_directive_4_7_violation] */
;            prvRECEIVE_COMPLETED_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken );
uxSavedInterruptStatus_2	set	10
	stz	<L127+uxSavedInterruptStatus_2
	ldy	#$c
	lda	[<L127+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L127+pxStreamBuffer_1],Y
	beq	L10356
	pei	<L126+pxHigherPriorityTaskWoken_0+2
	pei	<L126+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L127+pxStreamBuffer_1],Y
	pha
	ldy	#$e
	lda	[<L127+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L127+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
	lda	#$0
	ldy	#$c
	sta	[<L127+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L127+pxStreamBuffer_1],Y
;        }
;        else
L10356:
;
;    traceSTREAM_BUFFER_RECEIVE_FROM_ISR( xStreamBuffer, xReceivedLength );
;    traceRETURN_xStreamBufferReceiveFromISR( xReceivedLength );
;
;    return xReceivedLength;
	lda	<L127+xReceivedLength_1
	tay
	lda	<L126+1
	sta	<L126+1+14
	pld
	tsc
	clc
	adc	#L126+14
	tcs
	tya
	rts
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L126	equ	16
L127	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static size_t prvReadMessageFromBuffer( StreamBuffer_t * pxStreamBuffer,
;                                        void * pvRxData,
;                                        size_t xBufferLengthBytes,
;                                        size_t xBytesAvailable )
;{
	code
	func
_~prvReadMessageFromBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L135
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
pvRxData_0	set	7
xBufferLengthBytes_0	set	11
xBytesAvailable_0	set	13
;    size_t xCount, xNextMessageLength;
;    configMESSAGE_BUFFER_LENGTH_TYPE xTempNextMessageLength;
;    size_t xNextTail = pxStreamBuffer->xTail;
;
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
xCount_1	set	0
xNextMessageLength_1	set	2
xTempNextMessageLength_1	set	4
xNextTail_1	set	6
	lda	[<L135+pxStreamBuffer_0]
	sta	<L136+xNextTail_1
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L135+pxStreamBuffer_0],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10357
;        /* A discrete message is being received.  First receive the length
;         * of the message. */
;        xNextTail = prvReadBytesFromBuffer( pxStreamBuffer, ( uint8_t * ) &xTempNextMessageLength, sbBYTES_TO_STORE_MESSAGE_LENGTH, xNextTail );
	pei	<L136+xNextTail_1
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L136+xTempNextMessageLength_1
	pha
	pei	<L135+pxStreamBuffer_0+2
	pei	<L135+pxStreamBuffer_0
	jsr	_~prvReadBytesFromBuffer
	sta	<L136+xNextTail_1
;        xNextMessageLength = ( size_t ) xTempNextMessageLength;
	lda	<L136+xTempNextMessageLength_1
	sta	<L136+xNextMessageLength_1
;
;        /* Reduce the number of bytes available by the number of bytes just
;         * read out. */
;        xBytesAvailable -= sbBYTES_TO_STORE_MESSAGE_LENGTH;
	dec	<L135+xBytesAvailable_0
	dec	<L135+xBytesAvailable_0
;
;        /* Check there is enough space in the buffer provided by the
;         * user. */
;        if( xNextMessageLength > xBufferLengthBytes )
;        {
	lda	<L135+xBufferLengthBytes_0
	cmp	<L136+xNextMessageLength_1
	bcs	L10360
;            /* The user has provided insufficient space to read the message. */
;            xNextMessageLength = 0;
	stz	<L136+xNextMessageLength_1
;        }
;        else
	bra	L10360
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
L10357:
;    {
;        /* A stream of bytes is being received (as opposed to a discrete
;         * message), so read as many bytes as possible. */
;        xNextMessageLength = xBufferLengthBytes;
	lda	<L135+xBufferLengthBytes_0
	sta	<L136+xNextMessageLength_1
;    }
L10360:
;
;    /* Use the minimum of the wanted bytes and the available bytes. */
;    xCount = configMIN( xNextMessageLength, xBytesAvailable );
	lda	<L136+xNextMessageLength_1
	cmp	<L135+xBytesAvailable_0
	bcs	L139
	lda	<L136+xNextMessageLength_1
	bra	L141
L139:
	lda	<L135+xBytesAvailable_0
L141:
	sta	<L136+xCount_1
;
;    if( xCount != ( size_t ) 0 )
;    {
	lda	<L136+xCount_1
	beq	L10361
;        /* Read the actual data and update the tail to mark the data as officially consumed. */
;        /* MISRA Ref 11.5.5 [Void pointer assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        pxStreamBuffer->xTail = prvReadBytesFromBuffer( pxStreamBuffer, ( uint8_t * ) pvRxData, xCount, xNextTail );
	pei	<L136+xNextTail_1
	pei	<L136+xCount_1
	pei	<L135+pvRxData_0+2
	pei	<L135+pvRxData_0
	pei	<L135+pxStreamBuffer_0+2
	pei	<L135+pxStreamBuffer_0
	jsr	_~prvReadBytesFromBuffer
	sta	[<L135+pxStreamBuffer_0]
;    }
;
;    return xCount;
L10361:
	lda	<L136+xCount_1
	tay
	lda	<L135+1
	sta	<L135+1+12
	pld
	tsc
	clc
	adc	#L135+12
	tcs
	tya
	rts
;}
L135	equ	8
L136	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferIsEmpty( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferIsEmpty
	func
_~xStreamBufferIsEmpty:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L144
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    const StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    BaseType_t xReturn;
;    size_t xTail;
;
;    traceENTER_xStreamBufferIsEmpty( xStreamBuffer );
pxStreamBuffer_1	set	0
xReturn_1	set	4
xTail_1	set	6
	lda	<L144+xStreamBuffer_0
	sta	<L145+pxStreamBuffer_1
	lda	<L144+xStreamBuffer_0+2
	sta	<L145+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L145+pxStreamBuffer_1
	ora	<L145+pxStreamBuffer_1+2
	bne	L10362
L10366:
	bra	L10366
L10362:
;
;    /* True if no bytes are available. */
;    xTail = pxStreamBuffer->xTail;
	lda	[<L145+pxStreamBuffer_1]
	sta	<L145+xTail_1
;
;    if( pxStreamBuffer->xHead == xTail )
;    {
	ldy	#$2
	lda	[<L145+pxStreamBuffer_1],Y
	cmp	<L145+xTail_1
	bne	L10369
;        xReturn = pdTRUE;
	lda	#$1
	sta	<L145+xReturn_1
;    }
;    else
	bra	L10370
L10369:
;    {
;        xReturn = pdFALSE;
	stz	<L145+xReturn_1
;    }
L10370:
;
;    traceRETURN_xStreamBufferIsEmpty( xReturn );
;
;    return xReturn;
	lda	<L145+xReturn_1
	tay
	lda	<L144+1
	sta	<L144+1+4
	pld
	tsc
	clc
	adc	#L144+4
	tcs
	tya
	rts
;}
L144	equ	8
L145	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferIsFull( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~xStreamBufferIsFull
	func
_~xStreamBufferIsFull:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L149
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    BaseType_t xReturn;
;    size_t xBytesToStoreMessageLength;
;    const StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_xStreamBufferIsFull( xStreamBuffer );
xReturn_1	set	0
xBytesToStoreMessageLength_1	set	2
pxStreamBuffer_1	set	4
	lda	<L149+xStreamBuffer_0
	sta	<L150+pxStreamBuffer_1
	lda	<L149+xStreamBuffer_0+2
	sta	<L150+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L150+pxStreamBuffer_1
	ora	<L150+pxStreamBuffer_1+2
	bne	L10371
L10375:
	bra	L10375
L10371:
;
;    /* This generic version of the receive function is used by both message
;     * buffers, which store discrete messages, and stream buffers, which store a
;     * continuous stream of bytes.  Discrete messages include an additional
;     * sbBYTES_TO_STORE_MESSAGE_LENGTH bytes that hold the length of the message. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L150+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10378
;        xBytesToStoreMessageLength = sbBYTES_TO_STORE_MESSAGE_LENGTH;
	lda	#$2
	sta	<L150+xBytesToStoreMessageLength_1
;    }
;    else
	bra	L10379
L10378:
;    {
;        xBytesToStoreMessageLength = 0;
	stz	<L150+xBytesToStoreMessageLength_1
;    }
L10379:
;
;    /* True if the available space equals zero. */
;    if( xStreamBufferSpacesAvailable( xStreamBuffer ) <= xBytesToStoreMessageLength )
;    {
	pei	<L149+xStreamBuffer_0+2
	pei	<L149+xStreamBuffer_0
	jsr	_~xStreamBufferSpacesAvailable
	sta	<R0
	lda	<L150+xBytesToStoreMessageLength_1
	cmp	<R0
	bcc	L10380
;        xReturn = pdTRUE;
	lda	#$1
	sta	<L150+xReturn_1
;    }
;    else
	bra	L10381
L10380:
;    {
;        xReturn = pdFALSE;
	stz	<L150+xReturn_1
;    }
L10381:
;
;    traceRETURN_xStreamBufferIsFull( xReturn );
;
;    return xReturn;
	lda	<L150+xReturn_1
	tay
	lda	<L149+1
	sta	<L149+1+4
	pld
	tsc
	clc
	adc	#L149+4
	tcs
	tya
	rts
;}
L149	equ	12
L150	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferSendCompletedFromISR( StreamBufferHandle_t xStreamBuffer,
;                                              BaseType_t * pxHigherPriorityTaskWoken )
;{
	code
	xdef	_~xStreamBufferSendCompletedFromISR
	func
_~xStreamBufferSendCompletedFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L155
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
pxHigherPriorityTaskWoken_0	set	7
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    BaseType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;
;    traceENTER_xStreamBufferSendCompletedFromISR( xStreamBuffer, pxHigherPriorityTaskWoken );
pxStreamBuffer_1	set	0
xReturn_1	set	4
uxSavedInterruptStatus_1	set	6
	lda	<L155+xStreamBuffer_0
	sta	<L156+pxStreamBuffer_1
	lda	<L155+xStreamBuffer_0+2
	sta	<L156+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L156+pxStreamBuffer_1
	ora	<L156+pxStreamBuffer_1+2
	bne	L10382
L10386:
	bra	L10386
L10382:
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L156+uxSavedInterruptStatus_1
;    {
;        if( ( pxStreamBuffer )->xTaskWaitingToReceive != NULL )
;        {
	ldy	#$8
	lda	[<L156+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L156+pxStreamBuffer_1],Y
	beq	L10389
;            ( void ) xTaskNotifyIndexedFromISR( ( pxStreamBuffer )->xTaskWaitingToReceive,
;                                                ( pxStreamBuffer )->uxNotificationIndex,
;                                                ( uint32_t ) 0,
;                                                eNoAction,
;                                                pxHigherPriorityTaskWoken );
	pei	<L155+pxHigherPriorityTaskWoken_0+2
	pei	<L155+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L156+pxStreamBuffer_1],Y
	pha
	ldy	#$a
	lda	[<L156+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L156+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
;            ( pxStreamBuffer )->xTaskWaitingToReceive = NULL;
	lda	#$0
	ldy	#$8
	sta	[<L156+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L156+pxStreamBuffer_1],Y
;            xReturn = pdTRUE;
	ina
	sta	<L156+xReturn_1
;        }
;        else
	bra	L10390
L10389:
;        {
;            xReturn = pdFALSE;
	stz	<L156+xReturn_1
;        }
L10390:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xStreamBufferSendCompletedFromISR( xReturn );
;
;    return xReturn;
	lda	<L156+xReturn_1
	tay
	lda	<L155+1
	sta	<L155+1+8
	pld
	tsc
	clc
	adc	#L155+8
	tcs
	tya
	rts
;}
L155	equ	12
L156	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;BaseType_t xStreamBufferReceiveCompletedFromISR( StreamBufferHandle_t xStreamBuffer,
;                                                 BaseType_t * pxHigherPriorityTaskWoken )
;{
	code
	xdef	_~xStreamBufferReceiveCompletedFromISR
	func
_~xStreamBufferReceiveCompletedFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L160
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
pxHigherPriorityTaskWoken_0	set	7
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;    BaseType_t xReturn;
;    UBaseType_t uxSavedInterruptStatus;
;
;    traceENTER_xStreamBufferReceiveCompletedFromISR( xStreamBuffer, pxHigherPriorityTaskWoken );
pxStreamBuffer_1	set	0
xReturn_1	set	4
uxSavedInterruptStatus_1	set	6
	lda	<L160+xStreamBuffer_0
	sta	<L161+pxStreamBuffer_1
	lda	<L160+xStreamBuffer_0+2
	sta	<L161+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L161+pxStreamBuffer_1
	ora	<L161+pxStreamBuffer_1+2
	bne	L10391
L10395:
	bra	L10395
L10391:
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L161+uxSavedInterruptStatus_1
;    {
;        if( ( pxStreamBuffer )->xTaskWaitingToSend != NULL )
;        {
	ldy	#$c
	lda	[<L161+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L161+pxStreamBuffer_1],Y
	beq	L10398
;            ( void ) xTaskNotifyIndexedFromISR( ( pxStreamBuffer )->xTaskWaitingToSend,
;                                                ( pxStreamBuffer )->uxNotificationIndex,
;                                                ( uint32_t ) 0,
;                                                eNoAction,
;                                                pxHigherPriorityTaskWoken );
	pei	<L160+pxHigherPriorityTaskWoken_0+2
	pei	<L160+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L161+pxStreamBuffer_1],Y
	pha
	ldy	#$e
	lda	[<L161+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L161+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
;            ( pxStreamBuffer )->xTaskWaitingToSend = NULL;
	lda	#$0
	ldy	#$c
	sta	[<L161+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L161+pxStreamBuffer_1],Y
;            xReturn = pdTRUE;
	ina
	sta	<L161+xReturn_1
;        }
;        else
	bra	L10399
L10398:
;        {
;            xReturn = pdFALSE;
	stz	<L161+xReturn_1
;        }
L10399:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xStreamBufferReceiveCompletedFromISR( xReturn );
;
;    return xReturn;
	lda	<L161+xReturn_1
	tay
	lda	<L160+1
	sta	<L160+1+8
	pld
	tsc
	clc
	adc	#L160+8
	tcs
	tya
	rts
;}
L160	equ	12
L161	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static size_t prvWriteBytesToBuffer( StreamBuffer_t * const pxStreamBuffer,
;                                     const uint8_t * pucData,
;                                     size_t xCount,
;                                     size_t xHead )
;{
	code
	func
_~prvWriteBytesToBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L165
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
pucData_0	set	7
xCount_0	set	11
xHead_0	set	13
;    size_t xFirstLength;
;
;    configASSERT( xCount > ( size_t ) 0 );
xFirstLength_1	set	0
	lda	#$0
	cmp	<L165+xCount_0
	bcc	L10400
L10404:
	bra	L10404
L10400:
;
;    /* Calculate the number of bytes that can be added in the first write -
;     * which may be less than the total number of bytes that need to be added if
;     * the buffer will wrap back to the beginning. */
;    xFirstLength = configMIN( pxStreamBuffer->xLength - xHead, xCount );
	sec
	ldy	#$4
	lda	[<L165+pxStreamBuffer_0],Y
	sbc	<L165+xHead_0
	cmp	<L165+xCount_0
	bcs	L168
	sec
	lda	[<L165+pxStreamBuffer_0],Y
	sbc	<L165+xHead_0
	bra	L170
L168:
	lda	<L165+xCount_0
L170:
	sta	<L166+xFirstLength_1
	clc
	adc	<L165+xHead_0
	sta	<R0
	ldy	#$4
	lda	[<L165+pxStreamBuffer_0],Y
	cmp	<R0
	bcs	L10407
L10411:
	bra	L10411
L10407:
;    ( void ) memcpy( ( void * ) ( &( pxStreamBuffer->pucBuffer[ xHead ] ) ), ( const void * ) pucData, xFirstLength );
	pei	<L166+xFirstLength_1
	pei	<L165+pucData_0+2
	pei	<L165+pucData_0
	lda	<L165+xHead_0
	sta	<R0
	stz	<R0+2
	clc
	ldy	#$10
	lda	[<L165+pxStreamBuffer_0],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L165+pxStreamBuffer_0],Y
	adc	<R0+2
	pha
	pei	<R1
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;
;    /* If the number of bytes written was less than the number that could be
;     * written in the first write... */
;    if( xCount > xFirstLength )
;    {
	lda	<L166+xFirstLength_1
	cmp	<L165+xCount_0
	bcs	L10422
;        /* ...then write the remaining bytes to the start of the buffer. */
;        configASSERT( ( xCount - xFirstLength ) <= pxStreamBuffer->xLength );
	sec
	lda	<L165+xCount_0
	sbc	<L166+xFirstLength_1
	sta	<R0
	ldy	#$4
	lda	[<L165+pxStreamBuffer_0],Y
	cmp	<R0
	bcs	L10415
L10419:
	bra	L10419
L10415:
;        ( void ) memcpy( ( void * ) pxStreamBuffer->pucBuffer, ( const void * ) &( pucData[ xFirstLength ] ), xCount - xFirstLength );
	sec
	lda	<L165+xCount_0
	sbc	<L166+xFirstLength_1
	pha
	lda	<L166+xFirstLength_1
	sta	<R0
	stz	<R0+2
	lda	<L165+pucData_0
	clc
	adc	<R0
	sta	<R1
	lda	<L165+pucData_0+2
	adc	<R0+2
	pha
	pei	<R1
	ldy	#$12
	lda	[<L165+pxStreamBuffer_0],Y
	pha
	dey
	dey
	lda	[<L165+pxStreamBuffer_0],Y
	pha
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10422:
;
;    xHead += xCount;
	lda	<L165+xHead_0
	clc
	adc	<L165+xCount_0
	sta	<L165+xHead_0
;
;    if( xHead >= pxStreamBuffer->xLength )
;    {
	ldy	#$4
	cmp	[<L165+pxStreamBuffer_0],Y
	bcc	L10424
;        xHead -= pxStreamBuffer->xLength;
	sec
	lda	<L165+xHead_0
	sbc	[<L165+pxStreamBuffer_0],Y
	sta	<L165+xHead_0
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10424:
;
;    return xHead;
	lda	<L165+xHead_0
	tay
	lda	<L165+1
	sta	<L165+1+12
	pld
	tsc
	clc
	adc	#L165+12
	tcs
	tya
	rts
;}
L165	equ	10
L166	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static size_t prvReadBytesFromBuffer( StreamBuffer_t * pxStreamBuffer,
;                                      uint8_t * pucData,
;                                      size_t xCount,
;                                      size_t xTail )
;{
	code
	func
_~prvReadBytesFromBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L176
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
pucData_0	set	7
xCount_0	set	11
xTail_0	set	13
;    size_t xFirstLength;
;
;    configASSERT( xCount != ( size_t ) 0 );
xFirstLength_1	set	0
	lda	<L176+xCount_0
	bne	L10425
L10429:
	bra	L10429
L10425:
;
;    /* Calculate the number of bytes that can be read - which may be
;     * less than the number wanted if the data wraps around to the start of
;     * the buffer. */
;    xFirstLength = configMIN( pxStreamBuffer->xLength - xTail, xCount );
	sec
	ldy	#$4
	lda	[<L176+pxStreamBuffer_0],Y
	sbc	<L176+xTail_0
	cmp	<L176+xCount_0
	bcs	L179
	sec
	lda	[<L176+pxStreamBuffer_0],Y
	sbc	<L176+xTail_0
	bra	L181
L179:
	lda	<L176+xCount_0
L181:
	sta	<L177+xFirstLength_1
;
;    /* Obtain the number of bytes it is possible to obtain in the first
;     * read.  Asserts check bounds of read and write. */
;    configASSERT( xFirstLength <= xCount );
	lda	<L176+xCount_0
	cmp	<L177+xFirstLength_1
	bcs	L10432
L10436:
	bra	L10436
L10432:
;    configASSERT( ( xTail + xFirstLength ) <= pxStreamBuffer->xLength );
	lda	<L176+xTail_0
	clc
	adc	<L177+xFirstLength_1
	sta	<R0
	ldy	#$4
	lda	[<L176+pxStreamBuffer_0],Y
	cmp	<R0
	bcs	L10439
L10443:
	bra	L10443
L10439:
;    ( void ) memcpy( ( void * ) pucData, ( const void * ) &( pxStreamBuffer->pucBuffer[ xTail ] ), xFirstLength );
	pei	<L177+xFirstLength_1
	lda	<L176+xTail_0
	sta	<R0
	stz	<R0+2
	clc
	ldy	#$10
	lda	[<L176+pxStreamBuffer_0],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L176+pxStreamBuffer_0],Y
	adc	<R0+2
	pha
	pei	<R1
	pei	<L176+pucData_0+2
	pei	<L176+pucData_0
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;
;    /* If the total number of wanted bytes is greater than the number
;     * that could be read in the first read... */
;    if( xCount > xFirstLength )
;    {
	lda	<L177+xFirstLength_1
	cmp	<L176+xCount_0
	bcs	L10447
;        /* ...then read the remaining bytes from the start of the buffer. */
;        ( void ) memcpy( ( void * ) &( pucData[ xFirstLength ] ), ( void * ) ( pxStreamBuffer->pucBuffer ), xCount - xFirstLength );
	sec
	lda	<L176+xCount_0
	sbc	<L177+xFirstLength_1
	pha
	ldy	#$12
	lda	[<L176+pxStreamBuffer_0],Y
	pha
	dey
	dey
	lda	[<L176+pxStreamBuffer_0],Y
	pha
	lda	<L177+xFirstLength_1
	sta	<R0
	stz	<R0+2
	lda	<L176+pucData_0
	clc
	adc	<R0
	sta	<R1
	lda	<L176+pucData_0+2
	adc	<R0+2
	pha
	pei	<R1
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10447:
;
;    /* Move the tail pointer to effectively remove the data read from the buffer. */
;    xTail += xCount;
	lda	<L176+xTail_0
	clc
	adc	<L176+xCount_0
	sta	<L176+xTail_0
;
;    if( xTail >= pxStreamBuffer->xLength )
;    {
	ldy	#$4
	cmp	[<L176+pxStreamBuffer_0],Y
	bcc	L10448
;        xTail -= pxStreamBuffer->xLength;
	sec
	lda	<L176+xTail_0
	sbc	[<L176+pxStreamBuffer_0],Y
	sta	<L176+xTail_0
;    }
;
;    return xTail;
L10448:
	lda	<L176+xTail_0
	tay
	lda	<L176+1
	sta	<L176+1+12
	pld
	tsc
	clc
	adc	#L176+12
	tcs
	tya
	rts
;}
L176	equ	10
L177	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static size_t prvBytesInBuffer( const StreamBuffer_t * const pxStreamBuffer )
;{
	code
	func
_~prvBytesInBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L187
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
;    /* Returns the distance between xTail and xHead. */
;    size_t xCount;
;
;    xCount = pxStreamBuffer->xLength + pxStreamBuffer->xHead;
xCount_1	set	0
	clc
	ldy	#$4
	lda	[<L187+pxStreamBuffer_0],Y
	dey
	dey
	adc	[<L187+pxStreamBuffer_0],Y
	sta	<L188+xCount_1
;    xCount -= pxStreamBuffer->xTail;
	sec
	sbc	[<L187+pxStreamBuffer_0]
	sta	<L188+xCount_1
;
;    if( xCount >= pxStreamBuffer->xLength )
;    {
	iny
	iny
	cmp	[<L187+pxStreamBuffer_0],Y
	bcc	L10450
;        xCount -= pxStreamBuffer->xLength;
	sec
	lda	<L188+xCount_1
	sbc	[<L187+pxStreamBuffer_0],Y
	sta	<L188+xCount_1
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10450:
;
;    return xCount;
	lda	<L188+xCount_1
	tay
	lda	<L187+1
	sta	<L187+1+4
	pld
	tsc
	clc
	adc	#L187+4
	tcs
	tya
	rts
;}
L187	equ	2
L188	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static BaseType_t prvBytesInBufferMeetTriggerLevel( const StreamBuffer_t * const pxStreamBuffer,
;                                                    size_t xBytesInBuffer )
;{
	code
	func
_~prvBytesInBufferMeetTriggerLevel:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L191
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
xBytesInBuffer_0	set	7
;    BaseType_t xReturn = pdFALSE;
;
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_BATCHING_BUFFER ) != ( uint8_t ) 0 )
xReturn_1	set	0
	stz	<L192+xReturn_1
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L191+pxStreamBuffer_0],Y
	and	#<$4
	rep	#$20
	longa	on
	beq	L10451
;        if( xBytesInBuffer > pxStreamBuffer->xTriggerLevelBytes )
;        {
	ldy	#$6
	lda	[<L191+pxStreamBuffer_0],Y
	cmp	<L191+xBytesInBuffer_0
	bcs	L10454
;            xReturn = pdTRUE;
L20011:
	lda	#$1
	sta	<L192+xReturn_1
;        }
;        else
L10454:
;
;    return xReturn;
	lda	<L192+xReturn_1
	tay
	lda	<L191+1
	sta	<L191+1+6
	pld
	tsc
	clc
	adc	#L191+6
	tcs
	tya
	rts
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else if( xBytesInBuffer >= pxStreamBuffer->xTriggerLevelBytes )
L10451:
;    {
	lda	<L191+xBytesInBuffer_0
	ldy	#$6
	cmp	[<L191+pxStreamBuffer_0],Y
	bcc	L10454
;        xReturn = pdTRUE;
	bra	L20011
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L191	equ	2
L192	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;static void prvInitialiseNewStreamBuffer( StreamBuffer_t * const pxStreamBuffer,
;                                          uint8_t * const pucBuffer,
;                                          size_t xBufferSizeBytes,
;                                          size_t xTriggerLevelBytes,
;                                          uint8_t ucFlags,
;                                          StreamBufferCallbackFunction_t pxSendCompletedCallback,
;                                          StreamBufferCallbackFunction_t pxReceiveCompletedCallback )
;{
	code
	func
_~prvInitialiseNewStreamBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L197
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
pucBuffer_0	set	7
xBufferSizeBytes_0	set	11
xTriggerLevelBytes_0	set	13
ucFlags_0	set	15
pxSendCompletedCallback_0	set	17
pxReceiveCompletedCallback_0	set	19
;    /* Assert here is deliberately writing to the entire buffer to ensure it can
;     * be written to without generating exceptions, and is setting the buffer to a
;     * known value to assist in development/debugging. */
;    #if ( configASSERT_DEFINED == 1 )
;    {
;        /* The value written just has to be identifiable when looking at the
;         * memory.  Don't use 0xA5 as that is the stack fill value and could
;         * result in confusion as to what is actually being observed. */
;        #define STREAM_BUFFER_BUFFER_WRITE_VALUE    ( 0x55 )
;        configASSERT( memset( pucBuffer, ( int ) STREAM_BUFFER_BUFFER_WRITE_VALUE, xBufferSizeBytes ) == pucBuffer );
	pei	<L197+xBufferSizeBytes_0
	pea	#<$55
	pei	<L197+pucBuffer_0+2
	pei	<L197+pucBuffer_0
	jsr	_~memset
	stx	<R0+2
	cmp	<L197+pucBuffer_0
	bne	L199
	lda	<R0+2
	cmp	<L197+pucBuffer_0+2
L199:
	beq	L10457
L10461:
	bra	L10461
L10457:
;    }
;    #endif
;
;    ( void ) memset( ( void * ) pxStreamBuffer, 0x00, sizeof( StreamBuffer_t ) );
	pea	#<$17
	pea	#<$0
	pei	<L197+pxStreamBuffer_0+2
	pei	<L197+pxStreamBuffer_0
	jsr	_~memset
;    pxStreamBuffer->pucBuffer = pucBuffer;
	lda	<L197+pucBuffer_0
	ldy	#$10
	sta	[<L197+pxStreamBuffer_0],Y
	lda	<L197+pucBuffer_0+2
	iny
	iny
	sta	[<L197+pxStreamBuffer_0],Y
;    pxStreamBuffer->xLength = xBufferSizeBytes;
	lda	<L197+xBufferSizeBytes_0
	ldy	#$4
	sta	[<L197+pxStreamBuffer_0],Y
;    pxStreamBuffer->xTriggerLevelBytes = xTriggerLevelBytes;
	lda	<L197+xTriggerLevelBytes_0
	iny
	iny
	sta	[<L197+pxStreamBuffer_0],Y
;    pxStreamBuffer->ucFlags = ucFlags;
	sep	#$20
	longa	off
	lda	<L197+ucFlags_0
	ldy	#$14
	sta	[<L197+pxStreamBuffer_0],Y
	rep	#$20
	longa	on
;    pxStreamBuffer->uxNotificationIndex = tskDEFAULT_INDEX_TO_NOTIFY;
	lda	#$0
	iny
	sta	[<L197+pxStreamBuffer_0],Y
;    #if ( configUSE_SB_COMPLETED_CALLBACK == 1 )
;    {
;        pxStreamBuffer->pxSendCompletedCallback = pxSendCompletedCallback;
;        pxStreamBuffer->pxReceiveCompletedCallback = pxReceiveCompletedCallback;
;    }
;    #else
;    {
;        /* MISRA Ref 11.1.1 [Object type casting] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-111 */
;        /* coverity[misra_c_2012_rule_11_1_violation] */
;        ( void ) pxSendCompletedCallback;
;
;        /* MISRA Ref 11.1.1 [Object type casting] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-111 */
;        /* coverity[misra_c_2012_rule_11_1_violation] */
;        ( void ) pxReceiveCompletedCallback;
;    }
;    #endif /* if ( configUSE_SB_COMPLETED_CALLBACK == 1 ) */
;}
	lda	<L197+1
	sta	<L197+1+18
	pld
	tsc
	clc
	adc	#L197+18
	tcs
	rts
L197	equ	4
L198	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;UBaseType_t uxStreamBufferGetStreamBufferNotificationIndex( StreamBufferHandle_t xStreamBuffer )
;{
	code
	xdef	_~uxStreamBufferGetStreamBufferNotificationIndex
	func
_~uxStreamBufferGetStreamBufferNotificationIndex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L202
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_uxStreamBufferGetStreamBufferNotificationIndex( xStreamBuffer );
pxStreamBuffer_1	set	0
	lda	<L202+xStreamBuffer_0
	sta	<L203+pxStreamBuffer_1
	lda	<L202+xStreamBuffer_0+2
	sta	<L203+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L203+pxStreamBuffer_1
	ora	<L203+pxStreamBuffer_1+2
	bne	L10464
L10468:
	bra	L10468
L10464:
;
;    traceRETURN_uxStreamBufferGetStreamBufferNotificationIndex( pxStreamBuffer->uxNotificationIndex );
;
;    return pxStreamBuffer->uxNotificationIndex;
	ldy	#$15
	lda	[<L203+pxStreamBuffer_1],Y
	tay
	lda	<L202+1
	sta	<L202+1+4
	pld
	tsc
	clc
	adc	#L202+4
	tcs
	tya
	rts
;}
L202	equ	4
L203	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;void vStreamBufferSetStreamBufferNotificationIndex( StreamBufferHandle_t xStreamBuffer,
;                                                    UBaseType_t uxNotificationIndex )
;{
	code
	xdef	_~vStreamBufferSetStreamBufferNotificationIndex
	func
_~vStreamBufferSetStreamBufferNotificationIndex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L206
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
uxNotificationIndex_0	set	7
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_vStreamBufferSetStreamBufferNotificationIndex( xStreamBuffer, uxNotificationIndex );
pxStreamBuffer_1	set	0
	lda	<L206+xStreamBuffer_0
	sta	<L207+pxStreamBuffer_1
	lda	<L206+xStreamBuffer_0+2
	sta	<L207+pxStreamBuffer_1+2
;
;    /* There should be no task waiting otherwise we'd never resume them. */
;    configASSERT( ( pxStreamBuffer != NULL ) && ( pxStreamBuffer->xTaskWaitingToReceive == NULL ) );
	lda	<L207+pxStreamBuffer_1
	ora	<L207+pxStreamBuffer_1+2
	beq	L10475
	ldy	#$8
	lda	[<L207+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L207+pxStreamBuffer_1],Y
	beq	L10471
L10475:
	bra	L10475
L10471:
;    configASSERT( ( pxStreamBuffer != NULL ) && ( pxStreamBuffer->xTaskWaitingToSend == NULL ) );
	lda	<L207+pxStreamBuffer_1
	ora	<L207+pxStreamBuffer_1+2
	beq	L10482
	ldy	#$c
	lda	[<L207+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L207+pxStreamBuffer_1],Y
	beq	L10478
L10482:
	bra	L10482
L10478:
;
;    /* Check that the task notification index is valid. */
;    configASSERT( uxNotificationIndex < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L206+uxNotificationIndex_0
	cmp	#<$1
	bcc	L10485
L10489:
	bra	L10489
L10485:
;
;    pxStreamBuffer->uxNotificationIndex = uxNotificationIndex;
	lda	<L206+uxNotificationIndex_0
	ldy	#$15
	sta	[<L207+pxStreamBuffer_1],Y
;
;    traceRETURN_vStreamBufferSetStreamBufferNotificationIndex();
;}
	lda	<L206+1
	sta	<L206+1+6
	pld
	tsc
	clc
	adc	#L206+6
	tcs
	rts
L206	equ	4
L207	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;    UBaseType_t uxStreamBufferGetStreamBufferNumber( StreamBufferHandle_t xStreamBuffer )
;    {
;        traceENTER_uxStreamBufferGetStreamBufferNumber( xStreamBuffer );
;
;        traceRETURN_uxStreamBufferGetStreamBufferNumber( xStreamBuffer->uxStreamBufferNumber );
;
;        return xStreamBuffer->uxStreamBufferNumber;
;    }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;    void vStreamBufferSetStreamBufferNumber( StreamBufferHandle_t xStreamBuffer,
;                                             UBaseType_t uxStreamBufferNumber )
;    {
;        traceENTER_vStreamBufferSetStreamBufferNumber( xStreamBuffer, uxStreamBufferNumber );
;
;        xStreamBuffer->uxStreamBufferNumber = uxStreamBufferNumber;
;
;        traceRETURN_vStreamBufferSetStreamBufferNumber();
;    }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;    uint8_t ucStreamBufferGetStreamBufferType( StreamBufferHandle_t xStreamBuffer )
;    {
;        traceENTER_ucStreamBufferGetStreamBufferType( xStreamBuffer );
;
;        traceRETURN_ucStreamBufferGetStreamBufferType( ( uint8_t ) ( xStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) );
;
;        return( ( uint8_t ) ( xStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) );
;    }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;/* This entire source file will be skipped if the application is not configured
; * to include stream buffer functionality. This #if is closed at the very bottom
; * of this file. If you want to include stream buffers then ensure
; * configUSE_STREAM_BUFFERS is set to 1 in FreeRTOSConfig.h. */
;#endif /* configUSE_STREAM_BUFFERS == 1 */
;
	xref	_~xTaskGetCurrentTaskHandle
	xref	_~xTaskCheckForTimeOut
	xref	_~vTaskSetTimeOutState
	xref	_~xTaskGenericNotifyStateClear
	xref	_~xTaskGenericNotifyWait
	xref	_~xTaskGenericNotifyFromISR
	xref	_~xTaskGenericNotify
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~vPortFree
	xref	_~pvPortMalloc
	xref	_~memset
	xref	_~memcpy

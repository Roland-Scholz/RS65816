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
;        /* MISRA Ref 11.3.1 [Misaligned access] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;        /* coverity[misra_c_2012_rule_11_3_violation] */
;        StreamBuffer_t * const pxStreamBuffer = ( StreamBuffer_t * ) pxStaticStreamBuffer;
;        StreamBufferHandle_t xReturn;
;        uint8_t ucFlags;
;
;        traceENTER_xStreamBufferGenericCreateStatic( xBufferSizeBytes, xTriggerLevelBytes, xStreamBufferType, pucStreamBufferStorageArea, pxStaticStreamBuffer, pxSendCompletedCallback, pxReceiveCompletedCallback );
;
;        configASSERT( pucStreamBufferStorageArea );
;        configASSERT( pxStaticStreamBuffer );
;        configASSERT( xTriggerLevelBytes <= xBufferSizeBytes );
;
;        /* A trigger level of 0 would cause a waiting task to unblock even when
;         * the buffer was empty. */
;        if( xTriggerLevelBytes == ( size_t ) 0 )
;        {
;            xTriggerLevelBytes = ( size_t ) 1;
;        }
;
;        /* In case the stream buffer is going to be used as a message buffer
;         * (that is, it will hold discrete messages with a little meta data that
;         * says how big the next message is) check the buffer will be large enough
;         * to hold at least one message. */
;
;        if( xStreamBufferType == sbTYPE_MESSAGE_BUFFER )
;        {
;            /* Statically allocated message buffer. */
;            ucFlags = sbFLAGS_IS_MESSAGE_BUFFER | sbFLAGS_IS_STATICALLY_ALLOCATED;
;            configASSERT( xBufferSizeBytes > sbBYTES_TO_STORE_MESSAGE_LENGTH );
;        }
;        else if( xStreamBufferType == sbTYPE_STREAM_BATCHING_BUFFER )
;        {
;            /* Statically allocated batching buffer. */
;            ucFlags = sbFLAGS_IS_BATCHING_BUFFER | sbFLAGS_IS_STATICALLY_ALLOCATED;
;            configASSERT( xBufferSizeBytes > 0 );
;        }
;        else
;        {
;            /* Statically allocated stream buffer. */
;            ucFlags = sbFLAGS_IS_STATICALLY_ALLOCATED;
;        }
;
;        #if ( configASSERT_DEFINED == 1 )
;        {
;            /* Sanity check that the size of the structure used to declare a
;             * variable of type StaticStreamBuffer_t equals the size of the real
;             * message buffer structure. */
;            volatile size_t xSize = sizeof( StaticStreamBuffer_t );
;            configASSERT( xSize == sizeof( StreamBuffer_t ) );
;        }
;        #endif /* configASSERT_DEFINED */
;
;        if( ( pucStreamBufferStorageArea != NULL ) && ( pxStaticStreamBuffer != NULL ) )
;        {
;            prvInitialiseNewStreamBuffer( pxStreamBuffer,
;                                          pucStreamBufferStorageArea,
;                                          xBufferSizeBytes,
;                                          xTriggerLevelBytes,
;                                          ucFlags,
;                                          pxSendCompletedCallback,
;                                          pxReceiveCompletedCallback );
;
;            /* Remember this was statically allocated in case it is ever deleted
;             * again. */
;            pxStreamBuffer->ucFlags |= sbFLAGS_IS_STATICALLY_ALLOCATED;
;
;            traceSTREAM_BUFFER_CREATE( pxStreamBuffer, xStreamBufferType );
;
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            xReturn = ( StreamBufferHandle_t ) pxStaticStreamBuffer;
;        }
;        else
;        {
;            xReturn = NULL;
;            traceSTREAM_BUFFER_CREATE_STATIC_FAILED( xReturn, xStreamBufferType );
;        }
;
;        traceRETURN_xStreamBufferGenericCreateStatic( xReturn );
;
;        return xReturn;
;    }
;    #endif /* ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;    BaseType_t xStreamBufferGetStaticBuffers( StreamBufferHandle_t xStreamBuffer,
;                                              uint8_t ** ppucStreamBufferStorageArea,
;                                              StaticStreamBuffer_t ** ppxStaticStreamBuffer )
;    {
;        BaseType_t xReturn;
;        StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;        traceENTER_xStreamBufferGetStaticBuffers( xStreamBuffer, ppucStreamBufferStorageArea, ppxStaticStreamBuffer );
;
;        configASSERT( pxStreamBuffer );
;        configASSERT( ppucStreamBufferStorageArea );
;        configASSERT( ppxStaticStreamBuffer );
;
;        if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_STATICALLY_ALLOCATED ) != ( uint8_t ) 0 )
;        {
;            *ppucStreamBufferStorageArea = pxStreamBuffer->pucBuffer;
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            *ppxStaticStreamBuffer = ( StaticStreamBuffer_t * ) pxStreamBuffer;
;            xReturn = pdTRUE;
;        }
;        else
;        {
;            xReturn = pdFALSE;
;        }
;
;        traceRETURN_xStreamBufferGetStaticBuffers( xReturn );
;
;        return xReturn;
;    }
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
	sbc	#L14
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_vStreamBufferDelete( xStreamBuffer );
pxStreamBuffer_1	set	0
	lda	<L14+xStreamBuffer_0
	sta	<L15+pxStreamBuffer_1
	lda	<L14+xStreamBuffer_0+2
	sta	<L15+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L15+pxStreamBuffer_1
	ora	<L15+pxStreamBuffer_1+2
	bne	L10038
L10042:
	bra	L10042
L10038:
;
;    traceSTREAM_BUFFER_DELETE( xStreamBuffer );
;
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_STATICALLY_ALLOCATED ) == ( uint8_t ) pdFALSE )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L15+pxStreamBuffer_1],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10045
;        #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;        {
;            /* Both the structure and the buffer were allocated using a single call
;            * to pvPortMalloc(), hence only one call to vPortFree() is required. */
;            vPortFree( ( void * ) pxStreamBuffer );
	pei	<L15+pxStreamBuffer_1+2
	pei	<L15+pxStreamBuffer_1
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
	bra	L18
L10045:
;    {
;        /* The structure and buffer were not allocated dynamically and cannot be
;         * freed - just scrub the structure so future use will assert. */
;        ( void ) memset( pxStreamBuffer, 0x00, sizeof( StreamBuffer_t ) );
	pea	#<$17
	pea	#<$0
	pei	<L15+pxStreamBuffer_1+2
	pei	<L15+pxStreamBuffer_1
	jsr	_~memset
;    }
;
;    traceRETURN_vStreamBufferDelete();
;}
L18:
	lda	<L14+1
	sta	<L14+1+4
	pld
	tsc
	clc
	adc	#L14+4
	tcs
	rts
L14	equ	8
L15	equ	5
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
	sbc	#L19
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
	lda	<L19+xStreamBuffer_0
	sta	<L20+pxStreamBuffer_1
	lda	<L19+xStreamBuffer_0+2
	sta	<L20+pxStreamBuffer_1+2
	stz	<L20+xReturn_1
	stz	<L20+pxSendCallback_1
;	pxReceiveCallback = (StreamBufferCallbackFunction_t)0;
	stz	<L20+pxReceiveCallback_1
;	
;    #if ( configUSE_TRACE_FACILITY == 1 )
;        UBaseType_t uxStreamBufferNumber;
;    #endif
;
;    traceENTER_xStreamBufferReset( xStreamBuffer );
;
;    configASSERT( pxStreamBuffer );
	lda	<L20+pxStreamBuffer_1
	ora	<L20+pxStreamBuffer_1+2
	bne	L10055
L10051:
	bra	L10051
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
L10055:
;    {
;        if( ( pxStreamBuffer->xTaskWaitingToReceive == NULL ) && ( pxStreamBuffer->xTaskWaitingToSend == NULL ) )
;        {
	ldy	#$8
	lda	[<L20+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L20+pxStreamBuffer_1],Y
	bne	L10059
	iny
	iny
	lda	[<L20+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L20+pxStreamBuffer_1],Y
	bne	L10059
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
	pei	<L20+pxReceiveCallback_1
	pei	<L20+pxSendCallback_1
	ldy	#$14
	lda	[<L20+pxStreamBuffer_1],Y
	pha
	ldy	#$6
	lda	[<L20+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L20+pxStreamBuffer_1],Y
	pha
	ldy	#$12
	lda	[<L20+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L20+pxStreamBuffer_1],Y
	pha
	pei	<L20+pxStreamBuffer_1+2
	pei	<L20+pxStreamBuffer_1
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
	sta	<L20+xReturn_1
;        }
;    }
;    taskEXIT_CRITICAL();
L10059:
;
;    traceRETURN_xStreamBufferReset( xReturn );
;
;    return xReturn;
	lda	<L20+xReturn_1
	tay
	lda	<L19+1
	sta	<L19+1+4
	pld
	tsc
	clc
	adc	#L19+4
	tcs
	tya
	rts
;}
L19	equ	10
L20	equ	1
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
	sbc	#L25
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
	lda	<L25+xStreamBuffer_0
	sta	<L26+pxStreamBuffer_1
	lda	<L25+xStreamBuffer_0+2
	sta	<L26+pxStreamBuffer_1+2
	stz	<L26+xReturn_1
	stz	<L26+pxSendCallback_1
	stz	<L26+pxReceiveCallback_1
;
;    configASSERT( pxStreamBuffer );
	lda	<L26+pxStreamBuffer_1
	ora	<L26+pxStreamBuffer_1+2
	bne	L10061
L10065:
	bra	L10065
L10061:
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
	stz	<L26+uxSavedInterruptStatus_1
;    {
;        if( ( pxStreamBuffer->xTaskWaitingToReceive == NULL ) && ( pxStreamBuffer->xTaskWaitingToSend == NULL ) )
;        {
	ldy	#$8
	lda	[<L26+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L26+pxStreamBuffer_1],Y
	bne	L10068
	iny
	iny
	lda	[<L26+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L26+pxStreamBuffer_1],Y
	bne	L10068
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
	pei	<L26+pxReceiveCallback_1
	pei	<L26+pxSendCallback_1
	ldy	#$14
	lda	[<L26+pxStreamBuffer_1],Y
	pha
	ldy	#$6
	lda	[<L26+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L26+pxStreamBuffer_1],Y
	pha
	ldy	#$12
	lda	[<L26+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L26+pxStreamBuffer_1],Y
	pha
	pei	<L26+pxStreamBuffer_1+2
	pei	<L26+pxStreamBuffer_1
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
	sta	<L26+xReturn_1
;        }
;    }
L10068:
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xStreamBufferResetFromISR( xReturn );
;
;    return xReturn;
	lda	<L26+xReturn_1
	tay
	lda	<L25+1
	sta	<L25+1+4
	pld
	tsc
	clc
	adc	#L25+4
	tcs
	tya
	rts
;}
L25	equ	12
L26	equ	1
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
	sbc	#L31
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
	lda	<L31+xStreamBuffer_0
	sta	<L32+pxStreamBuffer_1
	lda	<L31+xStreamBuffer_0+2
	sta	<L32+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L32+pxStreamBuffer_1
	ora	<L32+pxStreamBuffer_1+2
	bne	L10069
L10073:
	bra	L10073
L10069:
;
;    /* It is not valid for the trigger level to be 0. */
;    if( xTriggerLevel == ( size_t ) 0 )
;    {
	lda	<L31+xTriggerLevel_0
	bne	L10076
;        xTriggerLevel = ( size_t ) 1;
	lda	#$1
	sta	<L31+xTriggerLevel_0
;    }
;
;    /* The trigger level is the number of bytes that must be in the stream
;     * buffer before a task that is waiting for data is unblocked. */
;    if( xTriggerLevel < pxStreamBuffer->xLength )
L10076:
;    {
	lda	<L31+xTriggerLevel_0
	ldy	#$4
	cmp	[<L32+pxStreamBuffer_1],Y
	bcs	L10077
;        pxStreamBuffer->xTriggerLevelBytes = xTriggerLevel;
	lda	<L31+xTriggerLevel_0
	iny
	iny
	sta	[<L32+pxStreamBuffer_1],Y
;        xReturn = pdPASS;
	lda	#$1
	sta	<L32+xReturn_1
;    }
;    else
	bra	L10078
L10077:
;    {
;        xReturn = pdFALSE;
	stz	<L32+xReturn_1
;    }
L10078:
;
;    traceRETURN_xStreamBufferSetTriggerLevel( xReturn );
;
;    return xReturn;
	lda	<L32+xReturn_1
	tay
	lda	<L31+1
	sta	<L31+1+6
	pld
	tsc
	clc
	adc	#L31+6
	tcs
	tya
	rts
;}
L31	equ	6
L32	equ	1
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
	sbc	#L37
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
	lda	<L37+xStreamBuffer_0
	sta	<L38+pxStreamBuffer_1
	lda	<L37+xStreamBuffer_0+2
	sta	<L38+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L38+pxStreamBuffer_1
	ora	<L38+pxStreamBuffer_1+2
	bne	L10088
L10083:
	bra	L10083
;
;    /* The code below reads xTail and then xHead.  This is safe if the stream
;     * buffer is updated once between the two reads - but not if the stream buffer
;     * is updated more than once between the two reads - hence the loop. */
;    do
L10088:
;    {
;        xOriginalTail = pxStreamBuffer->xTail;
	lda	[<L38+pxStreamBuffer_1]
	sta	<L38+xOriginalTail_1
;        xSpace = pxStreamBuffer->xLength + pxStreamBuffer->xTail;
	clc
	ldy	#$4
	lda	[<L38+pxStreamBuffer_1],Y
	adc	[<L38+pxStreamBuffer_1]
	sta	<L38+xSpace_1
;        xSpace -= pxStreamBuffer->xHead;
	sec
	dey
	dey
	sbc	[<L38+pxStreamBuffer_1],Y
	sta	<L38+xSpace_1
;    } while( xOriginalTail != pxStreamBuffer->xTail );
	lda	<L38+xOriginalTail_1
	cmp	[<L38+pxStreamBuffer_1]
	bne	L10088
;
;    xSpace -= ( size_t ) 1;
	dec	<L38+xSpace_1
;
;    if( xSpace >= pxStreamBuffer->xLength )
;    {
	lda	<L38+xSpace_1
	iny
	iny
	cmp	[<L38+pxStreamBuffer_1],Y
	bcc	L10090
;        xSpace -= pxStreamBuffer->xLength;
	sec
	lda	<L38+xSpace_1
	sbc	[<L38+pxStreamBuffer_1],Y
	sta	<L38+xSpace_1
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10090:
;
;    traceRETURN_xStreamBufferSpacesAvailable( xSpace );
;
;    return xSpace;
	lda	<L38+xSpace_1
	tay
	lda	<L37+1
	sta	<L37+1+4
	pld
	tsc
	clc
	adc	#L37+4
	tcs
	tya
	rts
;}
L37	equ	8
L38	equ	1
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
	sbc	#L43
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
	lda	<L43+xStreamBuffer_0
	sta	<L44+pxStreamBuffer_1
	lda	<L43+xStreamBuffer_0+2
	sta	<L44+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L44+pxStreamBuffer_1
	ora	<L44+pxStreamBuffer_1+2
	bne	L10091
L10095:
	bra	L10095
L10091:
;
;    xReturn = prvBytesInBuffer( pxStreamBuffer );
	pei	<L44+pxStreamBuffer_1+2
	pei	<L44+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L44+xReturn_1
;
;    traceRETURN_xStreamBufferBytesAvailable( xReturn );
;
;    return xReturn;
	tay
	lda	<L43+1
	sta	<L43+1+4
	pld
	tsc
	clc
	adc	#L43+4
	tcs
	tya
	rts
;}
L43	equ	6
L44	equ	1
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
	sbc	#L47
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
	lda	<L47+xStreamBuffer_0
	sta	<L48+pxStreamBuffer_1
	lda	<L47+xStreamBuffer_0+2
	sta	<L48+pxStreamBuffer_1+2
	stz	<L48+xSpace_1
	lda	<L47+xDataLengthBytes_0
	sta	<L48+xRequiredSpace_1
	stz	<L48+xMaxReportedSpace_1
;
;    configASSERT( pvTxData );
	lda	<L47+pvTxData_0
	ora	<L47+pvTxData_0+2
	bne	L10098
L10102:
	bra	L10102
L10098:
;    configASSERT( pxStreamBuffer );
	lda	<L48+pxStreamBuffer_1
	ora	<L48+pxStreamBuffer_1+2
	bne	L10105
L10109:
	bra	L10109
L10105:
;
;    /* The maximum amount of space a stream buffer will ever report is its length
;     * minus 1. */
;    xMaxReportedSpace = pxStreamBuffer->xLength - ( size_t ) 1;
	clc
	lda	#$ffff
	ldy	#$4
	adc	[<L48+pxStreamBuffer_1],Y
	sta	<L48+xMaxReportedSpace_1
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
	lda	[<L48+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10112
;        xRequiredSpace += sbBYTES_TO_STORE_MESSAGE_LENGTH;
	inc	<L48+xRequiredSpace_1
	inc	<L48+xRequiredSpace_1
;
;        /* Overflow? */
;        configASSERT( xRequiredSpace > xDataLengthBytes );
	lda	<L47+xDataLengthBytes_0
	cmp	<L48+xRequiredSpace_1
	bcc	L10113
L10117:
	bra	L10117
L10113:
;
;        /* If this is a message buffer then it must be possible to write the
;         * whole message. */
;        if( xRequiredSpace > xMaxReportedSpace )
;        {
	lda	<L48+xMaxReportedSpace_1
	cmp	<L48+xRequiredSpace_1
	bcs	L10122
;            /* The message would not fit even if the entire buffer was empty,
;             * so don't wait for space. */
;            xTicksToWait = ( TickType_t ) 0;
	stz	<L47+xTicksToWait_0
	stz	<L47+xTicksToWait_0+2
;        }
;        else
	bra	L10122
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
L10112:
;    {
;        /* If this is a stream buffer then it is acceptable to write only part
;         * of the message to the buffer.  Cap the length to the total length of
;         * the buffer. */
;        if( xRequiredSpace > xMaxReportedSpace )
;        {
	lda	<L48+xMaxReportedSpace_1
	cmp	<L48+xRequiredSpace_1
	bcs	L10122
;            xRequiredSpace = xMaxReportedSpace;
	lda	<L48+xMaxReportedSpace_1
	sta	<L48+xRequiredSpace_1
;        }
;        else
L10122:
;
;    if( xTicksToWait != ( TickType_t ) 0 )
;    {
	lda	<L47+xTicksToWait_0
	ora	<L47+xTicksToWait_0+2
	bne	*+5
	brl	L10147
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;        vTaskSetTimeOutState( &xTimeOut );
	pea	#0
	clc
	tdc
	adc	#<L48+xTimeOut_1
	pha
	jsr	_~vTaskSetTimeOutState
;
;        do
;        {
;            /* Wait until the required number of bytes are free in the message
;             * buffer. */
;            taskENTER_CRITICAL();
	bra	L10130
L20002:
;                    /* Clear notification state as going to wait for space. */
;                    ( void ) xTaskNotifyStateClearIndexed( NULL, pxStreamBuffer->uxNotificationIndex );
	ldy	#$15
	lda	[<L48+pxStreamBuffer_1],Y
	pha
	pea	#^$0
	pea	#<$0
	jsr	_~xTaskGenericNotifyStateClear
	sta	<R0
;
;                    /* Should only be one writer. */
;                    configASSERT( pxStreamBuffer->xTaskWaitingToSend == NULL );
	ldy	#$c
	lda	[<L48+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L48+pxStreamBuffer_1],Y
	beq	L10133
L10137:
	bra	L10137
L10133:
;                    pxStreamBuffer->xTaskWaitingToSend = xTaskGetCurrentTaskHandle();
	jsr	_~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$c
	sta	[<L48+pxStreamBuffer_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L48+pxStreamBuffer_1],Y
;                }
;                else
;
;            traceBLOCKING_ON_STREAM_BUFFER_SEND( xStreamBuffer );
;            ( void ) xTaskNotifyWaitIndexed( pxStreamBuffer->uxNotificationIndex, ( uint32_t ) 0, ( uint32_t ) 0, NULL, xTicksToWait );
	pei	<L47+xTicksToWait_0+2
	pei	<L47+xTicksToWait_0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L48+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyWait
	sta	<R0
;            pxStreamBuffer->xTaskWaitingToSend = NULL;
	lda	#$0
	ldy	#$c
	sta	[<L48+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L48+pxStreamBuffer_1],Y
;        } while( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) == pdFALSE );
	pea	#0
	clc
	tdc
	adc	#<L47+xTicksToWait_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L48+xTimeOut_1
	pha
	jsr	_~xTaskCheckForTimeOut
	tax
	bne	L10147
L10130:
;            {
;                xSpace = xStreamBufferSpacesAvailable( pxStreamBuffer );
	pei	<L48+pxStreamBuffer_1+2
	pei	<L48+pxStreamBuffer_1
	jsr	_~xStreamBufferSpacesAvailable
	sta	<L48+xSpace_1
;
;                if( xSpace < xRequiredSpace )
;                {
	cmp	<L48+xRequiredSpace_1
	bcs	*+5
	brl	L20002
;                {
;                    taskEXIT_CRITICAL();
;                    break;
L10147:
;
;    if( xSpace == ( size_t ) 0 )
;    {
	lda	<L48+xSpace_1
	bne	L10149
;                }
;            }
;            taskEXIT_CRITICAL();
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;        xSpace = xStreamBufferSpacesAvailable( pxStreamBuffer );
	pei	<L48+pxStreamBuffer_1+2
	pei	<L48+pxStreamBuffer_1
	jsr	_~xStreamBufferSpacesAvailable
	sta	<L48+xSpace_1
;    }
;    else
L10149:
;
;    xReturn = prvWriteMessageToBuffer( pxStreamBuffer, pvTxData, xDataLengthBytes, xSpace, xRequiredSpace );
	pei	<L48+xRequiredSpace_1
	pei	<L48+xSpace_1
	pei	<L47+xDataLengthBytes_0
	pei	<L47+pvTxData_0+2
	pei	<L47+pvTxData_0
	pei	<L48+pxStreamBuffer_1+2
	pei	<L48+pxStreamBuffer_1
	jsr	_~prvWriteMessageToBuffer
	sta	<L48+xReturn_1
;
;    if( xReturn > ( size_t ) 0 )
;    {
	lda	#$0
	cmp	<L48+xReturn_1
	bcs	L10154
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;        traceSTREAM_BUFFER_SEND( xStreamBuffer, xReturn );
;
;        /* Was a task waiting for the data? */
;        if( prvBytesInBufferMeetTriggerLevel( pxStreamBuffer, prvBytesInBuffer( pxStreamBuffer ) ) != pdFALSE )
;        {
	pei	<L48+pxStreamBuffer_1+2
	pei	<L48+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	pha
	pei	<L48+pxStreamBuffer_1+2
	pei	<L48+pxStreamBuffer_1
	jsr	_~prvBytesInBufferMeetTriggerLevel
	tax
	beq	L10154
;            prvSEND_COMPLETED( pxStreamBuffer );
	jsr	_~vTaskSuspendAll
	ldy	#$8
	lda	[<L48+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L48+pxStreamBuffer_1],Y
	beq	L10152
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L48+pxStreamBuffer_1],Y
	pha
	ldy	#$a
	lda	[<L48+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L48+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotify
	sta	<R0
	lda	#$0
	ldy	#$8
	sta	[<L48+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L48+pxStreamBuffer_1],Y
L10152:
	jsr	_~xTaskResumeAll
;        }
;        else
L10154:
;
;    traceRETURN_xStreamBufferSend( xReturn );
;
;    return xReturn;
	lda	<L48+xReturn_1
	tay
	lda	<L47+1
	sta	<L47+1+14
	pld
	tsc
	clc
	adc	#L47+14
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
L47	equ	22
L48	equ	5
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
	sbc	#L64
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
	lda	<L64+xStreamBuffer_0
	sta	<L65+pxStreamBuffer_1
	lda	<L64+xStreamBuffer_0+2
	sta	<L65+pxStreamBuffer_1+2
	lda	<L64+xDataLengthBytes_0
	sta	<L65+xRequiredSpace_1
;
;    configASSERT( pvTxData );
	lda	<L64+pvTxData_0
	ora	<L64+pvTxData_0+2
	bne	L10155
L10159:
	bra	L10159
L10155:
;    configASSERT( pxStreamBuffer );
	lda	<L65+pxStreamBuffer_1
	ora	<L65+pxStreamBuffer_1+2
	bne	L10162
L10166:
	bra	L10166
L10162:
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
	lda	[<L65+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10177
;        xRequiredSpace += sbBYTES_TO_STORE_MESSAGE_LENGTH;
	inc	<L65+xRequiredSpace_1
	inc	<L65+xRequiredSpace_1
;
;        /* Overflow? */
;        configASSERT( xRequiredSpace > xDataLengthBytes );
	lda	<L64+xDataLengthBytes_0
	cmp	<L65+xRequiredSpace_1
	bcc	L10177
L10174:
	bra	L10174
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10177:
;
;    xSpace = xStreamBufferSpacesAvailable( pxStreamBuffer );
	pei	<L65+pxStreamBuffer_1+2
	pei	<L65+pxStreamBuffer_1
	jsr	_~xStreamBufferSpacesAvailable
	sta	<L65+xSpace_1
;    xReturn = prvWriteMessageToBuffer( pxStreamBuffer, pvTxData, xDataLengthBytes, xSpace, xRequiredSpace );
	pei	<L65+xRequiredSpace_1
	pei	<L65+xSpace_1
	pei	<L64+xDataLengthBytes_0
	pei	<L64+pvTxData_0+2
	pei	<L64+pvTxData_0
	pei	<L65+pxStreamBuffer_1+2
	pei	<L65+pxStreamBuffer_1
	jsr	_~prvWriteMessageToBuffer
	sta	<L65+xReturn_1
;
;    if( xReturn > ( size_t ) 0 )
;    {
	lda	#$0
	cmp	<L65+xReturn_1
	bcs	L10185
;        /* Was a task waiting for the data? */
;        if( prvBytesInBufferMeetTriggerLevel( pxStreamBuffer, prvBytesInBuffer( pxStreamBuffer ) ) != pdFALSE )
;        {
	pei	<L65+pxStreamBuffer_1+2
	pei	<L65+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	pha
	pei	<L65+pxStreamBuffer_1+2
	pei	<L65+pxStreamBuffer_1
	jsr	_~prvBytesInBufferMeetTriggerLevel
	tax
	beq	L10185
;            /* MISRA Ref 4.7.1 [Return value shall be checked] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;            /* coverity[misra_c_2012_directive_4_7_violation] */
;            prvSEND_COMPLETE_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken );
uxSavedInterruptStatus_2	set	10
	stz	<L65+uxSavedInterruptStatus_2
	ldy	#$8
	lda	[<L65+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L65+pxStreamBuffer_1],Y
	beq	L10185
	pei	<L64+pxHigherPriorityTaskWoken_0+2
	pei	<L64+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L65+pxStreamBuffer_1],Y
	pha
	ldy	#$a
	lda	[<L65+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L65+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
	lda	#$0
	ldy	#$8
	sta	[<L65+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L65+pxStreamBuffer_1],Y
;        }
;        else
L10185:
;
;    traceSTREAM_BUFFER_SEND_FROM_ISR( xStreamBuffer, xReturn );
;    traceRETURN_xStreamBufferSendFromISR( xReturn );
;
;    return xReturn;
	lda	<L65+xReturn_1
	tay
	lda	<L64+1
	sta	<L64+1+14
	pld
	tsc
	clc
	adc	#L64+14
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
L64	equ	16
L65	equ	5
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
	sbc	#L74
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
	lda	[<L74+pxStreamBuffer_0],Y
	sta	<L75+xNextHead_1
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L74+pxStreamBuffer_0],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10186
;        /* This is a message buffer, as opposed to a stream buffer. */
;
;        /* Convert xDataLengthBytes to the message length type. */
;        xMessageLength = ( configMESSAGE_BUFFER_LENGTH_TYPE ) xDataLengthBytes;
	lda	<L74+xDataLengthBytes_0
	sta	<L75+xMessageLength_1
;
;        /* Ensure the data length given fits within configMESSAGE_BUFFER_LENGTH_TYPE. */
;        configASSERT( ( size_t ) xMessageLength == xDataLengthBytes );
	cmp	<L74+xDataLengthBytes_0
	beq	L10187
L10191:
	bra	L10191
L10187:
;
;        if( xSpace >= xRequiredSpace )
;        {
	lda	<L74+xSpace_0
	cmp	<L74+xRequiredSpace_0
	bcc	L10194
;            /* There is enough space to write both the message length and the message
;             * itself into the buffer.  Start by writing the length of the data, the data
;             * itself will be written later in this function. */
;            xNextHead = prvWriteBytesToBuffer( pxStreamBuffer, ( const uint8_t * ) &( xMessageLength ), sbBYTES_TO_STORE_MESSAGE_LENGTH, xNextHead );
	pei	<L75+xNextHead_1
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L75+xMessageLength_1
	pha
	pei	<L74+pxStreamBuffer_0+2
	pei	<L74+pxStreamBuffer_0
	jsr	_~prvWriteBytesToBuffer
	sta	<L75+xNextHead_1
;        }
;        else
	bra	L10196
L10194:
;        {
;            /* Not enough space, so do not write data to the buffer. */
;            xDataLengthBytes = 0;
	stz	<L74+xDataLengthBytes_0
;        }
;    }
;    else
	bra	L10196
L10186:
;    {
;        /* This is a stream buffer, as opposed to a message buffer, so writing a
;         * stream of bytes rather than discrete messages.  Plan to write as many
;         * bytes as possible. */
;        xDataLengthBytes = configMIN( xDataLengthBytes, xSpace );
	lda	<L74+xDataLengthBytes_0
	cmp	<L74+xSpace_0
	bcs	L79
	lda	<L74+xDataLengthBytes_0
	bra	L81
L79:
	lda	<L74+xSpace_0
L81:
	sta	<L74+xDataLengthBytes_0
;    }
L10196:
;
;    if( xDataLengthBytes != ( size_t ) 0 )
;    {
	lda	<L74+xDataLengthBytes_0
	beq	L10197
;        /* Write the data to the buffer. */
;        /* MISRA Ref 11.5.5 [Void pointer assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        pxStreamBuffer->xHead = prvWriteBytesToBuffer( pxStreamBuffer, ( const uint8_t * ) pvTxData, xDataLengthBytes, xNextHead );
	pei	<L75+xNextHead_1
	pei	<L74+xDataLengthBytes_0
	pei	<L74+pvTxData_0+2
	pei	<L74+pvTxData_0
	pei	<L74+pxStreamBuffer_0+2
	pei	<L74+pxStreamBuffer_0
	jsr	_~prvWriteBytesToBuffer
	ldy	#$2
	sta	[<L74+pxStreamBuffer_0],Y
;    }
;
;    return xDataLengthBytes;
L10197:
	lda	<L74+xDataLengthBytes_0
	tay
	lda	<L74+1
	sta	<L74+1+14
	pld
	tsc
	clc
	adc	#L74+14
	tcs
	tya
	rts
;}
L74	equ	4
L75	equ	1
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
	sbc	#L84
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
	lda	<L84+xStreamBuffer_0
	sta	<L85+pxStreamBuffer_1
	lda	<L84+xStreamBuffer_0+2
	sta	<L85+pxStreamBuffer_1+2
	stz	<L85+xReceivedLength_1
;
;    configASSERT( pvRxData );
	lda	<L84+pvRxData_0
	ora	<L84+pvRxData_0+2
	bne	L10198
L10202:
	bra	L10202
L10198:
;    configASSERT( pxStreamBuffer );
	lda	<L85+pxStreamBuffer_1
	ora	<L85+pxStreamBuffer_1+2
	bne	L10205
L10209:
	bra	L10209
L10205:
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
	lda	[<L85+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10212
;        xBytesToStoreMessageLength = sbBYTES_TO_STORE_MESSAGE_LENGTH;
	lda	#$2
	bra	L20007
L20009:
;        /* Force task to block if the batching buffer contains less bytes than
;         * the trigger level. */
;        xBytesToStoreMessageLength = pxStreamBuffer->xTriggerLevelBytes;
	ldy	#$6
	lda	[<L85+pxStreamBuffer_1],Y
;    }
;    else
L20007:
	sta	<L85+xBytesToStoreMessageLength_1
;    }
;    else if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_BATCHING_BUFFER ) != ( uint8_t ) 0 )
	bra	L10213
L10212:
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L85+pxStreamBuffer_1],Y
	and	#<$4
	rep	#$20
	longa	on
	bne	L20009
;    {
;        xBytesToStoreMessageLength = 0;
	stz	<L85+xBytesToStoreMessageLength_1
;    }
L10213:
;
;    if( xTicksToWait != ( TickType_t ) 0 )
;    {
	lda	<L84+xTicksToWait_0
	ora	<L84+xTicksToWait_0+2
	beq	L10216
;        /* Checking if there is data and clearing the notification state must be
;         * performed atomically. */
;        taskENTER_CRITICAL();
;        {
;            xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L85+pxStreamBuffer_1+2
	pei	<L85+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L85+xBytesAvailable_1
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
	lda	<L85+xBytesToStoreMessageLength_1
	cmp	<L85+xBytesAvailable_1
	bcc	L10230
;                /* Clear notification state as going to wait for data. */
;                ( void ) xTaskNotifyStateClearIndexed( NULL, pxStreamBuffer->uxNotificationIndex );
	ldy	#$15
	lda	[<L85+pxStreamBuffer_1],Y
	pha
	pea	#^$0
	pea	#<$0
	jsr	_~xTaskGenericNotifyStateClear
	sta	<R0
;
;                /* Should only be one reader. */
;                configASSERT( pxStreamBuffer->xTaskWaitingToReceive == NULL );
	ldy	#$8
	lda	[<L85+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L85+pxStreamBuffer_1],Y
	beq	L10221
L10225:
	bra	L10225
L10221:
;                pxStreamBuffer->xTaskWaitingToReceive = xTaskGetCurrentTaskHandle();
	jsr	_~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$8
	sta	[<L85+pxStreamBuffer_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L85+pxStreamBuffer_1],Y
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        taskEXIT_CRITICAL();
L10230:
;
;        if( xBytesAvailable <= xBytesToStoreMessageLength )
;        {
	lda	<L85+xBytesToStoreMessageLength_1
	cmp	<L85+xBytesAvailable_1
	bcc	L10234
;            /* Wait for data to be available. */
;            traceBLOCKING_ON_STREAM_BUFFER_RECEIVE( xStreamBuffer );
;            ( void ) xTaskNotifyWaitIndexed( pxStreamBuffer->uxNotificationIndex, ( uint32_t ) 0, ( uint32_t ) 0, NULL, xTicksToWait );
	pei	<L84+xTicksToWait_0+2
	pei	<L84+xTicksToWait_0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L85+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyWait
	sta	<R0
;            pxStreamBuffer->xTaskWaitingToReceive = NULL;
	lda	#$0
	ldy	#$8
	sta	[<L85+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L85+pxStreamBuffer_1],Y
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
L10216:
;    {
;        xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L85+pxStreamBuffer_1+2
	pei	<L85+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L85+xBytesAvailable_1
;    }
L10234:
;
;    /* Whether receiving a discrete message (where xBytesToStoreMessageLength
;     * holds the number of bytes used to store the message length) or a stream of
;     * bytes (where xBytesToStoreMessageLength is zero), the number of bytes
;     * available must be greater than xBytesToStoreMessageLength to be able to
;     * read bytes from the buffer. */
;    if( xBytesAvailable > xBytesToStoreMessageLength )
;    {
	lda	<L85+xBytesToStoreMessageLength_1
	cmp	<L85+xBytesAvailable_1
	bcs	L10242
;        xReceivedLength = prvReadMessageFromBuffer( pxStreamBuffer, pvRxData, xBufferLengthBytes, xBytesAvailable );
	pei	<L85+xBytesAvailable_1
	pei	<L84+xBufferLengthBytes_0
	pei	<L84+pvRxData_0+2
	pei	<L84+pvRxData_0
	pei	<L85+pxStreamBuffer_1+2
	pei	<L85+pxStreamBuffer_1
	jsr	_~prvReadMessageFromBuffer
	sta	<L85+xReceivedLength_1
;
;        /* Was a task waiting for space in the buffer? */
;        if( xReceivedLength != ( size_t ) 0 )
;        {
	lda	<L85+xReceivedLength_1
	beq	L10242
;            traceSTREAM_BUFFER_RECEIVE( xStreamBuffer, xReceivedLength );
;            prvRECEIVE_COMPLETED( xStreamBuffer );
	jsr	_~vTaskSuspendAll
	ldy	#$c
	lda	[<L84+xStreamBuffer_0],Y
	iny
	iny
	ora	[<L84+xStreamBuffer_0],Y
	beq	L10240
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L84+xStreamBuffer_0],Y
	pha
	ldy	#$e
	lda	[<L84+xStreamBuffer_0],Y
	pha
	dey
	dey
	lda	[<L84+xStreamBuffer_0],Y
	pha
	jsr	_~xTaskGenericNotify
	sta	<R0
	lda	#$0
	ldy	#$c
	sta	[<L84+xStreamBuffer_0],Y
	iny
	iny
	sta	[<L84+xStreamBuffer_0],Y
L10240:
	jsr	_~xTaskResumeAll
;        }
;        else
L10242:
;
;    traceRETURN_xStreamBufferReceive( xReceivedLength );
;
;    return xReceivedLength;
	lda	<L85+xReceivedLength_1
	tay
	lda	<L84+1
	sta	<L84+1+14
	pld
	tsc
	clc
	adc	#L84+14
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
L84	equ	14
L85	equ	5
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
	sbc	#L98
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
	lda	<L98+xStreamBuffer_0
	sta	<L99+pxStreamBuffer_1
	lda	<L98+xStreamBuffer_0+2
	sta	<L99+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L99+pxStreamBuffer_1
	ora	<L99+pxStreamBuffer_1+2
	bne	L10243
L10247:
	bra	L10247
L10243:
;
;    /* Ensure the stream buffer is being used as a message buffer. */
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_MESSAGE_BUFFER ) != ( uint8_t ) 0 )
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L99+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10250
;        xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L99+pxStreamBuffer_1+2
	pei	<L99+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L99+xBytesAvailable_1
;
;        if( xBytesAvailable > sbBYTES_TO_STORE_MESSAGE_LENGTH )
;        {
	lda	#$2
	cmp	<L99+xBytesAvailable_1
	bcs	L10251
;            /* The number of bytes available is greater than the number of bytes
;             * required to hold the length of the next message, so another message
;             * is available. */
;            ( void ) prvReadBytesFromBuffer( pxStreamBuffer, ( uint8_t * ) &xTempReturn, sbBYTES_TO_STORE_MESSAGE_LENGTH, pxStreamBuffer->xTail );
	lda	[<L99+pxStreamBuffer_1]
	pha
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L99+xTempReturn_1
	pha
	pei	<L99+pxStreamBuffer_1+2
	pei	<L99+pxStreamBuffer_1
	jsr	_~prvReadBytesFromBuffer
	sta	<R0
;            xReturn = ( size_t ) xTempReturn;
	lda	<L99+xTempReturn_1
	sta	<L99+xReturn_1
;        }
;        else
	bra	L10260
L10251:
;        {
;            /* The minimum amount of bytes in a message buffer is
;             * ( sbBYTES_TO_STORE_MESSAGE_LENGTH + 1 ), so if xBytesAvailable is
;             * less than sbBYTES_TO_STORE_MESSAGE_LENGTH the only other valid
;             * value is 0. */
;            configASSERT( xBytesAvailable == 0 );
	lda	<L99+xBytesAvailable_1
	beq	L10250
L10257:
	bra	L10257
;            xReturn = 0;
;        }
;    }
;    else
L10250:
;    {
;        xReturn = 0;
	stz	<L99+xReturn_1
;    }
L10260:
;
;    traceRETURN_xStreamBufferNextMessageLengthBytes( xReturn );
;
;    return xReturn;
	lda	<L99+xReturn_1
	tay
	lda	<L98+1
	sta	<L98+1+4
	pld
	tsc
	clc
	adc	#L98+4
	tcs
	tya
	rts
;}
L98	equ	14
L99	equ	5
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
	sbc	#L105
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
	lda	<L105+xStreamBuffer_0
	sta	<L106+pxStreamBuffer_1
	lda	<L105+xStreamBuffer_0+2
	sta	<L106+pxStreamBuffer_1+2
	stz	<L106+xReceivedLength_1
;
;    configASSERT( pvRxData );
	lda	<L105+pvRxData_0
	ora	<L105+pvRxData_0+2
	bne	L10261
L10265:
	bra	L10265
L10261:
;    configASSERT( pxStreamBuffer );
	lda	<L106+pxStreamBuffer_1
	ora	<L106+pxStreamBuffer_1+2
	bne	L10268
L10272:
	bra	L10272
L10268:
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
	beq	L10275
;        xBytesToStoreMessageLength = sbBYTES_TO_STORE_MESSAGE_LENGTH;
	lda	#$2
	sta	<L106+xBytesToStoreMessageLength_1
;    }
;    else
	bra	L10276
L10275:
;    {
;        xBytesToStoreMessageLength = 0;
	stz	<L106+xBytesToStoreMessageLength_1
;    }
L10276:
;
;    xBytesAvailable = prvBytesInBuffer( pxStreamBuffer );
	pei	<L106+pxStreamBuffer_1+2
	pei	<L106+pxStreamBuffer_1
	jsr	_~prvBytesInBuffer
	sta	<L106+xBytesAvailable_1
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
	bcs	L10284
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
	beq	L10284
;            /* MISRA Ref 4.7.1 [Return value shall be checked] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;            /* coverity[misra_c_2012_directive_4_7_violation] */
;            prvRECEIVE_COMPLETED_FROM_ISR( pxStreamBuffer, pxHigherPriorityTaskWoken );
uxSavedInterruptStatus_2	set	10
	stz	<L106+uxSavedInterruptStatus_2
	ldy	#$c
	lda	[<L106+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L106+pxStreamBuffer_1],Y
	beq	L10284
	pei	<L105+pxHigherPriorityTaskWoken_0+2
	pei	<L105+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L106+pxStreamBuffer_1],Y
	pha
	ldy	#$e
	lda	[<L106+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L106+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
	lda	#$0
	ldy	#$c
	sta	[<L106+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L106+pxStreamBuffer_1],Y
;        }
;        else
L10284:
;
;    traceSTREAM_BUFFER_RECEIVE_FROM_ISR( xStreamBuffer, xReceivedLength );
;    traceRETURN_xStreamBufferReceiveFromISR( xReceivedLength );
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
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L105	equ	16
L106	equ	5
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
	sbc	#L114
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
	lda	[<L114+pxStreamBuffer_0]
	sta	<L115+xNextTail_1
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L114+pxStreamBuffer_0],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10285
;        /* A discrete message is being received.  First receive the length
;         * of the message. */
;        xNextTail = prvReadBytesFromBuffer( pxStreamBuffer, ( uint8_t * ) &xTempNextMessageLength, sbBYTES_TO_STORE_MESSAGE_LENGTH, xNextTail );
	pei	<L115+xNextTail_1
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L115+xTempNextMessageLength_1
	pha
	pei	<L114+pxStreamBuffer_0+2
	pei	<L114+pxStreamBuffer_0
	jsr	_~prvReadBytesFromBuffer
	sta	<L115+xNextTail_1
;        xNextMessageLength = ( size_t ) xTempNextMessageLength;
	lda	<L115+xTempNextMessageLength_1
	sta	<L115+xNextMessageLength_1
;
;        /* Reduce the number of bytes available by the number of bytes just
;         * read out. */
;        xBytesAvailable -= sbBYTES_TO_STORE_MESSAGE_LENGTH;
	dec	<L114+xBytesAvailable_0
	dec	<L114+xBytesAvailable_0
;
;        /* Check there is enough space in the buffer provided by the
;         * user. */
;        if( xNextMessageLength > xBufferLengthBytes )
;        {
	lda	<L114+xBufferLengthBytes_0
	cmp	<L115+xNextMessageLength_1
	bcs	L10288
;            /* The user has provided insufficient space to read the message. */
;            xNextMessageLength = 0;
	stz	<L115+xNextMessageLength_1
;        }
;        else
	bra	L10288
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else
L10285:
;    {
;        /* A stream of bytes is being received (as opposed to a discrete
;         * message), so read as many bytes as possible. */
;        xNextMessageLength = xBufferLengthBytes;
	lda	<L114+xBufferLengthBytes_0
	sta	<L115+xNextMessageLength_1
;    }
L10288:
;
;    /* Use the minimum of the wanted bytes and the available bytes. */
;    xCount = configMIN( xNextMessageLength, xBytesAvailable );
	lda	<L115+xNextMessageLength_1
	cmp	<L114+xBytesAvailable_0
	bcs	L118
	lda	<L115+xNextMessageLength_1
	bra	L120
L118:
	lda	<L114+xBytesAvailable_0
L120:
	sta	<L115+xCount_1
;
;    if( xCount != ( size_t ) 0 )
;    {
	lda	<L115+xCount_1
	beq	L10289
;        /* Read the actual data and update the tail to mark the data as officially consumed. */
;        /* MISRA Ref 11.5.5 [Void pointer assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        pxStreamBuffer->xTail = prvReadBytesFromBuffer( pxStreamBuffer, ( uint8_t * ) pvRxData, xCount, xNextTail );
	pei	<L115+xNextTail_1
	pei	<L115+xCount_1
	pei	<L114+pvRxData_0+2
	pei	<L114+pvRxData_0
	pei	<L114+pxStreamBuffer_0+2
	pei	<L114+pxStreamBuffer_0
	jsr	_~prvReadBytesFromBuffer
	sta	[<L114+pxStreamBuffer_0]
;    }
;
;    return xCount;
L10289:
	lda	<L115+xCount_1
	tay
	lda	<L114+1
	sta	<L114+1+12
	pld
	tsc
	clc
	adc	#L114+12
	tcs
	tya
	rts
;}
L114	equ	8
L115	equ	1
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
	sbc	#L123
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
	lda	<L123+xStreamBuffer_0
	sta	<L124+pxStreamBuffer_1
	lda	<L123+xStreamBuffer_0+2
	sta	<L124+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L124+pxStreamBuffer_1
	ora	<L124+pxStreamBuffer_1+2
	bne	L10290
L10294:
	bra	L10294
L10290:
;
;    /* True if no bytes are available. */
;    xTail = pxStreamBuffer->xTail;
	lda	[<L124+pxStreamBuffer_1]
	sta	<L124+xTail_1
;
;    if( pxStreamBuffer->xHead == xTail )
;    {
	ldy	#$2
	lda	[<L124+pxStreamBuffer_1],Y
	cmp	<L124+xTail_1
	bne	L10297
;        xReturn = pdTRUE;
	lda	#$1
	sta	<L124+xReturn_1
;    }
;    else
	bra	L10298
L10297:
;    {
;        xReturn = pdFALSE;
	stz	<L124+xReturn_1
;    }
L10298:
;
;    traceRETURN_xStreamBufferIsEmpty( xReturn );
;
;    return xReturn;
	lda	<L124+xReturn_1
	tay
	lda	<L123+1
	sta	<L123+1+4
	pld
	tsc
	clc
	adc	#L123+4
	tcs
	tya
	rts
;}
L123	equ	8
L124	equ	1
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
	sbc	#L128
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
	lda	<L128+xStreamBuffer_0
	sta	<L129+pxStreamBuffer_1
	lda	<L128+xStreamBuffer_0+2
	sta	<L129+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L129+pxStreamBuffer_1
	ora	<L129+pxStreamBuffer_1+2
	bne	L10299
L10303:
	bra	L10303
L10299:
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
	lda	[<L129+pxStreamBuffer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	beq	L10306
;        xBytesToStoreMessageLength = sbBYTES_TO_STORE_MESSAGE_LENGTH;
	lda	#$2
	sta	<L129+xBytesToStoreMessageLength_1
;    }
;    else
	bra	L10307
L10306:
;    {
;        xBytesToStoreMessageLength = 0;
	stz	<L129+xBytesToStoreMessageLength_1
;    }
L10307:
;
;    /* True if the available space equals zero. */
;    if( xStreamBufferSpacesAvailable( xStreamBuffer ) <= xBytesToStoreMessageLength )
;    {
	pei	<L128+xStreamBuffer_0+2
	pei	<L128+xStreamBuffer_0
	jsr	_~xStreamBufferSpacesAvailable
	sta	<R0
	lda	<L129+xBytesToStoreMessageLength_1
	cmp	<R0
	bcc	L10308
;        xReturn = pdTRUE;
	lda	#$1
	sta	<L129+xReturn_1
;    }
;    else
	bra	L10309
L10308:
;    {
;        xReturn = pdFALSE;
	stz	<L129+xReturn_1
;    }
L10309:
;
;    traceRETURN_xStreamBufferIsFull( xReturn );
;
;    return xReturn;
	lda	<L129+xReturn_1
	tay
	lda	<L128+1
	sta	<L128+1+4
	pld
	tsc
	clc
	adc	#L128+4
	tcs
	tya
	rts
;}
L128	equ	12
L129	equ	5
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
	sbc	#L134
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
	lda	<L134+xStreamBuffer_0
	sta	<L135+pxStreamBuffer_1
	lda	<L134+xStreamBuffer_0+2
	sta	<L135+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L135+pxStreamBuffer_1
	ora	<L135+pxStreamBuffer_1+2
	bne	L10310
L10314:
	bra	L10314
L10310:
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L135+uxSavedInterruptStatus_1
;    {
;        if( ( pxStreamBuffer )->xTaskWaitingToReceive != NULL )
;        {
	ldy	#$8
	lda	[<L135+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L135+pxStreamBuffer_1],Y
	beq	L10317
;            ( void ) xTaskNotifyIndexedFromISR( ( pxStreamBuffer )->xTaskWaitingToReceive,
;                                                ( pxStreamBuffer )->uxNotificationIndex,
;                                                ( uint32_t ) 0,
;                                                eNoAction,
;                                                pxHigherPriorityTaskWoken );
	pei	<L134+pxHigherPriorityTaskWoken_0+2
	pei	<L134+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L135+pxStreamBuffer_1],Y
	pha
	ldy	#$a
	lda	[<L135+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L135+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
;            ( pxStreamBuffer )->xTaskWaitingToReceive = NULL;
	lda	#$0
	ldy	#$8
	sta	[<L135+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L135+pxStreamBuffer_1],Y
;            xReturn = pdTRUE;
	ina
	sta	<L135+xReturn_1
;        }
;        else
	bra	L10318
L10317:
;        {
;            xReturn = pdFALSE;
	stz	<L135+xReturn_1
;        }
L10318:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xStreamBufferSendCompletedFromISR( xReturn );
;
;    return xReturn;
	lda	<L135+xReturn_1
	tay
	lda	<L134+1
	sta	<L134+1+8
	pld
	tsc
	clc
	adc	#L134+8
	tcs
	tya
	rts
;}
L134	equ	12
L135	equ	5
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
	sbc	#L139
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
	lda	<L139+xStreamBuffer_0
	sta	<L140+pxStreamBuffer_1
	lda	<L139+xStreamBuffer_0+2
	sta	<L140+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L140+pxStreamBuffer_1
	ora	<L140+pxStreamBuffer_1+2
	bne	L10319
L10323:
	bra	L10323
L10319:
;
;    /* MISRA Ref 4.7.1 [Return value shall be checked] */
;    /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#dir-47 */
;    /* coverity[misra_c_2012_directive_4_7_violation] */
;    uxSavedInterruptStatus = taskENTER_CRITICAL_FROM_ISR();
	stz	<L140+uxSavedInterruptStatus_1
;    {
;        if( ( pxStreamBuffer )->xTaskWaitingToSend != NULL )
;        {
	ldy	#$c
	lda	[<L140+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L140+pxStreamBuffer_1],Y
	beq	L10326
;            ( void ) xTaskNotifyIndexedFromISR( ( pxStreamBuffer )->xTaskWaitingToSend,
;                                                ( pxStreamBuffer )->uxNotificationIndex,
;                                                ( uint32_t ) 0,
;                                                eNoAction,
;                                                pxHigherPriorityTaskWoken );
	pei	<L139+pxHigherPriorityTaskWoken_0+2
	pei	<L139+pxHigherPriorityTaskWoken_0
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	ldy	#$15
	lda	[<L140+pxStreamBuffer_1],Y
	pha
	ldy	#$e
	lda	[<L140+pxStreamBuffer_1],Y
	pha
	dey
	dey
	lda	[<L140+pxStreamBuffer_1],Y
	pha
	jsr	_~xTaskGenericNotifyFromISR
	sta	<R0
;            ( pxStreamBuffer )->xTaskWaitingToSend = NULL;
	lda	#$0
	ldy	#$c
	sta	[<L140+pxStreamBuffer_1],Y
	iny
	iny
	sta	[<L140+pxStreamBuffer_1],Y
;            xReturn = pdTRUE;
	ina
	sta	<L140+xReturn_1
;        }
;        else
	bra	L10327
L10326:
;        {
;            xReturn = pdFALSE;
	stz	<L140+xReturn_1
;        }
L10327:
;    }
;    taskEXIT_CRITICAL_FROM_ISR( uxSavedInterruptStatus );
;
;    traceRETURN_xStreamBufferReceiveCompletedFromISR( xReturn );
;
;    return xReturn;
	lda	<L140+xReturn_1
	tay
	lda	<L139+1
	sta	<L139+1+8
	pld
	tsc
	clc
	adc	#L139+8
	tcs
	tya
	rts
;}
L139	equ	12
L140	equ	5
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
	sbc	#L144
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
	cmp	<L144+xCount_0
	bcc	L10328
L10332:
	bra	L10332
L10328:
;
;    /* Calculate the number of bytes that can be added in the first write -
;     * which may be less than the total number of bytes that need to be added if
;     * the buffer will wrap back to the beginning. */
;    xFirstLength = configMIN( pxStreamBuffer->xLength - xHead, xCount );
	sec
	ldy	#$4
	lda	[<L144+pxStreamBuffer_0],Y
	sbc	<L144+xHead_0
	cmp	<L144+xCount_0
	bcs	L147
	sec
	lda	[<L144+pxStreamBuffer_0],Y
	sbc	<L144+xHead_0
	bra	L149
L147:
	lda	<L144+xCount_0
L149:
	sta	<L145+xFirstLength_1
	clc
	adc	<L144+xHead_0
	sta	<R0
	ldy	#$4
	lda	[<L144+pxStreamBuffer_0],Y
	cmp	<R0
	bcs	L10335
L10339:
	bra	L10339
L10335:
;    ( void ) memcpy( ( void * ) ( &( pxStreamBuffer->pucBuffer[ xHead ] ) ), ( const void * ) pucData, xFirstLength );
	pei	<L145+xFirstLength_1
	pei	<L144+pucData_0+2
	pei	<L144+pucData_0
	lda	<L144+xHead_0
	sta	<R0
	stz	<R0+2
	clc
	ldy	#$10
	lda	[<L144+pxStreamBuffer_0],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L144+pxStreamBuffer_0],Y
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
	lda	<L145+xFirstLength_1
	cmp	<L144+xCount_0
	bcs	L10350
;        /* ...then write the remaining bytes to the start of the buffer. */
;        configASSERT( ( xCount - xFirstLength ) <= pxStreamBuffer->xLength );
	sec
	lda	<L144+xCount_0
	sbc	<L145+xFirstLength_1
	sta	<R0
	ldy	#$4
	lda	[<L144+pxStreamBuffer_0],Y
	cmp	<R0
	bcs	L10343
L10347:
	bra	L10347
L10343:
;        ( void ) memcpy( ( void * ) pxStreamBuffer->pucBuffer, ( const void * ) &( pucData[ xFirstLength ] ), xCount - xFirstLength );
	sec
	lda	<L144+xCount_0
	sbc	<L145+xFirstLength_1
	pha
	lda	<L145+xFirstLength_1
	sta	<R0
	stz	<R0+2
	lda	<L144+pucData_0
	clc
	adc	<R0
	sta	<R1
	lda	<L144+pucData_0+2
	adc	<R0+2
	pha
	pei	<R1
	ldy	#$12
	lda	[<L144+pxStreamBuffer_0],Y
	pha
	dey
	dey
	lda	[<L144+pxStreamBuffer_0],Y
	pha
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10350:
;
;    xHead += xCount;
	lda	<L144+xHead_0
	clc
	adc	<L144+xCount_0
	sta	<L144+xHead_0
;
;    if( xHead >= pxStreamBuffer->xLength )
;    {
	ldy	#$4
	cmp	[<L144+pxStreamBuffer_0],Y
	bcc	L10352
;        xHead -= pxStreamBuffer->xLength;
	sec
	lda	<L144+xHead_0
	sbc	[<L144+pxStreamBuffer_0],Y
	sta	<L144+xHead_0
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10352:
;
;    return xHead;
	lda	<L144+xHead_0
	tay
	lda	<L144+1
	sta	<L144+1+12
	pld
	tsc
	clc
	adc	#L144+12
	tcs
	tya
	rts
;}
L144	equ	10
L145	equ	9
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
	sbc	#L155
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
	lda	<L155+xCount_0
	bne	L10353
L10357:
	bra	L10357
L10353:
;
;    /* Calculate the number of bytes that can be read - which may be
;     * less than the number wanted if the data wraps around to the start of
;     * the buffer. */
;    xFirstLength = configMIN( pxStreamBuffer->xLength - xTail, xCount );
	sec
	ldy	#$4
	lda	[<L155+pxStreamBuffer_0],Y
	sbc	<L155+xTail_0
	cmp	<L155+xCount_0
	bcs	L158
	sec
	lda	[<L155+pxStreamBuffer_0],Y
	sbc	<L155+xTail_0
	bra	L160
L158:
	lda	<L155+xCount_0
L160:
	sta	<L156+xFirstLength_1
;
;    /* Obtain the number of bytes it is possible to obtain in the first
;     * read.  Asserts check bounds of read and write. */
;    configASSERT( xFirstLength <= xCount );
	lda	<L155+xCount_0
	cmp	<L156+xFirstLength_1
	bcs	L10360
L10364:
	bra	L10364
L10360:
;    configASSERT( ( xTail + xFirstLength ) <= pxStreamBuffer->xLength );
	lda	<L155+xTail_0
	clc
	adc	<L156+xFirstLength_1
	sta	<R0
	ldy	#$4
	lda	[<L155+pxStreamBuffer_0],Y
	cmp	<R0
	bcs	L10367
L10371:
	bra	L10371
L10367:
;    ( void ) memcpy( ( void * ) pucData, ( const void * ) &( pxStreamBuffer->pucBuffer[ xTail ] ), xFirstLength );
	pei	<L156+xFirstLength_1
	lda	<L155+xTail_0
	sta	<R0
	stz	<R0+2
	clc
	ldy	#$10
	lda	[<L155+pxStreamBuffer_0],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L155+pxStreamBuffer_0],Y
	adc	<R0+2
	pha
	pei	<R1
	pei	<L155+pucData_0+2
	pei	<L155+pucData_0
	jsr	_~memcpy
	sta	<R0
	stx	<R0+2
;
;    /* If the total number of wanted bytes is greater than the number
;     * that could be read in the first read... */
;    if( xCount > xFirstLength )
;    {
	lda	<L156+xFirstLength_1
	cmp	<L155+xCount_0
	bcs	L10375
;        /* ...then read the remaining bytes from the start of the buffer. */
;        ( void ) memcpy( ( void * ) &( pucData[ xFirstLength ] ), ( void * ) ( pxStreamBuffer->pucBuffer ), xCount - xFirstLength );
	sec
	lda	<L155+xCount_0
	sbc	<L156+xFirstLength_1
	pha
	ldy	#$12
	lda	[<L155+pxStreamBuffer_0],Y
	pha
	dey
	dey
	lda	[<L155+pxStreamBuffer_0],Y
	pha
	lda	<L156+xFirstLength_1
	sta	<R0
	stz	<R0+2
	lda	<L155+pucData_0
	clc
	adc	<R0
	sta	<R1
	lda	<L155+pucData_0+2
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
L10375:
;
;    /* Move the tail pointer to effectively remove the data read from the buffer. */
;    xTail += xCount;
	lda	<L155+xTail_0
	clc
	adc	<L155+xCount_0
	sta	<L155+xTail_0
;
;    if( xTail >= pxStreamBuffer->xLength )
;    {
	ldy	#$4
	cmp	[<L155+pxStreamBuffer_0],Y
	bcc	L10376
;        xTail -= pxStreamBuffer->xLength;
	sec
	lda	<L155+xTail_0
	sbc	[<L155+pxStreamBuffer_0],Y
	sta	<L155+xTail_0
;    }
;
;    return xTail;
L10376:
	lda	<L155+xTail_0
	tay
	lda	<L155+1
	sta	<L155+1+12
	pld
	tsc
	clc
	adc	#L155+12
	tcs
	tya
	rts
;}
L155	equ	10
L156	equ	9
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
	sbc	#L166
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
	lda	[<L166+pxStreamBuffer_0],Y
	dey
	dey
	adc	[<L166+pxStreamBuffer_0],Y
	sta	<L167+xCount_1
;    xCount -= pxStreamBuffer->xTail;
	sec
	sbc	[<L166+pxStreamBuffer_0]
	sta	<L167+xCount_1
;
;    if( xCount >= pxStreamBuffer->xLength )
;    {
	iny
	iny
	cmp	[<L166+pxStreamBuffer_0],Y
	bcc	L10378
;        xCount -= pxStreamBuffer->xLength;
	sec
	lda	<L167+xCount_1
	sbc	[<L166+pxStreamBuffer_0],Y
	sta	<L167+xCount_1
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
L10378:
;
;    return xCount;
	lda	<L167+xCount_1
	tay
	lda	<L166+1
	sta	<L166+1+4
	pld
	tsc
	clc
	adc	#L166+4
	tcs
	tya
	rts
;}
L166	equ	2
L167	equ	1
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
	sbc	#L170
	tcs
	phd
	tcd
pxStreamBuffer_0	set	3
xBytesInBuffer_0	set	7
;    BaseType_t xReturn = pdFALSE;
;
;    if( ( pxStreamBuffer->ucFlags & sbFLAGS_IS_BATCHING_BUFFER ) != ( uint8_t ) 0 )
xReturn_1	set	0
	stz	<L171+xReturn_1
;    {
	sep	#$20
	longa	off
	ldy	#$14
	lda	[<L170+pxStreamBuffer_0],Y
	and	#<$4
	rep	#$20
	longa	on
	beq	L10379
;        if( xBytesInBuffer > pxStreamBuffer->xTriggerLevelBytes )
;        {
	ldy	#$6
	lda	[<L170+pxStreamBuffer_0],Y
	cmp	<L170+xBytesInBuffer_0
	bcs	L10382
;            xReturn = pdTRUE;
L20011:
	lda	#$1
	sta	<L171+xReturn_1
;        }
;        else
L10382:
;
;    return xReturn;
	lda	<L171+xReturn_1
	tay
	lda	<L170+1
	sta	<L170+1+6
	pld
	tsc
	clc
	adc	#L170+6
	tcs
	tya
	rts
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
;    else if( xBytesInBuffer >= pxStreamBuffer->xTriggerLevelBytes )
L10379:
;    {
	lda	<L170+xBytesInBuffer_0
	ldy	#$6
	cmp	[<L170+pxStreamBuffer_0],Y
	bcc	L10382
;        xReturn = pdTRUE;
	bra	L20011
;    }
;    else
;    {
;        mtCOVERAGE_TEST_MARKER();
;    }
;}
L170	equ	2
L171	equ	1
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
	sbc	#L176
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
	pei	<L176+xBufferSizeBytes_0
	pea	#<$55
	pei	<L176+pucBuffer_0+2
	pei	<L176+pucBuffer_0
	jsr	_~memset
	stx	<R0+2
	cmp	<L176+pucBuffer_0
	bne	L178
	lda	<R0+2
	cmp	<L176+pucBuffer_0+2
L178:
	beq	L10385
L10389:
	bra	L10389
L10385:
;    }
;    #endif
;
;    ( void ) memset( ( void * ) pxStreamBuffer, 0x00, sizeof( StreamBuffer_t ) );
	pea	#<$17
	pea	#<$0
	pei	<L176+pxStreamBuffer_0+2
	pei	<L176+pxStreamBuffer_0
	jsr	_~memset
;    pxStreamBuffer->pucBuffer = pucBuffer;
	lda	<L176+pucBuffer_0
	ldy	#$10
	sta	[<L176+pxStreamBuffer_0],Y
	lda	<L176+pucBuffer_0+2
	iny
	iny
	sta	[<L176+pxStreamBuffer_0],Y
;    pxStreamBuffer->xLength = xBufferSizeBytes;
	lda	<L176+xBufferSizeBytes_0
	ldy	#$4
	sta	[<L176+pxStreamBuffer_0],Y
;    pxStreamBuffer->xTriggerLevelBytes = xTriggerLevelBytes;
	lda	<L176+xTriggerLevelBytes_0
	iny
	iny
	sta	[<L176+pxStreamBuffer_0],Y
;    pxStreamBuffer->ucFlags = ucFlags;
	sep	#$20
	longa	off
	lda	<L176+ucFlags_0
	ldy	#$14
	sta	[<L176+pxStreamBuffer_0],Y
	rep	#$20
	longa	on
;    pxStreamBuffer->uxNotificationIndex = tskDEFAULT_INDEX_TO_NOTIFY;
	lda	#$0
	iny
	sta	[<L176+pxStreamBuffer_0],Y
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
	lda	<L176+1
	sta	<L176+1+18
	pld
	tsc
	clc
	adc	#L176+18
	tcs
	rts
L176	equ	4
L177	equ	5
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
	sbc	#L181
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_uxStreamBufferGetStreamBufferNotificationIndex( xStreamBuffer );
pxStreamBuffer_1	set	0
	lda	<L181+xStreamBuffer_0
	sta	<L182+pxStreamBuffer_1
	lda	<L181+xStreamBuffer_0+2
	sta	<L182+pxStreamBuffer_1+2
;
;    configASSERT( pxStreamBuffer );
	lda	<L182+pxStreamBuffer_1
	ora	<L182+pxStreamBuffer_1+2
	bne	L10392
L10396:
	bra	L10396
L10392:
;
;    traceRETURN_uxStreamBufferGetStreamBufferNotificationIndex( pxStreamBuffer->uxNotificationIndex );
;
;    return pxStreamBuffer->uxNotificationIndex;
	ldy	#$15
	lda	[<L182+pxStreamBuffer_1],Y
	tay
	lda	<L181+1
	sta	<L181+1+4
	pld
	tsc
	clc
	adc	#L181+4
	tcs
	tya
	rts
;}
L181	equ	4
L182	equ	1
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
	sbc	#L185
	tcs
	phd
	tcd
xStreamBuffer_0	set	3
uxNotificationIndex_0	set	7
;    StreamBuffer_t * const pxStreamBuffer = xStreamBuffer;
;
;    traceENTER_vStreamBufferSetStreamBufferNotificationIndex( xStreamBuffer, uxNotificationIndex );
pxStreamBuffer_1	set	0
	lda	<L185+xStreamBuffer_0
	sta	<L186+pxStreamBuffer_1
	lda	<L185+xStreamBuffer_0+2
	sta	<L186+pxStreamBuffer_1+2
;
;    /* There should be no task waiting otherwise we'd never resume them. */
;    configASSERT( ( pxStreamBuffer != NULL ) && ( pxStreamBuffer->xTaskWaitingToReceive == NULL ) );
	lda	<L186+pxStreamBuffer_1
	ora	<L186+pxStreamBuffer_1+2
	beq	L10403
	ldy	#$8
	lda	[<L186+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L186+pxStreamBuffer_1],Y
	beq	L10399
L10403:
	bra	L10403
L10399:
;    configASSERT( ( pxStreamBuffer != NULL ) && ( pxStreamBuffer->xTaskWaitingToSend == NULL ) );
	lda	<L186+pxStreamBuffer_1
	ora	<L186+pxStreamBuffer_1+2
	beq	L10410
	ldy	#$c
	lda	[<L186+pxStreamBuffer_1],Y
	iny
	iny
	ora	[<L186+pxStreamBuffer_1],Y
	beq	L10406
L10410:
	bra	L10410
L10406:
;
;    /* Check that the task notification index is valid. */
;    configASSERT( uxNotificationIndex < configTASK_NOTIFICATION_ARRAY_ENTRIES );
	lda	<L185+uxNotificationIndex_0
	cmp	#<$1
	bcc	L10413
L10417:
	bra	L10417
L10413:
;
;    pxStreamBuffer->uxNotificationIndex = uxNotificationIndex;
	lda	<L185+uxNotificationIndex_0
	ldy	#$15
	sta	[<L186+pxStreamBuffer_1],Y
;
;    traceRETURN_vStreamBufferSetStreamBufferNotificationIndex();
;}
	lda	<L185+1
	sta	<L185+1+6
	pld
	tsc
	clc
	adc	#L185+6
	tcs
	rts
L185	equ	4
L186	equ	1
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

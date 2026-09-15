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
; * all the API functions to use the MPU wrappers.  That should only be done when
; * task.h is included from an application file. */
;#define MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;#include "FreeRTOS.h"
;#include "task.h"
;#include "queue.h"
;#include "timers.h"
;
;#if ( INCLUDE_xTimerPendFunctionCall == 1 ) && ( configUSE_TIMERS == 0 )
;    #error configUSE_TIMERS must be set to 1 to make the xTimerPendFunctionCall() function available.
;#endif
;
;/* The MPU ports require MPU_WRAPPERS_INCLUDED_FROM_API_FILE to be defined
; * for the header files above, but not in this file, in order to generate the
; * correct privileged Vs unprivileged linkage and placement. */
;#undef MPU_WRAPPERS_INCLUDED_FROM_API_FILE
;
;
;/* This entire source file will be skipped if the application is not configured
; * to include software timer functionality.  This #if is closed at the very bottom
; * of this file.  If you want to include software timer functionality then ensure
; * configUSE_TIMERS is set to 1 in FreeRTOSConfig.h. */
;#if ( configUSE_TIMERS == 1 )
;
;/* Misc definitions. */
;    #define tmrNO_DELAY                    ( ( TickType_t ) 0U )
;    #define tmrMAX_TIME_BEFORE_OVERFLOW    ( ( TickType_t ) -1 )
;
;/* The name assigned to the timer service task. This can be overridden by
; * defining configTIMER_SERVICE_TASK_NAME in FreeRTOSConfig.h. */
;    #ifndef configTIMER_SERVICE_TASK_NAME
;        #define configTIMER_SERVICE_TASK_NAME    "Tmr Svc"
;    #endif
;
;    #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;
;/* The core affinity assigned to the timer service task on SMP systems.
; * This can be overridden by defining configTIMER_SERVICE_TASK_CORE_AFFINITY in FreeRTOSConfig.h. */
;        #ifndef configTIMER_SERVICE_TASK_CORE_AFFINITY
;            #define configTIMER_SERVICE_TASK_CORE_AFFINITY    tskNO_AFFINITY
;        #endif
;    #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;
;/* Bit definitions used in the ucStatus member of a timer structure. */
;    #define tmrSTATUS_IS_ACTIVE                  ( 0x01U )
;    #define tmrSTATUS_IS_STATICALLY_ALLOCATED    ( 0x02U )
;    #define tmrSTATUS_IS_AUTORELOAD              ( 0x04U )
;
;/* The definition of the timers themselves. */
;    typedef struct tmrTimerControl                                               /* The old naming convention is used to prevent breaking kernel aware debuggers. */
;    {
;        const char * pcTimerName;                                                /**< Text name.  This is not used by the kernel, it is included simply to make debugging easier. */
;        ListItem_t xTimerListItem;                                               /**< Standard linked list item as used by all kernel features for event management. */
;        TickType_t xTimerPeriodInTicks;                                          /**< How quickly and often the timer expires. */
;        void * pvTimerID;                                                        /**< An ID to identify the timer.  This allows the timer to be identified when the same callback is used for multiple timers. */
;        portTIMER_CALLBACK_ATTRIBUTE TimerCallbackFunction_t pxCallbackFunction; /**< The function that will be called when the timer expires. */
;        #if ( configUSE_TRACE_FACILITY == 1 )
;            UBaseType_t uxTimerNumber;                                           /**< An ID assigned by trace tools such as FreeRTOS+Trace */
;        #endif
;        uint8_t ucStatus;                                                        /**< Holds bits to say if the timer was statically allocated or not, and if it is active or not. */
;    } xTIMER;
;
;/* The old xTIMER name is maintained above then typedefed to the new Timer_t
; * name below to enable the use of older kernel aware debuggers. */
;    typedef xTIMER Timer_t;
;
;/* The definition of messages that can be sent and received on the timer queue.
; * Two types of message can be queued - messages that manipulate a software timer,
; * and messages that request the execution of a non-timer related callback.  The
; * two message types are defined in two separate structures, xTimerParametersType
; * and xCallbackParametersType respectively. */
;    typedef struct tmrTimerParameters
;    {
;        TickType_t xMessageValue; /**< An optional value used by a subset of commands, for example, when changing the period of a timer. */
;        Timer_t * pxTimer;        /**< The timer to which the command will be applied. */
;    } TimerParameter_t;
;
;
;    typedef struct tmrCallbackParameters
;    {
;        portTIMER_CALLBACK_ATTRIBUTE
;        PendedFunction_t pxCallbackFunction; /* << The callback function to execute. */
;        void * pvParameter1;                 /* << The value that will be used as the callback functions first parameter. */
;        uint32_t ulParameter2;               /* << The value that will be used as the callback functions second parameter. */
;    } CallbackParameters_t;
;
;/* The structure that contains the two message types, along with an identifier
; * that is used to determine which message type is valid. */
;    typedef struct tmrTimerQueueMessage
;    {
;        BaseType_t xMessageID; /**< The command being sent to the timer service task. */
;        union
;        {
;            TimerParameter_t xTimerParameters;
;
;            /* Don't include xCallbackParameters if it is not going to be used as
;             * it makes the structure (and therefore the timer queue) larger. */
;            #if ( INCLUDE_xTimerPendFunctionCall == 1 )
;                CallbackParameters_t xCallbackParameters;
;            #endif /* INCLUDE_xTimerPendFunctionCall */
;        } u;
;    } DaemonTaskMessage_t;
;
;/* The list in which active timers are stored.  Timers are referenced in expire
; * time order, with the nearest expiry time at the front of the list.  Only the
; * timer service task is allowed to access these lists.
; * xActiveTimerList1 and xActiveTimerList2 could be at function scope but that
; * breaks some kernel aware debuggers, and debuggers that reply on removing the
; * static qualifier. */
;    PRIVILEGED_DATA static List_t xActiveTimerList1;
;    PRIVILEGED_DATA static List_t xActiveTimerList2;
;    PRIVILEGED_DATA static List_t * pxCurrentTimerList;
;    PRIVILEGED_DATA static List_t * pxOverflowTimerList;
;
;/* A queue that is used to send commands to the timer service task. */
;    PRIVILEGED_DATA static QueueHandle_t xTimerQueue = NULL;
	data
_~xTimerQueue:
	dl	$0
	ends
;    PRIVILEGED_DATA static TaskHandle_t xTimerTaskHandle = NULL;
	data
_~xTimerTaskHandle:
	dl	$0
	ends
;
;/*-----------------------------------------------------------*/
;
;/*
; * Initialise the infrastructure used by the timer service task if it has not
; * been initialised already.
; */
;    static void prvCheckForValidListAndQueue( void ) PRIVILEGED_FUNCTION;
;
;/*
; * The timer service task (daemon).  Timer functionality is controlled by this
; * task.  Other tasks communicate with the timer service task using the
; * xTimerQueue queue.
; */
;    static portTASK_FUNCTION_PROTO( prvTimerTask, pvParameters ) PRIVILEGED_FUNCTION;
;
;/*
; * Called by the timer service task to interpret and process a command it
; * received on the timer queue.
; */
;    static void prvProcessReceivedCommands( void ) PRIVILEGED_FUNCTION;
;
;/*
; * Insert the timer into either xActiveTimerList1, or xActiveTimerList2,
; * depending on if the expire time causes a timer counter overflow.
; */
;    static BaseType_t prvInsertTimerInActiveList( Timer_t * const pxTimer,
;                                                  const TickType_t xNextExpiryTime,
;                                                  const TickType_t xTimeNow,
;                                                  const TickType_t xCommandTime ) PRIVILEGED_FUNCTION;
;
;/*
; * Reload the specified auto-reload timer.  If the reloading is backlogged,
; * clear the backlog, calling the callback for each additional reload.  When
; * this function returns, the next expiry time is after xTimeNow.
; */
;    static void prvReloadTimer( Timer_t * const pxTimer,
;                                TickType_t xExpiredTime,
;                                const TickType_t xTimeNow ) PRIVILEGED_FUNCTION;
;
;/*
; * An active timer has reached its expire time.  Reload the timer if it is an
; * auto-reload timer, then call its callback.
; */
;    static void prvProcessExpiredTimer( const TickType_t xNextExpireTime,
;                                        const TickType_t xTimeNow ) PRIVILEGED_FUNCTION;
;
;/*
; * The tick count has overflowed.  Switch the timer lists after ensuring the
; * current timer list does not still reference some timers.
; */
;    static void prvSwitchTimerLists( void ) PRIVILEGED_FUNCTION;
;
;/*
; * Obtain the current tick count, setting *pxTimerListsWereSwitched to pdTRUE
; * if a tick count overflow occurred since prvSampleTimeNow() was last called.
; */
;    static TickType_t prvSampleTimeNow( BaseType_t * const pxTimerListsWereSwitched ) PRIVILEGED_FUNCTION;
;
;/*
; * If the timer list contains any active timers then return the expire time of
; * the timer that will expire first and set *pxListWasEmpty to false.  If the
; * timer list does not contain any timers then return 0 and set *pxListWasEmpty
; * to pdTRUE.
; */
;    static TickType_t prvGetNextExpireTime( BaseType_t * const pxListWasEmpty ) PRIVILEGED_FUNCTION;
;
;/*
; * If a timer has expired, process it.  Otherwise, block the timer service task
; * until either a timer does expire or a command is received.
; */
;    static void prvProcessTimerOrBlockTask( const TickType_t xNextExpireTime,
;                                            BaseType_t xListWasEmpty ) PRIVILEGED_FUNCTION;
;
;/*
; * Called after a Timer_t structure has been allocated either statically or
; * dynamically to fill in the structure's members.
; */
;    static void prvInitialiseNewTimer( const char * const pcTimerName,
;                                       const TickType_t xTimerPeriodInTicks,
;                                       const BaseType_t xAutoReload,
;                                       void * const pvTimerID,
;                                       TimerCallbackFunction_t pxCallbackFunction,
;                                       Timer_t * pxNewTimer ) PRIVILEGED_FUNCTION;
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTimerCreateTimerTask( void )
;    {
	code
	xdef	_~xTimerCreateTimerTask
	func
_~xTimerCreateTimerTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
;        BaseType_t xReturn = pdFAIL;
;
;        traceENTER_xTimerCreateTimerTask();
xReturn_1	set	0
	stz	<L3+xReturn_1
;
;        /* This function is called when the scheduler is started if
;         * configUSE_TIMERS is set to 1.  Check that the infrastructure used by the
;         * timer service task has been created/initialised.  If timers have already
;         * been created then the initialisation will already have been performed. */
;        prvCheckForValidListAndQueue();
	jsr	_~prvCheckForValidListAndQueue
;
;        if( xTimerQueue != NULL )
;        {
	lda	|_~xTimerQueue
	ora	|_~xTimerQueue+2
	beq	L10003
;            #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) )
;            {
;                #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;                {
;                    StaticTask_t * pxTimerTaskTCBBuffer = NULL;
;                    StackType_t * pxTimerTaskStackBuffer = NULL;
;                    configSTACK_DEPTH_TYPE uxTimerTaskStackSize;
;
;                    vApplicationGetTimerTaskMemory( &pxTimerTaskTCBBuffer, &pxTimerTaskStackBuffer, &uxTimerTaskStackSize );
;                    xTimerTaskHandle = xTaskCreateStaticAffinitySet( &prvTimerTask,
;                                                                     configTIMER_SERVICE_TASK_NAME,
;                                                                     uxTimerTaskStackSize,
;                                                                     NULL,
;                                                                     ( ( UBaseType_t ) configTIMER_TASK_PRIORITY ) | portPRIVILEGE_BIT,
;                                                                     pxTimerTaskStackBuffer,
;                                                                     pxTimerTaskTCBBuffer,
;                                                                     configTIMER_SERVICE_TASK_CORE_AFFINITY );
;
;                    if( xTimerTaskHandle != NULL )
;                    {
;                        xReturn = pdPASS;
;                    }
;                }
;                #else /* if ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;                {
;                    xReturn = xTaskCreateAffinitySet( &prvTimerTask,
;                                                      configTIMER_SERVICE_TASK_NAME,
;                                                      configTIMER_TASK_STACK_DEPTH,
;                                                      NULL,
;                                                      ( ( UBaseType_t ) configTIMER_TASK_PRIORITY ) | portPRIVILEGE_BIT,
;                                                      configTIMER_SERVICE_TASK_CORE_AFFINITY,
;                                                      &xTimerTaskHandle );
;                }
;                #endif /* configSUPPORT_STATIC_ALLOCATION */
;            }
;            #else /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;            {
;                #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;                {
;                    StaticTask_t * pxTimerTaskTCBBuffer = NULL;
;                    StackType_t * pxTimerTaskStackBuffer = NULL;
;                    configSTACK_DEPTH_TYPE uxTimerTaskStackSize;
;
;                    vApplicationGetTimerTaskMemory( &pxTimerTaskTCBBuffer, &pxTimerTaskStackBuffer, &uxTimerTaskStackSize );
pxTimerTaskTCBBuffer_2	set	2
pxTimerTaskStackBuffer_2	set	6
uxTimerTaskStackSize_2	set	10
	stz	<L3+pxTimerTaskTCBBuffer_2
	stz	<L3+pxTimerTaskTCBBuffer_2+2
	stz	<L3+pxTimerTaskStackBuffer_2
	stz	<L3+pxTimerTaskStackBuffer_2+2
	pea	#0
	clc
	tdc
	adc	#<L3+uxTimerTaskStackSize_2
	pha
	pea	#0
	clc
	tdc
	adc	#<L3+pxTimerTaskStackBuffer_2
	pha
	pea	#0
	clc
	tdc
	adc	#<L3+pxTimerTaskTCBBuffer_2
	pha
	jsr	_~vApplicationGetTimerTaskMemory
;                    xTimerTaskHandle = xTaskCreateStatic( &prvTimerTask,
;                                                          configTIMER_SERVICE_TASK_NAME,
;                                                          uxTimerTaskStackSize,
;                                                          NULL,
;                                                          ( ( UBaseType_t ) configTIMER_TASK_PRIORITY ) | portPRIVILEGE_BIT,
;                                                          pxTimerTaskStackBuffer,
;                                                          pxTimerTaskTCBBuffer );
	pei	<L3+pxTimerTaskTCBBuffer_2+2
	pei	<L3+pxTimerTaskTCBBuffer_2
	pei	<L3+pxTimerTaskStackBuffer_2+2
	pei	<L3+pxTimerTaskStackBuffer_2
	pea	#<$4
	pea	#^$0
	pea	#<$0
	pei	<L3+uxTimerTaskStackSize_2
	pea	#^L1
	pea	#<L1
	pea	#<_~prvTimerTask
	jsr	_~xTaskCreateStatic
	sta	|_~xTimerTaskHandle
	stx	|_~xTimerTaskHandle+2
;
;                    if( xTimerTaskHandle != NULL )
;                    {
	ora	|_~xTimerTaskHandle+2
	beq	L10003
;                        xReturn = pdPASS;
	lda	#$1
	sta	<L3+xReturn_1
;                    }
;                }
;                #else /* if ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;                {
;                    xReturn = xTaskCreate( &prvTimerTask,
;                                           configTIMER_SERVICE_TASK_NAME,
;                                           configTIMER_TASK_STACK_DEPTH,
;                                           NULL,
;                                           ( ( UBaseType_t ) configTIMER_TASK_PRIORITY ) | portPRIVILEGE_BIT,
;                                           &xTimerTaskHandle );
;                }
;                #endif /* configSUPPORT_STATIC_ALLOCATION */
;            }
;            #endif /* #if ( ( configNUMBER_OF_CORES > 1 ) && ( configUSE_CORE_AFFINITY == 1 ) ) */
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10003:
;
;        configASSERT( xReturn );
	lda	<L3+xReturn_1
	bne	L10004
L10008:
	bra	L10008
L10004:
;
;        traceRETURN_xTimerCreateTimerTask( xReturn );
;
;        return xReturn;
	lda	<L3+xReturn_1
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rts
;    }
L2	equ	12
L3	equ	1
	ends
	efunc
	data
L1:
	db	$54,$6D,$72,$20,$53,$76,$63,$00
	ends
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;
;        TimerHandle_t xTimerCreate( const char * const pcTimerName,
;                                    const TickType_t xTimerPeriodInTicks,
;                                    const BaseType_t xAutoReload,
;                                    void * const pvTimerID,
;                                    TimerCallbackFunction_t pxCallbackFunction )
;        {
	code
	xdef	_~xTimerCreate
	func
_~xTimerCreate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
pcTimerName_0	set	3
xTimerPeriodInTicks_0	set	7
xAutoReload_0	set	11
pvTimerID_0	set	13
pxCallbackFunction_0	set	17
;            Timer_t * pxNewTimer;
;
;            traceENTER_xTimerCreate( pcTimerName, xTimerPeriodInTicks, xAutoReload, pvTimerID, pxCallbackFunction );
pxNewTimer_1	set	0
;
;            /* MISRA Ref 11.5.1 [Malloc memory assignment] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;            /* coverity[misra_c_2012_rule_11_5_violation] */
;            pxNewTimer = ( Timer_t * ) pvPortMalloc( sizeof( Timer_t ) );
	pea	#<$23
	jsr	_~pvPortMalloc
	sta	<L10+pxNewTimer_1
	stx	<L10+pxNewTimer_1+2
;
;            if( pxNewTimer != NULL )
;            {
	ora	<L10+pxNewTimer_1+2
	beq	L10011
;                /* Status is thus far zero as the timer is not created statically
;                 * and has not been started.  The auto-reload bit may get set in
;                 * prvInitialiseNewTimer. */
;                pxNewTimer->ucStatus = 0x00;
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$22
	sta	[<L10+pxNewTimer_1],Y
	rep	#$20
	longa	on
;                prvInitialiseNewTimer( pcTimerName, xTimerPeriodInTicks, xAutoReload, pvTimerID, pxCallbackFunction, pxNewTimer );
	pei	<L10+pxNewTimer_1+2
	pei	<L10+pxNewTimer_1
	pei	<L9+pxCallbackFunction_0
	pei	<L9+pvTimerID_0+2
	pei	<L9+pvTimerID_0
	pei	<L9+xAutoReload_0
	pei	<L9+xTimerPeriodInTicks_0+2
	pei	<L9+xTimerPeriodInTicks_0
	pei	<L9+pcTimerName_0+2
	pei	<L9+pcTimerName_0
	jsr	_~prvInitialiseNewTimer
;            }
;
;            traceRETURN_xTimerCreate( pxNewTimer );
L10011:
;
;            return pxNewTimer;
	ldx	<L10+pxNewTimer_1+2
	lda	<L10+pxNewTimer_1
	tay
	lda	<L9+1
	sta	<L9+1+16
	pld
	tsc
	clc
	adc	#L9+16
	tcs
	tya
	rts
;        }
L9	equ	4
L10	equ	1
	ends
	efunc
;
;    #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;
;        TimerHandle_t xTimerCreateStatic( const char * const pcTimerName,
;                                          const TickType_t xTimerPeriodInTicks,
;                                          const BaseType_t xAutoReload,
;                                          void * const pvTimerID,
;                                          TimerCallbackFunction_t pxCallbackFunction,
;                                          StaticTimer_t * pxTimerBuffer )
;        {
	code
	xdef	_~xTimerCreateStatic
	func
_~xTimerCreateStatic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
pcTimerName_0	set	3
xTimerPeriodInTicks_0	set	7
xAutoReload_0	set	11
pvTimerID_0	set	13
pxCallbackFunction_0	set	17
pxTimerBuffer_0	set	19
;            Timer_t * pxNewTimer;
;
;            traceENTER_xTimerCreateStatic( pcTimerName, xTimerPeriodInTicks, xAutoReload, pvTimerID, pxCallbackFunction, pxTimerBuffer );
pxNewTimer_1	set	0
;
;            #if ( configASSERT_DEFINED == 1 )
;            {
;                /* Sanity check that the size of the structure used to declare a
;                 * variable of type StaticTimer_t equals the size of the real timer
;                 * structure. */
;                volatile size_t xSize = sizeof( StaticTimer_t );
;                configASSERT( xSize == sizeof( Timer_t ) );
xSize_2	set	4
	lda	#$23
	sta	<L14+xSize_2
	cmp	#<$23
	beq	L10012
L10016:
	bra	L10016
L10012:
;                ( void ) xSize; /* Prevent unused variable warning when configASSERT() is not defined. */
;            }
;            #endif /* configASSERT_DEFINED */
;
;            /* A pointer to a StaticTimer_t structure MUST be provided, use it. */
;            configASSERT( pxTimerBuffer );
	lda	<L13+pxTimerBuffer_0
	ora	<L13+pxTimerBuffer_0+2
	bne	L10019
L10023:
	bra	L10023
L10019:
;            /* MISRA Ref 11.3.1 [Misaligned access] */
;            /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;            /* coverity[misra_c_2012_rule_11_3_violation] */
;            pxNewTimer = ( Timer_t * ) pxTimerBuffer;
	lda	<L13+pxTimerBuffer_0
	sta	<L14+pxNewTimer_1
	lda	<L13+pxTimerBuffer_0+2
	sta	<L14+pxNewTimer_1+2
;
;            if( pxNewTimer != NULL )
;            {
	lda	<L14+pxNewTimer_1
	ora	<L14+pxNewTimer_1+2
	beq	L10026
;                /* Timers can be created statically or dynamically so note this
;                 * timer was created statically in case it is later deleted.  The
;                 * auto-reload bit may get set in prvInitialiseNewTimer(). */
;                pxNewTimer->ucStatus = ( uint8_t ) tmrSTATUS_IS_STATICALLY_ALLOCATED;
	sep	#$20
	longa	off
	lda	#$2
	ldy	#$22
	sta	[<L14+pxNewTimer_1],Y
	rep	#$20
	longa	on
;
;                prvInitialiseNewTimer( pcTimerName, xTimerPeriodInTicks, xAutoReload, pvTimerID, pxCallbackFunction, pxNewTimer );
	pei	<L14+pxNewTimer_1+2
	pei	<L14+pxNewTimer_1
	pei	<L13+pxCallbackFunction_0
	pei	<L13+pvTimerID_0+2
	pei	<L13+pvTimerID_0
	pei	<L13+xAutoReload_0
	pei	<L13+xTimerPeriodInTicks_0+2
	pei	<L13+xTimerPeriodInTicks_0
	pei	<L13+pcTimerName_0+2
	pei	<L13+pcTimerName_0
	jsr	_~prvInitialiseNewTimer
;            }
;
;            traceRETURN_xTimerCreateStatic( pxNewTimer );
L10026:
;
;            return pxNewTimer;
	ldx	<L14+pxNewTimer_1+2
	lda	<L14+pxNewTimer_1
	tay
	lda	<L13+1
	sta	<L13+1+20
	pld
	tsc
	clc
	adc	#L13+20
	tcs
	tya
	rts
;        }
L13	equ	6
L14	equ	1
	ends
	efunc
;
;    #endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;    static void prvInitialiseNewTimer( const char * const pcTimerName,
;                                       const TickType_t xTimerPeriodInTicks,
;                                       const BaseType_t xAutoReload,
;                                       void * const pvTimerID,
;                                       TimerCallbackFunction_t pxCallbackFunction,
;                                       Timer_t * pxNewTimer )
;    {
	code
	func
_~prvInitialiseNewTimer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L19
	tcs
	phd
	tcd
pcTimerName_0	set	3
xTimerPeriodInTicks_0	set	7
xAutoReload_0	set	11
pvTimerID_0	set	13
pxCallbackFunction_0	set	17
pxNewTimer_0	set	19
;        /* 0 is not a valid value for xTimerPeriodInTicks. */
;        configASSERT( ( xTimerPeriodInTicks > 0 ) );
	lda	#$0
	cmp	<L19+xTimerPeriodInTicks_0
	sbc	<L19+xTimerPeriodInTicks_0+2
	bcc	L10027
L10031:
	bra	L10031
L10027:
;
;        /* Ensure the infrastructure used by the timer service task has been
;         * created/initialised. */
;        prvCheckForValidListAndQueue();
	jsr	_~prvCheckForValidListAndQueue
;
;        /* Initialise the timer structure members using the function
;         * parameters. */
;        pxNewTimer->pcTimerName = pcTimerName;
	lda	<L19+pcTimerName_0
	sta	[<L19+pxNewTimer_0]
	lda	<L19+pcTimerName_0+2
	ldy	#$2
	sta	[<L19+pxNewTimer_0],Y
;        pxNewTimer->xTimerPeriodInTicks = xTimerPeriodInTicks;
	lda	<L19+xTimerPeriodInTicks_0
	ldy	#$18
	sta	[<L19+pxNewTimer_0],Y
	lda	<L19+xTimerPeriodInTicks_0+2
	iny
	iny
	sta	[<L19+pxNewTimer_0],Y
;        pxNewTimer->pvTimerID = pvTimerID;
	lda	<L19+pvTimerID_0
	iny
	iny
	sta	[<L19+pxNewTimer_0],Y
	lda	<L19+pvTimerID_0+2
	iny
	iny
	sta	[<L19+pxNewTimer_0],Y
;        pxNewTimer->pxCallbackFunction = pxCallbackFunction;
	lda	<L19+pxCallbackFunction_0
	iny
	iny
	sta	[<L19+pxNewTimer_0],Y
;        vListInitialiseItem( &( pxNewTimer->xTimerListItem ) );
	lda	#$4
	clc
	adc	<L19+pxNewTimer_0
	sta	<R0
	lda	#$0
	adc	<L19+pxNewTimer_0+2
	pha
	pei	<R0
	jsr	_~vListInitialiseItem
;
;        if( xAutoReload != pdFALSE )
;        {
	lda	<L19+xAutoReload_0
	beq	L23
;            pxNewTimer->ucStatus |= ( uint8_t ) tmrSTATUS_IS_AUTORELOAD;
	lda	#$22
	clc
	adc	<L19+pxNewTimer_0
	sta	<R0
	lda	#$0
	adc	<L19+pxNewTimer_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$4
	sta	[<R0]
	rep	#$20
	longa	on
;        }
;
;        traceTIMER_CREATE( pxNewTimer );
;    }
L23:
	lda	<L19+1
	sta	<L19+1+20
	pld
	tsc
	clc
	adc	#L19+20
	tcs
	rts
L19	equ	4
L20	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTimerGenericCommandFromTask( TimerHandle_t xTimer,
;                                             const BaseType_t xCommandID,
;                                             const TickType_t xOptionalValue,
;                                             BaseType_t * const pxHigherPriorityTaskWoken,
;                                             const TickType_t xTicksToWait )
;    {
	code
	xdef	_~xTimerGenericCommandFromTask
	func
_~xTimerGenericCommandFromTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L24
	tcs
	phd
	tcd
xTimer_0	set	3
xCommandID_0	set	7
xOptionalValue_0	set	9
pxHigherPriorityTaskWoken_0	set	13
xTicksToWait_0	set	17
;        BaseType_t xReturn = pdFAIL;
;        DaemonTaskMessage_t xMessage;
;
;        ( void ) pxHigherPriorityTaskWoken;
xReturn_1	set	0
xMessage_1	set	2
	stz	<L25+xReturn_1
;
;        traceENTER_xTimerGenericCommandFromTask( xTimer, xCommandID, xOptionalValue, pxHigherPriorityTaskWoken, xTicksToWait );
;
;        /* Send a message to the timer service task to perform a particular action
;         * on a particular timer definition. */
;        if( ( xTimerQueue != NULL ) && ( xTimer != NULL ) )
;        {
	lda	|_~xTimerQueue
	ora	|_~xTimerQueue+2
	beq	L10046
	lda	<L24+xTimer_0
	ora	<L24+xTimer_0+2
	beq	L10046
;            /* Send a command to the timer service task to start the xTimer timer. */
;            xMessage.xMessageID = xCommandID;
	lda	<L24+xCommandID_0
	sta	<L25+xMessage_1
;            xMessage.u.xTimerParameters.xMessageValue = xOptionalValue;
	lda	<L24+xOptionalValue_0
	sta	<L25+xMessage_1+2
	lda	<L24+xOptionalValue_0+2
	sta	<L25+xMessage_1+4
;            xMessage.u.xTimerParameters.pxTimer = xTimer;
	lda	<L24+xTimer_0
	sta	<L25+xMessage_1+6
	lda	<L24+xTimer_0+2
	sta	<L25+xMessage_1+8
;
;            /* Enforce a lower bound as well as an upper bound so that only
;             * valid task-issued commands are accepted here. */
;            configASSERT( ( xCommandID >= tmrCOMMAND_START_DONT_TRACE ) && ( xCommandID < tmrFIRST_FROM_ISR_COMMAND ) );
	lda	<L24+xCommandID_0
	bmi	L10040
	sec
	lda	<L24+xCommandID_0
	sbc	#<$6
	bvs	L30
	eor	#$8000
L30:
	bpl	L10036
L10040:
	bra	L10040
L10036:
;
;            if( ( xCommandID >= tmrCOMMAND_START_DONT_TRACE ) && ( xCommandID < tmrFIRST_FROM_ISR_COMMAND ) )
;            {
	lda	<L24+xCommandID_0
	bmi	L10046
	sec
	lda	<L24+xCommandID_0
	sbc	#<$6
	bvs	L33
	eor	#$8000
L33:
	bmi	L10046
;                if( xTaskGetSchedulerState() == taskSCHEDULER_RUNNING )
;                {
	jsr	_~xTaskGetSchedulerState
	cmp	#<$2
	bne	L10044
;                    xReturn = xQueueSendToBack( xTimerQueue, &xMessage, xTicksToWait );
	pea	#<$0
	pei	<L24+xTicksToWait_0+2
	pei	<L24+xTicksToWait_0
L20010:
	pea	#0
	clc
	tdc
	adc	#<L25+xMessage_1
	pha
	lda	|_~xTimerQueue+2
	pha
	lda	|_~xTimerQueue
	pha
	jsr	_~xQueueGenericSend
	sta	<L25+xReturn_1
;                }
;                else
L10046:
;
;        traceRETURN_xTimerGenericCommandFromTask( xReturn );
;
;        return xReturn;
	lda	<L25+xReturn_1
	tay
	lda	<L24+1
	sta	<L24+1+18
	pld
	tsc
	clc
	adc	#L24+18
	tcs
	tya
	rts
L10044:
;                {
;                    xReturn = xQueueSendToBack( xTimerQueue, &xMessage, tmrNO_DELAY );
	pea	#<$0
	pea	#^$0
	pea	#<$0
	bra	L20010
;                }
;            }
;
;            traceTIMER_COMMAND_SEND( xTimer, xCommandID, xOptionalValue, xReturn );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
;    }
L24	equ	16
L25	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTimerGenericCommandFromISR( TimerHandle_t xTimer,
;                                            const BaseType_t xCommandID,
;                                            const TickType_t xOptionalValue,
;                                            BaseType_t * const pxHigherPriorityTaskWoken,
;                                            const TickType_t xTicksToWait )
;    {
	code
	xdef	_~xTimerGenericCommandFromISR
	func
_~xTimerGenericCommandFromISR:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L37
	tcs
	phd
	tcd
xTimer_0	set	3
xCommandID_0	set	7
xOptionalValue_0	set	9
pxHigherPriorityTaskWoken_0	set	13
xTicksToWait_0	set	17
;        BaseType_t xReturn = pdFAIL;
;        DaemonTaskMessage_t xMessage;
;
;        ( void ) xTicksToWait;
xReturn_1	set	0
xMessage_1	set	2
	stz	<L38+xReturn_1
;
;        traceENTER_xTimerGenericCommandFromISR( xTimer, xCommandID, xOptionalValue, pxHigherPriorityTaskWoken, xTicksToWait );
;
;        /* Send a message to the timer service task to perform a particular action
;         * on a particular timer definition. */
;        if( ( xTimerQueue != NULL ) && ( xTimer != NULL ) )
;        {
	lda	|_~xTimerQueue
	ora	|_~xTimerQueue+2
	beq	L10056
	lda	<L37+xTimer_0
	ora	<L37+xTimer_0+2
	beq	L10056
;            /* Send a command to the timer service task to start the xTimer timer. */
;            xMessage.xMessageID = xCommandID;
	lda	<L37+xCommandID_0
	sta	<L38+xMessage_1
;            xMessage.u.xTimerParameters.xMessageValue = xOptionalValue;
	lda	<L37+xOptionalValue_0
	sta	<L38+xMessage_1+2
	lda	<L37+xOptionalValue_0+2
	sta	<L38+xMessage_1+4
;            xMessage.u.xTimerParameters.pxTimer = xTimer;
	lda	<L37+xTimer_0
	sta	<L38+xMessage_1+6
	lda	<L37+xTimer_0+2
	sta	<L38+xMessage_1+8
;
;            configASSERT( xCommandID >= tmrFIRST_FROM_ISR_COMMAND );
	sec
	lda	<L37+xCommandID_0
	sbc	#<$6
	bvs	L41
	eor	#$8000
L41:
	bmi	L10048
L10052:
	bra	L10052
L10048:
;
;            if( xCommandID >= tmrFIRST_FROM_ISR_COMMAND )
;            {
	sec
	lda	<L37+xCommandID_0
	sbc	#<$6
	bvs	L43
	eor	#$8000
L43:
	bpl	L10056
;                xReturn = xQueueSendToBackFromISR( xTimerQueue, &xMessage, pxHigherPriorityTaskWoken );
	pea	#<$0
	pei	<L37+pxHigherPriorityTaskWoken_0+2
	pei	<L37+pxHigherPriorityTaskWoken_0
	pea	#0
	clc
	tdc
	adc	#<L38+xMessage_1
	pha
	lda	|_~xTimerQueue+2
	pha
	lda	|_~xTimerQueue
	pha
	jsr	_~xQueueGenericSendFromISR
	sta	<L38+xReturn_1
;            }
;
;            traceTIMER_COMMAND_SEND( xTimer, xCommandID, xOptionalValue, xReturn );
;        }
;        else
;        {
;            mtCOVERAGE_TEST_MARKER();
;        }
L10056:
;
;        traceRETURN_xTimerGenericCommandFromISR( xReturn );
;
;        return xReturn;
	lda	<L38+xReturn_1
	tay
	lda	<L37+1
	sta	<L37+1+18
	pld
	tsc
	clc
	adc	#L37+18
	tcs
	tya
	rts
;    }
L37	equ	12
L38	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    TaskHandle_t xTimerGetTimerDaemonTaskHandle( void )
;    {
	code
	xdef	_~xTimerGetTimerDaemonTaskHandle
	func
_~xTimerGetTimerDaemonTaskHandle:
	longa	on
	longi	on
;        traceENTER_xTimerGetTimerDaemonTaskHandle();
;
;        /* If xTimerGetTimerDaemonTaskHandle() is called before the scheduler has been
;         * started, then xTimerTaskHandle will be NULL. */
;        configASSERT( ( xTimerTaskHandle != NULL ) );
	lda	|_~xTimerTaskHandle
	ora	|_~xTimerTaskHandle+2
	bne	L10057
L10061:
	bra	L10061
L10057:
;
;        traceRETURN_xTimerGetTimerDaemonTaskHandle( xTimerTaskHandle );
;
;        return xTimerTaskHandle;
	ldx	|_~xTimerTaskHandle+2
	lda	|_~xTimerTaskHandle
	rts
;    }
L46	equ	0
L47	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    TickType_t xTimerGetPeriod( TimerHandle_t xTimer )
;    {
	code
	xdef	_~xTimerGetPeriod
	func
_~xTimerGetPeriod:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L50
	tcs
	phd
	tcd
xTimer_0	set	3
;        Timer_t * pxTimer = xTimer;
;
;        traceENTER_xTimerGetPeriod( xTimer );
pxTimer_1	set	0
	lda	<L50+xTimer_0
	sta	<L51+pxTimer_1
	lda	<L50+xTimer_0+2
	sta	<L51+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L50+xTimer_0
	ora	<L50+xTimer_0+2
	bne	L10064
L10068:
	bra	L10068
L10064:
;
;        traceRETURN_xTimerGetPeriod( pxTimer->xTimerPeriodInTicks );
;
;        return pxTimer->xTimerPeriodInTicks;
	ldy	#$1a
	lda	[<L51+pxTimer_1],Y
	tax
	dey
	dey
	lda	[<L51+pxTimer_1],Y
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
L50	equ	4
L51	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    void vTimerSetReloadMode( TimerHandle_t xTimer,
;                              const BaseType_t xAutoReload )
;    {
	code
	xdef	_~vTimerSetReloadMode
	func
_~vTimerSetReloadMode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
xTimer_0	set	3
xAutoReload_0	set	7
;        Timer_t * pxTimer = xTimer;
;
;        traceENTER_vTimerSetReloadMode( xTimer, xAutoReload );
pxTimer_1	set	0
	lda	<L54+xTimer_0
	sta	<L55+pxTimer_1
	lda	<L54+xTimer_0+2
	sta	<L55+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L54+xTimer_0
	ora	<L54+xTimer_0+2
	bne	L10079
L10075:
	bra	L10075
;        taskENTER_CRITICAL();
L10079:
;        {
;            if( xAutoReload != pdFALSE )
;            {
	lda	<L54+xAutoReload_0
	beq	L10081
;                pxTimer->ucStatus |= ( uint8_t ) tmrSTATUS_IS_AUTORELOAD;
	lda	#$22
	clc
	adc	<L55+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L55+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$4
	sta	[<R0]
	rep	#$20
	longa	on
;            }
;            else
	bra	L58
L10081:
;            {
;                pxTimer->ucStatus &= ( ( uint8_t ) ~tmrSTATUS_IS_AUTORELOAD );
	lda	#$22
	clc
	adc	<L55+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L55+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$fb
	sta	[<R0]
	rep	#$20
	longa	on
;            }
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_vTimerSetReloadMode();
;    }
L58:
	lda	<L54+1
	sta	<L54+1+6
	pld
	tsc
	clc
	adc	#L54+6
	tcs
	rts
L54	equ	8
L55	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTimerGetReloadMode( TimerHandle_t xTimer )
;    {
	code
	xdef	_~xTimerGetReloadMode
	func
_~xTimerGetReloadMode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L59
	tcs
	phd
	tcd
xTimer_0	set	3
;        Timer_t * pxTimer = xTimer;
;        BaseType_t xReturn;
;
;        traceENTER_xTimerGetReloadMode( xTimer );
pxTimer_1	set	0
xReturn_1	set	4
	lda	<L59+xTimer_0
	sta	<L60+pxTimer_1
	lda	<L59+xTimer_0+2
	sta	<L60+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L59+xTimer_0
	ora	<L59+xTimer_0+2
	bne	L10094
L10090:
	bra	L10090
;        portBASE_TYPE_ENTER_CRITICAL();
L10094:
;        {
;            if( ( pxTimer->ucStatus & tmrSTATUS_IS_AUTORELOAD ) == 0U )
;            {
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L60+pxTimer_1],Y
	and	#<$4
	rep	#$20
	longa	on
	bne	L10096
;                /* Not an auto-reload timer. */
;                xReturn = pdFALSE;
	stz	<L60+xReturn_1
;            }
;            else
	bra	L10099
L10096:
;            {
;                /* Is an auto-reload timer. */
;                xReturn = pdTRUE;
	lda	#$1
	sta	<L60+xReturn_1
;            }
;        }
;        portBASE_TYPE_EXIT_CRITICAL();
L10099:
;
;        traceRETURN_xTimerGetReloadMode( xReturn );
;
;        return xReturn;
	lda	<L60+xReturn_1
	tay
	lda	<L59+1
	sta	<L59+1+4
	pld
	tsc
	clc
	adc	#L59+4
	tcs
	tya
	rts
;    }
L59	equ	6
L60	equ	1
	ends
	efunc
;
;    UBaseType_t uxTimerGetReloadMode( TimerHandle_t xTimer )
;    {
	code
	xdef	_~uxTimerGetReloadMode
	func
_~uxTimerGetReloadMode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L64
	tcs
	phd
	tcd
xTimer_0	set	3
;        UBaseType_t uxReturn;
;
;        traceENTER_uxTimerGetReloadMode( xTimer );
uxReturn_1	set	0
;
;        uxReturn = ( UBaseType_t ) xTimerGetReloadMode( xTimer );
	pei	<L64+xTimer_0+2
	pei	<L64+xTimer_0
	jsr	_~xTimerGetReloadMode
	sta	<L65+uxReturn_1
;
;        traceRETURN_uxTimerGetReloadMode( uxReturn );
;
;        return uxReturn;
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
;    }
L64	equ	2
L65	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    TickType_t xTimerGetExpiryTime( TimerHandle_t xTimer )
;    {
	code
	xdef	_~xTimerGetExpiryTime
	func
_~xTimerGetExpiryTime:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L67
	tcs
	phd
	tcd
xTimer_0	set	3
;        Timer_t * pxTimer = xTimer;
;        TickType_t xReturn;
;
;        traceENTER_xTimerGetExpiryTime( xTimer );
pxTimer_1	set	0
xReturn_1	set	4
	lda	<L67+xTimer_0
	sta	<L68+pxTimer_1
	lda	<L67+xTimer_0+2
	sta	<L68+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L67+xTimer_0
	ora	<L67+xTimer_0+2
	bne	L10101
L10105:
	bra	L10105
L10101:
;        xReturn = listGET_LIST_ITEM_VALUE( &( pxTimer->xTimerListItem ) );
	ldy	#$4
	lda	[<L68+pxTimer_1],Y
	sta	<L68+xReturn_1
	iny
	iny
	lda	[<L68+pxTimer_1],Y
	sta	<L68+xReturn_1+2
;
;        traceRETURN_xTimerGetExpiryTime( xReturn );
;
;        return xReturn;
	ldx	<L68+xReturn_1+2
	lda	<L68+xReturn_1
	tay
	lda	<L67+1
	sta	<L67+1+4
	pld
	tsc
	clc
	adc	#L67+4
	tcs
	tya
	rts
;    }
L67	equ	8
L68	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;        BaseType_t xTimerGetStaticBuffer( TimerHandle_t xTimer,
;                                          StaticTimer_t ** ppxTimerBuffer )
;        {
	code
	xdef	_~xTimerGetStaticBuffer
	func
_~xTimerGetStaticBuffer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L71
	tcs
	phd
	tcd
xTimer_0	set	3
ppxTimerBuffer_0	set	7
;            BaseType_t xReturn;
;            Timer_t * pxTimer = xTimer;
;
;            traceENTER_xTimerGetStaticBuffer( xTimer, ppxTimerBuffer );
xReturn_1	set	0
pxTimer_1	set	2
	lda	<L71+xTimer_0
	sta	<L72+pxTimer_1
	lda	<L71+xTimer_0+2
	sta	<L72+pxTimer_1+2
;
;            configASSERT( ppxTimerBuffer != NULL );
	lda	<L71+ppxTimerBuffer_0
	ora	<L71+ppxTimerBuffer_0+2
	bne	L10108
L10112:
	bra	L10112
L10108:
;
;            if( ( pxTimer->ucStatus & tmrSTATUS_IS_STATICALLY_ALLOCATED ) != 0U )
;            {
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L72+pxTimer_1],Y
	and	#<$2
	rep	#$20
	longa	on
	beq	L10115
;                /* MISRA Ref 11.3.1 [Misaligned access] */
;                /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-113 */
;                /* coverity[misra_c_2012_rule_11_3_violation] */
;                *ppxTimerBuffer = ( StaticTimer_t * ) pxTimer;
	lda	<L72+pxTimer_1
	sta	[<L71+ppxTimerBuffer_0]
	lda	<L72+pxTimer_1+2
	ldy	#$2
	sta	[<L71+ppxTimerBuffer_0],Y
;                xReturn = pdTRUE;
	lda	#$1
	sta	<L72+xReturn_1
;            }
;            else
	bra	L10116
L10115:
;            {
;                xReturn = pdFALSE;
	stz	<L72+xReturn_1
;            }
L10116:
;
;            traceRETURN_xTimerGetStaticBuffer( xReturn );
;
;            return xReturn;
	lda	<L72+xReturn_1
	tay
	lda	<L71+1
	sta	<L71+1+8
	pld
	tsc
	clc
	adc	#L71+8
	tcs
	tya
	rts
;        }
L71	equ	6
L72	equ	1
	ends
	efunc
;    #endif /* configSUPPORT_STATIC_ALLOCATION */
;/*-----------------------------------------------------------*/
;
;    const char * pcTimerGetName( TimerHandle_t xTimer )
;    {
	code
	xdef	_~pcTimerGetName
	func
_~pcTimerGetName:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L76
	tcs
	phd
	tcd
xTimer_0	set	3
;        Timer_t * pxTimer = xTimer;
;
;        traceENTER_pcTimerGetName( xTimer );
pxTimer_1	set	0
	lda	<L76+xTimer_0
	sta	<L77+pxTimer_1
	lda	<L76+xTimer_0+2
	sta	<L77+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L76+xTimer_0
	ora	<L76+xTimer_0+2
	bne	L10117
L10121:
	bra	L10121
L10117:
;
;        traceRETURN_pcTimerGetName( pxTimer->pcTimerName );
;
;        return pxTimer->pcTimerName;
	ldy	#$2
	lda	[<L77+pxTimer_1],Y
	tax
	lda	[<L77+pxTimer_1]
	tay
	lda	<L76+1
	sta	<L76+1+4
	pld
	tsc
	clc
	adc	#L76+4
	tcs
	tya
	rts
;    }
L76	equ	4
L77	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static void prvReloadTimer( Timer_t * const pxTimer,
;                                TickType_t xExpiredTime,
;                                const TickType_t xTimeNow )
;    {
	code
	func
_~prvReloadTimer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L80
	tcs
	phd
	tcd
pxTimer_0	set	3
xExpiredTime_0	set	7
xTimeNow_0	set	11
;        /* Insert the timer into the appropriate list for the next expiry time.
;         * If the next expiry time has already passed, advance the expiry time,
;         * call the callback function, and try again. */
;        while( prvInsertTimerInActiveList( pxTimer, ( xExpiredTime + pxTimer->xTimerPeriodInTicks ), xTimeNow, xExpiredTime ) != pdFALSE )
L10124:
	pei	<L80+xExpiredTime_0+2
	pei	<L80+xExpiredTime_0
	pei	<L80+xTimeNow_0+2
	pei	<L80+xTimeNow_0
	clc
	lda	<L80+xExpiredTime_0
	ldy	#$18
	adc	[<L80+pxTimer_0],Y
	sta	<R0
	lda	<L80+xExpiredTime_0+2
	iny
	iny
	adc	[<L80+pxTimer_0],Y
	pha
	pei	<R0
	pei	<L80+pxTimer_0+2
	pei	<L80+pxTimer_0
	jsr	_~prvInsertTimerInActiveList
	tax
	beq	L83
;        {
;            /* Advance the expiry time. */
;            xExpiredTime += pxTimer->xTimerPeriodInTicks;
	clc
	lda	<L80+xExpiredTime_0
	ldy	#$18
	adc	[<L80+pxTimer_0],Y
	sta	<L80+xExpiredTime_0
	lda	<L80+xExpiredTime_0+2
	iny
	iny
	adc	[<L80+pxTimer_0],Y
	sta	<L80+xExpiredTime_0+2
;
;            /* Call the timer callback. */
;            traceTIMER_EXPIRED( pxTimer );
;            pxTimer->pxCallbackFunction( ( TimerHandle_t ) pxTimer );
	pei	<L80+pxTimer_0+2
	pei	<L80+pxTimer_0
	ldy	#$20
	lda	[<L80+pxTimer_0],Y
	xref	_~~cal
	jsr	_~~cal
;        }
	bra	L10124
;    }
L83:
	lda	<L80+1
	sta	<L80+1+12
	pld
	tsc
	clc
	adc	#L80+12
	tcs
	rts
L80	equ	4
L81	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static void prvProcessExpiredTimer( const TickType_t xNextExpireTime,
;                                        const TickType_t xTimeNow )
;    {
	code
	func
_~prvProcessExpiredTimer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L84
	tcs
	phd
	tcd
xNextExpireTime_0	set	3
xTimeNow_0	set	7
;        /* MISRA Ref 11.5.3 [Void pointer assignment] */
;        /* More details at: https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/MISRA.md#rule-115 */
;        /* coverity[misra_c_2012_rule_11_5_violation] */
;        Timer_t * const pxTimer = ( Timer_t * ) listGET_OWNER_OF_HEAD_ENTRY( pxCurrentTimerList );
;
;        /* Remove the timer from the list of active timers.  A check has already
;         * been performed to ensure the list is not empty. */
;
;        ( void ) uxListRemove( &( pxTimer->xTimerListItem ) );
pxTimer_1	set	0
	lda	|_~pxCurrentTimerList
	sta	<R0
	lda	|_~pxCurrentTimerList+2
	sta	<R0+2
	ldy	#$a
	lda	[<R0],Y
	sta	<R1
	iny
	iny
	lda	[<R0],Y
	sta	<R1+2
	lda	[<R1],Y
	sta	<L85+pxTimer_1
	iny
	iny
	lda	[<R1],Y
	sta	<L85+pxTimer_1+2
	lda	#$4
	clc
	adc	<L85+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L85+pxTimer_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;
;        /* If the timer is an auto-reload timer then calculate the next
;         * expiry time and re-insert the timer in the list of active timers. */
;        if( ( pxTimer->ucStatus & tmrSTATUS_IS_AUTORELOAD ) != 0U )
;        {
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L85+pxTimer_1],Y
	and	#<$4
	rep	#$20
	longa	on
	beq	L10126
;            prvReloadTimer( pxTimer, xNextExpireTime, xTimeNow );
	pei	<L84+xTimeNow_0+2
	pei	<L84+xTimeNow_0
	pei	<L84+xNextExpireTime_0+2
	pei	<L84+xNextExpireTime_0
	pei	<L85+pxTimer_1+2
	pei	<L85+pxTimer_1
	jsr	_~prvReloadTimer
;        }
;        else
	bra	L10127
L10126:
;        {
;            pxTimer->ucStatus &= ( ( uint8_t ) ~tmrSTATUS_IS_ACTIVE );
	lda	#$22
	clc
	adc	<L85+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L85+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$fe
	sta	[<R0]
	rep	#$20
	longa	on
;        }
L10127:
;
;        /* Call the timer callback. */
;        traceTIMER_EXPIRED( pxTimer );
;        pxTimer->pxCallbackFunction( ( TimerHandle_t ) pxTimer );
	pei	<L85+pxTimer_1+2
	pei	<L85+pxTimer_1
	ldy	#$20
	lda	[<L85+pxTimer_1],Y
	xref	_~~cal
	jsr	_~~cal
;    }
	lda	<L84+1
	sta	<L84+1+8
	pld
	tsc
	clc
	adc	#L84+8
	tcs
	rts
L84	equ	12
L85	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static portTASK_FUNCTION( prvTimerTask, pvParameters )
;    {
	code
	func
_~prvTimerTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L88
	tcs
	phd
	tcd
pvParameters_0	set	3
;        TickType_t xNextExpireTime;
;        BaseType_t xListWasEmpty;
;
;        /* Just to avoid compiler warnings. */
;        ( void ) pvParameters;
xNextExpireTime_1	set	0
xListWasEmpty_1	set	4
;
;        #if ( configUSE_DAEMON_TASK_STARTUP_HOOK == 1 )
;        {
;            /* Allow the application writer to execute some code in the context of
;             * this task at the point the task starts executing.  This is useful if the
;             * application includes initialisation code that would benefit from
;             * executing after the scheduler has been started. */
;            vApplicationDaemonTaskStartupHook();
;        }
;        #endif /* configUSE_DAEMON_TASK_STARTUP_HOOK */
;
;        for( ; configCONTROL_INFINITE_LOOP(); )
L10130:
;        {
;            /* Query the timers list to see if it contains any timers, and if so,
;             * obtain the time at which the next timer will expire. */
;            xNextExpireTime = prvGetNextExpireTime( &xListWasEmpty );
	pea	#0
	clc
	tdc
	adc	#<L89+xListWasEmpty_1
	pha
	jsr	_~prvGetNextExpireTime
	sta	<L89+xNextExpireTime_1
	stx	<L89+xNextExpireTime_1+2
;
;            /* If a timer has expired, process it.  Otherwise, block this task
;             * until either a timer does expire, or a command is received. */
;            prvProcessTimerOrBlockTask( xNextExpireTime, xListWasEmpty );
	pei	<L89+xListWasEmpty_1
	pei	<L89+xNextExpireTime_1+2
	pei	<L89+xNextExpireTime_1
	jsr	_~prvProcessTimerOrBlockTask
;
;            /* Empty the command queue. */
;            prvProcessReceivedCommands();
	jsr	_~prvProcessReceivedCommands
;        }
	bra	L10130
;    }
L88	equ	6
L89	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static void prvProcessTimerOrBlockTask( const TickType_t xNextExpireTime,
;                                            BaseType_t xListWasEmpty )
;    {
	code
	func
_~prvProcessTimerOrBlockTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L90
	tcs
	phd
	tcd
xNextExpireTime_0	set	3
xListWasEmpty_0	set	7
;        TickType_t xTimeNow;
;        BaseType_t xTimerListsWereSwitched;
;
;        vTaskSuspendAll();
xTimeNow_1	set	0
xTimerListsWereSwitched_1	set	4
	jsr	_~vTaskSuspendAll
;        {
;            /* Obtain the time now to make an assessment as to whether the timer
;             * has expired or not.  If obtaining the time causes the lists to switch
;             * then don't process this timer as any timers that remained in the list
;             * when the lists were switched will have been processed within the
;             * prvSampleTimeNow() function. */
;            xTimeNow = prvSampleTimeNow( &xTimerListsWereSwitched );
	pea	#0
	clc
	tdc
	adc	#<L91+xTimerListsWereSwitched_1
	pha
	jsr	_~prvSampleTimeNow
	sta	<L91+xTimeNow_1
	stx	<L91+xTimeNow_1+2
;
;            if( xTimerListsWereSwitched == pdFALSE )
;            {
	lda	<L91+xTimerListsWereSwitched_1
	bne	L10131
;                /* The tick count has not overflowed, has the timer expired? */
;                if( ( xListWasEmpty == pdFALSE ) && ( xNextExpireTime <= xTimeNow ) )
;                {
	lda	<L90+xListWasEmpty_0
	bne	L10132
	lda	<L91+xTimeNow_1
	cmp	<L90+xNextExpireTime_0
	lda	<L91+xTimeNow_1+2
	sbc	<L90+xNextExpireTime_0+2
	bcc	L10132
;                    ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;                    prvProcessExpiredTimer( xNextExpireTime, xTimeNow );
	pei	<L91+xTimeNow_1+2
	pei	<L91+xTimeNow_1
	pei	<L90+xNextExpireTime_0+2
	pei	<L90+xNextExpireTime_0
	jsr	_~prvProcessExpiredTimer
;                }
;                else
	bra	L100
L10132:
;                {
;                    /* The tick count has not overflowed, and the next expire
;                     * time has not been reached yet.  This task should therefore
;                     * block to wait for the next expire time or a command to be
;                     * received - whichever comes first.  The following line cannot
;                     * be reached unless xNextExpireTime > xTimeNow, except in the
;                     * case when the current timer list is empty. */
;                    if( xListWasEmpty != pdFALSE )
;                    {
	lda	<L90+xListWasEmpty_0
	beq	L10134
;                        /* The current timer list is empty - is the overflow list
;                         * also empty? */
;                        xListWasEmpty = listLIST_IS_EMPTY( pxOverflowTimerList );
	lda	|_~pxOverflowTimerList
	sta	<R0
	lda	|_~pxOverflowTimerList+2
	sta	<R0+2
	lda	[<R0]
	bne	L96
	lda	#$1
	bra	L98
L96:
	lda	#$0
L98:
	sta	<L90+xListWasEmpty_0
;                    }
;
;                    vQueueWaitForMessageRestricted( xTimerQueue, ( xNextExpireTime - xTimeNow ), xListWasEmpty );
L10134:
	pei	<L90+xListWasEmpty_0
	sec
	lda	<L90+xNextExpireTime_0
	sbc	<L91+xTimeNow_1
	sta	<R0
	lda	<L90+xNextExpireTime_0+2
	sbc	<L91+xTimeNow_1+2
	pha
	pei	<R0
	lda	|_~xTimerQueue+2
	pha
	lda	|_~xTimerQueue
	pha
	jsr	_~vQueueWaitForMessageRestricted
;
;                    if( xTaskResumeAll() == pdFALSE )
;                    {
	jsr	_~xTaskResumeAll
	tax
	bne	L100
;                        /* Yield to wait for either a command to arrive, or the
;                         * block time to expire.  If a command arrived between the
;                         * critical section being exited and this yield then the yield
;                         * will not cause the task to block. */
;                        taskYIELD_WITHIN_API();
	jsr	_~vPortYield
;                    }
;                    else
	bra	L100
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;            }
;            else
L10131:
;            {
;                ( void ) xTaskResumeAll();
	jsr	_~xTaskResumeAll
;            }
;        }
;    }
L100:
	lda	<L90+1
	sta	<L90+1+6
	pld
	tsc
	clc
	adc	#L90+6
	tcs
	rts
L90	equ	10
L91	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static TickType_t prvGetNextExpireTime( BaseType_t * const pxListWasEmpty )
;    {
	code
	func
_~prvGetNextExpireTime:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L101
	tcs
	phd
	tcd
pxListWasEmpty_0	set	3
;        TickType_t xNextExpireTime;
;
;        /* Timers are listed in expiry time order, with the head of the list
;         * referencing the task that will expire first.  Obtain the time at which
;         * the timer with the nearest expiry time will expire.  If there are no
;         * active timers then just set the next expire time to 0.  That will cause
;         * this task to unblock when the tick count overflows, at which point the
;         * timer lists will be switched and the next expiry time can be
;         * re-assessed.  */
;        *pxListWasEmpty = listLIST_IS_EMPTY( pxCurrentTimerList );
xNextExpireTime_1	set	0
	lda	|_~pxCurrentTimerList
	sta	<R0
	lda	|_~pxCurrentTimerList+2
	sta	<R0+2
	lda	[<R0]
	bne	L103
	lda	#$1
	bra	L105
L103:
	lda	#$0
L105:
	sta	[<L101+pxListWasEmpty_0]
;
;        if( *pxListWasEmpty == pdFALSE )
;        {
	lda	[<L101+pxListWasEmpty_0]
	bne	L10138
;            xNextExpireTime = listGET_ITEM_VALUE_OF_HEAD_ENTRY( pxCurrentTimerList );
	lda	|_~pxCurrentTimerList
	sta	<R0
	lda	|_~pxCurrentTimerList+2
	sta	<R0+2
	ldy	#$a
	lda	[<R0],Y
	sta	<R1
	iny
	iny
	lda	[<R0],Y
	sta	<R1+2
	lda	[<R1]
	sta	<L102+xNextExpireTime_1
	ldy	#$2
	lda	[<R1],Y
	sta	<L102+xNextExpireTime_1+2
;        }
;        else
	bra	L10139
L10138:
;        {
;            /* Ensure the task unblocks when the tick count rolls over. */
;            xNextExpireTime = ( TickType_t ) 0U;
	stz	<L102+xNextExpireTime_1
	stz	<L102+xNextExpireTime_1+2
;        }
L10139:
;
;        return xNextExpireTime;
	ldx	<L102+xNextExpireTime_1+2
	lda	<L102+xNextExpireTime_1
	tay
	lda	<L101+1
	sta	<L101+1+4
	pld
	tsc
	clc
	adc	#L101+4
	tcs
	tya
	rts
;    }
L101	equ	12
L102	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static TickType_t prvSampleTimeNow( BaseType_t * const pxTimerListsWereSwitched )
;    {
	code
	func
_~prvSampleTimeNow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L108
	tcs
	phd
	tcd
pxTimerListsWereSwitched_0	set	3
;        TickType_t xTimeNow;
;        PRIVILEGED_DATA static TickType_t xLastTime = ( TickType_t ) 0U;
;
;        xTimeNow = xTaskGetTickCount();
xTimeNow_1	set	0
	jsr	_~xTaskGetTickCount
	sta	<L109+xTimeNow_1
	stx	<L109+xTimeNow_1+2
;
;        if( xTimeNow < xLastTime )
;        {
	cmp	|L110
	lda	<L109+xTimeNow_1+2
	sbc	|L110+2
	bcs	L10140
;            prvSwitchTimerLists();
	jsr	_~prvSwitchTimerLists
;            *pxTimerListsWereSwitched = pdTRUE;
	lda	#$1
	bra	L20011
;        }
;        else
L10140:
;        {
;            *pxTimerListsWereSwitched = pdFALSE;
	lda	#$0
L20011:
	sta	[<L108+pxTimerListsWereSwitched_0]
;        }
;
;        xLastTime = xTimeNow;
	lda	<L109+xTimeNow_1
	sta	|L110
	lda	<L109+xTimeNow_1+2
	sta	|L110+2
;
;        return xTimeNow;
	ldx	<L109+xTimeNow_1+2
	lda	<L109+xTimeNow_1
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
L108	equ	4
L109	equ	1
	ends
	efunc
	data
L110:
	dl	$0
	ends
;/*-----------------------------------------------------------*/
;
;    static BaseType_t prvInsertTimerInActiveList( Timer_t * const pxTimer,
;                                                  const TickType_t xNextExpiryTime,
;                                                  const TickType_t xTimeNow,
;                                                  const TickType_t xCommandTime )
;    {
	code
	func
_~prvInsertTimerInActiveList:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L113
	tcs
	phd
	tcd
pxTimer_0	set	3
xNextExpiryTime_0	set	7
xTimeNow_0	set	11
xCommandTime_0	set	15
;        BaseType_t xProcessTimerNow = pdFALSE;
;
;        listSET_LIST_ITEM_VALUE( &( pxTimer->xTimerListItem ), xNextExpiryTime );
xProcessTimerNow_1	set	0
	stz	<L114+xProcessTimerNow_1
	lda	<L113+xNextExpiryTime_0
	ldy	#$4
	sta	[<L113+pxTimer_0],Y
	lda	<L113+xNextExpiryTime_0+2
	iny
	iny
	sta	[<L113+pxTimer_0],Y
;        listSET_LIST_ITEM_OWNER( &( pxTimer->xTimerListItem ), pxTimer );
	lda	<L113+pxTimer_0
	ldy	#$10
	sta	[<L113+pxTimer_0],Y
	lda	<L113+pxTimer_0+2
	iny
	iny
	sta	[<L113+pxTimer_0],Y
;
;        if( xNextExpiryTime <= xTimeNow )
;        {
	lda	<L113+xTimeNow_0
	cmp	<L113+xNextExpiryTime_0
	lda	<L113+xTimeNow_0+2
	sbc	<L113+xNextExpiryTime_0+2
	bcc	L10142
;            /* Has the expiry time elapsed between the command to start/reset a
;             * timer was issued, and the time the command was processed? */
;            if( ( ( TickType_t ) ( xTimeNow - xCommandTime ) ) >= pxTimer->xTimerPeriodInTicks )
;            {
	sec
	lda	<L113+xTimeNow_0
	sbc	<L113+xCommandTime_0
	sta	<R0
	lda	<L113+xTimeNow_0+2
	sbc	<L113+xCommandTime_0+2
	sta	<R0+2
	lda	<R0
	ldy	#$18
	cmp	[<L113+pxTimer_0],Y
	lda	<R0+2
	iny
	iny
	sbc	[<L113+pxTimer_0],Y
	bcc	L10143
;                /* The time between a command being issued and the command being
;                 * processed actually exceeds the timers period.  */
;                xProcessTimerNow = pdTRUE;
L20015:
	lda	#$1
	sta	<L114+xProcessTimerNow_1
;            }
;            else
	bra	L10145
L10143:
;            {
;                vListInsert( pxOverflowTimerList, &( pxTimer->xTimerListItem ) );
	lda	#$4
	clc
	adc	<L113+pxTimer_0
	sta	<R0
	lda	#$0
	adc	<L113+pxTimer_0+2
	pha
	pei	<R0
	lda	|_~pxOverflowTimerList+2
	pha
	lda	|_~pxOverflowTimerList
	bra	L20013
;            }
;        }
;        else
L10142:
;        {
;            if( ( xTimeNow < xCommandTime ) && ( xNextExpiryTime >= xCommandTime ) )
;            {
	lda	<L113+xTimeNow_0
	cmp	<L113+xCommandTime_0
	lda	<L113+xTimeNow_0+2
	sbc	<L113+xCommandTime_0+2
	bcs	L10146
	lda	<L113+xNextExpiryTime_0
	cmp	<L113+xCommandTime_0
	lda	<L113+xNextExpiryTime_0+2
	sbc	<L113+xCommandTime_0+2
	bcs	L20015
;                /* If, since the command was issued, the tick count has overflowed
;                 * but the expiry time has not, then the timer must have already passed
;                 * its expiry time and should be processed immediately. */
;                xProcessTimerNow = pdTRUE;
;            }
;            else
L10146:
;            {
;                vListInsert( pxCurrentTimerList, &( pxTimer->xTimerListItem ) );
	lda	#$4
	clc
	adc	<L113+pxTimer_0
	sta	<R0
	lda	#$0
	adc	<L113+pxTimer_0+2
	pha
	pei	<R0
	lda	|_~pxCurrentTimerList+2
	pha
	lda	|_~pxCurrentTimerList
L20013:
	pha
	jsr	_~vListInsert
;            }
;        }
L10145:
;
;        return xProcessTimerNow;
	lda	<L114+xProcessTimerNow_1
	tay
	lda	<L113+1
	sta	<L113+1+16
	pld
	tsc
	clc
	adc	#L113+16
	tcs
	tya
	rts
;    }
L113	equ	6
L114	equ	5
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static void prvProcessReceivedCommands( void )
;    {
	code
	func
_~prvProcessReceivedCommands:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L120
	tcs
	phd
	tcd
;        DaemonTaskMessage_t xMessage = { 0 };
;        Timer_t * pxTimer;
;        BaseType_t xTimerListsWereSwitched;
;        TickType_t xTimeNow;
;
;        while( xQueueReceive( xTimerQueue, &xMessage, tmrNO_DELAY ) != pdFAIL )
xMessage_1	set	0
pxTimer_1	set	10
xTimerListsWereSwitched_1	set	14
xTimeNow_1	set	16
	pea	#^L122
	pea	#<L122
	clc
	tdc
	adc	#<L121+xMessage_1
	sta	<R0
	lda	#$0
	pha
	pei	<R0
	lda	#$a
	xref	_~~fmov
	jsr	_~~fmov
L10148:
	pea	#^$0
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L121+xMessage_1
	pha
	lda	|_~xTimerQueue+2
	pha
	lda	|_~xTimerQueue
	pha
	jsr	_~xQueueReceive
	tax
	bne	L20016
;    }
	pld
	tsc
	clc
	adc	#L120
	tcs
	rts
L20016:
;        {
;            #if ( INCLUDE_xTimerPendFunctionCall == 1 )
;            {
;                /* Negative commands are pended function calls rather than timer
;                 * commands. */
;                if( xMessage.xMessageID < ( BaseType_t ) 0 )
;                {
;                    const CallbackParameters_t * const pxCallback = &( xMessage.u.xCallbackParameters );
;
;                    /* The timer uses the xCallbackParameters member to request a
;                     * callback be executed.  Check the callback is not NULL. */
;                    configASSERT( pxCallback );
;
;                    /* Call the function. */
;                    pxCallback->pxCallbackFunction( pxCallback->pvParameter1, pxCallback->ulParameter2 );
;                }
;                else
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;            #endif /* INCLUDE_xTimerPendFunctionCall */
;
;            /* Commands that are positive are timer commands rather than pended
;             * function calls. */
;            if( xMessage.xMessageID >= ( BaseType_t ) 0 )
;            {
	lda	<L121+xMessage_1
	bmi	L10148
;                /* The messages uses the xTimerParameters member to work on a
;                 * software timer. */
;                pxTimer = xMessage.u.xTimerParameters.pxTimer;
	lda	<L121+xMessage_1+6
	sta	<L121+pxTimer_1
	lda	<L121+xMessage_1+8
	sta	<L121+pxTimer_1+2
;
;                if( pxTimer != NULL )
;                {
	lda	<L121+pxTimer_1
	ora	<L121+pxTimer_1+2
	beq	L10148
;                    if( listIS_CONTAINED_WITHIN( NULL, &( pxTimer->xTimerListItem ) ) == pdFALSE )
;                    {
	ldy	#$14
	lda	[<L121+pxTimer_1],Y
	iny
	iny
	ora	[<L121+pxTimer_1],Y
	bne	L126
	lda	#$1
	bra	L128
L126:
	lda	#$0
L128:
	tax
	bne	L10153
;                        /* The timer is in a list, remove it. */
;                        ( void ) uxListRemove( &( pxTimer->xTimerListItem ) );
	lda	#$4
	clc
	adc	<L121+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L121+pxTimer_1+2
	pha
	pei	<R0
	jsr	_~uxListRemove
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
L10153:
;
;                    traceTIMER_COMMAND_RECEIVED( pxTimer, xMessage.xMessageID, xMessage.u.xTimerParameters.xMessageValue );
;
;                    /* In this case the xTimerListsWereSwitched parameter is not used, but
;                     *  it must be present in the function call.  prvSampleTimeNow() must be
;                     *  called after the message is received from xTimerQueue so there is no
;                     *  possibility of a higher priority task adding a message to the message
;                     *  queue with a time that is ahead of the timer daemon task (because it
;                     *  pre-empted the timer daemon task after the xTimeNow value was set). */
;                    xTimeNow = prvSampleTimeNow( &xTimerListsWereSwitched );
	pea	#0
	clc
	tdc
	adc	#<L121+xTimerListsWereSwitched_1
	pha
	jsr	_~prvSampleTimeNow
	sta	<L121+xTimeNow_1
	stx	<L121+xTimeNow_1+2
;
;                    switch( xMessage.xMessageID )
	lda	<L121+xMessage_1
	xref	_~~fsw
	jsr	_~~fsw
	dw	1
	dw	9
	dw	L10148-1
	dw	L10159-1
	dw	L10159-1
	dw	L10165-1
	dw	L10167-1
	dw	L10175-1
	dw	L10159-1
	dw	L10159-1
	dw	L10165-1
	dw	L10167-1
;                    {
;                        case tmrCOMMAND_START:
;                        case tmrCOMMAND_START_FROM_ISR:
;                        case tmrCOMMAND_RESET:
;                        case tmrCOMMAND_RESET_FROM_ISR:
L10159:
;                            /* Start or restart a timer. */
;                            pxTimer->ucStatus |= ( uint8_t ) tmrSTATUS_IS_ACTIVE;
	lda	#$22
	clc
	adc	<L121+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L121+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$1
	sta	[<R0]
	rep	#$20
	longa	on
;
;                            if( prvInsertTimerInActiveList( pxTimer, xMessage.u.xTimerParameters.xMessageValue + pxTimer->xTimerPeriodInTicks, xTimeNow, xMessage.u.xTimerParameters.xMessageValue ) != pdFALSE )
;                            {
	pei	<L121+xMessage_1+4
	pei	<L121+xMessage_1+2
	pei	<L121+xTimeNow_1+2
	pei	<L121+xTimeNow_1
	clc
	lda	<L121+xMessage_1+2
	ldy	#$18
	adc	[<L121+pxTimer_1],Y
	sta	<R0
	lda	<L121+xMessage_1+4
	iny
	iny
	adc	[<L121+pxTimer_1],Y
	pha
	pei	<R0
	pei	<L121+pxTimer_1+2
	pei	<L121+pxTimer_1
	jsr	_~prvInsertTimerInActiveList
	tax
	bne	*+5
	brl	L10148
;                                /* The timer expired before it was added to the active
;                                 * timer list.  Process it now. */
;                                if( ( pxTimer->ucStatus & tmrSTATUS_IS_AUTORELOAD ) != 0U )
;                                {
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L121+pxTimer_1],Y
	and	#<$4
	rep	#$20
	longa	on
	beq	L10161
;                                    prvReloadTimer( pxTimer, xMessage.u.xTimerParameters.xMessageValue + pxTimer->xTimerPeriodInTicks, xTimeNow );
	pei	<L121+xTimeNow_1+2
	pei	<L121+xTimeNow_1
	clc
	lda	<L121+xMessage_1+2
	ldy	#$18
	adc	[<L121+pxTimer_1],Y
	sta	<R0
	lda	<L121+xMessage_1+4
	iny
	iny
	adc	[<L121+pxTimer_1],Y
	pha
	pei	<R0
	pei	<L121+pxTimer_1+2
	pei	<L121+pxTimer_1
	jsr	_~prvReloadTimer
;                                }
;                                else
	bra	L10162
L10161:
;                                {
;                                    pxTimer->ucStatus &= ( ( uint8_t ) ~tmrSTATUS_IS_ACTIVE );
	lda	#$22
	clc
	adc	<L121+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L121+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$fe
	sta	[<R0]
	rep	#$20
	longa	on
;                                }
L10162:
;
;                                /* Call the timer callback. */
;                                traceTIMER_EXPIRED( pxTimer );
;                                pxTimer->pxCallbackFunction( ( TimerHandle_t ) pxTimer );
	pei	<L121+pxTimer_1+2
	pei	<L121+pxTimer_1
	ldy	#$20
	lda	[<L121+pxTimer_1],Y
	xref	_~~cal
	jsr	_~~cal
;                            }
;                            else
;                }
;                else
	brl	L10148
;                            {
;                                mtCOVERAGE_TEST_MARKER();
;                            }
;
;                            break;
;
;                        case tmrCOMMAND_STOP:
;                        case tmrCOMMAND_STOP_FROM_ISR:
L10165:
;                            /* The timer has already been removed from the active list. */
;                            pxTimer->ucStatus &= ( ( uint8_t ) ~tmrSTATUS_IS_ACTIVE );
	lda	#$22
	clc
	adc	<L121+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L121+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$fe
	sta	[<R0]
	rep	#$20
	longa	on
;                            break;
	brl	L10148
;
;                        case tmrCOMMAND_CHANGE_PERIOD:
;                        case tmrCOMMAND_CHANGE_PERIOD_FROM_ISR:
L10167:
;                            pxTimer->ucStatus |= ( uint8_t ) tmrSTATUS_IS_ACTIVE;
	lda	#$22
	clc
	adc	<L121+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L121+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	ora	#<$1
	sta	[<R0]
	rep	#$20
	longa	on
;                            pxTimer->xTimerPeriodInTicks = xMessage.u.xTimerParameters.xMessageValue;
	lda	<L121+xMessage_1+2
	ldy	#$18
	sta	[<L121+pxTimer_1],Y
	lda	<L121+xMessage_1+4
	iny
	iny
	sta	[<L121+pxTimer_1],Y
;                            configASSERT( ( pxTimer->xTimerPeriodInTicks > 0 ) );
	lda	#$0
	dey
	dey
	cmp	[<L121+pxTimer_1],Y
	iny
	iny
	sbc	[<L121+pxTimer_1],Y
	bcc	L10168
L10172:
	bra	L10172
L10168:
;
;                            /* The new period does not really have a reference, and can
;                             * be longer or shorter than the old one.  The command time is
;                             * therefore set to the current time, and as the period cannot
;                             * be zero the next expiry time can only be in the future,
;                             * meaning (unlike for the xTimerStart() case above) there is
;                             * no fail case that needs to be handled here. */
;                            ( void ) prvInsertTimerInActiveList( pxTimer, ( xTimeNow + pxTimer->xTimerPeriodInTicks ), xTimeNow, xTimeNow );
	pei	<L121+xTimeNow_1+2
	pei	<L121+xTimeNow_1
	pei	<L121+xTimeNow_1+2
	pei	<L121+xTimeNow_1
	clc
	lda	<L121+xTimeNow_1
	ldy	#$18
	adc	[<L121+pxTimer_1],Y
	sta	<R0
	lda	<L121+xTimeNow_1+2
	iny
	iny
	adc	[<L121+pxTimer_1],Y
	pha
	pei	<R0
	pei	<L121+pxTimer_1+2
	pei	<L121+pxTimer_1
	jsr	_~prvInsertTimerInActiveList
	sta	<R1
;                            break;
	brl	L10148
;
;                        case tmrCOMMAND_DELETE:
L10175:
;                            #if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 )
;                            {
;                                /* The timer has already been removed from the active list,
;                                 * just free up the memory if the memory was dynamically
;                                 * allocated. */
;                                if( ( pxTimer->ucStatus & tmrSTATUS_IS_STATICALLY_ALLOCATED ) == ( uint8_t ) 0 )
;                                {
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L121+pxTimer_1],Y
	and	#<$2
	rep	#$20
	longa	on
	bne	L10176
;                                    vPortFree( pxTimer );
	pei	<L121+pxTimer_1+2
	pei	<L121+pxTimer_1
	jsr	_~vPortFree
;                                }
;                                else
	brl	L10148
L10176:
;                                {
;                                    pxTimer->ucStatus &= ( ( uint8_t ) ~tmrSTATUS_IS_ACTIVE );
	lda	#$22
	clc
	adc	<L121+pxTimer_1
	sta	<R0
	lda	#$0
	adc	<L121+pxTimer_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	and	#<$fe
	sta	[<R0]
	rep	#$20
	longa	on
;                                }
;                            }
;                            #else /* if ( configSUPPORT_DYNAMIC_ALLOCATION == 1 ) */
;                            {
;                                /* If dynamic allocation is not enabled, the memory
;                                 * could not have been dynamically allocated. So there is
;                                 * no need to free the memory - just mark the timer as
;                                 * "not active". */
;                                pxTimer->ucStatus &= ( ( uint8_t ) ~tmrSTATUS_IS_ACTIVE );
;                            }
;                            #endif /* configSUPPORT_DYNAMIC_ALLOCATION */
;                            break;
	brl	L10148
;
;                        default:
;                            /* Don't expect to get here. */
;                            break;
;                    }
;                {
;                    mtCOVERAGE_TEST_MARKER();
;                }
;            }
;        }
L120	equ	28
L121	equ	9
	ends
	efunc
	data
L122:
	dw	$0
	ds	8
	ends
;/*-----------------------------------------------------------*/
;
;    static void prvSwitchTimerLists( void )
;    {
	code
	func
_~prvSwitchTimerLists:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L135
	tcs
	phd
	tcd
;        TickType_t xNextExpireTime;
;        List_t * pxTemp;
;
;        /* The tick count has overflowed.  The timer lists must be switched.
;         * If there are any timers still referenced from the current timer list
;         * then they must have expired and should be processed before the lists
;         * are switched. */
;        while( listLIST_IS_EMPTY( pxCurrentTimerList ) == pdFALSE )
xNextExpireTime_1	set	0
pxTemp_1	set	4
	bra	L10180
L20018:
;        {
;            xNextExpireTime = listGET_ITEM_VALUE_OF_HEAD_ENTRY( pxCurrentTimerList );
	lda	|_~pxCurrentTimerList
	sta	<R0
	lda	|_~pxCurrentTimerList+2
	sta	<R0+2
	ldy	#$a
	lda	[<R0],Y
	sta	<R1
	iny
	iny
	lda	[<R0],Y
	sta	<R1+2
	lda	[<R1]
	sta	<L136+xNextExpireTime_1
	ldy	#$2
	lda	[<R1],Y
	sta	<L136+xNextExpireTime_1+2
;
;            /* Process the expired timer.  For auto-reload timers, be careful to
;             * process only expirations that occur on the current list.  Further
;             * expirations must wait until after the lists are switched. */
;            prvProcessExpiredTimer( xNextExpireTime, tmrMAX_TIME_BEFORE_OVERFLOW );
	pea	#^$ffffffff
	pea	#<$ffffffff
	pei	<L136+xNextExpireTime_1+2
	pei	<L136+xNextExpireTime_1
	jsr	_~prvProcessExpiredTimer
;        }
L10180:
	lda	|_~pxCurrentTimerList
	sta	<R0
	lda	|_~pxCurrentTimerList+2
	sta	<R0+2
	lda	[<R0]
	bne	L137
	lda	#$1
	bra	L139
L137:
	lda	#$0
L139:
	tax
	beq	L20018
;
;        pxTemp = pxCurrentTimerList;
	lda	|_~pxCurrentTimerList
	sta	<L136+pxTemp_1
	lda	|_~pxCurrentTimerList+2
	sta	<L136+pxTemp_1+2
;        pxCurrentTimerList = pxOverflowTimerList;
	lda	|_~pxOverflowTimerList
	sta	|_~pxCurrentTimerList
	lda	|_~pxOverflowTimerList+2
	sta	|_~pxCurrentTimerList+2
;        pxOverflowTimerList = pxTemp;
	lda	<L136+pxTemp_1
	sta	|_~pxOverflowTimerList
	lda	<L136+pxTemp_1+2
	sta	|_~pxOverflowTimerList+2
;    }
	pld
	tsc
	clc
	adc	#L135
	tcs
	rts
L135	equ	16
L136	equ	9
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    static void prvCheckForValidListAndQueue( void )
;    {
	code
	func
_~prvCheckForValidListAndQueue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L142
	tcs
	phd
	tcd
;        /* Check that the list from which active timers are referenced, and the
;         * queue used to communicate with the timer service, have been
;         * initialised. */
;        taskENTER_CRITICAL();
;        {
;            if( xTimerQueue == NULL )
;            {
	lda	|_~xTimerQueue
	ora	|_~xTimerQueue+2
	bne	L145
;                vListInitialise( &xActiveTimerList1 );
	lda	#<_~xActiveTimerList1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;                vListInitialise( &xActiveTimerList2 );
	lda	#<_~xActiveTimerList2
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsr	_~vListInitialise
;                pxCurrentTimerList = &xActiveTimerList1;
	lda	#<_~xActiveTimerList1
	sta	|_~pxCurrentTimerList
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|_~pxCurrentTimerList+2
;                pxOverflowTimerList = &xActiveTimerList2;
	lda	#<_~xActiveTimerList2
	sta	|_~pxOverflowTimerList
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|_~pxOverflowTimerList+2
;
;                #if ( configSUPPORT_STATIC_ALLOCATION == 1 )
;                {
;                    /* The timer queue is allocated statically in case
;                     * configSUPPORT_DYNAMIC_ALLOCATION is 0. */
;                    PRIVILEGED_DATA static StaticQueue_t xStaticTimerQueue;
;                    PRIVILEGED_DATA static uint8_t ucStaticTimerQueueStorage[ ( size_t ) configTIMER_QUEUE_LENGTH * sizeof( DaemonTaskMessage_t ) ];
;
;                    xTimerQueue = xQueueCreateStatic( ( UBaseType_t ) configTIMER_QUEUE_LENGTH, ( UBaseType_t ) sizeof( DaemonTaskMessage_t ), &( ucStaticTimerQueueStorage[ 0 ] ), &xStaticTimerQueue );
	pea	#<$0
	lda	#<L10186
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	lda	#<L10187
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	pea	#<$a
	pea	#<$a
	jsr	_~xQueueGenericCreateStatic
	sta	|_~xTimerQueue
	stx	|_~xTimerQueue+2
;                }
;                #else
;                {
;                    xTimerQueue = xQueueCreate( ( UBaseType_t ) configTIMER_QUEUE_LENGTH, ( UBaseType_t ) sizeof( DaemonTaskMessage_t ) );
;                }
;                #endif /* if ( configSUPPORT_STATIC_ALLOCATION == 1 ) */
;
;                #if ( configQUEUE_REGISTRY_SIZE > 0 )
;                {
;                    if( xTimerQueue != NULL )
;                    {
;                        vQueueAddToRegistry( xTimerQueue, "TmrQ" );
;                    }
;                    else
;                    {
;                        mtCOVERAGE_TEST_MARKER();
;                    }
;                }
;                #endif /* configQUEUE_REGISTRY_SIZE */
;            }
;            else
;            {
;                mtCOVERAGE_TEST_MARKER();
;            }
;        }
;        taskEXIT_CRITICAL();
;    }
L145:
	pld
	tsc
	clc
	adc	#L142
	tcs
	rts
L142	equ	8
L143	equ	9
	ends
	efunc
	udata
L10186:
	ds	61
	ends
	udata
L10187:
	ds	100
	ends
;/*-----------------------------------------------------------*/
;
;    BaseType_t xTimerIsTimerActive( TimerHandle_t xTimer )
;    {
	code
	xdef	_~xTimerIsTimerActive
	func
_~xTimerIsTimerActive:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L146
	tcs
	phd
	tcd
xTimer_0	set	3
;        BaseType_t xReturn;
;        Timer_t * pxTimer = xTimer;
;
;        traceENTER_xTimerIsTimerActive( xTimer );
xReturn_1	set	0
pxTimer_1	set	2
	lda	<L146+xTimer_0
	sta	<L147+pxTimer_1
	lda	<L146+xTimer_0+2
	sta	<L147+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L146+xTimer_0
	ora	<L146+xTimer_0+2
	bne	L10200
L10196:
	bra	L10196
;
;        /* Is the timer in the list of active timers? */
;        portBASE_TYPE_ENTER_CRITICAL();
L10200:
;        {
;            if( ( pxTimer->ucStatus & tmrSTATUS_IS_ACTIVE ) == 0U )
;            {
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L147+pxTimer_1],Y
	and	#<$1
	rep	#$20
	longa	on
	bne	L10202
;                xReturn = pdFALSE;
	stz	<L147+xReturn_1
;            }
;            else
	bra	L10205
L10202:
;            {
;                xReturn = pdTRUE;
	lda	#$1
	sta	<L147+xReturn_1
;            }
;        }
;        portBASE_TYPE_EXIT_CRITICAL();
L10205:
;
;        traceRETURN_xTimerIsTimerActive( xReturn );
;
;        return xReturn;
	lda	<L147+xReturn_1
	tay
	lda	<L146+1
	sta	<L146+1+4
	pld
	tsc
	clc
	adc	#L146+4
	tcs
	tya
	rts
;    }
L146	equ	6
L147	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    void * pvTimerGetTimerID( const TimerHandle_t xTimer )
;    {
	code
	xdef	_~pvTimerGetTimerID
	func
_~pvTimerGetTimerID:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L151
	tcs
	phd
	tcd
xTimer_0	set	3
;        Timer_t * const pxTimer = xTimer;
;        void * pvReturn;
;
;        traceENTER_pvTimerGetTimerID( xTimer );
pxTimer_1	set	0
pvReturn_1	set	4
	lda	<L151+xTimer_0
	sta	<L152+pxTimer_1
	lda	<L151+xTimer_0+2
	sta	<L152+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L151+xTimer_0
	ora	<L151+xTimer_0+2
	bne	L10215
L10211:
	bra	L10211
;
;        taskENTER_CRITICAL();
L10215:
;        {
;            pvReturn = pxTimer->pvTimerID;
	ldy	#$1c
	lda	[<L152+pxTimer_1],Y
	sta	<L152+pvReturn_1
	iny
	iny
	lda	[<L152+pxTimer_1],Y
	sta	<L152+pvReturn_1+2
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_pvTimerGetTimerID( pvReturn );
;
;        return pvReturn;
	ldx	<L152+pvReturn_1+2
	lda	<L152+pvReturn_1
	tay
	lda	<L151+1
	sta	<L151+1+4
	pld
	tsc
	clc
	adc	#L151+4
	tcs
	tya
	rts
;    }
L151	equ	8
L152	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    void vTimerSetTimerID( TimerHandle_t xTimer,
;                           void * pvNewID )
;    {
	code
	xdef	_~vTimerSetTimerID
	func
_~vTimerSetTimerID:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L155
	tcs
	phd
	tcd
xTimer_0	set	3
pvNewID_0	set	7
;        Timer_t * const pxTimer = xTimer;
;
;        traceENTER_vTimerSetTimerID( xTimer, pvNewID );
pxTimer_1	set	0
	lda	<L155+xTimer_0
	sta	<L156+pxTimer_1
	lda	<L155+xTimer_0+2
	sta	<L156+pxTimer_1+2
;
;        configASSERT( xTimer );
	lda	<L155+xTimer_0
	ora	<L155+xTimer_0+2
	bne	L10228
L10224:
	bra	L10224
;
;        taskENTER_CRITICAL();
L10228:
;        {
;            pxTimer->pvTimerID = pvNewID;
	lda	<L155+pvNewID_0
	ldy	#$1c
	sta	[<L156+pxTimer_1],Y
	lda	<L155+pvNewID_0+2
	iny
	iny
	sta	[<L156+pxTimer_1],Y
;        }
;        taskEXIT_CRITICAL();
;
;        traceRETURN_vTimerSetTimerID();
;    }
	lda	<L155+1
	sta	<L155+1+8
	pld
	tsc
	clc
	adc	#L155+8
	tcs
	rts
L155	equ	4
L156	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;    #if ( INCLUDE_xTimerPendFunctionCall == 1 )
;
;        BaseType_t xTimerPendFunctionCallFromISR( PendedFunction_t xFunctionToPend,
;                                                  void * pvParameter1,
;                                                  uint32_t ulParameter2,
;                                                  BaseType_t * pxHigherPriorityTaskWoken )
;        {
;            DaemonTaskMessage_t xMessage;
;            BaseType_t xReturn;
;
;            traceENTER_xTimerPendFunctionCallFromISR( xFunctionToPend, pvParameter1, ulParameter2, pxHigherPriorityTaskWoken );
;
;            /* Complete the message with the function parameters and post it to the
;             * daemon task. */
;            xMessage.xMessageID = tmrCOMMAND_EXECUTE_CALLBACK_FROM_ISR;
;            xMessage.u.xCallbackParameters.pxCallbackFunction = xFunctionToPend;
;            xMessage.u.xCallbackParameters.pvParameter1 = pvParameter1;
;            xMessage.u.xCallbackParameters.ulParameter2 = ulParameter2;
;
;            xReturn = xQueueSendFromISR( xTimerQueue, &xMessage, pxHigherPriorityTaskWoken );
;
;            tracePEND_FUNC_CALL_FROM_ISR( xFunctionToPend, pvParameter1, ulParameter2, xReturn );
;            traceRETURN_xTimerPendFunctionCallFromISR( xReturn );
;
;            return xReturn;
;        }
;
;    #endif /* INCLUDE_xTimerPendFunctionCall */
;/*-----------------------------------------------------------*/
;
;    #if ( INCLUDE_xTimerPendFunctionCall == 1 )
;
;        BaseType_t xTimerPendFunctionCall( PendedFunction_t xFunctionToPend,
;                                           void * pvParameter1,
;                                           uint32_t ulParameter2,
;                                           TickType_t xTicksToWait )
;        {
;            DaemonTaskMessage_t xMessage;
;            BaseType_t xReturn;
;
;            traceENTER_xTimerPendFunctionCall( xFunctionToPend, pvParameter1, ulParameter2, xTicksToWait );
;
;            /* This function can only be called after a timer has been created or
;             * after the scheduler has been started because, until then, the timer
;             * queue does not exist. */
;            configASSERT( xTimerQueue );
;
;            /* Complete the message with the function parameters and post it to the
;             * daemon task. */
;            xMessage.xMessageID = tmrCOMMAND_EXECUTE_CALLBACK;
;            xMessage.u.xCallbackParameters.pxCallbackFunction = xFunctionToPend;
;            xMessage.u.xCallbackParameters.pvParameter1 = pvParameter1;
;            xMessage.u.xCallbackParameters.ulParameter2 = ulParameter2;
;
;            xReturn = xQueueSendToBack( xTimerQueue, &xMessage, xTicksToWait );
;
;            tracePEND_FUNC_CALL( xFunctionToPend, pvParameter1, ulParameter2, xReturn );
;            traceRETURN_xTimerPendFunctionCall( xReturn );
;
;            return xReturn;
;        }
;
;    #endif /* INCLUDE_xTimerPendFunctionCall */
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;        UBaseType_t uxTimerGetTimerNumber( TimerHandle_t xTimer )
;        {
;            traceENTER_uxTimerGetTimerNumber( xTimer );
;
;            traceRETURN_uxTimerGetTimerNumber( ( ( Timer_t * ) xTimer )->uxTimerNumber );
;
;            return ( ( Timer_t * ) xTimer )->uxTimerNumber;
;        }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;    #if ( configUSE_TRACE_FACILITY == 1 )
;
;        void vTimerSetTimerNumber( TimerHandle_t xTimer,
;                                   UBaseType_t uxTimerNumber )
;        {
;            traceENTER_vTimerSetTimerNumber( xTimer, uxTimerNumber );
;
;            ( ( Timer_t * ) xTimer )->uxTimerNumber = uxTimerNumber;
;
;            traceRETURN_vTimerSetTimerNumber();
;        }
;
;    #endif /* configUSE_TRACE_FACILITY */
;/*-----------------------------------------------------------*/
;
;/*
; * Reset the state in this file. This state is normally initialized at start up.
; * This function must be called by the application before restarting the
; * scheduler.
; */
;    void vTimerResetState( void )
;    {
	code
	xdef	_~vTimerResetState
	func
_~vTimerResetState:
	longa	on
	longi	on
;        xTimerQueue = NULL;
	stz	|_~xTimerQueue
	stz	|_~xTimerQueue+2
;        xTimerTaskHandle = NULL;
	stz	|_~xTimerTaskHandle
	stz	|_~xTimerTaskHandle+2
;    }
	rts
L159	equ	0
L160	equ	1
	ends
	efunc
;/*-----------------------------------------------------------*/
;
;/* This entire source file will be skipped if the application is not configured
; * to include software timer functionality.  If you want to include software timer
; * functionality then ensure configUSE_TIMERS is set to 1 in FreeRTOSConfig.h. */
;#endif /* configUSE_TIMERS == 1 */
;
	xref	_~vApplicationGetTimerTaskMemory
	xref	_~vQueueWaitForMessageRestricted
	xref	_~xQueueGenericCreateStatic
	xref	_~xQueueGenericSendFromISR
	xref	_~xQueueReceive
	xref	_~xQueueGenericSend
	xref	_~xTaskGetSchedulerState
	xref	_~xTaskGetTickCount
	xref	_~xTaskResumeAll
	xref	_~vTaskSuspendAll
	xref	_~xTaskCreateStatic
	xref	_~uxListRemove
	xref	_~vListInsert
	xref	_~vListInitialiseItem
	xref	_~vListInitialise
	xref	_~vPortFree
	xref	_~pvPortMalloc
	xref	_~vPortYield
	udata
_~pxOverflowTimerList
	ds	4
	ends
	udata
_~pxCurrentTimerList
	ds	4
	ends
	udata
_~xActiveTimerList2
	ds	18
	ends
	udata
_~xActiveTimerList1
	ds	18
	ends

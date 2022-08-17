/**
  ******************************************************************************
  * File Name          : OSWrappers.cpp
  ******************************************************************************
  * This file is generated by TouchGFX Generator 4.20.0. Please, do not edit!
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

#include <cassert>
#include <touchgfx/hal/HAL.hpp>
#include <touchgfx/hal/OSWrappers.hpp>

#include "stm32f4xx.h"

#include "tx_api.h"
#include "tx_byte_pool.h"

// tx_thread.h is not C++ compatible, declare used symbols here as externals
extern "C" volatile UINT _tx_thread_preempt_disable;
extern "C" VOID _tx_thread_system_preempt_check(VOID);

#define OSWRAPPER_BYTE_POOL_SIZE    TX_BYTE_POOL_MIN
#define OSWRAPPER_QUEUE_SIZE        sizeof(ULONG)

static uint8_t oswrapper_pool_mem[OSWRAPPER_BYTE_POOL_SIZE];
static TX_BYTE_POOL oswrapper_byte_pool;
static TX_SEMAPHORE frame_buffer_sem = { 0 };
static TX_QUEUE vsync_q = { 0 };

// Just a dummy message to insert in the VSYNC queue.
static ULONG dummy_msg = 0x5A5A5A5A;

using namespace touchgfx;

/*
 * Initialize frame buffer semaphore and queue/mutex for VSYNC signal.
 */
void OSWrappers::initialize()
{
    CHAR* pointer;

    /* Create a byte memory pool from which to allocate the thread stacks.  */
    if (tx_byte_pool_create(&oswrapper_byte_pool, (CHAR*) "OSWrapper Byte Pool", oswrapper_pool_mem,
                            OSWRAPPER_BYTE_POOL_SIZE) != TX_SUCCESS)
    {
        assert(0 && "Failed to create OSWrapper Pool memory!");
    }

    /* Allocate the vsync_q.  */
    if (tx_byte_allocate(&oswrapper_byte_pool, (VOID**) &pointer,
                         OSWRAPPER_QUEUE_SIZE, TX_NO_WAIT) != TX_SUCCESS)
    {
        assert(0 && "Failed to allocate memory for the Vsync Message Queue!");
    }

    // Create a queue of length 1
    if (tx_queue_create(&vsync_q, (CHAR*) "Vsync Message Queue", TX_1_ULONG,
                        pointer, OSWRAPPER_QUEUE_SIZE) != TX_SUCCESS)
    {
        assert(0 && "Failed to create Vsync Message Queue!");
    }

    // Create the Framebuffer Semaphore (Binary)
    if (tx_semaphore_create(&frame_buffer_sem, (CHAR*) "FrameBuffer Semaphore", 1) != TX_SUCCESS)
    {
        assert(0 && "Failed to create FrameBuffer Semaphore!");
    }
}

/*
 * Take the frame buffer semaphore. Blocks until semaphore is available.
 */
void OSWrappers::takeFrameBufferSemaphore()
{
    if (tx_semaphore_get(&frame_buffer_sem, TX_WAIT_FOREVER) != TX_SUCCESS)
    {
        assert(0 && "Failed to get FrameBuffer Semaphore!");
    }
}

/*
 * Release the frame buffer semaphore.
 */
void OSWrappers::giveFrameBufferSemaphore()
{
    if (!frame_buffer_sem.tx_semaphore_count)
    {
        if (tx_semaphore_put(&frame_buffer_sem) != TX_SUCCESS)
        {
            assert(0 && "Failed to put FrameBuffer Semaphore!");
        }
    }
}

/*
 * Attempt to obtain the frame buffer semaphore. If semaphore is not available, do
 * nothing.
 *
 * Note must return immediately! This function does not care who has the taken the semaphore,
 * it only serves to make sure that the semaphore is taken by someone.
 */
void OSWrappers::tryTakeFrameBufferSemaphore()
{
    if (tx_semaphore_get(&frame_buffer_sem, TX_NO_WAIT) != TX_SUCCESS)
    {
        // Typically we should inform the requester about failing to get this semaphore
        // Maybe we should update the prototype of this method to return the result of the try
        // assert(0 && "Failed to get FrameBuffer Semaphore!");
    }
}

/*
 * Release the frame buffer semaphore in a way that is safe in interrupt context. Called
 * from ISR.
 *
 * Release the frame buffer semaphore in a way that is safe in interrupt context.
 * Called from ISR.
 */
void OSWrappers::giveFrameBufferSemaphoreFromISR()
{
    TX_INTERRUPT_SAVE_AREA
    TX_DISABLE;
    _tx_thread_preempt_disable++;
    if (!frame_buffer_sem.tx_semaphore_count)
    {
        if (tx_semaphore_put(&frame_buffer_sem) != TX_SUCCESS)
        {
            assert(0 && "Failed to put FrameBuffer Semaphore!");
        }
    }
    _tx_thread_preempt_disable--;
    TX_RESTORE;
    _tx_thread_system_preempt_check();
}

/*
 * Signal that a VSYNC has occurred. Should make the vsync queue/mutex available.
 *
 * Note This function is called from an ISR, and should (depending on OS) trigger a
 * scheduling.
 */
void OSWrappers::signalVSync()
{
    UINT ret;

    // Send the message only if the queue is empty.
    // This call is from ISR, so no need to re-send
    // the message if not yet consumed by threads
    if (vsync_q.tx_queue_enqueued == 0)
    {
        // This is supposed to be called from Vsync Interrupt Handler
        // So wait_option should be equal to TX_NO_WAIT
        ret = tx_queue_send(&vsync_q, &dummy_msg, TX_NO_WAIT);
        if (ret != TX_SUCCESS)
        {
            assert(0 && "Failed to Signal Vsync!");
        }
    }
}

/*
  * Signal that the rendering of the frame has completed. Used by
  * some systems to avoid using any previous vsync.
  */
void OSWrappers::signalRenderingDone()
{

}

/*
 * This function blocks until a VSYNC occurs.
 *
 * Note This function must first clear the mutex/queue and then wait for the next one to
 * occur.
 */
void OSWrappers::waitForVSync()
{
    UINT ret;

    // First make sure the queue is empty, by trying to remove an element with 0 timeout.
    ret = tx_queue_receive(&vsync_q, &dummy_msg, TX_NO_WAIT);

    if ((ret == TX_SUCCESS) || (ret == TX_QUEUE_EMPTY))
    {
        // Then, wait for next VSYNC to occur.
        ret = tx_queue_receive(&vsync_q, &dummy_msg, TX_WAIT_FOREVER);
    }

    if (ret != TX_SUCCESS)
    {
        assert(0 && "Failed to Wait for Vsync!");
    }
}

/*
 * A function that causes executing task to sleep for a number of milliseconds.
 *
 * A function that causes executing task to sleep for a number of milliseconds.
 * This function is OPTIONAL. It is only used by the TouchGFX in the case of
 * a specific frame refresh strategy (REFRESH_STRATEGY_OPTIM_SINGLE_BUFFER_TFT_CTRL).
 * Due to backwards compatibility, in order for this function to be useable by the HAL
 * the function must be explicitly registered:
 * hal.registerTaskDelayFunction(&OSWrappers::taskDelay)
 *
 * see HAL::setFrameRefreshStrategy(FrameRefreshStrategy s)
 * see HAL::registerTaskDelayFunction(void (*delayF)(uint16_t))
 */
void OSWrappers::taskDelay(uint16_t ms)
{
    tx_thread_sleep(ms);
}

/**
 * A function that causes the executing task to yield control to
 * another thread. This function is used by the framework when it
 * is necessary to wait a little before continuing (e.g. drawing).
 *
 * The implementation should typically request the operating
 * system to change to another task of similar priority. When
 * running without an operating system, the implementation can run
 * a very short task and return.
 */
void OSWrappers::taskYield()
{
    /* Check if this API is called from Interrupt Service Routines */
    if (__get_IPSR() == 0U)
    {
        /* Call the tx_thread_relinquish to relinquishes processor control to
           other ready-to-run threads at the same or higher priority. */
        tx_thread_relinquish();
    }
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/


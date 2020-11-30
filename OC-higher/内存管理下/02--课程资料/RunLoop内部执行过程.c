//
//  RunLoop内部执行过程.c
//
//  Created by cooci on 2018/8/25.
//  Copyright © 2018年 lg. All rights reserved.
//

SInt32 CFRunLoopRunSpecific(CFRunLoopRef rl, CFStringRef modeName, CFTimeInterval seconds, Boolean returnAfterSourceHandled) {     /* DOES CALLOUT */
    CHECK_FOR_FORK();
    if (__CFRunLoopIsDeallocating(rl)) return kCFRunLoopRunFinished;
    __CFRunLoopLock(rl);
    
    /// 首先根据modeName找到对应mode
    CFRunLoopModeRef currentMode = __CFRunLoopFindMode(rl, modeName, false);
    
    /// 通知 Observers: RunLoop 即将进入 loop。
    __CFRunLoopDoObservers(rl, currentMode, kCFRunLoopEntry);
    
    /// 内部函数，进入loop
    result = __CFRunLoopRun(rl, currentMode, seconds, returnAfterSourceHandled, previousMode);
    
    /// 通知 Observers: RunLoop 即将退出。
    __CFRunLoopDoObservers(rl, currentMode, kCFRunLoopExit);
    
    return result;
}

/// 核心函数
static int32_t __CFRunLoopRun(CFRunLoopRef rl, CFRunLoopModeRef rlm, CFTimeInterval seconds, Boolean stopAfterHandle, CFRunLoopModeRef previousMode) {
    
    int32_t retVal = 0;
    
    do {  // itmes do
        
        /// 通知 Observers: 即将处理timer事件
        __CFRunLoopDoObservers(rl, rlm, kCFRunLoopBeforeTimers);
        
        /// 通知 Observers: 即将处理Source事件
        __CFRunLoopDoObservers(rl, rlm, kCFRunLoopBeforeSources)
        
        /// 处理Blocks
        __CFRunLoopDoBlocks(rl, rlm);
        
        /// 处理sources0
        Boolean sourceHandledThisLoop = __CFRunLoopDoSources0(rl, rlm, stopAfterHandle);
        
        /// 处理sources0返回为YES
        if (sourceHandledThisLoop) {
            /// 处理Blocks
            __CFRunLoopDoBlocks(rl, rlm);
        }
        
        
        /// 判断有无端口消息(Source1)
        if (__CFRunLoopServiceMachPort(dispatchPort, &msg, sizeof(msg_buffer), &livePort, 0, &voucherState, NULL)) {
            /// 处理消息
            goto handle_msg;
        }
        
        /// 通知 Observers: 即将进入休眠
        __CFRunLoopDoObservers(rl, rlm, kCFRunLoopBeforeWaiting);
        __CFRunLoopSetSleeping(rl);
        
        /// 等待被唤醒
        __CFRunLoopServiceMachPort(waitSet, &msg, sizeof(msg_buffer), &livePort, poll ? 0 : TIMEOUT_INFINITY, &voucherState, &voucherCopy);
        
        
        // user callouts now OK again
        __CFRunLoopUnsetSleeping(rl);
        
        /// 通知 Observers: 被唤醒，结束休眠
        __CFRunLoopDoObservers(rl, rlm, kCFRunLoopAfterWaiting);
        
    handle_msg:
        if (被Timer唤醒) {
            /// 处理Timers
            __CFRunLoopDoTimers(rl, rlm, mach_absolute_time())；
        } else if (被GCD唤醒) {
            /// 处理gcd
            __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(msg);
        } else if (被Source1唤醒) {
            /// 被Source1唤醒，处理Source1
            __CFRunLoopDoSource1(rl, rlm, rls, msg, msg->msgh_size, &reply)
        }
        
        /// 处理block
        __CFRunLoopDoBlocks(rl, rlm);
        
        
        if (sourceHandledThisLoop && stopAfterHandle) {
            retVal = kCFRunLoopRunHandledSource;
        } else if (timeout_context->termTSR < mach_absolute_time()) {
            retVal = kCFRunLoopRunTimedOut;
        } else if (__CFRunLoopIsStopped(rl)) {
            __CFRunLoopUnsetStopped(rl);
            retVal = kCFRunLoopRunStopped;
        } else if (rlm->_stopped) {
            rlm->_stopped = false;
            retVal = kCFRunLoopRunStopped;
        } else if (__CFRunLoopModeIsEmpty(rl, rlm, previousMode)) {
            retVal = kCFRunLoopRunFinished;
        }
        
    } while (0 == retVal);
    
    return retVal;
}

// main  dispatch queue
__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__

// __CFRunLoopDoObservers
__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__

// __CFRunLoopDoBlocks
__CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__

// __CFRunLoopDoSources0
__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__

// __CFRunLoopDoSource1
__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__

// __CFRunLoopDoTimers
__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__

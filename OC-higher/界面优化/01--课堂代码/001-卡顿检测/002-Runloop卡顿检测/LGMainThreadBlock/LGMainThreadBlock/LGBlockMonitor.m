//
//  LGBlockMonitor.m
//  LGMainThreadBlock
//
//  Created by cooci on 2019/12/30.
//  Copyright © 2020 cooci. All rights reserved.
//

#import "LGBlockMonitor.h"

@interface LGBlockMonitor (){
    CFRunLoopActivity activity;
}

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, assign) NSUInteger timeoutCount;

@end

@implementation LGBlockMonitor

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)start{
    [self registerObserver];
    [self startMonitor];
}

static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    LGBlockMonitor *monitor = (__bridge LGBlockMonitor *)info;
    monitor->activity = activity;
    // 发送信号
    dispatch_semaphore_t semaphore = monitor->_semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)registerObserver{
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    //NSIntegerMax : 优先级最小
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            kCFRunLoopAllActivities,
                                                            YES,
                                                            NSIntegerMax,
                                                            &CallBack,
                                                            &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
}

- (void)startMonitor{
    // 创建信号
    _semaphore = dispatch_semaphore_create(0);
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            // 超时时间是 1 秒，没有等到信号量，st 就不等于 0， RunLoop 所有的任务
            long st = dispatch_semaphore_wait(self->_semaphore, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
            if (st != 0)
            {
                if (self->activity == kCFRunLoopBeforeSources || self->activity == kCFRunLoopAfterWaiting)
                {
                    if (++self->_timeoutCount < 2){
                        NSLog(@"timeoutCount==%lu",(unsigned long)self->_timeoutCount);
                        continue;
                    }
                    // 一秒左右的衡量尺度 很大可能性连续来 避免大规模打印!
                    NSLog(@"检测到超过两次连续卡顿");
                }
            }
            self->_timeoutCount = 0;
        }
    });
}



@end

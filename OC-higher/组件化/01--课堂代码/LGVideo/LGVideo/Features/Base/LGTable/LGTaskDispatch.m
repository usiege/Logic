//
//  LGTaskDispatch.m
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGTaskDispatch.h"

@implementation LGTask

- (id)initWithIdentifier:(NSString *)identifier task:(executeTask)task{
    self = [super init];
    if (self) {
        self.taskID = identifier;
        self.task = task;
    }
    return self;
}

- (void)excute{
    if (self.task) {
        self.task();
    }
}

@end

@interface LGTaskDispatch ()

@property (nonatomic, assign) LGTaskMode excuteMode;
@property (nonatomic, strong) NSMutableDictionary<NSString *, LGTask *> *taskPool;
@property (nonatomic, strong) NSMutableArray<NSString *> *taskKeys;
@property (nonatomic, assign) LGTaskState state;

@end

static CFRunLoopObserverRef observer;


@implementation LGTaskDispatch

- (id)initWithModel:(LGTaskMode)mode{
    self = [super init];
    if (self) {
        _excuteMode = mode;
        _state = LGTaskStateSuspend;
    }
    return self;
}

#pragma mark -- Public Method

- (void)addTask:(NSString *)taskID excute:(void (^)(void))excute{
    LGTask *task = [[LGTask alloc] initWithIdentifier:taskID task:excute];
    [self addTask:task];
}

- (void)cancelTask:(NSString *)taskID{
    if (!self.taskPool[taskID]) return;
    self.taskPool[taskID] = nil;
    [self.taskKeys removeAllObjects];
    if (self.taskPool.count == 0 && self.state == LGTaskStateRunning) {
        [self invaliate];
    }
}

#pragma mark -- Private Method

- (void)addTask:(LGTask *)task{
    self.taskPool[task.taskID] = task;
    [self.taskKeys addObject:task.taskID];
    if (self.state == LGTaskStateSuspend) {
        reigsterObserver(self);
    }
}

- (void)executeTask{
    NSString *taskID = [self.taskKeys firstObject];
    if (!taskID) return;
    [self.taskKeys removeObjectAtIndex:0];
    LGTask *task = self.taskPool[taskID];
    [task excute];
    self.taskPool[taskID] = nil;
    if (self.taskPool.count == 0 && self.state == LGTaskStateRunning) {
        [self invaliate];
    }
}

- (void)invaliate{
    CFRunLoopRemoveObserver([NSRunLoop mainRunLoop].getCFRunLoop, observer, kCFRunLoopCommonModes);
    self.state = LGTaskStateSuspend;
}

static void reigsterObserver(id self){
    CFRunLoopRef runLoop = [NSRunLoop mainRunLoop].getCFRunLoop;
    CFRunLoopActivity activities = kCFRunLoopBeforeWaiting | kCFRunLoopExit;
    observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                  activities,
                                                  YES, NSUIntegerMax, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
                                                      [self executeTask];
                                                  });
    LGTaskDispatch *dispatcher = (LGTaskDispatch *)self;
    CFRunLoopMode mode = (dispatcher.excuteMode == LGTaskModeDefault ? kCFRunLoopDefaultMode : kCFRunLoopCommonModes);
    CFRunLoopAddObserver(runLoop, observer, mode);
    dispatcher.state = LGTaskStateRunning;
}


@end

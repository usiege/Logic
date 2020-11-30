//
//  LGTimerWapper.m
//  003---强引用问题
//
//  Created by cooci on 2019/1/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGTimerWapper.h"
#import <objc/message.h>

@interface LGTimerWapper()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL aSelector;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LGTimerWapper

// 中介者 vc dealloc
// objc 骚 vc -/-> LGTimerWapper <-/- runloop
// vc 释放 fireHome

- (instancetype)lg_initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    if (self == [super init]) {
        self.target     = aTarget; // vc
        self.aSelector  = aSelector; // 方法 -- vc 释放
        
        if ([self.target respondsToSelector:self.aSelector]) { 
            Method method    = class_getInstanceMethod([self.target class], aSelector);
            const char *type = method_getTypeEncoding(method);
            class_addMethod([self class], aSelector, (IMP)fireHomeWapper, type);
            
            self.timer      = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:aSelector userInfo:userInfo repeats:yesOrNo];
        }
    }
    return self;
}

// 一直跑 runloop
void fireHomeWapper(LGTimerWapper *warpper){
    
    if (warpper.target) { // vc - dealloc
        void (*lg_msgSend)(void *,SEL, id) = (void *)objc_msgSend;
         lg_msgSend((__bridge void *)(warpper.target), warpper.aSelector,warpper.timer);
    }else{ // warpper.target
        [warpper.timer invalidate];
        warpper.timer = nil;
    }
}


- (void)lg_invalidate{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

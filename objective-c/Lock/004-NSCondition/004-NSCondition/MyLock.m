//
//  MyLock.m
//  004-NSCondition
//
//  Created by Qingqing on 2020/3/5.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "MyLock.h"

@interface MyLock ()<NSLocking>
@property (nonatomic, strong) NSCondition *testCondition;
@end

@implementation MyLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        _testCondition = [NSCondition new];
        _value = 2;
    }
    return self;
}

- (void)mylockWithCondition:(int)condition {
    [_testCondition lock];
    while (_thread != nil || _value != condition) {
        if (![_testCondition waitUntilDate:[NSDate distantPast]]) {
            [_testCondition unlock];
        }
    }
    _thread = [NSThread currentThread];
    [_testCondition unlock];
}

- (void)myUnlockWithCondition:(int)condition {
    _value = condition;
    [_testCondition lock];
    _thread = nil;
    [_testCondition broadcast];
    [_testCondition unlock];
}


@end

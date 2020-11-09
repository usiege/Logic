//
//  ViewController.m
//  006-os_unfair_lock&OSSpinLock
//
//  Created by Cooci on 2020/2/29.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "ViewController.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>

@interface ViewController (){
    OSSpinLock _spinLock;
}
@property (nonatomic, assign) NSUInteger ticketCount;
@property (nonatomic, assign) os_unfair_lock unfairLock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _unfairLock = OS_UNFAIR_LOCK_INIT;
    [self lg_testOSSPinLock];
}

#pragma mark -- OSSpinLock

- (void)lg_testOSSPinLock{
    _spinLock = OS_SPINLOCK_INIT;
    // 线程1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程1 准备上锁,currentThread:%@",[NSThread currentThread]);
        OSSpinLockLock(&_spinLock);
        NSLog(@"线程1");
        sleep(3);
        OSSpinLockUnlock(&_spinLock);
        NSLog(@"线程1 解锁完成");
    });
    
    // 线程2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程2 准备上锁,currentThread:%@",[NSThread currentThread]);
        OSSpinLockLock(&_spinLock);
        NSLog(@"线程2");
        sleep(3);
        OSSpinLockUnlock(&_spinLock);
        NSLog(@"线程2 解锁完成");
    });
}

#pragma mark -- os_unfair_lock

- (void)lg_test_os_unfair_lock{
//    os_unfair_lock
    _spinLock = OS_SPINLOCK_INIT;
    
//    _unfairLock = OS_UNFAIR_LOCK_INIT;
}


- (void)saleTicket{
    
    os_unfair_lock_lock(&_unfairLock);
    if (self.ticketCount > 0) {
        self.ticketCount--;
        NSLog(@"当前窗口：%@,当前余票还剩：%lu张",[NSThread currentThread],(unsigned long)self.ticketCount);
    }else{
        NSLog(@"当前窗口：%@,当前车票已售罄",[NSThread currentThread]);
    }
    os_unfair_lock_unlock(&_unfairLock);

}

@end


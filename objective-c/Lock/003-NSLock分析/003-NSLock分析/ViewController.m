//
//  ViewController.m
//  003-NSLock分析
//
//  Created by Cooci on 2019/2/27.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *testArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [self lg_crash];
    [self lg_testRecursive];
    
}

#pragma mark -- NSLock

- (void)lg_crash{
    for (int i = 0; i < 200; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _testArray = [NSMutableArray array];
        });
    }
}


#pragma mark -- NSRecursiveLock

- (void)lg_testRecursive{
  
    // self - map
    // cache -
    // lock
    
    
    // 普通线程  安全 - NSLock
    // 递归调用的 NSRecursiveLock
    // 循环 - 线程影响 - 死锁
    //
    
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];

    for (int i= 0; i<100; i++) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            static void (^testMethod)(int);
            
            testMethod = ^(int value){
                
                @synchronized (self) {
                    if (value > 0) {
                      NSLog(@"current value = %d",value);
                      testMethod(value - 1);
                    }
                }
                
            };
            testMethod(10);
        });
    }

    
    
}



@end

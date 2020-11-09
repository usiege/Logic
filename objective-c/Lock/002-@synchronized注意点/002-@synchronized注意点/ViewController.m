//
//  ViewController.m
//  002-@synchronized注意点
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
    NSLog(@"1223");
    _testArray = [NSMutableArray array];

    [self lg_crash];
}

- (void)lg_crash{
    // _testArray = [NSMutableArray array]; setter
    // new retain release old
    // release old  2
    // release old  3
    // @synchronized(self)  : 性能 + objc 生命周期
    // enter 找节点 objc : 查找非常麻烦 - self
    
    
    NSLock *lock = [[NSLock alloc] init];
    for (int i = 0; i < 200000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [lock lock];
            _testArray = [NSMutableArray array];
            [lock unlock];
        });
    }
}

@end

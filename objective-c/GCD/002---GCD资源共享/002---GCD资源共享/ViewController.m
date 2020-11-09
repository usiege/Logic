//
//  ViewController.m
//  002---GCD资源共享
//
//  Created by Cooci on 2018/6/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger tickets;
@property (nonatomic, strong) dispatch_queue_t queue;;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 准备票数
    _tickets = 20;
    // 创建串行队列
    _queue = dispatch_queue_create("Cooci", DISPATCH_QUEUE_SERIAL);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 第一个线程卖票
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self saleTickes];
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 第二个线程卖票
        [self saleTickes];
    });

  

}

- (void)saleTickes {
    
    while (self.tickets > 0) {
        // 模拟延时
        [NSThread sleepForTimeInterval:1.0];
        // 苹果不推荐程序员使用互斥锁，串行队列同步任务可以达到同样的效果！
        // @synchronized
        // 使用串行队列，同步任务卖票
        dispatch_sync(_queue, ^{
            // 检查票数
            if (self.tickets > 0) {
                self.tickets--;
                NSLog(@"还剩 %zd %@", self.tickets, [NSThread currentThread]);
            } else {
                NSLog(@"没有票了");
            }
        });
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

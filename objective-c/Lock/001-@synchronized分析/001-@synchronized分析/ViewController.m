//
//  ViewController.m
//  001-@synchronized分析
//
//  Created by Cooci on 2019/2/27.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) NSUInteger ticketCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ticketCount = 20;
    [self lg_testSaleTicket];
}


- (void)lg_testSaleTicket{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10; i++) {
            [self saleTicket];
        }
    });
}

- (void)saleTicket{
    // 枷锁 - 线程安全
    // 研究 底层原理
    // 分析 请问怎么分析?
    // objc_sync_enter  lock
    // objc_sync_exit
    // libobjc.A.dylib
    // 思路 清晰
    @synchronized (self) {
        
        if (self.ticketCount > 0) {
            self.ticketCount--;
            sleep(0.1);
            NSLog(@"当前余票还剩：%ld张",self.ticketCount);
            
        }else{
            NSLog(@"当前车票已售罄");
        }

    }

}


@end

//
//  ViewController.m
//  007---Dispatch_source
//
//  Created by Cooci on 2018/8/28.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) dispatch_source_t source;
@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, assign) NSUInteger totalComplete;
@property (nonatomic) BOOL isRunning;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 调度组 - source(timer)
    // 下载 2个image  - image
    // dispatch_group_notify : 成对 OK
    // 成对存在 - enter - leave - notify
    // state = 0
    // dispatch_group_async = enter - leave

    
    self.totalComplete = 0;
    
    self.queue = dispatch_queue_create("chenshu.com", NULL);
    
    // runloop
    // kenel-workloop
    // DISPATCH_SOURCE_TYPE_TIMER 准确
    self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_event_handler(self.source, ^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        NSUInteger value = dispatch_source_get_data(self.source);
        self.totalComplete += value;
        NSLog(@"进度: %.2f",self.totalComplete/100.0);
        self.progressView.progress = self.totalComplete/100.0;
    });
    
    self.isRunning = YES;
    dispatch_resume(self.source);
}



- (IBAction)didClickStartOrPauseAction:(id)sender {
   
    if (self.isRunning) {
        dispatch_suspend(self.source);
        dispatch_suspend(self.queue);
        NSLog(@"已经暂停");
        self.isRunning = NO;
        [sender setTitle:@"暂停中.." forState:UIControlStateNormal];
    }else{
        dispatch_resume(self.source);
        dispatch_resume(self.queue);
        NSLog(@"已经执行了");
        self.isRunning = YES;
        [sender setTitle:@"暂停中.." forState:UIControlStateNormal];
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"开始了");
    
    for (int i= 0; i<100; i++) {
        dispatch_async(self.queue, ^{
            if (!self.isRunning) {
                NSLog(@"已经暂停");
                return;
            }
            sleep(1);
            dispatch_source_merge_data(self.source, 1);
        });
    }

}

- (void)groupDemo{
    
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group); // 0-1
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"他们回来了 我准备主线程更新UI");
    });
    
    dispatch_group_leave(group);
    
    // dispatch_async block
    // 自己能不能唤醒
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"890");
    });
    
    


    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"123");
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"4567");
        dispatch_group_leave(group);
    });
    

    NSLog(@"主线程事务正常执行");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

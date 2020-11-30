//
//  LGTimerViewController.m
//  003---强引用问题
//
//  Created by cooci on 2019/1/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGTimerViewController.h"
#import "LGTimerWapper.h"
#import "LGProxy.h"
#import <objc/runtime.h>

static int num = 0;

@interface LGTimerViewController ()
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) LGTimerWapper *timerWapper;
@property (nonatomic, strong) id            target;
@property (nonatomic, strong) LGProxy       *proxy;
@end

@implementation LGTimerViewController

void fireHomeFunc(){
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self -> timer -> self
    // 这里用 weakSelf 能够解决!!!
    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)self));
    
    // self.timer -> self 释放不掉
    // timer vc 对象 内存
    // self -> timer - weakSelf -> self 循环
    // [NSRunLoop currentRunLoop] 强持有 -> timer -> weakSelf -> self
    // block -> 指针地址
    // self -> block - weakSelf -> self
    
    // weakSelf : 没有对内存加1
    // __weak typeof(self) weakSelf = self;
    
    // NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)self));

    
//    self.timer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(fireHome) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
   
    // NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)self));

    // 两个同时持有 - 引用计数没有处理
    
    // 对象的地址
    // self 的地址 和 weakSelf 的地址不一样!!!!
    // self -> block -> weakSelf (临时变量的指针地址) 地址->内存
    // weakSelf 能够释放
    // 强持有 - 对象
    // timer : <LGTimerViewController: 0x7fb8c9d11240>
    // NSRunLoop -> timer -> weakSelf (<LGTimerViewController: 0x7fb8c9d11240>)
    
//     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(fireHome) userInfo:nil repeats:YES];

    // 解决思路 : 我们需要打破这一层强持有 - self
    
    // 思路一: dealloc 不能来 那我们能不能看看有没有其他的方法在pop的时候 就销毁timer
    // 把 核心timer 销毁 那么 强持有 - 循环引用就不存在
    
    // 思路二: 中介者模式 - 不方便使用 self
    // 换其他对象
//     self.target = [[NSObject alloc] init];
//     class_addMethod([NSObject class], @selector(fireHome), (IMP)fireHomeObjc, "v@:");
//     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.target selector:@selector(fireHome) userInfo:nil repeats:YES];
    
    // 思路三: 感觉 NSObject 这里写在这里好恶心! 裹脚布藏起来
//     self.timerWapper = [[LGTimerWapper alloc] lg_initWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
    
    // 思路四: proxy 虚基类的方式
    self.proxy = [LGProxy proxyWithTransformObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(fireHome) userInfo:nil repeats:YES];
    
}

//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    // 无论push 进来 还是 pop 出去 正常跑
//    // 就算继续push 到下一层 pop 回去还是继续
//    if (parent == nil) {
//       [self.timer invalidate];
//        self.timer = nil;
//        NSLog(@"timer 走了");
//    }
//}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    // push 到下一层返回就不走了!!!
//    [self.timer invalidate];
//    self.timer = nil;
//    NSLog(@"timer 走了");
//}

//void fireHomeObjc(id obj){
//    NSLog(@"%s -- %@",__func__,obj);
//}

- (void)fireHome{
    num++;
    NSLog(@"hello word - %d",num);
}

- (void)dealloc{
    // [self.timerWapper lg_invalidate];
    // VC -> proxy <- runloop
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%s",__func__);
}

- (void)blockTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer fire - %@",timer);
    }];
}


@end

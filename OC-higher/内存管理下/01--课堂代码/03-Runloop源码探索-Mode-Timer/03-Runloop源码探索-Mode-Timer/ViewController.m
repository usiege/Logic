//
//  ViewController.m
//  03-Runloop源码探索-Mode-Timer
//
//  Created by cooci on 2018/12/7.
//  Copyright © 2018 cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotNotification:) name:@"helloMyNotification" object:nil];

    [self timerDemo];
    
    self.textView.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"1@#");
    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"123");
    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
}

#pragma mark - mode演练

- (void)timerDemo{
    
    // CFRunLoopMode 研究
    CFRunLoopRef lp     = CFRunLoopGetCurrent();
    CFRunLoopMode mode  = CFRunLoopCopyCurrentMode(lp);
    NSLog(@"mode == %@",mode);
    CFArrayRef modeArray= CFRunLoopCopyAllModes(lp);
    NSLog(@"modeArray == %@",modeArray);

    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"fire in home -- %@",[[NSRunLoop currentRunLoop] currentMode]);
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - timer

- (void)cfTimerDemo{
    CFRunLoopTimerContext context = {
        0,
        ((__bridge void *)self),
        NULL,
        NULL,
        NULL
    };
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    /**
     参数一:用于分配对象的内存
     参数二:在什么是触发 (距离现在)
     参数三:每隔多少时间触发一次
     参数四:未来参数
     参数五:CFRunLoopObserver的优先级 当在Runloop同一运行阶段中有多个CFRunLoopObserver 正常情况下使用0
     参数六:回调,比如触发事件,我就会来到这里
     参数七:上下文记录信息
     */
    CFRunLoopTimerRef timerRef = CFRunLoopTimerCreate(kCFAllocatorDefault, 0, 1, 0, 0, lgRunLoopTimerCallBack, &context);
    CFRunLoopAddTimer(rlp, timerRef, kCFRunLoopDefaultMode);

}

void lgRunLoopTimerCallBack(CFRunLoopTimerRef timer, void *info){
    NSLog(@"%@---%@",timer,info);
}

#pragma mark - observe

- (void)cfObseverDemo{
    
    CFRunLoopObserverContext context = {
        0,
        ((__bridge void *)self),
        NULL,
        NULL,
        NULL
    };
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    /**
     参数一:用于分配对象的内存
     参数二:你关注的事件
          kCFRunLoopEntry=(1<<0),
          kCFRunLoopBeforeTimers=(1<<1),
          kCFRunLoopBeforeSources=(1<<2),
          kCFRunLoopBeforeWaiting=(1<<5),
          kCFRunLoopAfterWaiting=(1<<6),
          kCFRunLoopExit=(1<<7),
          kCFRunLoopAllActivities=0x0FFFFFFFU
     参数三:CFRunLoopObserver是否循环调用
     参数四:CFRunLoopObserver的优先级 当在Runloop同一运行阶段中有多个CFRunLoopObserver 正常情况下使用0
     参数五:回调,比如触发事件,我就会来到这里
     参数六:上下文记录信息
     */
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, lgRunLoopObserverCallBack, &context);
    CFRunLoopAddObserver(rlp, observerRef, kCFRunLoopDefaultMode);
}

void lgRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"%lu-%@",activity,info);
}


#pragma mark - 测试观察

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"helloMyNotification" object:@"cooci"];
}

- (void)gotNotification:(NSNotification *)noti{
    NSLog(@"gotNotification = %@",noti);
}

@end

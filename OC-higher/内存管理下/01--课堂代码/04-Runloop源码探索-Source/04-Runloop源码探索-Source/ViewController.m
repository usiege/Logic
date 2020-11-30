//
//  ViewController.m
//  04-Runloop源码探索-Source
//
//  Created by cooci on 2018/12/7.
//  Copyright © 2018 cooci. All rights reserved.
//


#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()<NSPortDelegate>
@property (nonatomic, strong) NSPort* subThreadPort;
@property (nonatomic, strong) NSPort* mainThreadPort;
@end

@implementation ViewController

typedef union{
    char a;
    float b;
} UnionType;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UnionType type;
    type.a = 10;
    NSLog(@"a=%p",&type.a);
    NSLog(@"b=%p",&type.b);
    // 位域
    // 0xff72000010
    NSLog(@"%zd",sizeof(UnionType));
    
    [self source0Demo];
    
    [self setupPort];
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

#pragma mark - source0:演练

// 就是喜欢玩一下: 我们下面来自定义一个source
- (void)source0Demo{
    
    CFRunLoopSourceContext context = {
        0,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        schedule,
        cancel,
        perform,
    };
    /**
     
     参数一:传递NULL或kCFAllocatorDefault以使用当前默认分配器。
     参数二:优先级索引，指示处理运行循环源的顺序。这里我传0为了的就是自主回调
     参数三:为运行循环源保存上下文信息的结构
     */
    CFRunLoopSourceRef source0 = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &context);
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    // source --> runloop 指定了mode  那么此时我们source就进入待绪状态
    CFRunLoopAddSource(rlp, source0, kCFRunLoopDefaultMode);
    // 一个执行信号
    CFRunLoopSourceSignal(source0);
    // 唤醒 run loop 防止沉睡状态
    CFRunLoopWakeUp(rlp);
    // 取消 移除
    CFRunLoopRemoveSource(rlp, source0, kCFRunLoopDefaultMode);
    CFRelease(rlp);
}

void schedule(void *info, CFRunLoopRef rl, CFRunLoopMode mode){
    NSLog(@"准备代发");
}

void perform(void *info){
    NSLog(@"执行吧,骚年");
}

void cancel(void *info, CFRunLoopRef rl, CFRunLoopMode mode){
    NSLog(@"取消了,终止了!!!!");
}

#pragma mark - source1: port演示

- (void)setupPort{
    
    self.mainThreadPort = [NSPort port];
    self.mainThreadPort.delegate = self;
    // port - source1 -- runloop
    [[NSRunLoop currentRunLoop] addPort:self.mainThreadPort forMode:NSDefaultRunLoopMode];

    [self task];
}

- (void) task {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        self.subThreadPort = [NSPort port];
        self.subThreadPort.delegate = self;
        
        [[NSRunLoop currentRunLoop] addPort:self.subThreadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    
    [thread start];
    // 主线 -- 子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", [NSThread currentThread]); // 3

        NSString *str;
        dispatch_async(dispatch_get_main_queue(), ^{
            // 1
            NSLog(@"%@", [NSThread currentThread]);

        });
    });
}

// 线程之间通讯
// 主线程 -- data
// 子线程 -- data1
// 更加低层 -- 内核
// mach

- (void)handlePortMessage:(id)message {
    NSLog(@"%@", [NSThread currentThread]); // 3 1

    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([message class], &count);
    for (int i = 0; i<count; i++) {
        
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
//        NSLog(@"%@",name);
    }
    
    sleep(1);
    if (![[NSThread currentThread] isMainThread]) {

        NSMutableArray* components = [NSMutableArray array];
        NSData* data = [@"woard" dataUsingEncoding:NSUTF8StringEncoding];
        [components addObject:data];

        [self.mainThreadPort sendBeforeDate:[NSDate date] components:components from:self.subThreadPort reserved:0];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray* components = [NSMutableArray array];
    NSData* data = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
    [components addObject:data];
    
    [self.subThreadPort sendBeforeDate:[NSDate date] components:components from:self.mainThreadPort reserved:0];
}
@end

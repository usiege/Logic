//
//  ViewController.m
//  001---alloc&init底层探索
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // alloc 通过我们的类创建实例对象
    // init  为什么?
    // 啥也没做  why
    // 设计模式 ---  自由
    // 底层难  方法研究
    // LLVM 优化 - 什么?
    // 连接 编译 运行 空闲  C++
    // 
    LGPerson *p = [LGPerson alloc]; // objc -- 找资料 -- 1: 汇编
    // objc_msgSend (id 消息接受者 , sel) ---  发送消息 --
    // 
    LGPerson *p1 = [p init];
    LGPerson *p2 = [p init];
    NSLog(@"%p-%p-%p",p,p1,p2); // ? -- alloc init 到底做了什么 -- api
    NSLog(@"end");
}


@end

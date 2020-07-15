//
//  ViewController.m
//  001-消息转发流程
//
//  Created by cooci on 2019/3/27.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGStudent.h"
#import "NSObject+LG.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // student -- 类 - 结构体
    // OC - C ---
    LGStudent *student = [[LGStudent alloc] init];
    // 方法 -- 消息 - 是如何发送
    // student -> person - 集成 - 消息
    [student lg_instanceMethod];
    // SEL IMP
    // method -> 函数 (id self,SEL _cmd)
    // 消息接受者   方法编号
    // 书 目录(SEL) - 页码(IMP:指向函数具体实现的指针) - 具体内容(函数实现)
    // sel -> imp
    // 每一次 - objc_msgSend
    // 实例的方法 存在哪里? 类对象
    NSLog(@"%@",[LGStudent class]);
    // 类是不是也会有方法 - 元类里面
}


@end

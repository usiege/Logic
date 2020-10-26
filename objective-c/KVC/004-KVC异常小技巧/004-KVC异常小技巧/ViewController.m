//
//  ViewController.m
//  004-KVC异常小技巧
//
//  Created by Cooci on 2019/12/9.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LGPerson *person = [[LGPerson alloc] init];
    
    // 1: KVC 自动转换类型
    NSLog(@"******1: KVC - int -> NSNumber - 结构体******");
    
    // 2: 设置空值
    NSLog(@"******2: 设置空值******");
    
    // 3: 找不到的 key
    NSLog(@"******3: 找不到的 key******");

    // 4: 取值时 - 找不到 key
    NSLog(@"******4: 取值时 - 找不到 key******");
    
    // 5: 键值验证
    NSLog(@"******5: 键值验证******");
    
}


@end

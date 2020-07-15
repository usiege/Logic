//
//  ViewController.m
//  003---字节对齐
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LGPerson *p = [LGPerson alloc];
    p.age  = 18;
    p.name = @"cooci";
    p.height = 185;
    NSLog(@"%zu",class_getInstanceSize([p class])); // 8 --- 16
    NSLog(@"%zu",malloc_size((__bridge const void *)(p))); // 16
    // 系统 内存对齐 --- ISA 8 age 4 (int 剩 4) name(8)
    // 8  算法
    // 16 优化
    // 对象内存分配
    // isa -- age -- height -- name  : 8 + 4 + 4 + 8 = 24 ---- 32
    // isa -- age -- name -- height  : 8 + 8 + 8 + 8 = 32 ---- 32

}



@end

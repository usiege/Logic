//
//  ViewController.m
//  002---taggedPointer
//
//  Created by Cooci on 2019/5/12.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

extern uintptr_t objc_debug_taggedpointer_obfuscator;

@interface ViewController ()

@property (nonatomic, strong) dispatch_queue_t  queue;
@property (nonatomic, strong) NSString *nameStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *objc = [NSObject alloc];
    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)objc));
    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)objc)); // 2
    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)objc)); // 3

    // alloc 引用计数为多少 : 0
    // extrc
    // 1
    
    // [self taggedPointerDemo];
    // taggedpointer 指针 : 指针 + 值
    // 对象 string 值 + 指针
    // 小对象: number1 date 11
    // 一个对象: 8字节 * 8位 = 64位
    // 象棋
    // @"";
    // 10000000000000000000000000000000000
    NSString *str1 = [NSString stringWithFormat:@"a"];
    NSString *str2 = [NSString stringWithFormat:@"b"];
    NSString *str3 = [[NSString alloc] initWithFormat:@"c"];
    NSString *str4 = [[NSString alloc] initWithFormat:@"cccccccccccccccccccc"];


    NSLog(@"%p-%@",str1,str1);
    NSLog(@"%p-%@",str2,str2);
    NSLog(@"0x%lx",_objc_decodeTaggedPointer_(str2));
    // 0xa000000000000621
    // 地址: 包含了值
    // 0xb000000000000012
    // 0xb000000000000025
    // 特殊的含义
    // 0xb 0xa 判断条件 是否taggedpointer
    // 0xa string 1 010  2 tagtype
    // 0xb int    1 011  3
    // 小对象
    // 地址 + 值 -
    // 不进去 直接释放回收
    // 效率: 3倍 100倍

    NSNumber *number1 = @1;
    NSNumber *number2 = @(-1); // 0xbffffffffffffff2
    NSNumber *number3 = @2.0;
    NSNumber *number4 = @3.2;
    NSLog(@"%@-%p-%@",object_getClass(number1),number1,number1);
    NSLog(@"%@-%p-%@",object_getClass(number2),number2,number2);
    NSLog(@"%@-%p-%@",object_getClass(number3),number3,number3);
    NSLog(@"%@-%p-%@",object_getClass(number4),number4,number4);

    NSLog(@"%@-%p-%@ - 0x%lx",object_getClass(number1),number1,number1,_objc_decodeTaggedPointer_(number1));
    NSLog(@"0x%lx",_objc_decodeTaggedPointer_(number2)); // 0xb000000000000012
    NSLog(@"0x%lx",_objc_decodeTaggedPointer_(number3));
    NSLog(@"0x%lx",_objc_decodeTaggedPointer_(number4));

}

uintptr_t
_objc_decodeTaggedPointer_(id ptr)
{
    return (uintptr_t)ptr ^ objc_debug_taggedpointer_obfuscator;
}

//MARK: - taggedPointer 面试题
- (void)taggedPointerDemo {
  
    self.queue = dispatch_queue_create("com.cooci.cn", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i<10000; i++) {
        dispatch_async(self.queue, ^{
            self.nameStr = [NSString stringWithFormat:@"cooci"];  // alloc 堆 iOS优化 - taggedpointer
             NSLog(@"%@",self.nameStr);
        });
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    // objc_release
    // setter
    // retain release 多条线程 同时对一个对象释放 - 过渡释放
    
    
    NSLog(@"来了");
    for (int i = 0; i<10000; i++) {
        dispatch_async(self.queue, ^{
            self.nameStr = [NSString stringWithFormat:@"cooci_和谐学习不急不躁"];
            NSLog(@"%@",self.nameStr);
        });
    }
}

@end

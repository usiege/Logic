//
//  main.m
//  001-自动释放池初探
//
//  Created by Cooci on 2020/8/10.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    /**
     自动释放池: 苹果官方文档  大家可以自己慢慢看
     NSAutoreleasePool 类被用来支持自动引用计数内存管理系统。一个自动释放池存储的对象当自己被销毁的时会向其中的对象发送 release 消息。
     
     什么时候需要autorelease
     写基于命令行的的程序时，就是没有UI框架，如 AppKit 等 Cocoa 框架时。
     当我们的应用有需要创建大量的临时变量的时候，可以是用 @autoreleasepool 来减少内存峰值。
     
     
     1: 经过底层clang编译:
     __AtAutoreleasePool __autoreleasepool;
     
     struct __AtAutoreleasePool {
       __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
       ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
       void * atautoreleasepoolobj;
     };
     
     
     */
        NSObject *objc0  = [NSObject alloc];
        NSLog(@"打印对象:%@",objc0);
    
//        for (int i = 0; i< 100000000000; i++) {
////            NSString *names = [NSString stringWithFormat:@"cooci_AutoreleasePool"];
////            int names = 10;
////            NSObject *names  = [NSObject alloc];
//
//            NSLog(@"%d-%p",names,&names);
//        }
        

//        for (int i = 0; i< 100000000000; i++) {
//            @autoreleasepool {
//                NSObject *names  = [NSObject alloc];
////                NSString *names = [NSString stringWithFormat:@"cooci_AutoreleasePool"];
//                int names = 10;
//                NSLog(@"%d-%p",names,&names);
//            }
//        }
        
        NSLog(@"执行完毕了,内存没有奔溃");

    
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}

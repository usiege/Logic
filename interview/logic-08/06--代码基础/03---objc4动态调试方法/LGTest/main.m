//
//  main.m
//  LGTest
//
//  Created by cooci on 2019/2/7.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "LGPerson.h"

void test1(){
    // imp 获取 why
    Class 
    SEL
    IMP imp1 = class_getMethodImplementation([LGPerson class], @selector(lg_instanceMethod));
    IMP imp2 = class_getMethodImplementation([LGPerson class], @selector(lg_classMethod));
    IMP imp3 = class_getMethodImplementation(objc_getMetaClass("LGPerson"), @selector(lg_instanceMethod));
    IMP imp4 = class_getMethodImplementation(objc_getMetaClass("LGPerson"), @selector(lg_classMethod));
    NSLog(@"%p-%p-%p-%p",imp1,imp2,imp3,imp4);
    // objc_msgSend
    // objc_msgForward
    NSLog(@"ok");
}

void test2(){
    // 实例方法获取 -- 对象实例方法 -- 类 l
    // 类方法 -- 元类
    Method method1 = class_getInstanceMethod([LGPerson class], @selector(lg_instanceMethod)); // 类对象 拿 实例方法
    Method method2 = class_getInstanceMethod(objc_getMetaClass("LGPerson"), @selector(lg_instanceMethod)); // 元类对象 拿 实例方法

    Method method3 = class_getInstanceMethod([LGPerson class], @selector(lg_classMethod));
    Method method4 = class_getInstanceMethod(objc_getMetaClass("LGPerson"), @selector(lg_classMethod));
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    // 1:1 2:1 3:1 4:1
    NSLog(@"ok");
}

void test3(){
    // 类方法获取
    Method method1 = class_getClassMethod([LGPerson class], @selector(lg_instanceMethod));
    Method method2 = class_getClassMethod(objc_getMetaClass("LGPerson"), @selector(lg_instanceMethod));
    
    // 类 --> lg_classMethod 类方法
    // 元类
    Method method3 = class_getClassMethod([LGPerson class], @selector(lg_classMethod));
    Method method4 = class_getClassMethod(objc_getMetaClass("LGPerson"), @selector(lg_classMethod));
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    NSLog(@"ok");
}

int main(int argc, const char * argv[]) {
    LGPerson *p = [[LGPerson alloc] init];
    NSLog(@"%p",p.class);
    NSLog(@"%p",object_getClass(p.class));
    test3();
    NSLog(@"end");
    return 0;
}


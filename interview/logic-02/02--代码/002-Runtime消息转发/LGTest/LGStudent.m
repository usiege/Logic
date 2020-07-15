//
//  LGStudent.m
//  LGTest
//
//  Created by cooci on 2019/2/28.
//

#import "LGStudent.h"
#import <objc/runtime.h>
#import "LGDog.h"

@implementation LGStudent

+ (void)readBook{
    NSLog(@"%s",__func__);
}

- (void)helloBook{
    NSLog(@"%s",__func__);
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"%s",__func__);
    if (aSelector == @selector(walk)) {
        NSMethodSignature *ms = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return ms;
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s",__func__);

    // 切面 -- 动态方法解析
    // SDK -- 自由
    // 侵入性
    // 不到万不得已 不做消息重定向
    // 
    
    // walk anInvocation --
    // 系统调用堆栈
    // 沙盒 -- 服务器

    // 切面编程
    // 家庭作业 aspect -- 消息转发代码

    // method-swizzling hook array 数组越界
    // self.dataArray objecAtIndex
    // if index < self.count-1 -- excepetion
    // 消息转发
    // array nil
    // 切面

    NSString *sto = @"奔跑少年";
    anInvocation.target = [LGStudent class];
    [anInvocation setArgument:&sto atIndex:2];
    NSLog(@"%@",anInvocation.methodSignature);
    anInvocation.selector = @selector(run:);
    [anInvocation invoke];
}

// 发送一个消息
// LGStudent
// 找不到imp
// 开发人员也没处理
// 消息快速转发 -- 电话 --
// 不要去我家 -- 蜂巢 -- 菜鸟


@end

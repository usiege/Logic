//
//  NSObject+LG.m
//  LGTest
//
//  Created by cooci on 2019/4/11.
//

#import "NSObject+LG.h"
#import <objc/runtime.h>

@implementation NSObject (LG)

void lg_dynamicMethodIMP(){
    NSLog(@"%s",__func__);
}
// 网络 数据 - int string
// [int length] --> 做一些处理 -
// 写代码 在你奔溃 之前 - 动态处理
// crash 收集 - 动态方法解析
// 也不好 --

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    // 请你处理 - 给第一次机会
//    // sel - imp
//    NSLog(@"来了,老弟");
//    // load - 可以
//    // 方法 -- 动态化
//    // lg_run  --
//    if (sel==@selector(run)) {
//        class_addMethod([self class], sel, (IMP)lg_dynamicMethodIMP, "v@:");
//        return YES;
//    }
//    return NO;
//}


@end

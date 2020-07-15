//
//  LGRuntimeTool.m
//  005---Runtime应用
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGRuntimeTool.h"
#import <objc/runtime.h>

@implementation LGRuntimeTool
+ (void)lg_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL{
    
    if (!cls) NSLog(@"传入的交换类不能为空");

    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    method_exchangeImplementations(oriMethod, swiMethod);
}


+ (void)lg_betterMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL{
    
    if (!cls) NSLog(@"传入的交换类不能为空");
    
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    // 一般交换方法: 交换自己有的方法 -- 走下面 因为自己有意味添加方法失败
    // 交换自己没有实现的方法:
    //   首先第一步:会先尝试给自己添加要交换的方法 :personInstanceMethod (SEL) -> swiMethod(IMP)
    //   然后再将父类的IMP给swizzle  personInstanceMethod(imp) -> swizzledSEL
    //oriSEL:personInstanceMethod
    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}



@end

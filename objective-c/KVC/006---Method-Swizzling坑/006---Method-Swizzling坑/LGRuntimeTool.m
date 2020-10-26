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
    // oriSEL       personInstanceMethod
    // swizzledSEL  lg_studentInstanceMethod
    
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
   
    // 尝试添加你要交换的方法 - lg_studentInstanceMethod
    BOOL success = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(oriMethod));

    /**
     personInstanceMethod(sel) - lg_studentInstanceMethod(imp)
     lg_studentInstanceMethod (swizzledSEL) - personInstanceMethod(imp)
     */
    
    if (success) {// 自己没有 - 交换 - 没有父类进行处理 (重写一个)
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{ // 自己有
        method_exchangeImplementations(oriMethod, swiMethod);
    }
    
    
}



@end

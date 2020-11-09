//
//  LGStudent+LG.m
//  006---Method-Swizzling坑
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGStudent+LG.h"
#import "LGRuntimeTool.h"
#import <objc/runtime.h>

@implementation LGStudent (LG)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LGRuntimeTool lg_betterMethodSwizzlingWithClass:self oriSEL:@selector(personInstanceMethod) swizzledSEL:@selector(lg_studentInstanceMethod)];
    });
}

// personInstanceMethod 我需要父类的这个方法的一些东西
// 给你加一个personInstanceMethod 方法
// imp

- (void)lg_studentInstanceMethod{
    [self lg_studentInstanceMethod];
    NSLog(@"LGStudent分类添加的lg对象方法:%s",__func__);
}

@end

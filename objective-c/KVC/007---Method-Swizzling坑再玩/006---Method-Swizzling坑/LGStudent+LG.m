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
        [LGRuntimeTool lg_bestMethodSwizzlingWithClass:self oriSEL:@selector(helloword) swizzledSEL:@selector(lg_studentInstanceMethod)];
    });
}

- (void)lg_studentInstanceMethod{
    NSLog(@"LGStudent分类添加的lg对象方法:%s",__func__);
    [self lg_studentInstanceMethod];
}
@end

//
//  NSArray+LG.m
//  005---Runtime应用
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "NSArray+LG.h"
#import "LGRuntimeTool.h"
#import <objc/runtime.h>

@implementation NSArray (LG)

+ (void)load{
    
    Method oriMethod = class_getInstanceMethod([self class], @selector(objectAtIndex:));
    Method swiMethod = class_getInstanceMethod([self class], @selector(lg_objectAtIndex:));
    method_exchangeImplementations(oriMethod, swiMethod);
    
}

// 交换的方法

- (id)lg_objectAtIndex:(NSUInteger)index{
    if (index > self.count-1) {
        NSLog(@"数组越界 -- ");
        return nil;
    }
    return [self lg_objectAtIndex:index];
}




@end

//
//  NSObject+LG.m
//  KCObjc
//
//  Created by cooci on 2020/10/20.
//

#import "NSObject+LG.h"
#import <objc/runtime.h>

@implementation NSObject (LG)

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method m1 = class_getInstanceMethod(self, @selector(class));
//        Method m2 = class_getInstanceMethod(self, @selector(myClass));
//        method_exchangeImplementations(m1, m2);
//    });
//}
//
//- (void)myClass{
//    NSLog(@"%s",__func__);
//}

@end

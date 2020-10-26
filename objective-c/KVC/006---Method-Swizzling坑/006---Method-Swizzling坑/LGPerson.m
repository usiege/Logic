//
//  LGPerson.m
//  006---Method-Swizzling坑
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson
//- (void)personInstanceMethod{
//    NSLog(@"person对象方法:%s",__func__);
//}
+ (void)personClassMethod{
    NSLog(@"person类方法:%s",__func__);
}


@end

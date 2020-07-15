//
//  LGStudent.m
//  002-[self class]&[super class]
//
//  Created by cooci on 2019/2/21.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGStudent.h"
#import <objc/message.h>
@implementation LGStudent

- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}
@end

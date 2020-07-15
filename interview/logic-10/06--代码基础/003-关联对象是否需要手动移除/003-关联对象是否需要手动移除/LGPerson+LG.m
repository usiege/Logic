//
//  LGPerson+LG.m
//  003-关联对象是否需要手动移除
//
//  Created by cooci on 2019/2/21.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson+LG.h"
#import <objc/runtime.h>

const char kLGProperty;

@implementation LGPerson (LG)

- (void)setLgProperty:(NSString *)lgProperty{
    objc_setAssociatedObject(self, &kLGProperty, lgProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lgProperty{
    return objc_getAssociatedObject(self, &kLGProperty);
}
@end

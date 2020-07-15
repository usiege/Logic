//
//  LGPerson.m
//  01---实例对象-类对象-元类之间的关系
//
//  Created by cooci on 2019/2/8.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson

- (void)callDelegateMethod{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lg_protocolMethod)]) {
        [self.delegate lg_protocolMethod];
    }
}

@end

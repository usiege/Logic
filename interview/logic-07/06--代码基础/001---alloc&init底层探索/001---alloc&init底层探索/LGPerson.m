//
//  LGPerson.m
//  001---alloc&init底层探索
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson

- (instancetype)init{
    self = [super init];
    if (self) {
        self.name = @"cooci";
        self.age  = 18; // 根据你的需求写 ---
        // 初始化 
    }
    return self;
}



@end

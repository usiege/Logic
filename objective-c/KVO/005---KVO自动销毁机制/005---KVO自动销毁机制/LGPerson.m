//
//  LGPerson.m
//  005---KVO自动销毁机制
//
//  Created by cooci on 2019/1/5.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson

- (void)setNickName:(NSString *)nickName{
    NSLog(@"来到 LGPerson 的setter方法 :%@",nickName);
    _nickName = nickName;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end

//
//  LGPerson.m
//  003---自定义KVO
//
//  Created by cooci on 2019/1/5.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson
static LGPerson *_instance = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [LGPerson shareInstance] ;
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [LGPerson shareInstance] ;
}

- (void)setNickName:(NSString *)nickName{
    NSLog(@"来到 LGPerson 的setter方法 :%@",nickName);
    _nickName = nickName;
}
@end

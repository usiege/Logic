//
//  LGStudent.m
//  001---KVO初探
//
//  Created by cooci on 2019/1/3.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGStudent.h"

@implementation LGStudent

static LGStudent* _instance = nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [LGStudent shareInstance] ;
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [LGStudent shareInstance] ;
}

@end

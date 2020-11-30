//
//  LGPerson.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import "LGPerson.h"
extern void _objc_autoreleasePoolPrint(void);


@implementation LGPerson
+ (id)person{
    return [[LGPerson alloc] init];
}

+ (id)allocString{
    return @"allocString";
}
+ (id)initString{
    return @"initString";
}
+ (id)copyString{
    return @"copyString";
}

+ (id)otherString{
    return @"otherString";
}

// 子线程autorelease 测试
- (void)childThreadDemo{
    NSLog(@"person - %@",[NSThread currentThread]);
    NSLog(@"***********子线程***********");
    // NSObject *objc2 = [[[NSObject alloc] init] autorelease];
    _objc_autoreleasePoolPrint();
    NSLog(@"该有的信息我们都有了 线程做了事情 退出吧!!");
}


@end

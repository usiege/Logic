//
//  LGPerson.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import "LGPerson.h"

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

@end

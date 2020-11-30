//
//  LGPerson.m
//  001---五大区Demo
//
//  Created by cooci on 2019/1/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson
- (void)run{
    personNum ++;
    NSLog(@"LGPerson内部:%@-%p--%d",self,&personNum,personNum);
}

+ (void)eat{
    personNum ++;
    NSLog(@"LGPerson内部:%@-%p--%d",self,&personNum,personNum);
}

- (NSString *)description{
    return @"";
}

@end

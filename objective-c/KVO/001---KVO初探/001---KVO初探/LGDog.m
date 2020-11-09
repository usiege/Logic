//
//  LGDog.m
//  001---KVO初探
//
//  Created by cooci on 2019/1/3.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGDog.h"

@implementation LGDog
- (NSString *)description{
    return [NSString stringWithFormat:@"%@-%d",self.name,self.age];
}
@end

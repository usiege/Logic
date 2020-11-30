//
//  LGPerson+LG.m
//  001---五大区Demo
//
//  Created by Cooci on 2020/3/18.
//  Copyright © 2020 cooci. All rights reserved.
//

#import "LGPerson+LG.h"

@implementation LGPerson (LG)
- (void)cate_method{
    NSLog(@"LGPerson内部:%@-%p--%d",self,&personNum,personNum);
}

@end

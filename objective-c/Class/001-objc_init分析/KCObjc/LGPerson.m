//
//  LGPerson.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import "LGPerson.h"

@implementation LGPerson

- (void)kc_instanceMethod1{
    NSLog(@"%s",__func__);
}
- (void)kc_instanceMethod2{
    NSLog(@"%s",__func__);
}
- (void)kc_instanceMethod3{
    NSLog(@"%s",__func__);
}

+ (void)kc_classMethod{
    NSLog(@"%s",__func__);
}

@end

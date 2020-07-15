//
//  NSObject+LG.m
//  LGTest
//
//  Created by cooci on 2019/2/21.
//

#import "NSObject+LG.h"
#import "LGRuntimeTool.h"

@implementation NSObject (LG)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //[LGRuntimeTool lg_bestMethodSwizzlingWithClass:self oriSEL:@selector(class) swizzledSEL:@selector(lg_class)];
    });
}

- (Class)lg_class{
    NSLog(@"来了,老弟");
    return [self lg_class];
}
@end

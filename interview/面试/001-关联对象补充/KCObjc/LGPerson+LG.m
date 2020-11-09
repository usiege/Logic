//
//  LGPerson+LG.m
//  KCObjc
//
//  Created by cooci on 2020/10/20.
//

#import "LGPerson+LG.h"
#import <objc/runtime.h>

@implementation LGPerson (LG)
- (void)cate_instanceMethod1{
    NSLog(@"%s",__func__);
}

- (void)cate_instanceMethod3{
    NSLog(@"%s",__func__);
}

- (void)cate_instanceMethod2{
    NSLog(@"%s",__func__);
}

+ (void)cate_sayClassMethod{
    NSLog(@"%s",__func__);
}

- (void)setCate_name:(NSString *)cate_name{

    objc_setAssociatedObject(self, "cate_name", cate_name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)cate_name{
    return  objc_getAssociatedObject(self, "cate_name");
}
@end

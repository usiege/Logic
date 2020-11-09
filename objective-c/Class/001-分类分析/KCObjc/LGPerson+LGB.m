//
//  LGPerson+LGB.m
//  KCObjc
//
//  Created by cooci on 2020/10/9.
//

#import "LGPerson+LGB.h"

@implementation LGPerson (LGB)

// load 运行时
// 主类 没有实现 分类
// 2*2 = 4 种情况 

// 只要有一个分类是  非懒加载分类 所有都会是  -  rwe  - 懒加载 重新去处理 LGPerson
//+ (void)load{
//
//}

- (void)kc_instanceMethod1{
    NSLog(@"%s",__func__);
}

- (void)cateB_2{
    NSLog(@"%s",__func__);
}

- (void)cateB_3{
    NSLog(@"%s",__func__);
}

- (void)cateB_1{
    NSLog(@"%s",__func__);
}

@end

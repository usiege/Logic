//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

// 分类 怎么研究?

@interface LGPerson (LG)

@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, assign) int cate_age;

- (void)cate_instanceMethod1;
- (void)cate_instanceMethod3;
- (void)cate_instanceMethod2;
+ (void)cate_sayClassMethod;

@end

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
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        // 0x00007ffffffffff8ULL
        // class_data_bits_t bits;
        // class_rw_t *data()
        // read_images - main
        // 消息的发送 realizeClassWithoutSwift - 懒加载 - load
        // 有很多的代码 排序 临时变量 main 调用
        LGPerson *person = [LGPerson alloc];
        [person kc_instanceMethod1];
        NSLog(@"%p",person);
    }
    return 0;
}

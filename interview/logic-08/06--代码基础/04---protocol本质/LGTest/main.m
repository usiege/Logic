//
//  main.m
//  LGTest
//
//  Created by cooci on 2019/2/7.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "LGPerson.h"
#import "LGStudent.h"

/** 方法 协议 属性
 * 写 --> 处理
 * 读
 * 什么时候  加载类 + 加载分类 + 添加属性 , 方法 , 协议
 */


int main(int argc, const char * argv[]) {
    LGPerson *p = [[LGPerson alloc] init];
    LGStudent*s = [[LGStudent alloc] init];
    p.delegate  = s;
    [LGStudent class];
    [p callDelegateMethod];
    NSLog(@"end");
    return 0;
}

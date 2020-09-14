//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        // alloc 开辟内存 - 指针 - init - new
        // init : return (id)self; 构造方法 工厂设计
        // array objc 初始化出来 带东西相同
        // KC
        // new  LGPerson new ->  return [callAlloc(self, false/*checkNil*/) init]; (alloc init)
        // init {  }

        // NSObject 为什么没有进去?
        NSObject *objc  = [NSObject alloc];

        LGPerson *objc1 = [LGPerson alloc];
        objc1.name      = @"Cooci";
        objc1.nickName  = @"KC";
        objc1.hobby     = 180;
        LGPerson *objc2 = [LGPerson alloc];

        NSLog(@"Hello, World! %@ - %@",objc1,objc2);
    }
    return 0;
}

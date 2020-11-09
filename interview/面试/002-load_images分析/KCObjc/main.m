//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "LGPerson.h"
#import "LGPerson+LG.h"

// 类的方法 - 分类的方法重名
// 如果调用 分类 attach 
// load

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        LGPerson *person = [LGPerson alloc];
        person.cate_name = @"KC";
        
        NSLog(@"%@",person);
    }
    return 0;
}

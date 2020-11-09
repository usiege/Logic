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
#import "LGPerson+LGA.h"
#import "LGPerson+LGB.h"

void sayHelloIMP(){
}

void LGEqlTriangle(int n, int head){
    int i;
    if (n >= 1) {
        LGEqlTriangle(n - 1, head + 1);
        for (i = 0; i < head; i++){
            putchar(' ');
        }
        for (i = 0; i < 2 * n - 1; i++){
            putchar('*');
        }
        putchar('\n');
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // insert code here...
        // 0x00007ffffffffff8ULL
        // class_data_bits_t bits;
        // class_rw_t *data()
        // 分类 data -> 类
        // methodlizeClass
        LGPerson *person = [LGPerson alloc];
        person.cate_name = @"KC"; // 
        [person cateA_1];
//        Method method = class_getClassMethod(LGPerson.class, @selector(kc_instanceMethod1));
//        class_addMethod(LGPerson.class, @selector(sayHello), (IMP)sayHelloIMP, method_getTypeEncoding(method));
//        
//        NSLog(@"%p",person);
    }
    return 0;
}

/**
 1: 主类 load  分类 load      全部 - load_image 加载到数据
 2: 主类 load  分类           data()
 3: 主类       分类           第一次消息的时候 data()
 4: 主类       分类 load      迫使主类提前加载  
 
 
 */



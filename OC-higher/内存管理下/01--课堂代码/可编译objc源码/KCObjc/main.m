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

extern void _objc_autoreleasePoolPrint(void);

//struct LGTest {
//    LGTest(){
//        printf("1123 - %s",__func__);
//    }
//    ~LGTest(){
//        printf("5667 - %s",__func__);
//    }
//};


// @autoreleasepool 怎么办?
/**
 struct __AtAutoreleasePool {
   __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
   ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
   void * atautoreleasepoolobj;
 };
 */
// objc_autoreleasePoolPush
// objc_autoreleasePoolPop
int main(int argc, const char * argv[]) {
    // __AtAutoreleasePool __autoreleasepool;
    // {} 作用域
    @autoreleasepool {
        // atautoreleasepoolobj = objc_autoreleasePoolPush();
        // objc_autoreleasePoolPop(atautoreleasepoolobj);
    }
    return 0;
}

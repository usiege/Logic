//
//  main.m
//  LGTest
//
//  Created by cooci on 2019/2/7.
//


#import <Foundation/Foundation.h>
#import "LGPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        LGPerson *objc = [[LGPerson alloc] init];
        NSLog(@"%zu",class_getInstanceSize([objc class])); // 24?
        NSLog(@"%zu",malloc_size((__bridge const void *)(objc)));
    }
    return 0;
}

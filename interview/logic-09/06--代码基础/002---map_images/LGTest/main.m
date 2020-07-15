//
//  main.m
//  LGTest
//
//  Created by cooci on 2019/2/7.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "LGperson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        LGperson *p = [LGperson alloc];
        [p instanceMethod];
        [LGperson classMethod];
    }
    return 0;
}

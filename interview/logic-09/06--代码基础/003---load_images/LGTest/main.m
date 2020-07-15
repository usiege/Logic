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
#import "LGStudent.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        LGperson *p = [LGperson alloc];
        [p instanceMethod];
        [LGperson classMethod];
        
//        LGStudent *s = [LGStudent alloc];
//        NSLog(@"end");
        
    }
    return 0;
}

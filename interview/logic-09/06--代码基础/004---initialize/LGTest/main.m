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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [LGPerson class];
        [LGStudent class];

    }
    return 0;
}

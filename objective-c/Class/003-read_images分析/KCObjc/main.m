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


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        LGPerson *person = [LGPerson alloc];
        NSLog(@"%p",person);
    }
    return 0;
}

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
        // 0x00007ffffffffff8ULL
        // class_data_bits_t bits;
        // class_rw_t *data()
        
        LGPerson *person = [LGPerson alloc];
        [person kc_instanceMethod1];
        NSLog(@"%p",person);
    }
    return 0;
}

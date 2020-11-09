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


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        LGPerson *person = [LGPerson alloc];
        person.cate_name = @"KC";
        
        NSLog(@"%@",person);
    }
    return 0;
}

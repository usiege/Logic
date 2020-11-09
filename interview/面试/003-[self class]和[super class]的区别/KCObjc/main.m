//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "LGPerson.h"
#import "LGTeacher.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        LGTeacher *teacher = [[LGTeacher alloc] init];;
        NSLog(@"%@",teacher);
    }
    return 0;
}

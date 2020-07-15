//
//  main.m
//  LGTest
//
//  Created by cooci on 2019/2/7.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"
#import "LGStudent.h"
#import "NSObject+LG.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[LGPerson alloc] init];
        [[LGStudent alloc] init];
    }
    return 0;
}

//
//  main.m
//  001-isKindOfClass&isMemberOfClass
//
//  Created by cooci on 2019/2/21.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
  
        BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
        BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
        BOOL re3 = [(id)[LGPerson class] isKindOfClass:[LGPerson class]];
        BOOL re4 = [(id)[LGPerson class] isMemberOfClass:[LGPerson class]];
        NSLog(@" re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);
    }
    return 0;
}

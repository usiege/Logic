//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"

extern void _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSObject *objc1 = [[[NSObject alloc] init] autorelease];
        
        // alloc/new/copy/mutablecopy 由系统管理释放 release 并不会加入到自动释放池!
        LGPerson *objc2 = [[LGPerson alloc] init];
        
        // taggedpointer string 并不会加入到自动释放池
        NSString *name1 = [NSString stringWithFormat:@"cooci_opppp"];
        
        NSString *name2 = @"cooci";

        NSString *name3 = @"cooci_autorelease";
        
        int age = 1000000000000000;
        
        NSNumber *num = @100000;
        
        NSLog(@"Hello, World! %@ - %@",objc1,objc2);
        _objc_autoreleasePoolPrint();

    }
    
    return 0;
}

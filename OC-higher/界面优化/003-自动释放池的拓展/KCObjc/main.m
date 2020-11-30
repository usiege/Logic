//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"

extern void _objc_autoreleasePoolPrint(void);

void demo2(){
    // 自动释放池子 嵌套情况
    @autoreleasepool {
        
        NSString *name = [NSString stringWithString:@"1222222"];
        NSObject *objc1 = [[[NSObject alloc] init] autorelease];
         _objc_autoreleasePoolPrint();
         @autoreleasepool {
             NSLog(@"*****1*******");
             NSObject *objc2 = [[[NSObject alloc] init] autorelease];
             NSObject *objc3 = [[[NSObject alloc] init] autorelease];
             _objc_autoreleasePoolPrint();
             @autoreleasepool {
                 NSObject *objc4 = [[[NSObject alloc] init] autorelease];
                 NSObject *objc5 = [[[NSObject alloc] init] autorelease];
                 NSObject *objc6 = [[[NSObject alloc] init] autorelease];
                 NSLog(@"****2********");
                 _objc_autoreleasePoolPrint();
             }
         }
        NSLog(@"*****3*******");
        _objc_autoreleasePoolPrint();
     }
}

void demo1(){
    __weak id weakObj = nil;
    {
//       LGPerson *person = [[LGPerson alloc] init];
        LGPerson *person = [LGPerson initString];
//        NSArray *array = @[@"cooci"];
//        NSArray *array2 = [array copy];
//        NSMutableArray *array3 = [array mutableCopy];
//        weakObj = person;
        NSLog(@"作用域:%@",person);
        _objc_autoreleasePoolPrint();
    }

    NSLog(@"viewDidLoad:%@",weakObj);
}

int main(int argc, const char * argv[]) {
    // 自动释放池子 嵌套情况
//    @autoreleasepool {
//        NSLog(@"NSThread = %@",[NSThread currentThread]);
//        LGPerson *objc1 = [[[LGPerson alloc] init] autorelease];
//        NSLog(@"objc1 = %@",objc1);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSLog(@"person - %@",[NSThread currentThread]);
//            LGPerson *objc2 = [[[LGPerson alloc] init] autorelease];
//            NSLog(@"objc2 = %@",objc2);
//            _objc_autoreleasePoolPrint();
//            NSLog(@"该有的信息我们都有了 线程做了事情 退出吧!!");
//        });
//
//        // [NSThread detachNewThreadSelector:@selector(childThreadDemo) toTarget:objc1 withObject:nil];
//        NSLog(@"**********************");
//
//        sleep(3);
//        _objc_autoreleasePoolPrint();
//     }
    demo2();
    while (1) {}

    return 0;
}



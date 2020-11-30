//
//  main.m
//  01-Runloop初探
//
//  Created by cooci on 2018/12/4.
//  Copyright © 2018 cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSLog(@"来了,老弟");
        // 和普通的循环 有区别 : runloop 
//        while (1) {
//            NSLog(@"hello");
//        }

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));;
    }
}

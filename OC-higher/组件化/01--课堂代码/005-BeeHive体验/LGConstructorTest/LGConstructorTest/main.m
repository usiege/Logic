//
//  main.m
//  LGConstructorTest
//
//  Created by LG on 2020/3/20.
//  Copyright © 2020 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSLog(@"main=====");
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

__attribute__((constructor)) static void lg_testFunc()
{
    printf("lg_testFunc\n");
}

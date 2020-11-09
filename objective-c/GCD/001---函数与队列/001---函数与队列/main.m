//
//  main.m
//  001---函数与队列
//
//  Created by Cooci on 2018/6/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pthread.h>
#import "AppDelegate.h"

void* pthreadTestMethod(void *);
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

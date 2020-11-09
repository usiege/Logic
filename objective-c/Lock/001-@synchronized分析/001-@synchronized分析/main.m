//
//  main.m
//  001-@synchronized分析
//
//  Created by Cooci on 2019/2/27.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        @synchronized (appDelegateClassName) {
        }
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

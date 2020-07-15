//
//  main.m
//  002---汇编优化
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int sum(int a, int b){
    return a+b;
}

int main(int argc, const char * argv[]) {
    int c = sum(10, 20);
    // w8 10
    // w9 20
    NSLog(@"Hello, World! - %d",c);
    return 0;
}

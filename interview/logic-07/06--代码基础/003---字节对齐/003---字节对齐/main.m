//
//  main.m
//  003---字节对齐
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LGPerson.h"
#import <objc/runtime.h>

int funcMethod(int num){
    return (num + 15) >> 4 << 4;
    
    // 0000 1101
    // 0000 0001
    // 0000 1000 // 1+7 = 8
    // 7 + 7  8 -- 16倍数
    //
    // name  age  8 + 4 = 12 --- person  --  16
    // 对象底层到底 开辟了多少
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSLog(@"%d",funcMethod(23));
        NSLog(@"%d",funcMethod(16));
        
        LGPerson *p = [LGPerson alloc];
        // name 8  age 4  -- 12  + 8 = 20 -- 24
        // 4 -- + 8 = 12 --> 16
        // 
        NSLog(@"%zu",class_getInstanceSize([p class])); // 24
        // 很多源码分析 技巧
        // 底层探索的 方式
        // 最根本 --- 001
        // 自己分析  --- 自己研究 --- 讲课的根本
        // 16倍数
        //
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

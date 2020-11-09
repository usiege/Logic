//
//  Person.m
//  002---NSthread线程操作
//
//  Created by Cooci on 2018/6/19.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)study:(id)time{
    for (int i = 0; i<[time intValue]; i++) {
        NSLog(@"%@ 开始学习了 %d分钟",[NSThread currentThread],i);
    }
}

@end

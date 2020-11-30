//
//  LGThread.m
//  02-Runloop与线程的关系
//
//  Created by cooci on 2018/12/5.
//  Copyright © 2018 cooci. All rights reserved.
//

#import "LGThread.h"

@implementation LGThread
- (void)dealloc{
    NSLog(@"%s---线程销毁了",__func__);
}
@end

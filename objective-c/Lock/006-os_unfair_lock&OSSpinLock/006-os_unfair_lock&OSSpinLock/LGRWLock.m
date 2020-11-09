//
//  LGRWLock.m
//  006-os_unfair_lock&OSSpinLock
//
//  Created by Cooci on 2020/3/1.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "LGRWLock.h"

@interface LGRWLock ()
// 定义一个并发队列:
@property (nonatomic, strong) dispatch_queue_t concurrent_queue;
// 用户数据中心, 可能多个线程需要数据访问:
@property (nonatomic, strong) NSMutableDictionary *dataCenterDic;
@end

@implementation LGRWLock

- (id)init{
    self = [super init];
    if (self){
        // 创建一个并发队列:
        self.concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据字典:
        self.dataCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - 读数据
- (id)lg_objectForKey:(NSString *)key{
    __block id obj;
    // 同步读取指定数据:
    dispatch_sync(self.concurrent_queue, ^{
        obj = [self.dataCenterDic objectForKey:key];
    });
    return obj;
}

#pragma mark - 写数据
- (void)lg_setObject:(id)obj forKey:(NSString *)key{
    // 异步栅栏调用设置数据:
    dispatch_barrier_async(self.concurrent_queue, ^{
        [self.dataCenterDic setObject:obj forKey:key];
    });
}

@end

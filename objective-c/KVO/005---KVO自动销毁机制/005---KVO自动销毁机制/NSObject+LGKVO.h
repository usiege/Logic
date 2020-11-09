//
//  NSObject+LGKVO.h
//  005---KVO自动销毁机制
//
//  Created by cooci on 2019/1/5.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LGKVOBlock)(id observer,NSString *keyPath,id oldValue,id newValue);

@interface NSObject (LGKVO)

- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath block:(LGKVOBlock)block;

- (void)lg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END

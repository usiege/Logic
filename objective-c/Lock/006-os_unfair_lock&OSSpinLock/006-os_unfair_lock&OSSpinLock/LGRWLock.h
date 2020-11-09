//
//  LGRWLock.h
//  006-os_unfair_lock&OSSpinLock
//
//  Created by Cooci on 2020/3/1.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGRWLock : NSObject
// 读数据
- (id)lg_objectForKey:(NSString *)key;
// 写数据
- (void)lg_setObject:(id)obj forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END

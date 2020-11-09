//
//  MyLock.h
//  004-NSCondition
//
//  Created by Qingqing on 2020/3/5.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyLock : NSObject
@property (nonatomic, copy) NSThread *thread;
@property (nonatomic, assign) int value;
@property (nonatomic, assign) int condition;
- (void)mylockWithCondition:(int)condition;
- (void)myUnlockWithCondition:(int)condition;
@end

NS_ASSUME_NONNULL_END

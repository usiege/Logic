//
//  LGPerson.h
//  006---FBKVOController探索
//
//  Created by cooci on 2019/3/6.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *mArray;
@end

NS_ASSUME_NONNULL_END

//
//  LGPerson.h
//  001---alloc&init底层探索
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@end

NS_ASSUME_NONNULL_END

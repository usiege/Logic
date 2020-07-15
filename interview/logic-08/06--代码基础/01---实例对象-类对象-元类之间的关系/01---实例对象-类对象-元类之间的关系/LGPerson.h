//
//  LGPerson.h
//  01---实例对象-类对象-元类之间的关系
//
//  Created by cooci on 2019/2/8.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END

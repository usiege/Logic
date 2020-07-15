//
//  LGPerson.h
//  003---字节对齐
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
// 8
@property (nonatomic, assign) int age; // 4
@property (nonatomic, copy) NSString *name; // 8
@property (nonatomic, assign) int height; // 4

@end

NS_ASSUME_NONNULL_END

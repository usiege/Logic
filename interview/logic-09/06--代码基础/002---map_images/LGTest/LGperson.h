//
//  LGperson.h
//  LGTest
//
//  Created by cooci on 2019/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGperson : NSObject
@property (nonatomic, assign) int age; // 4
@property (nonatomic, assign) double heigh;// 8
@property (nonatomic, assign) int index;

- (void)instanceMethod;
+ (void)classMethod;
@end

NS_ASSUME_NONNULL_END

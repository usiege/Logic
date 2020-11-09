//
//  LGPerson.h
//  004-内存平移问题
//
//  Created by cooci on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
@property (nonatomic, assign) int kc_name;
@property (nonatomic, copy) NSString *kc_hobby;  // 12
- (void)saySomething;
@end

NS_ASSUME_NONNULL_END

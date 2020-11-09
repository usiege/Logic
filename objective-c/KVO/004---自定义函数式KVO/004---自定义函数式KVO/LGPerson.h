//
//  LGPerson.h
//  004---自定义函数式KVO
//
//  Created by cooci on 2019/1/5.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject{
    @public
    NSString *name;
}
@property (nonatomic, copy) NSString *nickName;

+ (instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END

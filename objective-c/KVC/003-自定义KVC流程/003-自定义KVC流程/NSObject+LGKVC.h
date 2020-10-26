//
//  NSObject+LGKVC.h
//  03-自定义KVC流程
//
//  Created by Cooci on 2019/12/9.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGKVC)

// LG KVC 自定义入口
- (void)lg_setValue:(nullable id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END

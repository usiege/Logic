//
//  LGRuntimeTool.h
//  005---Runtime应用
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGRuntimeTool : NSObject
/**
 交换方法
 @param cls 交换对象
 @param oriSEL 原始方法编号
 @param swizzledSEL 交换的方法编号
 */
+ (void)lg_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL;
+ (void)lg_betterMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL;
@end

NS_ASSUME_NONNULL_END

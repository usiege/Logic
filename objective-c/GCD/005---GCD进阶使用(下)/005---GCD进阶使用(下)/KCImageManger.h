//
//  KCImageManger.h
//  004--GCD进阶使用
//
//  Created by Cooci on 2018/7/2.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageManger : NSObject

//单利的实现方式
+ (instancetype)manager;
+(instancetype)shareManager;
@end

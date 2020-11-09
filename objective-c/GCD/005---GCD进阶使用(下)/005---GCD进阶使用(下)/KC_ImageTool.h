//
//  KC_ImageTool.h
//  004--GCD进阶使用
//
//  Created by Cooci on 2018/6/22.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KC_ImageTool : NSObject
+ (UIImage *)kc_filterImage:(UIImage *)sourceImage;

/**
 给指定图片加文字水印
 
 @param text 文字
 @param backImage 背景图片
 @return 返回文字水印照片
 */
+ (UIImage *)kc_WaterImageWithText:(NSString *)text backImage:(UIImage *)backImage;
+ (UIImage *)kc_WaterImageWithWaterImage:(UIImage *)waterImage backImage:(UIImage *)backImage waterImageRect:(CGRect)rect;
@end

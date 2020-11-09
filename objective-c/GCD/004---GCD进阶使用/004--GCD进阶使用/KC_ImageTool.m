//
//  KC_ImageTool.m
//  004--GCD进阶使用
//
//  Created by Cooci on 2018/6/22.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KC_ImageTool.h"

@implementation KC_ImageTool


/**
 模糊图片

 @param sourceImage 源图
 @return 返回结果图片
 */
+ (UIImage *)kc_filterImage:(UIImage *)sourceImage{
    if (!sourceImage) {
        sourceImage = [UIImage imageNamed:@"backImage"];
    }
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [[CIImage alloc] initWithImage:sourceImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@10.0f forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *bluerImage = [UIImage imageWithCGImage:outImage];
    return bluerImage;
}

/**
 给指定图片加文字水印

 @param text 文字
 @param backImage 背景图片
 @return 返回文字水印照片
 */
+ (UIImage *)kc_WaterImageWithText:(NSString *)text backImage:(UIImage *)backImage{
    
    if (!backImage) {
        backImage = [UIImage imageNamed:@"backImage"];
    }
    NSDictionary *attDict = @{NSFontAttributeName:[UIFont systemFontOfSize:40],NSForegroundColorAttributeName:[UIColor whiteColor]};
    return [self kc_WaterImageWithImage:backImage text:text textPoint:CGPointZero attributedString:attDict];
}


// 给图片添加文字水印：
+ (UIImage *)kc_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
    
}


/**
 给指定图片加图片水印

 @param waterImage 水印图片
 @param rect 位置
 @return 返回图片水印照片
 */

+ (UIImage *)kc_WaterImageWithWaterImage:(UIImage *)waterImage backImage:(UIImage *)backImage waterImageRect:(CGRect)rect{
    
    UIImage *newBackImage = backImage;
    if (!newBackImage) {
        newBackImage = [UIImage imageNamed:@"backImage"];
    }
    return [self kc_WaterImageWithImage:newBackImage waterImage:waterImage waterImageRect:rect];
}

// 给图片添加图片水印
+ (UIImage *)kc_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    //1.获取图片
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


@end

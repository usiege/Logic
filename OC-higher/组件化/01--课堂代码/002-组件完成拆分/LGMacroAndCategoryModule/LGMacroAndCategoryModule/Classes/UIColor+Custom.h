//
//  UIColor+Custom.h
//  LGVideo
//
//  Created by LG on 09/12/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

+ (instancetype)colorWithHexString:(NSString *)hexStr;

+ (instancetype)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;



@end

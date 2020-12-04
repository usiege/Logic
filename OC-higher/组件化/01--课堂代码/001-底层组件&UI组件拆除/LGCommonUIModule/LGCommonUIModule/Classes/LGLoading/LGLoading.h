//
//  LGLoading.h
//  LGVideo
//
//  Created by LG on 2018/7/14.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGLoading : UIView

@property (assign, nonatomic) IBInspectable CGFloat lineWidth;
@property (strong, nonatomic) IBInspectable UIColor *lineColor;

+ (instancetype)defaultLoading;
- (void)startLoading;
- (void)stopLoading;

@end

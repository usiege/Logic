//
//  LGPlayerUtils.h
//  LGVideo
//
//  Created by LG on 2018/5/20.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGPlayerUtils : NSObject
@property (assign,nonatomic) float volume;

+ (instancetype)sharedUtils;
+ (float)getSystemVolume;
+ (void)setSystemVolume:(float)volume;

+ (void)setSystemBrightness:(CGFloat)brightness;
@end

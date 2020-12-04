//
//  NSString+Custom.m
//  LGVideo
//
//  Created by LG on 2018/5/20.
//  Copyright © 2018 LG. All rights reserved.
//

#import "NSString+Custom.h"

@implementation NSString (Custom)

+ (instancetype)timeformatFromSeconds:(NSTimeInterval)seconds {
    int minute = (int)seconds/60;
    int second = (int)seconds%60;
    if (minute < 100) {
        NSString *time = [NSString stringWithFormat:@"%.2d:%.2d", minute, second];
        return time;
    } else {
        NSString *time = [NSString stringWithFormat:@"%d:%.2d", minute, second];
        return time;
    }
}

@end

//
//  UIButton+Custom.m
//  LGVideo
//
//  Created by LG on 2018/7/2.
//  Copyright © 2018 LG. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

- (void)scaleAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.12 animations:^{
                self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.12 animations:^{
                    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }];
        }];
    }];
}

@end

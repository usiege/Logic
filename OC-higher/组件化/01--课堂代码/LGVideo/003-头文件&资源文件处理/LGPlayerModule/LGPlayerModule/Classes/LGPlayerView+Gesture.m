//
//  LGPlayerView+Gesture.m
//  LGVideo
//
//  Created by LG on 2018/5/19.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView+Gesture.h"
#import "LGPlayerUtils.h"

@implementation LGPlayerView (Gesture)

- (void)setupGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(panGestureAction:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
}

- (void)disableGesture {
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [self removeGestureRecognizer:obj];
    }];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.originalLocation = [recognizer locationInView:self];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentLocation = [recognizer locationInView:self];
        CGFloat offset_x = currentLocation.x - self.originalLocation.x;
        CGFloat offset_y = currentLocation.y - self.originalLocation.y;
        if (CGPointEqualToPoint(self.originalLocation,CGPointZero)) {
            self.originalLocation = currentLocation;
            return;
        }
        CGRect frame = self.bounds;
        if (ABS(offset_x) > ABS(offset_y)
            && self.originalLocation.x < frame.size.width
            && self.originalLocation.y < frame.size.height
            && ABS(offset_x) > 0
            && self.gestureType != LGPlayerControlViewGestureTypeVolume
            && self.gestureType != LGPlayerControlViewGestureTypeBrightness) {      // 滑动控制播放进度
            self.originalLocation = currentLocation;
            self.gestureType = LGPlayerControlViewGestureTypeProgress;
            [self.controlView showLoadingView:@"进度 +" animation:NO];
        } else if (ABS(offset_x) <= ABS(offset_y)
                   && self.originalLocation.x < frame.size.width
                   && self.originalLocation.y < frame.size.height
                   && ABS(offset_y) > 0
                   && self.gestureType != LGPlayerControlViewGestureTypeProgress) {      // 滑动控制音量,亮度
            self.originalLocation = currentLocation;
            switch (self.gestureType) {
                case LGPlayerControlViewGestureTypeNone:{
                    if (currentLocation.x <= LGScreenWidth / 2) {
                        self.gestureType = LGPlayerControlViewGestureTypeBrightness;
                    } else {
                        self.gestureType = LGPlayerControlViewGestureTypeVolume;
                    }
                }break;
                case LGPlayerControlViewGestureTypeVolume:{
                    float volumeOffset = (offset_y/self.frame.size.height)* 1.5;
                    [LGPlayerUtils setSystemVolume:[LGPlayerUtils getSystemVolume] - volumeOffset];
                    [self.controlView showLoadingView:offset_y > 0 ? @"音量 -" : @"音量 +" animation:NO];
                }break;
                case LGPlayerControlViewGestureTypeBrightness:{
                    CGPoint trasnlation = [recognizer translationInView:self];
                    [LGPlayerUtils setSystemBrightness:-trasnlation.y/200];
                    [self.controlView showLoadingView:offset_y > 0 ? @"亮度 -" : @"亮度 +" animation:NO];
                }break;
                default:
                    break;
            }
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        [self.controlView hideLoadingView:nil animation:YES];
        self.gestureType = LGPlayerControlViewGestureTypeNone;
    }
}

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.player.rate = 2.0;
        [self.controlView showLoadingView:@"快速播放" animation:YES];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.player.rate = 1.0;
        [self.controlView hideLoadingView:@"正常播放" animation:YES];
    }
}

#pragma mark - touches
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = ((UITouch*)(touches.anyObject)).tapCount;
    if (tapCount == 1) {
        [self performSelector:@selector(singleTouchAction:) withObject:touch afterDelay:0.3f];
    } else if (tapCount == 2) {
        if (self.player.rate == 1) {
            [self.player pause];
        } else if (self.player.rate == 0) {
            [self.player play];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)singleTouchAction:(UITouch *)touch {
    BOOL hide = ![self.controlView controlHidden];
    [self.controlView setControlHidden:hide];
}
@end

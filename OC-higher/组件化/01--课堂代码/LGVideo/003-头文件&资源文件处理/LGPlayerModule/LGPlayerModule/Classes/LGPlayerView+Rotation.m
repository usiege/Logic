//
//  LGPlayerView+Rotation.m
//  LGVideo
//
//  Created by LG on 2018/5/19.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView+Rotation.h"

@implementation LGPlayerView (Rotation)

- (void)setupRotation {
    [self setOrientation:[self getDeviceCurrentOrientation] animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChangeNotif:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)disableRotation {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)forceDeviceSetOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        [UIViewController attemptRotationToDeviceOrientation];
    }
}

- (void)setOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    CGRect frame = CGRectZero;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        frame = CGRectMake(0, 0, self.portraitSize.width, self.portraitSize.height);
    } else {
        frame = CGRectMake(0, 0, self.landscapeSize.width, self.landscapeSize.height);
    }
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        self.frame = frame;
        self.playerLayer.frame = self.bounds;
        self.controlView.frame = self.bounds;
        LGLog(@"%@", NSStringFromCGRect(self.bounds));
    }];
    self.lastOrientation = orientation;
    [self forceDeviceSetOrientation:orientation];
    self.controlView.fullscreen = !UIInterfaceOrientationIsPortrait(orientation);
    [self layoutIfNeeded];
}

- (UIInterfaceOrientation)getDeviceCurrentOrientation {
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationPortrait;
        case UIDeviceOrientationLandscapeLeft:
            return UIInterfaceOrientationLandscapeRight;
        case UIDeviceOrientationLandscapeRight:
            return UIInterfaceOrientationLandscapeLeft;
        default:
            return self.lastOrientation;
    }
}

- (void)orientationDidChangeNotif:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [self getDeviceCurrentOrientation];
    if (orientation == self.lastOrientation) {
        return;
    }
    [self setOrientation:orientation animated:YES];
}
@end

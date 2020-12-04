//
//  LGPlayerView+Gesture.h
//  LGVideo
//
//  Created by LG on 2018/5/19.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView.h"

@interface LGPlayerView (Gesture) <UIGestureRecognizerDelegate>

- (void)setupGesture;
- (void)disableGesture;

@end

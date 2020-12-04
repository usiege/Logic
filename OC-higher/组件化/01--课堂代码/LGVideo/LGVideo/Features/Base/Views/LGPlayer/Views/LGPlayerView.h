//
//  LGPlayerView.h
//  LGVideo
//
//  Created by LG on 2018/5/17.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LGPlayerControlView.h"
#import "LGPlayerSource.h"

typedef NS_ENUM(NSInteger, LGPlayerControlViewGestureType) {
    LGPlayerControlViewGestureTypeNone = 0,
    LGPlayerControlViewGestureTypeBrightness,
    LGPlayerControlViewGestureTypeVolume,
    LGPlayerControlViewGestureTypeProgress,
    LGPlayerControlViewGestureTypeError,
};

@interface LGPlayerView : UIView

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) LGPlayerSource *playerSource;

@property (assign, nonatomic) CGSize portraitSize;
@property (assign, nonatomic) CGSize landscapeSize;

@property (nonatomic, strong) LGPlayerControlView *controlView;
@property (assign, nonatomic) UIInterfaceOrientation lastOrientation;
@property (assign, nonatomic) CGPoint originalLocation;
@property (assign, nonatomic) LGPlayerControlViewGestureType gestureType;

- (void)loadVideo:(NSString *)videoId;

@end

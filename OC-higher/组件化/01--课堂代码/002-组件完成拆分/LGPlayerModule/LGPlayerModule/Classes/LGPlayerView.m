//
//  LGPlayerView.m
//  LGVideo
//
//  Created by LG on 2018/5/17.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView.h"
#import "LGPlayerView+Rotation.h"
#import "LGPlayerView+Gesture.h"
#import "LGPlayerView+Cast.h"

@interface LGPlayerView () <LGPlayerControlViewDelegate>

@property (strong, nonatomic) id playerObserver;
@property (strong, nonatomic) AVPlayerItem *playerItem;

@end

@implementation LGPlayerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.playerSource = [LGPlayerSource new];
        
        self.controlView = [LGPlayerControlView loadFromNib];
        self.controlView.delegate = self;
        [self addSubview:self.controlView];

        self.portraitSize = CGSizeMake(LGScreenWidth, LGScreenWidth*9/16);
        self.landscapeSize = CGSizeMake(LGScreenHeight, LGScreenWidth);
        [self setupRotation];
        [self setupGesture];
        [self setupCast];
    }
    return self;
}

- (void)loadVideo:(NSString *)videoId {
    [self.playerSource getPlayerVideoUrl:videoId completion:^(LGPlayerVideoUrlResponse *response) {
        [self startLoadVideo];
    }];
}

- (void)startLoadVideo {
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
    }
    LGPlayerVideoUrlItem *item = self.playerSource.videoInfo.data.firstObject;
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.url]];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.player) {
        [self.player removeTimeObserver:self.playerObserver];
        self.playerObserver = nil;
    }
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self observePlayback];

    if (self.playerLayer) {
        [self.playerLayer removeFromSuperlayer];
    }
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    
    [self.controlView showLoadingView:nil animation:NO];
    [self.controlView.definitionButton setTitle:item.definition forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        self.playerItem = nil;
    }
    if (self.playerObserver) {
        [self.player removeTimeObserver:self.playerObserver];
        self.playerObserver = nil;
    }
}
#pragma mark kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self.playerItem && [keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case AVPlayerItemStatusUnknown:{
                NSLog(@"AVPlayerItemStatusUnknown");
            }break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"AVPlayerItemStatusReadyToPlay");
                [self.player play];
                [self.controlView setPlaying:YES];
                [self.controlView hideLoadingView:nil animation:YES];
                break;
            case AVPlayerItemStatusFailed:{
                LGLog(@"AVPlayerItemStatusFailed :%@", self.playerItem.error);
            }break;
            default:
                break;
        }
    }
    if (object == self.player && [keyPath isEqualToString:@"externalPlaybackActive"]) {
        
    }
}

- (void)observePlayback {
    __weak __typeof(self) wSelf = self;
    [self.player removeTimeObserver:self.playerObserver];
    self.playerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        if (CMTIME_IS_NUMERIC(wSelf.playerItem.currentTime) && CMTIME_IS_NUMERIC(wSelf.playerItem.duration)) {
            CGFloat current = wSelf.playerItem.currentTime.value/wSelf.playerItem.currentTime.timescale;
            CGFloat duration = wSelf.playerItem.duration.value/wSelf.playerItem.duration.timescale;
//            LGLog(@"current:%f duration:%f", current, duration);
            wSelf.controlView.progressSlider.value = current;
            wSelf.controlView.progressSlider.maximumValue = duration;
            wSelf.controlView.currentTimeLabel.text = [NSString timeformatFromSeconds:current];
            wSelf.controlView.totalTimeLabel.text = [NSString timeformatFromSeconds:duration];
        }
    }];
}

#pragma mark - player control view delegate
- (void)controlView:(LGPlayerControlView *)controlView event:(LGPlayerControlViewEvent)event {
    switch (event) {
        case LGPlayerControlViewEventBack:
//            [[LGMediator currentViewController].navigationController popViewControllerAnimated:YES];
            break;
        case LGPlayerControlViewEventCast:
            [self showCastDevicesView];
            break;
        case LGPlayerControlViewEventDefinition:
            
            break;
        case LGPlayerControlViewEventPlay:
            [self.player play];
            [self.controlView setPlaying:YES];
            break;
        case LGPlayerControlViewEventPause:
            [self.player pause];
            [self.controlView setPlaying:NO];
            break;
        case LGPlayerControlViewEventNext:
            
            break;
        case LGPlayerControlViewEventSeek:
            [self.player seekToTime:CMTimeMake(self.controlView.progressSlider.value, 1.)];
            break;
        case LGPlayerControlViewEventSmallscreen:
            [self setOrientation:UIInterfaceOrientationPortrait animated:YES];
            break;
        case LGPlayerControlViewEventFullscreen:
            [self setOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            break;
        case LGPlayerControlViewEventChangeCastDevice:
            [self changeCastDevice];
            break;
        case LGPlayerControlViewEventStopCast:
            [self stopCast];
            break;
        default:
            break;
    }
}
@end

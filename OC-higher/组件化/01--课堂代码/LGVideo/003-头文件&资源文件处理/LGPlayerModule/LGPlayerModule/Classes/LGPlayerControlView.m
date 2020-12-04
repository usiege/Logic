//
//  LGPlayerControlView.m
//  LGVideo
//
//  Created by LG on 2018/5/17.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerControlView.h"
#import "LGCastManager.h"

static NSInteger kLGPlayerControlViewButtonTagOffset = 1027;
@interface LGPlayerControlView ()

@end

@implementation LGPlayerControlView

+ (instancetype)loadFromNib {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for (id view in views) {
        if (view && [view isKindOfClass:[self class]]) {
            return view;
        }
    }
    return nil;
}

- (void)customForDiscovery {
    _backButton.hidden = YES;
    _titleLabel.hidden = YES;
    _definitionButton.hidden = YES;
    _castButton.hidden = YES;
    
    _nextButton.hidden = YES;
    [_nextButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];
    
    _fullscreenButton.hidden = YES;
    [_fullscreenButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _backButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventBack;
    _definitionButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventDefinition;
    _playButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventPlay;
    _nextButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventNext;
    _progressSlider.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventSeek;
    _definitionButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventDefinition;
    _castButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventCast;
    _fullscreenButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventFullscreen;
    _changeCastDeviceButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventChangeCastDevice;
    _stopCastButton.tag = kLGPlayerControlViewButtonTagOffset + LGPlayerControlViewEventStopCast;
    
    _titleLabel.hidden = YES;
    [_progressSlider setThumbImage:[UIImage imageNamed:@"qymovie_play_progressBar"] forState:UIControlStateNormal];
    
    [self setControlHidden:YES];
}

- (void)setFullscreen:(BOOL)fullscreen {
    _fullscreen = fullscreen;
    _titleLabel.hidden = !fullscreen;
    _definitionButton.hidden = !fullscreen;
}

- (void)setPlaying:(BOOL)playing {
    _playing = playing;
    [_playButton setImage:[UIImage imageNamed:playing ? @"qymovie_play_pause" : @"qymovie_play_play"] forState:UIControlStateNormal];
}

- (void)setControlHidden:(BOOL)controlHidden {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlDelay) object:nil];
    
    _controlHidden = controlHidden;
    CGFloat alpha = controlHidden ? 0 : 1;
    [UIView animateWithDuration:0.3 animations:^{
        _navView.alpha = alpha;
        _controlView.alpha = alpha;
    } completion:^(BOOL finished) {
        _navView.hidden = controlHidden;
        _controlView.hidden = controlHidden;
    }];
    
    if (controlHidden == NO) {
        [self performSelector:@selector(hideControlDelay) withObject:nil afterDelay:5.];
    }
}

- (void)hideControlDelay {
    [self setControlHidden:YES];
}

- (void)showLoadingView:(NSString *)tips animation:(BOOL)anime {
    [_loadingIndicator startLoading];
    if (tips) {
        _videoNameLabel.text = tips;
    }
    if (anime) {
        _loadingView.alpha = 0;
        _loadingView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _loadingView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        _loadingView.alpha = 1;
        _loadingView.hidden = NO;
    }
}

- (void)hideLoadingView:(NSString *)tips animation:(BOOL)anime {
    [_loadingIndicator stopLoading];
    if (tips) {
        _videoNameLabel.text = tips;
    }
    if (anime) {
        [UIView animateWithDuration:0.5 delay:1. options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _loadingView.alpha = 0;
        } completion:^(BOOL finished) {
            _loadingView.hidden = YES;
            _loadingView.alpha = 1;
        }];
    } else {
        _loadingView.hidden = YES;
        _loadingView.alpha = 1;
    }
}

- (void)updateCastState:(LGCastState)state {
    _castStateLabel.text = [NSString stringWithFormat:@"正在 %@ 上播放", [LGCastManager sharedManager].currentDevice.name];
    switch (state) {
        case LGCastState_Connecting:{
            _castControlView.hidden = NO;
            
            _playButton.enabled = NO;
            _controlView.alpha = 0;
            _navView.alpha = 0;
        }break;
        case LGCastState_Playing:{
            _castControlView.hidden = NO;
            
            _playButton.enabled = YES;
            _playButton.hidden = NO;
            _controlView.alpha = 1;
            _navView.alpha = 1;
        }break;
        case LGCastState_Paused:{
            _castControlView.hidden = NO;
            
            _playButton.enabled = YES;
            _playButton.hidden = NO;
            _controlView.alpha = 1;
            _navView.alpha = 1;
        }break;
        case LGCastState_Failed:{
            _castControlView.hidden = NO;
    
            _controlView.alpha = 0;
            _navView.alpha = 0;
        }break;
        case LGCastState_Stopped:
        case LGCastState_Dismissed:{
            _castControlView.hidden = YES;
        }break;
        default:
            break;
    }
}

- (IBAction)buttonAction:(UIControl *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(controlView:event:)]) {
        LGPlayerControlViewEvent event = sender.tag - kLGPlayerControlViewButtonTagOffset;
        if ((event == LGPlayerControlViewEventFullscreen ||
             event == LGPlayerControlViewEventBack) && _fullscreen) {
            event = LGPlayerControlViewEventSmallscreen;
        } else if (event == LGPlayerControlViewEventPlay && _playing) {
            event = LGPlayerControlViewEventPause;
        }
        [_delegate controlView:self event:event];
    }
}

@end

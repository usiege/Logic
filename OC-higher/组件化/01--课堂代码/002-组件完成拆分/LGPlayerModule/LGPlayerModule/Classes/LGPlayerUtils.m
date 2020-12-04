//
//  LGPlayerUtils.m
//  LGVideo
//
//  Created by LG on 2018/5/20.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerUtils.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAudioSession.h>

static NSString *kSystemVolumeChangeKey = @"AVSystemController_SystemVolumeDidChangeNotification";

@interface LGPlayerUtils () {
    MPVolumeView    *_volumeView;
    UISlider        *_volumeSlider;
}
@end

@implementation LGPlayerUtils
+ (instancetype)sharedUtils {
    static dispatch_once_t onceToken;
    static id _sharedUtils = nil;
    dispatch_once(&onceToken, ^{
        _sharedUtils = [[LGPlayerUtils alloc] init];
    });
    return _sharedUtils;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self  configureSystemVolume];
    }
    return self;
}

- (void)configureSystemVolume {
    _volumeView = [[MPVolumeView alloc]init];
    _volumeView.showsRouteButton = NO;
    _volumeView.showsVolumeSlider = NO;
    for (UIView *view in [_volumeView subviews]){
        if ([[view.class description] isEqualToString:@"MPVolumeSlider"]){
            _volumeSlider = (UISlider*)view;
            break;
        }
    }
    
    _volume = [[AVAudioSession sharedInstance] outputVolume];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)
                                                 name:kSystemVolumeChangeKey
                                               object:nil];
}


- (void)setVolume:(float)volume{
    _volumeSlider.value = volume;
    _volume = _volumeSlider.value;
}

-(void)volumeChanged:(NSNotification *)notification {
    float volumeValue = [[[notification userInfo] objectForKey:kSystemVolumeChangeKey] floatValue];
    _volume = volumeValue;
}

+ (float)getSystemVolume {
    return [LGPlayerUtils sharedUtils].volume;
}

+ (void)setSystemVolume:(float)volume {
    [LGPlayerUtils sharedUtils].volume = volume;
}

+ (void)setSystemBrightness:(CGFloat)brightness {
    float new = UIScreen.mainScreen.brightness + brightness;
    if (new < 0.0001f) {
        new = 0.f;
    }else{
        new = new > 1.f ? 1.f : new;
    }
    UIScreen.mainScreen.brightness = new;
}
@end

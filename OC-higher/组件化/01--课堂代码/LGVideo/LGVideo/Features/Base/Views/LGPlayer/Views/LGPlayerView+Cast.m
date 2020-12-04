//
//  LGPlayerView+Cast.m
//  LGVideo
//
//  Created by LG on 2018/5/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView+Cast.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LGDLNAViewController.h"

@interface LGPlayerView (Cast) <LGCastManagerDelegate, LGDLNAViewControllerDelegate>
@end

@implementation LGPlayerView (Cast)

- (void)setupCast {
    [LGCastManager sharedManager].delegate = self;

}

- (void)showCastDevicesView {
    LGDLNAViewController *vc = [LGDLNAViewController new];
    vc.delegate = self;
    [[LGMediator currentViewController].navigationController pushViewController:vc animated:YES];
}

- (void)changeCastDevice {
    LGCastDevice *device = [LGCastManager sharedManager].currentDevice;
    if (device.deviceType == LGCast_AirPlay) {
        [self showAirPlayPicker];
    } else {
        [self showCastDevicesView];
    }
}

- (void)stopCast {
    LGCastDevice *device = [LGCastManager sharedManager].currentDevice;
    if (device.deviceType == LGCast_AirPlay) {
        [self showAirPlayPicker];
    } else {
        [[LGCastManager sharedManager] stop];
    }
}

- (void)updateCastState:(LGCastState)state {
    [self.controlView updateCastState:state];
    switch (state) {
        case LGCastState_Connecting:{
            [self.player pause];
        }break;
        case LGCastState_Playing:{
            [self.player pause];
        }break;
        case LGCastState_Paused:{
        }break;
        case LGCastState_Failed:{
        }break;
        case LGCastState_Stopped:{
            
        }break;
        case LGCastState_Dismissed:{
            [self.player play];
        }break;
        default:
            break;
    }
}

- (void)showAirPlayPicker {
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
    volumeView.showsVolumeSlider = NO;
    volumeView.showsRouteButton = NO;
    [self addSubview:volumeView];
    
    SEL showSel = NSSelectorFromString(@"_displayAudioRoutePicker");
    if (showSel && [volumeView respondsToSelector:showSel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [volumeView performSelector:showSel];
#pragma clang diagnostic pop
    }
    
    [volumeView removeFromSuperview];
}

#pragma mark dlna viewcontroller
- (void)didChooseCastDevice:(LGCastDevice *)device {
    if (device.deviceType == LGCast_AirPlay) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showAirPlayPicker];
        });
    } else if (device.deviceType == LGCast_DLNA) {
        LGPlayerVideoUrlItem *item = self.playerSource.videoInfo.data.firstObject;
        [LGCastManager sharedManager].currentDevice = device;
        [[LGCastManager sharedManager] castUrl:item.url];
    }
}

#pragma mark - cast manager delegate
- (void)manager:(LGCastManager *)manager didUpdateState:(LGCastState)state {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf updateCastState:state];
    });
}

- (void)manager:(LGCastManager *)manager didUpdateDevice:(LGCastDevice *)device {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.controlView.progressSlider.value = device.position;
    });
}

- (void)manager:(LGCastManager *)manager didUpdateDevices:(NSArray *)devices {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}
@end

//
//  LGCastManager.m
//  LGVideo
//
//  Created by LG on 2018/6/3.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGCastManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "CLUPnP.h"

@interface LGCastDevice ()
@property(nonatomic,strong) CLUPnPRenderer *renderer;
@end

@implementation LGCastDevice
- (instancetype)initWithRenderer:(CLUPnPRenderer *)renderer {
    if (self = [super init]) {
        self.renderer = renderer;
        self.uuid = renderer.model.uuid;
        self.name = renderer.model.friendlyName;
        self.renderer.delegate = [LGCastManager sharedManager];
        self.deviceType = LGCast_DLNA;
    }
    return self;
}
- (void)setURI:(NSString *)uri {
    [self.renderer setAVTransportURL:uri];
}
- (void)play {
    [self.renderer play];
}
- (void)pause {
    [self.renderer pause];
}
- (void)seek:(CGFloat)position {
    [self.renderer seek:position];
}
- (void)stop {
    [self.renderer stop];
}
@end

@interface LGCastManager () <CLUPnPServerDelegate, CLUPnPResponseDelegate> {

}
@property (nonatomic, strong) CLUPnPServer *searcher;
@property (nonatomic, strong) NSMutableArray *devicesArr;
@end

@implementation LGCastManager

static LGCastManager *singleton = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {
        _devicesArr = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionRouteChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
        
        _searcher = [CLUPnPServer shareServer];
        _searcher.delegate = self;
        _searcher.searchTime = 30;
        [_searcher start];
    }
    return self;
}

- (BOOL)isCasting {
    switch (self.currentState) {
        case LGCastState_Connecting:
        case LGCastState_Playing:
        case LGCastState_Paused:
        case LGCastState_Stopped:
        case LGCastState_Failed:
            return YES;
            break;
        case LGCastState_Dismissed:
        default:
            return NO;
            break;
    }
}

- (void)updateDevice {
    if ([_delegate respondsToSelector:@selector(manager:didUpdateDevice:)]) {
        [_delegate manager:self didUpdateDevice:self.currentDevice];
    }
}

- (void)updateDevices {
    if ([_delegate respondsToSelector:@selector(manager:didUpdateDevices:)]) {
        [_delegate manager:self didUpdateDevices:[self availableDevices]];
    }
}

- (void)updateState:(LGCastState)state {
    if (self.currentState == state) {
        return;
    }
    self.currentState = state;
    if ([_delegate respondsToSelector:@selector(manager:didUpdateState:)]) {
        [_delegate manager:self didUpdateState:state];
    }
}
#pragma mark - AirPlay
- (void)audioSessionRouteChanged:(NSNotification *)notification {
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    AVAudioSessionRouteDescription* currentRoute = audioSession.currentRoute;
    for (AVAudioSessionPortDescription* outputPort in currentRoute.outputs) {
        if ([outputPort.portType isEqualToString:AVAudioSessionPortAirPlay]) {
            LGCastDevice *device = [LGCastDevice new];
            device.uuid = outputPort.UID;
            device.name = outputPort.portName;
            device.deviceType = LGCast_AirPlay;
            self.currentDevice = device;
            [self updateState:LGCastState_Connecting];
            return;
        }
    }
    self.currentDevice = nil;
    [self updateState:LGCastState_Dismissed];
}

#pragma mark - DLNA
- (NSArray *)availableDevices {
    return _devicesArr.copy;
}

- (void)searchForDevices {
    [_searcher search];
}

//投屏
- (void)castUrl:(NSString *)videoUrl {
    [self.currentDevice setURI:videoUrl];
}

//播放
- (void)play {
    [self.currentDevice play];
}

//暂停
- (void)pause {
    [self.currentDevice pause];
}

//seek
- (void)seekPosition:(float)position {
    [self.currentDevice seek:position];
}

//停止
- (void)stop {
    [self.currentDevice stop];
    [self updateState:LGCastState_Dismissed];
    self.currentDevice = nil;
    self.currentVideoUrl = nil;
}

#pragma mark - CLUPnPServerDelegate
- (void)upnpSearchChangeWithResults:(NSArray<CLUPnPDevice *> *)devices {
    NSMutableArray *tempArr = [NSMutableArray new];
    for (CLUPnPDevice *device in devices) {
        if (device.AVTransport &&  device.AVTransport.serviceType.length > 0) {
            CLUPnPRenderer *renderer = [[CLUPnPRenderer alloc] initWithModel:device];
            [tempArr addObject:[[LGCastDevice alloc] initWithRenderer:renderer]];
        }
    }
    self.devicesArr = tempArr;
    [self.delegate manager:self didUpdateDevices:tempArr];
}

- (void)upnpSearchErrorWithError:(NSError *)error {
    LGLog(@"%@", error);
}

#pragma mark - CLUPnPResponseDelegate
// 投屏响应
- (void)upnpSetAVTransportURIResponse{
    [self.currentDevice play]; //某些设备必须手动设置播放
    LGLog(@"DLNA");
}

// 播放状态
- (void)upnpGetTransportInfoResponse:(CLUPnPTransportInfo *)info{
    LGLog(@"DLNA: state:%@ status:%@", info.currentTransportState, info.currentTransportStatus);
    LGCastState currentState = self.currentState;
    if (currentState == LGCastState_Dismissed) {
        return;
    }
    NSString *newState =  info.currentTransportState;
    if ([newState isEqualToString:@"STOPPED"]) {
        currentState = LGCastState_Stopped;
    } else if ([newState isEqualToString:@"PAUSED_PLAYBACK"] || [newState isEqualToString:@"PAUSED"]) {
        currentState = LGCastState_Paused;
    } else if ([newState isEqualToString:@"PLAYING"]) {
        currentState = LGCastState_Playing;
    } else if ([newState isEqualToString:@"TRANSITIONING"]) {
        currentState = LGCastState_Connecting;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate manager:self didUpdateState:currentState];
    });
}

// 播放
- (void)upnpPlayResponse {
    LGLog(@"DLNA: play");
    [self.delegate manager:self didUpdateState:LGCastState_Playing];
}

// 暂停
- (void)upnpPauseResponse {
    LGLog(@"DLNA: pause");
    [self.delegate manager:self didUpdateState:LGCastState_Paused];
}

//seek
- (void)upnpSeekResponse {
    LGLog(@"DLNA: seek");
}

// 停止
- (void)upnpStopResponse {
    LGLog(@"DLNA: stop");
}

// 获取播放进度时长等信息
- (void)upnpGetPositionInfoResponse:(CLUPnPAVPositionInfo *)info {
    LGLog(@"DLNA:%.1f %.1f",info.trackDuration,info.relTime);
    if (self.currentState == LGCastState_Playing){
        if (info.trackDuration == 0) return;
        self.currentDevice.duration = info.trackDuration;
        self.currentDevice.position = info.relTime;
        [self.delegate manager:self didUpdateDevice:self.currentDevice];
    }
}

- (void)upnpUndefinedResponse:(NSString *)resXML postXML:(NSString *)postXML {
    LGLog(@"DLNA:response:%@\n request:%@",resXML,postXML);
}
@end

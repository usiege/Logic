//
//  LGCastManager.h
//  LGVideo
//
//  Created by LG on 2018/6/3.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LGCastState) {
    LGCastState_None,
    LGCastState_Connecting,
    LGCastState_Playing,
    LGCastState_Paused,
    LGCastState_Stopped,
    LGCastState_Failed,
    LGCastState_Dismissed,
};

typedef NS_ENUM(NSUInteger, LGCastType) {
    LGCast_AirPlay = 1,
    LGCast_DLNA,
};

@class LGCastDevice, LGCastManager;
@protocol LGCastManagerDelegate <NSObject>
@optional
//发现新设备
- (void)manager:(LGCastManager *)manager didUpdateDevices:(NSArray *)devices;
//投放设备有更新
- (void)manager:(LGCastManager *)manager didUpdateDevice:(LGCastDevice *)device;
//投放状态有更新
- (void)manager:(LGCastManager *)manager didUpdateState:(LGCastState)state;
@end

@interface LGCastDevice : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, assign) NSUInteger position;
@property (nonatomic, assign) NSUInteger duration;
@property (nonatomic, assign) LGCastType deviceType;
- (void)setURI:(NSString *)uri;
- (void)play;
- (void)pause;
- (void)seek:(CGFloat)position;
- (void)stop;
@end

@interface LGCastManager : NSObject
@property (class, readonly, strong) LGCastManager *sharedManager;
@property (nonatomic, weak) id<LGCastManagerDelegate> delegate;
@property (nonatomic, assign) NSString *currentVideoUrl;
@property (nonatomic, assign) LGCastState currentState;
@property (nonatomic, strong) LGCastDevice *currentDevice;
@property (nonatomic, assign) BOOL isCasting;

//有效设备
- (NSArray *)availableDevices;
//搜索设备
- (void)searchForDevices;
//投屏
- (void)castUrl:(NSString *)videoUrl;
//播放
- (void)play;
//暂停
- (void)pause;
//seek
- (void)seekPosition:(float)position;
//停止
- (void)stop;
@end

//
//  LGPlayerControlView.h
//  LGVideo
//
//  Created by LG on 2018/5/17.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGCastManager.h"

typedef NS_ENUM(NSInteger, LGPlayerControlViewEvent) {
    LGPlayerControlViewEventBack,               // 返回
    LGPlayerControlViewEventFullscreen,         // 全屏
    LGPlayerControlViewEventSmallscreen,        // 竖屏
    LGPlayerControlViewEventPlay,               // 播放
    LGPlayerControlViewEventPause,              // 暂停
    LGPlayerControlViewEventNext,               // 下一集
    LGPlayerControlViewEventSeek,               // 拖动进度
    LGPlayerControlViewEventDefinition,         // 切换清晰度
    LGPlayerControlViewEventShare,              // 分享
    LGPlayerControlViewEventCast,               // 投屏
    LGPlayerControlViewEventSpeedup,            // 加速播放
    LGPlayerControlViewEventSpeedDown,          // 停止加速播放
    LGPlayerControlViewEventChangeCastDevice,   // 切换投屏设备
    LGPlayerControlViewEventStopCast,           // 停止投屏
};

@class LGPlayerControlView;
@protocol LGPlayerControlViewDelegate <NSObject>
- (void)controlView:(LGPlayerControlView *)controlView event:(LGPlayerControlViewEvent)event;
@end

@interface LGPlayerControlView : UIView

@property (weak, nonatomic) id<LGPlayerControlViewDelegate> delegate;
@property (assign, nonatomic) BOOL fullscreen;
@property (assign, nonatomic) BOOL playing;
@property (assign, nonatomic) BOOL controlHidden;

@property (weak, nonatomic) IBOutlet UIView *navView;//顶部导航层
@property (weak, nonatomic) IBOutlet UIView *loadingView;//中间载入层
@property (weak, nonatomic) IBOutlet UIView *controlView;//底部控制层

//顶部导航层
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *definitionButton;
@property (weak, nonatomic) IBOutlet UIButton *castButton;

//中间载入层
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet LGLoading *loadingIndicator;

//底部控制层
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *fullscreenButton;

//投屏相关
@property (weak, nonatomic) IBOutlet UIView *castControlView;
@property (weak, nonatomic) IBOutlet UIButton *changeCastDeviceButton;
@property (weak, nonatomic) IBOutlet UIButton *stopCastButton;
@property (weak, nonatomic) IBOutlet UILabel *castStateLabel;

+ (instancetype)loadFromNib;
- (void)customForDiscovery;

- (void)showLoadingView:(NSString *)tips animation:(BOOL)anime;
- (void)hideLoadingView:(NSString *)tips animation:(BOOL)anime;
- (void)updateCastState:(LGCastState)state;
@end

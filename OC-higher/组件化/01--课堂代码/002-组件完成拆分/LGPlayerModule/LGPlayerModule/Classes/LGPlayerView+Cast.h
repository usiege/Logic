//
//  LGPlayerView+Cast.h
//  LGVideo
//
//  Created by LG on 2018/5/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView.h"
#import "LGCastManager.h"

@interface LGPlayerView (Cast)

- (void)setupCast;

//显示投屏设备选取界面
- (void)showCastDevicesView;

//切换设备
- (void)changeCastDevice;

//停止投屏
- (void)stopCast;

//根据投屏状态更新UI
- (void)updateCastState:(LGCastState)state;

@end

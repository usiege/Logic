//
//  LGPlayerVideoInfoCell.m
//  LGVideo
//
//  Created by LG on 2018/6/30.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerVideoInfoCell.h"
#import "LGPlayerVideoInfoResponse.h"
#import "UIButton+Custom.h"

@implementation LGPlayerVideoInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.favButton addTarget:self action:@selector(favButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[LGPlayerVideoInfoItem class]]) {
        LGPlayerVideoInfoItem *item = (LGPlayerVideoInfoItem *)data;
        self.titleLabel.text = item.title;
        self.descLabel.text = item.desc;
    }
}

- (void)favButtonAction {
    [_favButton scaleAnimation];
    _favButton.selected = !_favButton.selected;
    [LGToast toast:_favButton.selected ? @"收藏成功" : @"取消收藏"];
}

- (void)shareButtonAction {
    [_shareButton scaleAnimation];
    [LGShare showShareSheet];
}
@end

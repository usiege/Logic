//
//  LGPlayerFollowCell.m
//  LGVideo
//
//  Created by LG on 2018/7/2.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerFollowCell.h"
#import "LGPlayerVideoInfoResponse.h"
#import "UIButton+Custom.h"

@implementation LGPlayerFollowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius = 25.;
    self.avatarImageView.layer.masksToBounds = YES;
    self.titleLabel.textColor = LGForegroundColor;
    
    [self.followButton setTitleColor:LGForegroundColor forState:UIControlStateNormal];
    self.followButton.layer.borderWidth = 1.;
    self.followButton.layer.borderColor = LGForegroundColor.CGColor;
    self.followButton.layer.cornerRadius = 4.;
    [self.followButton addTarget:self action:@selector(followButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[LGPlayerVideoInfoItem class]]) {
        LGPlayerVideoInfoItem *item = (LGPlayerVideoInfoItem *)data;
        LGPlayerTemplateData *data = item.templateData.firstObject;
        self.titleLabel.text = data.title;
        self.descLabel.text = data.subTitle;
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:data.img]];
    }
}

- (void)followButtonAction {
    [_followButton scaleAnimation];
    _followButton.selected = !_followButton.selected;
    [LGToast toast:_followButton.selected ? @"关注成功" : @"取消关注"];
}
@end

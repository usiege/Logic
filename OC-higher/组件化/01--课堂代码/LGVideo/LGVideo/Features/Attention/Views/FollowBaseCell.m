//
//  FollowBaseCell.m
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowBaseCell.h"
#import "FollowDataSource.h"
#import "UIButton+Custom.h"

@implementation FollowBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = LGBackgroundColor;
    self.nameLabel.textColor = LGForegroundColor;
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.contentLabel.textColor = [UIColor lightGrayColor];
    
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 25;
    
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.contentLabel.numberOfLines = 2;
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[FollowListItem class]]) {
        FollowListItem *item = (FollowListItem *)data;
//        [self.coverImageView setImageWithURL:[NSURL URLWithString:item.cover]];
        
        self.nameLabel.text = item.publisher.name;
        self.timeLabel.text = @"刚刚";
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:item.publisher.avatar]];
        
        self.titleLabel.text = item.title;
        self.contentLabel.text = item.desc;
    }
}

- (IBAction)shareAction:(id)sender {
    [_shareButton scaleAnimation];
    [LGShare showShareSheet];
}

- (IBAction)favAction:(id)sender {
    [_praiseButton scaleAnimation];
    _praiseButton.selected = !_praiseButton.selected;
    [LGToast toast:_praiseButton.selected ? @"收藏成功" : @"取消收藏"];
}

- (IBAction)commentAction:(id)sender {
    [_commentButton scaleAnimation];
    LGInputView *inputView = [LGInputView new];
    inputView.titleLabel.text = @"    发表评论";
    [inputView showInView:[LGMediator currentViewController].view completion:^(NSString *text) {
        [LGToast toast:@"发送成功～"];
    }];
}

@end

//
//  DiscoveryTableViewCell.m
//  LGVideo
//
//  Created by LG on 2018/6/21.
//  Copyright © 2018 LG. All rights reserved.
//

#import "DiscoveryTableViewCell.h"
#import "DiscoveryDataSource.h"
#import "UIButton+Custom.h"

@implementation DiscoveryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.coverImageView.backgroundColor = [UIColor lightGrayColor];
    self.contentView.backgroundColor = LGBackgroundColor;
    self.coverImageViewHeightConstraint.constant = LGScreenWidth*9/16;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[DiscoveryListItem class]]) {
        DiscoveryListItem *item = (DiscoveryListItem *)data;
        [self.coverImageView setImageWithURL:[NSURL URLWithString:item.cover]];
        self.titleLabel.text = item.title;
        self.durationLabel.text = item.duration;
        
        self.nameLabel.text = item.publisher.name;
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:item.publisher.avatar]];
    }
}

- (void)loadVideoWithPlayerView:(LGPlayerView *)playerView {
    [playerView removeFromSuperview];
    [self.contentView addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.coverImageView);
    }];
    [playerView loadVideo:@"123"];
}

- (IBAction)shareAction:(id)sender {
    [_shareButton scaleAnimation];
    [LGShare showShareSheet];
}

- (IBAction)favAction:(id)sender {
    [_favButton scaleAnimation];
    _favButton.selected = !_favButton.selected;
    [LGToast toast:_favButton.selected ? @"收藏成功" : @"取消收藏"];
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

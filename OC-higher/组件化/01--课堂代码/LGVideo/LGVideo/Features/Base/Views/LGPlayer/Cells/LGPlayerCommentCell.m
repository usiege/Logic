//
//  LGPlayerCommentCell.m
//  LGVideo
//
//  Created by LG on 2018/7/5.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerCommentCell.h"
#import "LGPlayerVideoInfoResponse.h"
#import "UIButton+Custom.h"

@interface LGPlayerCommentCell ()
@property (nonatomic, strong) LGComment *comment;
@end

@implementation LGPlayerCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.nameLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"888888"];
    [self.contentView addSubview:self.contentLabel];
    
    self.praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.praiseButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.praiseButton setTitleColor:[UIColor colorWithHexString:@"888888"] forState:UIControlStateNormal];
    [self.praiseButton setTitleColor:LGForegroundColor forState:UIControlStateSelected];
    [self.praiseButton setImage:[UIImage imageNamed:@"pprn_favorite_heart"] forState:UIControlStateNormal];
    [self.praiseButton setImage:[UIImage imageNamed:@"pprn_favorite_heart_active"] forState:UIControlStateSelected];
    [self.praiseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [self.praiseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 3)];
    self.praiseButton.exclusiveTouch = YES;
    [self.praiseButton addTarget:self action:@selector(praiseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.praiseButton];
   
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.commentButton setTitleColor:[UIColor colorWithHexString:@"888888"] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"pprn_comment"] forState:UIControlStateNormal];
    [self.commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [self.commentButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 3)];
    self.commentButton.exclusiveTouch = YES;
    [self.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.commentButton];
    
    self.avatarImageView.layer.cornerRadius = 18;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@35);
        make.leading.top.equalTo(self.contentView).with.offset(15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.avatarImageView.mas_trailing).offset(5);
        make.centerY.equalTo(self.avatarImageView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).with.offset(15);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(15);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_leading).with.offset(LGScreenWidth/4+15);
        make.width.equalTo(@(LGScreenWidth/2-40));
        make.height.equalTo(@36);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_leading).with.offset(LGScreenWidth/4*3-15);
        make.centerY.equalTo(self.commentButton.mas_centerY);
        make.width.height.equalTo(self.commentButton);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[LGComment class]]) {
        LGComment *comment = (LGComment *)data;
        self.comment = comment;
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:comment.avatar]];
        self.nameLabel.text = comment.name;
        self.titleLabel.text = comment.title;
        self.contentLabel.text = comment.content;
        [self.commentButton setTitle:comment.replyCount forState:UIControlStateNormal];
        [self.praiseButton setTitle:comment.praiseCount forState:UIControlStateNormal];
    }
}

- (void)commentButtonAction:(UIButton *)sender {
    [_commentButton scaleAnimation];
    LGInputView *inputView = [LGInputView new];
    inputView.titleLabel.text = [NSString stringWithFormat:@"    回复%@：%@", self.comment.name, self.comment.content];
    [inputView showInView:[LGMediator currentViewController].view completion:^(NSString *text) {
        [LGToast toast:@"发送成功～"];
    }];
}

- (void)praiseButtonAction:(UIButton *)sender {
    [_praiseButton scaleAnimation];
    _praiseButton.selected = !_praiseButton.selected;
    [LGToast toast:_praiseButton.selected ? @"收藏成功" : @"取消收藏"];
}
@end

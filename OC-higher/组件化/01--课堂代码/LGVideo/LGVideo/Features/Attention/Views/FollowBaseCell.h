//
//  FollowBaseCell.h
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"

@interface FollowBaseCell : LGTableViewCell

@property(weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(weak, nonatomic) IBOutlet UIView *contentPlaceholderView;
@property(weak, nonatomic) IBOutlet UIButton *praiseButton;
@property(weak, nonatomic) IBOutlet UIButton *commentButton;
@property(weak, nonatomic) IBOutlet UIButton *shareButton;

@end

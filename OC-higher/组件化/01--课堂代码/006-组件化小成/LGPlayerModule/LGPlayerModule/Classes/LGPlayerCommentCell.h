//
//  LGPlayerCommentCell.h
//  LGVideo
//
//  Created by LG on 2018/7/5.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"

@interface LGPlayerCommentCell : LGTableViewCell

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIButton *praiseButton;
@property (strong, nonatomic) UIButton *commentButton;

@end

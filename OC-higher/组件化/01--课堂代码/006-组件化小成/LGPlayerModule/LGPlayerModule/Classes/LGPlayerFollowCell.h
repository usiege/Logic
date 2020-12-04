//
//  LGPlayerFollowCell.h
//  LGVideo
//
//  Created by LG on 2018/7/2.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"

@interface LGPlayerFollowCell : LGTableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;
@property (nonatomic, weak) IBOutlet UIButton *followButton;

@end

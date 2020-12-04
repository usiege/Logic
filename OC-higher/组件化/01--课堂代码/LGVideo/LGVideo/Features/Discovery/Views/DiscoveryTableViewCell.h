//
//  DiscoveryTableViewCell.h
//  LGVideo
//
//  Created by LG on 2018/6/21.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"
#import "LGPlayerView.h"

@interface DiscoveryTableViewCell : LGTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (void)loadVideoWithPlayerView:(LGPlayerView *)playerView;

@end

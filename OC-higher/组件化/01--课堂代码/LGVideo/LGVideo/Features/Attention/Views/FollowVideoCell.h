//
//  FollowVideoCell.h
//  LGVideo
//
//  Created by LG on 2018/6/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowBaseCell.h"

@interface FollowVideoCell : FollowBaseCell

@property(weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewHeightConstraint;

@end

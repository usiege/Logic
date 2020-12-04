//
//  FollowVideoCell.m
//  LGVideo
//
//  Created by LG on 2018/6/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowVideoCell.h"
#import "FollowDataSource.h"

@interface FollowVideoCell ()
@property (nonatomic, strong) FollowListItem *item;
@end

@implementation FollowVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.coverImageView.backgroundColor = [UIColor lightGrayColor];
    self.coverImageViewHeightConstraint.constant = (LGScreenWidth-20)*9/16;
    
    self.coverImageView.userInteractionEnabled = YES;
    [self.coverImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageAction)]];
}

- (void)configWithData:(id)data {
    [super configWithData:data];
    if ([data isKindOfClass:[FollowListItem class]]) {
        self.item = (FollowListItem *)data;
        [self.coverImageView setImageWithURL:[NSURL URLWithString:self.item.video.cover]];
    }
}

- (void)coverImageAction {
    [LGMediator jumpToPlayerVC:self.item];
}
@end

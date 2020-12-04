//
//  FollowImageCell.h
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowBaseCell.h"

@interface FollowImageCell : FollowBaseCell

@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidthConstraint;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@end

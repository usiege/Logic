//
//  LGPlayerVideoEpisodesCell.h
//  LGVideo
//
//  Created by LG on 2018/7/1.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"

@interface LGPlayerVideoEpisodesCell : LGTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@end

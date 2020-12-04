//
//  LGPlayerVideoEpisodesCell.m
//  LGVideo
//
//  Created by LG on 2018/7/1.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerVideoEpisodesCell.h"
#import "LGPlayerVideoInfoResponse.h"

@interface EpisodesCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation EpisodesCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"888888" alpha:0.7];
        self.layer.cornerRadius = 4.;
        self.layer.masksToBounds = YES;
        
        _titleLabel = [UILabel new];
        _titleLabel.textColor = LGForegroundColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
@end

@interface LGPlayerVideoEpisodesCell ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LGPlayerVideoEpisodesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.backgroundColor = LGBackgroundColor;
    [self.collectionView registerClass:EpisodesCollectionViewCell.class
            forCellWithReuseIdentifier:NSStringFromClass(EpisodesCollectionViewCell.class)];
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[LGPlayerVideoInfoItem class]]) {
        LGPlayerVideoInfoItem *item = (LGPlayerVideoInfoItem *)data;
        _titleLabel.text = item.title;
        _descLabel.text = item.desc;
        _dataArray = item.templateData.copy;
        
        [_collectionView.collectionViewLayout invalidateLayout];
        [_collectionView reloadData];
        self.collectionViewHeightConstraint.constant = _collectionView.collectionViewLayout.collectionViewContentSize.height+40;
        [self updateConstraintsIfNeeded];
    }
}

#pragma mark collectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark collectionview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGPlayerTemplateData *itemData = _dataArray[indexPath.item];
    EpisodesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(EpisodesCollectionViewCell.class) forIndexPath:indexPath];
    cell.titleLabel.text = itemData.title;
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 40);
}

@end

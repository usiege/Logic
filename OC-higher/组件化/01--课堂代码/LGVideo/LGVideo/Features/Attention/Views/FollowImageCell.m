//
//  FollowImageCell.m
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowImageCell.h"
#import "FollowDataSource.h"
#import "PYPhotoBrowser.h"

@interface FollowImageCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation FollowImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
@end

@interface FollowImageCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@end

@implementation FollowImageCell
+ (CGFloat)imageSizeWithCount:(NSUInteger)count {
    int size = 0;
    switch (count) {
        case 1:
            //按六个来算，占四个
            size = (LGScreenWidth - 20) / 3 * 2;
            break;
        case 2:
        case 4://每排两个平分
            size = (LGScreenWidth - 20) / 2;
            break;
        default://其它的都以每排3个来算
            size = (LGScreenWidth - 20) / 3;
            break;
    }
    return size;
}

+ (CGFloat)collectionViewHeightWithCount:(NSUInteger)count {
    int height = 0;
    switch (count) {
        case 1:
        case 5:
        case 6:
        //按六个来算，占四个
        height = (LGScreenWidth - 20) / 3 * 2;
        break;
        case 2:
        height = (LGScreenWidth - 20) / 2;
        break;
        case 3:
        height = (LGScreenWidth - 20) / 3;
        break;
        case 4:
        case 7:
        case 8:
        case 9:
        height = (LGScreenWidth - 20);
        break;
        default:
        break;
    }
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_collectionView registerClass:FollowImageCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(FollowImageCollectionViewCell.class)];
}

- (void)configWithData:(id)data {
    [super configWithData:data];
    if ([data isKindOfClass:[FollowListItem class]]) {
        FollowListItem *item = (FollowListItem *)data;
        _dataArray = item.images;
    }
    self.collectionViewHeightConstraint.constant = [FollowImageCell collectionViewHeightWithCount:_dataArray.count];
    self.collectionViewWidthConstraint.constant = _dataArray.count == 1 ? [FollowImageCell imageSizeWithCount:1] : LGScreenWidth-20;
    [self updateConstraintsIfNeeded];
    [self.collectionView reloadData];
}
#pragma mark uicollection view
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [collectionView.collectionViewLayout invalidateLayout];
    _imagesArray = [NSMutableArray arrayWithCapacity:_dataArray.count];
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FollowImageCollectionViewCell *cell = (FollowImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(FollowImageCollectionViewCell.class) forIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row]]];
    [_imagesArray addObject:cell.imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    photoBroseView.sourceImgageViews = _imagesArray;
    photoBroseView.currentIndex = indexPath.item;
    [photoBroseView show];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = [FollowImageCell imageSizeWithCount:_dataArray.count];
    return CGSizeMake(size, size);
}

@end

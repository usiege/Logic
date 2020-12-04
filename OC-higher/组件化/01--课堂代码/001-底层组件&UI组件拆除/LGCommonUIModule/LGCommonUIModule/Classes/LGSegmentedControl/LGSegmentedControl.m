//
//  LGSegmentedControl.m
//  LGVideo
//
//  Created by LG on 2018/4/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGSegmentedControl.h"

@interface LGSegmentedControlCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;
- (void)configCellWithTitle:(NSString *)title selectedStatus:(BOOL)isSelected;
@end
@implementation LGSegmentedControlCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
- (void)configCellWithTitle:(NSString *)title selectedStatus:(BOOL)isSelected {
    self.titleLabel.text = title;
    self.titleLabel.textColor = isSelected ? _highlightColor : _normalColor;
    self.titleLabel.font = isSelected ? [UIFont boldSystemFontOfSize:16.] : [UIFont systemFontOfSize:14.];
}
@end

@interface LGSegmentedControl () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) NSArray *itemTitles;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LGSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame itemWidth:(CGFloat)itemWidth itemTitles:(NSArray *)itemTitles {
    if (self = [super initWithFrame:frame]) {
        _itemWidth = itemWidth;
        _itemTitles = [NSArray arrayWithArray:itemTitles];
        [self layoutIfNeeded];      //to avoid _UIToolbarContentView cover our subviews
        [self setupSubviews];
    }
    return self;
}

- (void)setItemTitles:(NSArray *)itemTitles {
    _itemTitles = [NSArray arrayWithArray:itemTitles];
    [_collectionView reloadData];
}

- (id<LGSegmentedControlDelegate>)delegate {
    id curDelegate = [super delegate];
    return curDelegate;
}

- (void)setDelegate:(id<LGSegmentedControlDelegate>)delegate {
    [super setDelegate:delegate];
}

- (void)setupSubviews {
    [self addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.collectionView addSubview:self.lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.bottom.equalTo(self);
        make.width.equalTo(@(_itemWidth-30));
        make.height.equalTo(@4);
    }];
    
    [_collectionView registerClass:[LGSegmentedControlCell class] forCellWithReuseIdentifier:NSStringFromClass([LGSegmentedControlCell class])];
    [_collectionView reloadData];
}

- (void)didMoveTo:(CGFloat)index {
    NSLog(@"didMoveTo %f", index);
    [self updateLineViewIndicator:index];
    [self moveToPage:(int)index];
}

- (void)updateLineViewIndicator:(CGFloat)index {
    if (index <0 || index > _itemTitles.count-1) {
        return;
    }
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(index * _itemWidth + 15));
    }];
}

- (void)moveToPage:(NSInteger)index {
    _currentIndex = index;
    [_collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
#pragma mark properties
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LGForegroundColor;
        _lineView.layer.cornerRadius = 2.;
    }
    return _lineView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollsToTop = NO;
        [_collectionView setAutoresizesSubviews:NO];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControl:didSelectItemAtIndex:fromIndex:)]) {
        [self.delegate segmentedControl:self didSelectItemAtIndex:indexPath.item fromIndex:self.currentIndex];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGSegmentedControlCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LGSegmentedControlCell class]) forIndexPath:indexPath];
    if (!cell) cell = [LGSegmentedControlCell new];
    NSString *itemTitle = _itemTitles[indexPath.item];
    cell.normalColor = self.normalColor;
    cell.highlightColor = self.highlightColor;
    [cell configCellWithTitle:itemTitle selectedStatus:_currentIndex == indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_itemWidth, self.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
@end

//
//  LGShare.m
//  LGVideo
//
//  Created by LG on 2018/7/2.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGShare.h"
#import "LGToast.h"

@interface LGShareCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
@end

@implementation LGShareCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _icon = [UIImageView new];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView).offset(-10);
        }];
        
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.contentView);
            make.top.equalTo(_icon.mas_bottom).offset(5);
        }];
    }
    return self;
}
@end

@interface LGShare () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray  *configs;
@property (strong, nonatomic) UICollectionView  *collectionView;

@end

@implementation LGShare

+ (void)showShareSheet {
    NSArray *configs = @[@[@"朋友圈", @"share_friendCirle"],
                         @[@"微信", @"share_wechat"],
                         @[@"微博", @"share_weibo"],
                         @[@"QQ", @"share_qqFriend"],
                         @[@"QQ空间", @"share_qqZone"],];
    
    UIView *superview = [UIApplication sharedApplication].keyWindow;
    LGShare *share = [[LGShare alloc] initWithConfigs:configs];
    share.alpha = 0;
    [superview addSubview:share];
    
    CGRect frame = share.collectionView.frame;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetHeight(share.bounds);
    share.collectionView.frame = frame;
    frame.origin.y = CGRectGetHeight(share.bounds) - CGRectGetHeight(share.collectionView.bounds);
    [UIView animateWithDuration:0.2 animations:^{
        share.alpha = 1;
        share.collectionView.frame = frame;
    }];
}

- (instancetype)initWithConfigs:(NSArray *)configs {
    if (self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [button addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self addSubview:self.collectionView];
        
        self.configs = configs;
        [self.collectionView reloadData];
    }
    return self;
}

- (void)dismissAction {
    CGRect frame = self.collectionView.frame;
    frame.origin.y = CGRectGetHeight(self.bounds);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.collectionView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - Property
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(LGScreenWidth/5, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LGScreenWidth, 100+LGBottomBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:LGShareCell.class
            forCellWithReuseIdentifier:NSStringFromClass(LGShareCell.class)];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _configs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *config = _configs[indexPath.item];
    LGShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(LGShareCell.class) forIndexPath:indexPath];
    cell.label.text = config[0];
    cell.icon.image = [UIImage imageNamed:config[1]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *config = _configs[indexPath.item];
    [LGToast toast:[NSString stringWithFormat:@"分享到%@", config[0]]];
    [self dismissAction];
}

@end

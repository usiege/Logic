//
//  HomeBannerTableViewCell.m
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeBannerTableViewCell.h"
#import "HomeBannerCollectionViewCell.h"
#import "HomeTemplateResponse.h"

@interface HomeBannerTableViewCell () <TYCyclePagerViewDelegate, TYCyclePagerViewDataSource>
@property (strong, nonatomic) NSMutableArray    *dataArray;
@end

@implementation HomeBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cycleView.reloadDataNeedResetIndex = YES;
    NSString *cellName = NSStringFromClass([HomeBannerCollectionViewCell class]);
    [self.cycleView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:cellName];
    self.cycleView.autoScrollInterval = 5;
    self.cycleView.delegate = self;
    self.cycleView.dataSource = self;
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateItem class]]) {
        self.dataArray = [NSMutableArray arrayWithArray:[(HomeTemplateItem *)data templateData]];
        [self.cycleView reloadData];
    }
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.dataArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    if (index >=self.dataArray.count) {
        return [UICollectionViewCell new];
    }
    id data = self.dataArray[index];
    
    HomeBannerCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeBannerCollectionViewCell class]) forIndex:index];
    [cell configWithData:data];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    CGFloat space = 0;
    CGSize itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = itemSize;
    layout.itemSpacing = space;
    return layout;
}

#pragma mark - TYCyclePagerViewDelegate
- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {

}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (index >= self.dataArray.count)   return;
    id data = self.dataArray[index];
    [LGMediator jumpToPlayerVC:data];
}

@end

//
//  DiscoveryTableViewProxy.m
//  LGVideo
//
//  Created by LG on 2018/6/21.
//  Copyright © 2018 LG. All rights reserved.
//

#import "DiscoveryTableViewProxy.h"
#import "DiscoveryTableViewCell.h"
#import "DiscoveryDataSource.h"
#import "LGMediator.h"
#import "LGPlayerView+Gesture.h"
#import "LGPlayerView+Rotation.h"

@interface DiscoveryTableViewProxy ()
@property (nonatomic, strong) NSString *playingVideoId;
@end

@implementation DiscoveryTableViewProxy

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier configuration:(LGConfigBlock)cBlock action:(LGActionBlock)aBlock {
    if (self = [super initWithReuseIdentifier:reuseIdentifier configuration:cBlock action:aBlock]) {
        self.playerView = [[LGPlayerView alloc] init];
        [self.playerView disableGesture];
        [self.playerView disableRotation];
        [self.playerView.controlView customForDiscovery];
        
        self.tableView.estimatedRowHeight = 200;
        self.tableView.backgroundColor = LGBackgroundColor;
        [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    }
    return self;
}

#pragma mark - UIScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //视频滚动出可视范围，停止播放
    CGPoint playerCenter = [self.playerView.superview convertPoint:self.playerView.center toView:[LGMediator currentViewController].view];
    LGLog(@"playerCenter %@ %@", NSStringFromCGSize([LGMediator currentViewController].view.bounds.size), NSStringFromCGPoint(playerCenter));
    if (playerCenter.y < LGNavigationBarHeight || playerCenter.y > LGScreenHeight-LGNavigationBarHeight) {
        [self.playerView.player pause];
        [self.playerView removeFromSuperview];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    DiscoveryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell loadVideoWithPlayerView:_playerView];
    
    DiscoveryListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    self.playingVideoId = item.videoId;
}

#pragma mark tableview data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    if (self.cellConfigBlock) self.cellConfigBlock(cell, self.dataArray[indexPath.row], indexPath);
    
    //匹配正在播放的cell
    DiscoveryListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    if ([self.playingVideoId isEqualToString:item.videoId]) {
        [cell loadVideoWithPlayerView:_playerView];
    }
    return cell;
}
@end

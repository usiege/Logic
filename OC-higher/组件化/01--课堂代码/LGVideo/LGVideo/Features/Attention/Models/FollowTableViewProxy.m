//
//  FollowTableViewProxy.m
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowTableViewProxy.h"
#import "FollowCellHeader.h"
#import "FollowDataSource.h"
#import "LGMediator.h"

@interface FollowTableViewProxy ()
@end

@implementation FollowTableViewProxy

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier configuration:(LGConfigBlock)cBlock action:(LGActionBlock)aBlock {
    if (self = [super initWithReuseIdentifier:reuseIdentifier configuration:cBlock action:aBlock]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        self.tableView.estimatedRowHeight = 100;
        self.tableView.backgroundColor = LGBackgroundColor;
        [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    }
    return self;
}

#pragma mark - UIScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //cancel auto play next
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark tableview data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowListItem *item = self.dataArray[indexPath.row];
    FollowBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellClassName
                                                           forIndexPath:indexPath];
    if (self.cellConfigBlock) self.cellConfigBlock(cell, self.dataArray[indexPath.row], indexPath);
    return cell;
}
@end

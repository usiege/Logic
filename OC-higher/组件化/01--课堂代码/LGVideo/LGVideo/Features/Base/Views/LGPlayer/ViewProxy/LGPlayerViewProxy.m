//
//  LGPlayerViewProxy.m
//  LGVideo
//
//  Created by LG on 2018/5/17.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerViewProxy.h"
#import "LGPlayerVideoInfoResponse.h"
#import "LGPlayerCellsHeader.h"

@interface LGPlayerViewProxy () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation LGPlayerViewProxy

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier configuration:(LGConfigBlock)cBlock action:(LGActionBlock)aBlock {
    if (self = [super initWithReuseIdentifier:reuseIdentifier configuration:cBlock action:aBlock]) {
        self.tableView.estimatedRowHeight = 100;
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.separatorColor = [UIColor colorWithHexString:@"888888" alpha:0.3];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        for (NSString *className in LGPlayerTableViewCellIdentifiers.allValues) {
            [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil]
                 forCellReuseIdentifier:className];
        }
        [self.tableView registerClass:[LGPlayerCommentCell class] forCellReuseIdentifier:NSStringFromClass([LGPlayerCommentCell class])];
    }
    return self;
}

- (LGPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [LGPlayerView new];
    }
    return _playerView;
}

- (void)dealloc {
    LGLog(@"");
}

- (void)jumpToComment {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)commentAction {
    LGInputView *inputView = [LGInputView new];
    inputView.titleLabel.text = @"    发表评论";
    [inputView showInView:[LGMediator currentViewController].view completion:^(NSString *text) {
        [LGToast toast:@"发送成功～"];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray[1]];
        LGComment *comment = [LGComment new];
        comment.name = @"LGPro";
        comment.content = text;
        [temp insertObject:comment atIndex:0];
        
        self.dataArray = [NSArray arrayWithObjects:self.dataArray[0], temp, nil];
        [self.tableView reloadData];
    }];
}
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *temp = self.dataArray[indexPath.section];
    id item = temp[indexPath.row];
    if ([item isKindOfClass:[LGPlayerVideoInfoItem class]]) {
        return UITableViewAutomaticDimension;
    } else if ([item isKindOfClass:[LGComment class]]) {
        return ((LGComment *)item).cellHeight.floatValue;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellActionBlock) {
        NSArray *temp = self.dataArray[indexPath.section];
        self.cellActionBlock([tableView cellForRowAtIndexPath:indexPath], temp[indexPath.row], indexPath);
    }
}

#pragma mark tableview data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *temp = self.dataArray[section];
    return temp.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 1 ? 50 : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return nil;
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LGScreenWidth, height)];
    headerView.backgroundColor = LGBackgroundColor;

    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(20, 10, headerView.bounds.size.width-40, height-20);
    commentButton.backgroundColor = [UIColor colorWithHexString:@"888888" alpha:0.7];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
    commentButton.layer.cornerRadius = (height-20)/2;
    commentButton.layer.masksToBounds = YES;
    [commentButton setImage:[UIImage imageNamed:@"pprn_comment"] forState:UIControlStateNormal];
    [commentButton setTitle:@"别旁观了，你也来说说看吧" forState:UIControlStateNormal];
    [commentButton setTitleColor:LGForegroundColor forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:commentButton];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *temp = self.dataArray[indexPath.section];
    id item = temp[indexPath.row];
    LGTableViewCell *cell = nil;
    if ([item isKindOfClass:[LGPlayerVideoInfoItem class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:[LGPlayerTableViewCellIdentifiers objectForKey:((LGPlayerVideoInfoItem *)item).templateName]
                                               forIndexPath:indexPath];
        if ([cell isKindOfClass:[LGPlayerVideoInfoCell class]]) {
            [((LGPlayerVideoInfoCell *)cell).commentButton removeTarget:self action:@selector(jumpToComment) forControlEvents:UIControlEventTouchUpInside];
            [((LGPlayerVideoInfoCell *)cell).commentButton addTarget:self action:@selector(jumpToComment) forControlEvents:UIControlEventTouchUpInside];
        }
    } else if ([item isKindOfClass:[LGComment class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LGPlayerCommentCell class])
                                               forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = LGBackgroundColor;
    if (self.cellConfigBlock) self.cellConfigBlock(cell, item, indexPath);
    return cell;
}
@end

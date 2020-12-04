//
//  DiscoveryViewController.m
//  LGVideo
//
//  Created by LG on 25/02/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryTableViewProxy.h"
#import "DiscoveryDataSource.h"

@interface DiscoveryViewController ()
@property (nonatomic, strong) DiscoveryTableViewProxy *tableViewProxy;
@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.contentView addSubview:self.tableViewProxy.tableView];
    [self.tableViewProxy.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [DiscoveryDataSource getDiscoveryList:0 completion:^(BOOL succeed, NSError *error, id data) {
        if (data && [data isKindOfClass:[DiscoveryListResponse class]]) {
            DiscoveryListResponse *response = (DiscoveryListResponse *)data;
            self.tableViewProxy.dataArray = response.data;
            [self.tableViewProxy.tableView reloadData];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_tableViewProxy.playerView.player pause];
    [_tableViewProxy.playerView removeFromSuperview];
}

- (DiscoveryTableViewProxy *)tableViewProxy {
    if (!_tableViewProxy) {
        _tableViewProxy = [[DiscoveryTableViewProxy alloc] initWithReuseIdentifier:@"DiscoveryTableViewCell" configuration:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            [cell configWithData:cellData];
        } action:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            
        }];
    }
    return _tableViewProxy;
}
@end

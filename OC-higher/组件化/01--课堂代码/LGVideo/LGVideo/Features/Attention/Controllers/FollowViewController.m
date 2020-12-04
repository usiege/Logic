//
//  FollowViewController.m
//  LGVideo
//
//  Created by LG on 25/02/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowViewController.h"
#import "FollowTableViewProxy.h"
#import "FollowDataSource.h"

@interface FollowViewController ()
@property (nonatomic, strong) FollowTableViewProxy *tableViewProxy;
@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关注";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.contentView addSubview:self.tableViewProxy.tableView];
    [self.tableViewProxy.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [FollowDataSource getFollowList:0 completion:^(BOOL succeed, NSError *error, id data) {
        if (data && [data isKindOfClass:[FollowListResponse class]]) {
            FollowListResponse *response = (FollowListResponse *)data;
            self.tableViewProxy.dataArray = response.data;
            for (FollowListItem *item in response.data) {
                NSString *name = [item cellClassName];
                [self.tableViewProxy.tableView registerNib:[UINib nibWithNibName:name bundle:nil]
                                    forCellReuseIdentifier:name];
            }
            [self.tableViewProxy.tableView reloadData];
        }
    }];
}

- (FollowTableViewProxy *)tableViewProxy {
    if (!_tableViewProxy) {
        _tableViewProxy = [[FollowTableViewProxy alloc] initWithReuseIdentifier:@"FollowBaseCell" configuration:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            [cell configWithData:cellData];
        } action:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            
        }];
    }
    return _tableViewProxy;
}

@end

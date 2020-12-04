//
//  HomeViewController.m
//  LGVideo
//
//  Created by LG on 25/02/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataSource.h"
#import "HomeCollectionViewCell.h"
#import "HomeTableViewProxy.h"
#import "HomeTableViewDefines.h"
#import "LGErrorView.h"
#import "LGTableViewDataConfigProtocol.h"

@interface HomeViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LGErrorView *errorView;

@property (nonatomic, strong) HomeDataSource *dataSource;
@property (nonatomic, strong) HomeTableViewProxy *tableViewProxy;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    [self loadData];
    [self lg_layoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private Method

- (void)lg_layoutSubviews{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.errorView.hidden = YES;
    [self.view addSubview:self.errorView];
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(LGScreenWidth));
        make.center.equalTo(self.view);
    }];
}

- (void)loadData{
    self.dataSource = [HomeDataSource new];
    [self.dataSource getChannel:@"11" completion:^(BOOL succeed, NSError *error, id data) {
        HomeTemplateResponse *response = (HomeTemplateResponse *)data;
        if (response && response.data.count) {
            self.errorView.hidden = YES;
        } else {
            self.errorView.hidden = NO;
        }
        self.tableViewProxy.dataArray = [NSArray arrayWithArray:response.data];
        [self.tableView reloadData];
    }];
}

#pragma mark -- Getter and Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self.tableViewProxy;
        _tableView.dataSource = self.tableViewProxy;
        _tableView.backgroundColor = LGBackgroundColor;
        NSString *bundlePath = [NSBundle bundleForClass:[self class]].resourcePath;
        for (NSString *className in HomeTableViewCellIdentifiers.allValues) {
            UINib *nib = [UINib nibWithNibName:className bundle:[NSBundle bundleWithPath:bundlePath]];
            [self.tableView registerNib:nib forCellReuseIdentifier:className];
        }
    }
    return _tableView;
}

- (HomeTableViewProxy *)tableViewProxy {
    if (!_tableViewProxy) {
        _tableViewProxy = [[HomeTableViewProxy alloc] initWithReuseIdentifier:@"HomeTableViewCell" configuration:^(UITableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            if ([cell respondsToSelector:@selector(configWithData:)]) {
                [cell performSelector:@selector(configWithData:) withObject:cellData];
            }
        } action:^(UITableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            HomeTemplateItem *item = (HomeTemplateItem *)cellData;
            HomeTemplateData *data = item.templateData.firstObject;
//            [LGMediator jumpToPlayerVC:item.templateData.firstObject];
             UIViewController *vc = [[CTMediator sharedInstance] CTMediator_naviagetPlayerVC:data.videoId title:data.title];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _tableViewProxy;
}

- (LGErrorView *)errorView {
    if (!_errorView) {
        _errorView = [LGErrorView errorViewWith:LGErrorViewType_Unknown];
    }
    return _errorView;
}


@end

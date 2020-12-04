//
//  HomeCollectionViewCell.m
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.tableViewProxy.tableView];
        _tableViewProxy.tableView.backgroundColor = LGBackgroundColor;
        [_tableViewProxy.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
//        self.tableViewProxy.errorView.hidden = YES;
//        [self.contentView addSubview:self.tableViewProxy.errorView];
//        [_tableViewProxy.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.equalTo(@(LGScreenWidth));
//            make.center.equalTo(self.contentView);
//        }];
    }
    return self;
}

- (void)configWithResponse:(HomeTemplateResponse *)response {
//    if (response && response.data.count) {
//        self.tableViewProxy.errorView.hidden = YES;
//    } else {
//        self.tableViewProxy.errorView.hidden = NO;
//    }
    self.tableViewProxy.dataArray = [NSArray arrayWithArray:response.data];
    [self.tableViewProxy.tableView reloadData];
}

#pragma mark properties
- (HomeTableViewProxy *)tableViewProxy {
//    if (!_tableViewProxy) {
//        _tableViewProxy = [[HomeTableViewProxy alloc] initWithReuseIdentifier:@"HomeTableViewCell" configuration:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
//            if ([cell isKindOfClass:[LGTableViewCell class]]) {
//                [(LGTableViewCell *)cell configWithData:cellData];
//            }
//        } action:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
//            HomeTemplateItem *item = (HomeTemplateItem *)cellData;
//            [LGMediator jumpToPlayerVC:item.templateData.firstObject];
//        }];
//    }
    
     if (!_tableViewProxy) {
            _tableViewProxy = [[HomeTableViewProxy alloc] initWithReuseIdentifier:@"HomeTableViewCell" configuration:^(UITableViewCell *cell, id cellData, NSIndexPath *indexPath) {
               
                if ([cell respondsToSelector:@selector(configureWithData:)]) {
                    [cell performSelector:@selector(configureWithData:) withObject:cellData];
                }
            } action:^(UITableViewCell *cell, id cellData, NSIndexPath *indexPath) {
                HomeTemplateItem *item = (HomeTemplateItem *)cellData;
                HomeTemplateData *data = item.templateData.firstObject;
    //            [LGMediator jumpToPlayerVC:item.templateData.firstObject];
                [[CTMediator sharedInstance] CTMediator_naviagetPlayerVC:data.videoId title:data.title];
                
            }];
        }
    return _tableViewProxy;
}
@end

//
//  LGTableManager.m
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGTableManager.h"

@implementation LGTableManager

- (id)initWithSections:(NSArray<id<LGSectionProtocol>> *)sections delegateHandler:(LGTableDelegateHandler *)handler{
    self = [super init];
    if (self) {
        _sections = sections;
        _delegateHandler = handler;
        _preloader = [[LGTablePreloader alloc] init];
        _delegateHandler.tableManager = self;
    }
    return self;
}

- (void)bindToTableView:(UITableView *)tableView{
    tableView.delegate = self.delegateHandler;
    tableView.dataSource = self.delegateHandler;
    self.tableView = tableView;
}

- (id<LGRowProtocol>)rowAtIndexPath:(NSIndexPath *)indexPath{
    NSAssert(indexPath.section < self.sections.count, @"数组越界");
    if (indexPath.section < self.sections.count) {
        id<LGSectionProtocol> section = self.sections[indexPath.section];
        if (indexPath.row < section.rows.count) {
            return section.rows[indexPath.row];
        }
        return nil;
    }
    return nil;
}

- (void)reloadData{
    NSAssert(self.tableView != nil, @"tableView is nil");
    if ([NSThread isMainThread]) {
        [self.tableView reloadData];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

@end

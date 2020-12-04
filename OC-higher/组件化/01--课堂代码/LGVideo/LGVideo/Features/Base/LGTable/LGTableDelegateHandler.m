//
//  LGTableDelegateHandler.m
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGTableDelegateHandler.h"
#import "LGTableManager.h"

@implementation LGTableDelegateHandler

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return _tableManager.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableManager.sections[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<LGRowProtocol> row = [_tableManager rowAtIndexPath:indexPath];
    UITableViewCell *cell = row.cellForRowBlock(tableView, indexPath);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_tableManager rowAtIndexPath:indexPath].rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_tableManager rowAtIndexPath:indexPath].estimatedHeight;
}

#pragma mark -- Header

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     return _tableManager.sections[section].titleForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _tableManager.sections[section].heightForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return _tableManager.sections[section].estimatedHeightForHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    id<LGSectionProtocol> sec = _tableManager.sections[section];
    return (sec.viewForHeader ? sec.viewForHeader(tableView, section) : nil);
}

#pragma mark -- Footer

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return _tableManager.sections[section].titleForFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return _tableManager.sections[section].heightForFooter;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return _tableManager.sections[section].estimatedHeightForFooter;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    id<LGSectionProtocol> sec = _tableManager.sections[section];
    return (sec.viewForFooter ? sec.viewForFooter(tableView, section) : nil);}

@end

//
//  HomeTableViewProxy.m
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeTableViewProxy.h"
#import "HomeTemplateResponse.h"
#import "HomeTableViewDefines.h"

@interface HomeTableViewProxy () 
@end

@implementation HomeTableViewProxy

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier configuration:(LGConfigBlock)cBlock action:(LGActionBlock)aBlock {
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
        _cellConfigBlock = cBlock;
        _cellActionBlock = aBlock;
    }
    return self;
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTemplateItem *item = self.dataArray[indexPath.row];
    return [[HomeTableViewCellHeights objectForKey:item.templateName] floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellActionBlock) {
        self.cellActionBlock([tableView cellForRowAtIndexPath:indexPath], self.dataArray[indexPath.row], indexPath);
    }
}

#pragma mark tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTemplateItem *item = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeTableViewCellIdentifiers objectForKey:item.templateName] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = LGBackgroundColor;
    if (self.cellConfigBlock) self.cellConfigBlock(cell, self.dataArray[indexPath.row], indexPath);
    return cell;
}

@end

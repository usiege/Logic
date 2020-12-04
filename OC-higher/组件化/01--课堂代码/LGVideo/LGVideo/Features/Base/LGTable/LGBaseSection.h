//
//  LGBaseSection.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGBaseSection : NSObject<LGSectionProtocol>

@property (nonatomic, strong) NSArray<id<LGRowProtocol>> *rows;

@property (nonatomic, strong) NSString *titleForHeader;
@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat estimatedHeightForHeader;
@property (nonatomic, copy) HeaderFooter viewForHeader;

@property (nonatomic, strong) NSString *titleForFooter;
@property (nonatomic, assign) CGFloat heightForFooter;
@property (nonatomic, assign) CGFloat estimatedHeightForFooter;
@property (nonatomic, copy) HeaderFooter viewForFooter;

@property (nonatomic, strong) NSString *sectionIndexTitle;

- (void)createHeaderView:(UIView *(^)(UITableView *tableView, NSInteger section))viewBlock;
- (void)creatFooterView:(UIView *(^)(UITableView *tableView, NSInteger section))viewBlock;

@end


@interface LGDefaultSection : LGBaseSection

- (id)initWithRow:(NSArray<id<LGRowProtocol>> *)row;

@end


NS_ASSUME_NONNULL_END

//
//  LGSectionProtocol.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGRowProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef UIView *(^HeaderFooter)(UITableView *tableView, NSInteger section);

@protocol LGSectionProtocol <NSObject>

@property (nonatomic, strong) NSArray<id<LGRowProtocol>> *rows;

@property (nonatomic, strong) NSString *titleForHeader;
@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat estimatedHeightForHeader;

@property (nonatomic, strong) NSString *titleForFooter;
@property (nonatomic, assign) CGFloat heightForFooter;
@property (nonatomic, assign) CGFloat estimatedHeightForFooter;

@property (nonatomic, strong) NSString *sectionIndexTitle;

@property (nonatomic, copy) HeaderFooter viewForHeader;
@property (nonatomic, copy) HeaderFooter viewForFooter;

@end

NS_ASSUME_NONNULL_END

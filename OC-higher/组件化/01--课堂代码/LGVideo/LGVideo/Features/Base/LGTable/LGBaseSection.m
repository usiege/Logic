//
//  LGBaseSection.m
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGBaseSection.h"

static const CGFloat LG_DefaultHeightForHeader = 0.0;
static const CGFloat LG_DefaultEstimatedHeightForHeader = 0.0;
static const CGFloat LG_DefaultHeightForFooter = 0.0;
static const CGFloat LG_DefaultEstimatedHeightForFooter = 0.0;

@implementation LGBaseSection

#pragma mark -- Public Method

- (void)createHeaderView:(UIView *(^)(UITableView *tableView, NSInteger section))viewBlock{
    self.viewForHeader = viewBlock;
}

- (void)creatFooterView:(UIView *(^)(UITableView *tableView, NSInteger section))viewBlock{
    self.viewForFooter = viewBlock;
}

#pragma mark -- Getter and Setter

- (NSString *)sectionIndexTitle{
    return nil;
}

//Header
- (CGFloat)heightForHeader{
    return LG_DefaultHeightForHeader;
}

- (CGFloat)estimatedHeightForHeader{
    return LG_DefaultEstimatedHeightForHeader;
}

//Footer
- (CGFloat)heightForFooter{
    return LG_DefaultHeightForFooter;
}

- (CGFloat)estimatedHeightForFooter{
    return LG_DefaultEstimatedHeightForFooter;
}

@end


#pragma mark -- LGDefaultSection

@implementation LGDefaultSection

- (id)initWithRow:(NSArray<id<LGRowProtocol>> *)row{
    self = [super init];
    if (self) {
        self.rows = (row ? [row copy] : @[]);
    }
    return self;
}


@end

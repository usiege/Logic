//
//  UITableView+Manager.h
//  LGTable
//
//  Created by vampire on 2019/2/12.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LGTableManager;

@interface UITableView (Manager)

@property (nonatomic, strong) LGTableManager *manager;

@end

NS_ASSUME_NONNULL_END

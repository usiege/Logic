//
//  LGTableDelegateHandler.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGTableManager;

NS_ASSUME_NONNULL_BEGIN

@interface LGTableDelegateHandler : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) LGTableManager *tableManager;

@end

NS_ASSUME_NONNULL_END

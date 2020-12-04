//
//  LGRowProtocol.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LGRowProtocolInitalType) {
    LGXIB,
    LGCODE
};

typedef UITableViewCell *(^LGCellForRow)(UITableView *tableView, NSIndexPath *indexPath);

@protocol LGRowProtocol <NSObject>

@property (nonatomic, strong) NSString *reuseIdentifier;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat estimatedHeight;

@property (nonatomic, assign) LGRowProtocolInitalType initalType;

///XIB Name or Class Name
@property (nonatomic, strong) NSString *registerName;

@property (nonatomic, copy) LGCellForRow cellForRowBlock;

@end

NS_ASSUME_NONNULL_END

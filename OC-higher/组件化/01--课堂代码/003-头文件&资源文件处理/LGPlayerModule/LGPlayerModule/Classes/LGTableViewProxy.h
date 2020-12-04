//
//  LGTableViewProxy.h
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGErrorView.h"
#import "LGTableViewCell.h"

typedef void(^LGConfigBlock)(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath);
typedef void(^LGActionBlock)(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath);

@interface LGTableViewProxy : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (copy) LGConfigBlock cellConfigBlock;
@property (copy) LGActionBlock cellActionBlock;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LGErrorView *errorView;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                          configuration:(LGConfigBlock)cBlock
                                 action:(LGActionBlock)aBlock NS_DESIGNATED_INITIALIZER;

@end

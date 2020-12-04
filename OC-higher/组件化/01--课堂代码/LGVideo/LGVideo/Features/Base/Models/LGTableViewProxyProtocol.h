//
//  LGTableViewProxyProtocol.h
//  LGVideo
//
//  Created by vampire on 2019/4/15.
//  Copyright © 2019 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LGConfigBlock)(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath);
typedef void(^LGActionBlock)(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath);

@protocol LGTableViewProxyProtocol <NSObject,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (copy) LGConfigBlock cellConfigBlock;
@property (copy) LGActionBlock cellActionBlock;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LGErrorView *errorView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                          configuration:(LGConfigBlock)cBlock
                                 action:(LGActionBlock)aBlock;

@end

NS_ASSUME_NONNULL_END

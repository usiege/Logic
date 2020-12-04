//
//  HomeTableViewProxy.h
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LGConfigBlock)(UITableViewCell *cell, id cellData, NSIndexPath *indexPath);
typedef void(^LGActionBlock)(UITableViewCell *cell, id cellData, NSIndexPath *indexPath);

@protocol LGTableViewProxyProtocol <NSObject,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (copy) LGConfigBlock cellConfigBlock;
@property (copy) LGActionBlock cellActionBlock;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                          configuration:(LGConfigBlock)cBlock
                                 action:(LGActionBlock)aBlock;

@end


@interface HomeTableViewProxy : NSObject<LGTableViewProxyProtocol>

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (copy) LGConfigBlock cellConfigBlock;
@property (copy) LGActionBlock cellActionBlock;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                          configuration:(LGConfigBlock)cBlock
                                 action:(LGActionBlock)aBlock;

@end


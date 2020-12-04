//
//  HomeTableViewProxy.h
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewProxy.h"
#import "LGTableViewProxyProtocol.h"

@interface HomeTableViewProxy : NSObject<LGTableViewProxyProtocol>

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

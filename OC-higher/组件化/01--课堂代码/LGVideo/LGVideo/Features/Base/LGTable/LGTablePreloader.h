//
//  LGTablePreloader.h
//  LGTable
//
//  Created by vampire on 2019/2/9.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGRowProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGTablePreloader : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, UITableViewCell *> *preloadPool;

- (void)preLoadCellWithTableView:(UITableView *)tableView row:(id<LGRowProtocol>)row;

- (void)reset;

@end

NS_ASSUME_NONNULL_END

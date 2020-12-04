//
//  LGTablePreloader.m
//  LGTable
//
//  Created by vampire on 2019/2/9.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGTablePreloader.h"

@interface LGTablePreloader ()

@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic, strong) NSMutableDictionary<NSString *, UITableViewCell *> *preloadPool;

@end

@implementation LGTablePreloader

- (void)preLoadCellWithTableView:(UITableView *)tableView row:(id<LGRowProtocol>)row{
    NSAssert([NSThread isMainThread], @"当前线程不是主线程");
    switch (row.initalType) {
        case LGCODE:
        {
           [tableView registerClass:NSClassFromString(row.registerName) forCellReuseIdentifier:row.reuseIdentifier];
        }
            break;
        case LGXIB:
        {
            UINib *nib = [UINib nibWithNibName:row.registerName bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:row.reuseIdentifier];
        }
            break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier];
    [self.lock lock];
    self.preloadPool[row.reuseIdentifier] = cell;
    [self.lock unlock];
}

- (void)reset{
    [self.lock lock];
    [self.preloadPool removeAllObjects];
    [self.lock unlock];
}

#pragma mark -- Getter and Setter

- (NSRecursiveLock *)lock{
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

- (NSMutableDictionary<NSString *, UITableViewCell *> *)preloadPool{
    if (!_preloadPool) {
        _preloadPool = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _preloadPool;
}

@end

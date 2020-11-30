//
//  LGBlockMonitor.h
//  LGMainThreadBlock
//
//  Created by cooci on 2019/12/30.
//  Copyright © 2020 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface LGBlockMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)start;

@end

NS_ASSUME_NONNULL_END

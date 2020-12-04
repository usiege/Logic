//
//  LGBaseRow.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGRowProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGBaseRow : NSObject<LGRowProtocol>

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, assign) LGRowProtocolInitalType initalType;
@property (nonatomic, copy) LGCellForRow cellForRowBlock;
@property (nonatomic, strong) NSString *registerName;
@property (nonatomic, assign) CGFloat estimatedHeight;

@end

NS_ASSUME_NONNULL_END

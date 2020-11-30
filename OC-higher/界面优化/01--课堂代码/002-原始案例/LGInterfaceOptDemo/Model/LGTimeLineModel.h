//
//  LGTimeLineModel.h
//  LGInterfaceOptDemo
//
//  Created by vampire on 2019/3/11.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGTimeLineModel : NSObject

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *contentImages;

@property (nonatomic, assign) NSUInteger cacheId;
@property (nonatomic, assign, getter=isExpand) BOOL expand;

@end

NS_ASSUME_NONNULL_END

//
//  LGDataSourceManager.h
//  LGVideo
//
//  Created by vampire on 2020/3/3.
//  Copyright © 2020 tztv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LGDataSourceType){
    LGDataSourceType_Home,
    LGDataSourceType_Follow,
    LGDataSourceType_Attention
};

@protocol LGDataSourceHandleProtocol;

@interface LGDataSourceManager : NSObject

- (instancetype)initWithServiceType:(LGDataSourceType)serviceType;

- (void)loadDataList:(NSInteger)currentPage completion:(void(^)(BOOL successed, NSError *error, id data))completionBlock;

@end

NS_ASSUME_NONNULL_END

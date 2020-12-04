//
//  LGDataSourceHandleProtocol.h
//  LGVideo
//
//  Created by vampire on 2020/3/2.
//  Copyright © 2020 tztv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LGDataSourceHandleProtocol <NSObject>

@required

- (void)lg_getDataList:(NSInteger)currentPage completion:(void(^)(BOOL successed, NSError *error, id data))completionBlock;

@optional

- (void)lg_getDataWithID:(NSString *)id completion:(void (^)(BOOL succeed, NSError *error, id data))cBlock;

@end

NS_ASSUME_NONNULL_END

//
//  LGDataSourceManager.m
//  LGVideo
//
//  Created by vampire on 2020/3/3.
//  Copyright © 2020 tztv. All rights reserved.
//

#import "LGDataSourceManager.h"

#import "HomeDataSource.h"
#import "FollowDataSource.h"
#import "DiscoveryDataSource.h"

@interface LGDataSourceManager ()

@property (nonatomic, strong) id<LGDataSourceHandleProtocol> dataSrvice;

@end

@implementation LGDataSourceManager

- (instancetype)initWithServiceType:(LGDataSourceType)serviceType{
    self = [super init];
    if (self) {
       _dataSrvice = [self loadService:serviceType];
    }
    return self;
}

- (id<LGDataSourceHandleProtocol>)loadService:(LGDataSourceType)serviceType{
    id<LGDataSourceHandleProtocol> dataSourceHandle = nil;
    switch (serviceType) {
        case LGDataSourceType_Home:{
            dataSourceHandle = [HomeDataSource new];
        }
            break;
        case LGDataSourceType_Follow:{
            dataSourceHandle = [FollowDataSource new];
        }
            break;
        case LGDataSourceType_Attention:{
            dataSourceHandle = [DiscoveryDataSource new];
        }
            break;
        default:
            break;
    }
    NSAssert(!dataSourceHandle, @"服务未发现");
    return dataSourceHandle;
}

- (void)loadDataList:(NSInteger)currentPage completion:(void(^)(BOOL successed, NSError *error, id data))completionBlock{
    NSAssert(!_dataSrvice, @"服务未发现");
    [_dataSrvice lg_getDataList:currentPage completion:completionBlock];
}


@end

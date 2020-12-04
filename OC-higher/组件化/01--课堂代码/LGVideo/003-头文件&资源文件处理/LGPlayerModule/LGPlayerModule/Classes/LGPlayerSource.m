//
//  LGPlayerSource.m
//  LGVideo
//
//  Created by LG on 2018/5/26.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerSource.h"

@implementation LGPlayerSource

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [LGPlayerDataSource new];
    }
    return self;
}

- (void)getPlayerVideoUrl:(NSString *)videoId completion:(void (^)(LGPlayerVideoUrlResponse *))cBlock {
    [_dataSource getPlayerVideoUrl:videoId completion:^(BOOL succeed, NSError *error, id data) {
        if (data && [data isKindOfClass:[LGPlayerVideoUrlResponse class]]) {
            LGPlayerVideoUrlResponse *response = (LGPlayerVideoUrlResponse *)data;
            self.videoInfo = response;
            if (cBlock) {
                cBlock(response);
            }
        }
    }];
}

@end

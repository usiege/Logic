//
//  LGPlayerSource.h
//  LGVideo
//
//  Created by LG on 2018/5/26.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGPlayerDataSource.h"

@interface LGPlayerSource : NSObject
@property (nonatomic, strong) LGPlayerVideoUrlResponse *videoInfo;
@property (nonatomic, strong) LGPlayerDataSource *dataSource;

- (void)getPlayerVideoUrl:(NSString *)videoId completion:(void (^)(LGPlayerVideoUrlResponse *))cBlock;

@end

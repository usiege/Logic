//
//  LGPlayerDataSource.m
//  LGVideo
//
//  Created by LG on 2018/5/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerDataSource.h"

@implementation LGPlayerDataSource

- (void)getPlayerVideoUrl:(NSString *)videoId completion:(void (^)(BOOL, NSError *, id))completionBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Player_Video_Url" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    LGPlayerVideoUrlResponse *response = [[LGPlayerVideoUrlResponse alloc] initWithData:data error:&error];
    if (completionBlock) completionBlock(YES, error, response);
}

@end

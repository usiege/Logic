//
//  LGPlayerVideoInfoSource.m
//  LGVideo
//
//  Created by LG on 2018/6/30.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerVideoInfoSource.h"

@implementation LGPlayerVideoInfoSource

- (void)getVideoInfoResponse:(NSString *)videoId completion:(void (^)(LGPlayerVideoInfoResponse *))cBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Player_Video_Info" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    LGPlayerVideoInfoResponse *response = [[LGPlayerVideoInfoResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(response);
}

- (void)getVideoComment:(NSString *)videoId completion:(void (^)(LGCommentResponse *))cBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Player_Video_Comment" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    LGCommentResponse *response = [[LGCommentResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(response);
}
@end

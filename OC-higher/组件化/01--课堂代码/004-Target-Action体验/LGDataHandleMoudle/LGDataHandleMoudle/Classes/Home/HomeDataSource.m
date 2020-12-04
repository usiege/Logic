//
//  HomeDataSource.m
//  LGVideo
//
//  Created by LG on 2018/5/9.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeDataSource.h"

@implementation HomeDataSource

- (void)getChannelListCompletion:(void (^)(BOOL, NSError *, id))cBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Home_Channel_List" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    HomeChannelListResponse *response = [[HomeChannelListResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(YES, error, response);
}

- (void)getChannel:(NSString *)channelId completion:(void (^)(BOOL, NSError *, id))cBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Home_TableView_Response_%@", channelId] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    HomeTemplateResponse *response = [[HomeTemplateResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(YES, error, response);
}

@end

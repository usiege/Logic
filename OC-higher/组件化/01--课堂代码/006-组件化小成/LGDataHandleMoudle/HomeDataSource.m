//
//  HomeDataSource.m
//  LGVideo
//
//  Created by LG on 2018/5/9.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeDataSource.h"

@implementation HomeDataSource

- (void)lg_getDataList:(NSInteger)currentPage completion:(void(^)(BOOL successed, NSError *error, id data))completionBlock{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Home_Channel_List" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    HomeChannelListResponse *response = [[HomeChannelListResponse alloc] initWithData:data error:&error];
    if (completionBlock) completionBlock(YES, error, response);
}


- (void)lg_getDataWithID:(NSString *)id completion:(void (^)(BOOL succeed, NSError *error, id data))cBlock{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Home_TableView_Response_%@", id] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    HomeTemplateResponse *response = [[HomeTemplateResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(YES, error, response);
}


@end

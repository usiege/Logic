//
//  FollowDataSource.m
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowDataSource.h"
//#import "FollowCellHeader.h"
#import "FollowCellViewModel.h"
#import "FollowListResponse.h"

@implementation FollowDataSource

- (void)lg_getDataList:(NSInteger)currentPage completion:(void (^)(BOOL, NSError * _Nonnull, id _Nonnull))completionBlock{
       NSString *path = [[NSBundle mainBundle] pathForResource:@"Follow_List" ofType:@"json"];
       NSData *data = [NSData dataWithContentsOfFile:path];
       NSError *error = nil;
       FollowListResponse *response = [[FollowListResponse alloc] initWithData:data error:&error];
       NSArray *viewModelArray = [self configureViewModelWithResponse:response];
       if (completionBlock) completionBlock(YES, error, viewModelArray);
}

- (NSArray *)configureViewModelWithResponse:(FollowListResponse *)response{
    NSMutableArray *tmpViewModelArray = [NSMutableArray arrayWithCapacity:0];
    for (FollowListItem *item in response.data) {
        id<FollowCellViewModelProtocol> viewModel = [FollowCellViewModel new];
        viewModel.cellClassName = [item cellClassName];
        viewModel.name = item.publisher.name;
        viewModel.time = @"刚刚";
        viewModel.title = item.title;
        viewModel.content = item.desc;
        viewModel.imageURLArray = item.images;
        viewModel.videCoverImage = item.video.cover;
        [tmpViewModelArray addObject:viewModel];
    }
    return [tmpViewModelArray copy];
}


@end

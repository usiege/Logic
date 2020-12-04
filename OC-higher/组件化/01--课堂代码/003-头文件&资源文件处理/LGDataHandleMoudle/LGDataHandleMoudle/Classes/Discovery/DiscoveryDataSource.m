//
//  DiscoveryDataSource.m
//  LGVideo
//
//  Created by LG on 2018/6/21.
//  Copyright © 2018 LG. All rights reserved.
//

#import "DiscoveryDataSource.h"

@implementation DiscoveryPublisher
@end

@implementation DiscoveryListItem
@end

@implementation DiscoveryListResponse
@end

@implementation DiscoveryDataSource

+ (void)getDiscoveryList:(NSInteger)page completion:(void (^)(BOOL, NSError *, id))cBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Discovery_List" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    DiscoveryListResponse *response = [[DiscoveryListResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(YES, error, response);
}

@end

//
//  FollowDataSource.m
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import "FollowDataSource.h"
#import "FollowCellHeader.h"

@implementation FollowPublisher
@end

@implementation FollowVideoItem
@end

@implementation FollowListItem
- (NSString *)cellClassName {
    switch (self.type.integerValue) {
        case 1:
            return NSStringFromClass(FollowBaseCell.class);
            break;
        case 2:
            return NSStringFromClass(FollowImageCell.class);
            break;
        case 3:
            return NSStringFromClass(FollowVideoCell.class);
            break;
        default:
            return NSStringFromClass(FollowBaseCell.class);
            break;
    }
}
@end

@implementation FollowListResponse
@end

@implementation FollowDataSource

+ (void)getFollowList:(NSInteger)page completion:(void (^)(BOOL, NSError *, id))cBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Follow_List" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    FollowListResponse *response = [[FollowListResponse alloc] initWithData:data error:&error];
    if (cBlock) cBlock(YES, error, response);
}

@end

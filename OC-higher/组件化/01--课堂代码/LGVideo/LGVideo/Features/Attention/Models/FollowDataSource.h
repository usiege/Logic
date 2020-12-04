//
//  FollowDataSource.h
//  LGVideo
//
//  Created by LG on 2018/6/23.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGResponse.h"

@interface FollowPublisher : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@end

@interface FollowVideoItem : JSONModel
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *videoId;
@end

@protocol FollowListItem
@end
@interface FollowListItem : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSArray <Optional> *images;
@property (nonatomic, strong) FollowVideoItem <Optional> *video;
@property (nonatomic, strong) FollowPublisher *publisher;

- (NSString *)cellClassName;
@end

@interface FollowListResponse : LGResponse

@property (nonatomic, strong) NSArray <FollowListItem> *data;

@end

@interface FollowDataSource : NSObject

+ (void)getFollowList:(NSInteger)page completion:(void (^)(BOOL succeed, NSError *error, id data))cBlock;

@end

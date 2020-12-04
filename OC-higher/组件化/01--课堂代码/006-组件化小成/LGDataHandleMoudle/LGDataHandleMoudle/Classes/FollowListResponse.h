//
//  FollowListResponse.h
//  LGVideo
//
//  Created by vampire on 2020/3/13.
//  Copyright © 2020 tztv. All rights reserved.
//

#import "LGResponse.h"

NS_ASSUME_NONNULL_BEGIN


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

NS_ASSUME_NONNULL_END

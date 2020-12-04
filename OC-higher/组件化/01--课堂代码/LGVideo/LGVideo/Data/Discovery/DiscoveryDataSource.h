//
//  DiscoveryDataSource.h
//  LGVideo
//
//  Created by LG on 2018/6/21.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGResponse.h"

@interface DiscoveryPublisher : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@end


@protocol DiscoveryListItem
@end
@interface DiscoveryListItem : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) DiscoveryPublisher *publisher;

@end

@interface DiscoveryListResponse : LGResponse

@property (nonatomic, strong) NSArray <DiscoveryListItem> *data;

@end

@interface DiscoveryDataSource : NSObject

+ (void)getDiscoveryList:(NSInteger)page completion:(void (^)(BOOL succeed, NSError *error, id data))cBlock;

@end

//
//  HomeDataSource.h
//  LGVideo
//
//  Created by LG on 2018/5/9.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeTemplateResponse.h"

@interface HomeDataSource : NSObject

- (void)getChannelListCompletion:(void (^)(BOOL succeed, NSError *error, id data))cBlock;

- (void)getChannel:(NSString *)channelId completion:(void (^)(BOOL succeed, NSError *error, id data))cBlock;

@end

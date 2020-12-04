//
//  LGPlayerVideoInfoSource.h
//  LGVideo
//
//  Created by LG on 2018/6/30.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGPlayerVideoInfoResponse.h"

@interface LGPlayerVideoInfoSource : NSObject

- (void)getVideoInfoResponse:(NSString *)videoId completion:(void (^)(LGPlayerVideoInfoResponse *))cBlock;

- (void)getVideoComment:(NSString *)videoId completion:(void (^)(LGCommentResponse *))cBlock;
@end

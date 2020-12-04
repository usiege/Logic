//
//  LGPlayerDataSource.h
//  LGVideo
//
//  Created by LG on 2018/5/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGPlayerResponse.h"

@interface LGPlayerDataSource : NSObject

- (void)getPlayerVideoUrl:(NSString *)videoId completion:(void (^)(BOOL, NSError *, id))completionBlock;

@end

//
//  LGMediator.h
//  LGVideo
//
//  Created by LG on 2018/5/16.
//  Copyright © 2018 LG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGMediator : NSObject

+ (UIViewController *)currentViewController;
+ (void)jumpToPlayerVC:(id)data;

@end

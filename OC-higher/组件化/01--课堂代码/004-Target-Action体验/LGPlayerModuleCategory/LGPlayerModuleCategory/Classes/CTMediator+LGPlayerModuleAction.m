//
//  CTMediator+LGPlayerModuleAction.m
//  CTMediator
//
//  Created by vampire on 2020/3/19.
//

#import "CTMediator+LGPlayerModuleAction.h"

NSString * const kCTMediatorTargetLGPlayerModule = @"LGPlayerModule";
NSString * const kCTMediatorActionNativeLGPlayerViewController = @"nativeLGPlayerViewController";

@implementation CTMediator (LGPlayerModuleAction)

- (UIViewController *)CTMediator_naviagetPlayerVC:(NSString *)videoID title:(NSString *)videoTitle{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetLGPlayerModule
                                                    action:kCTMediatorActionNativeLGPlayerViewController
                                                    params:@{@"videoID":videoID,
                                                             @"videoTitle":videoTitle
                                                    }
                                         shouldCacheTarget:NO
                                        ];
    
    return viewController;
}

@end

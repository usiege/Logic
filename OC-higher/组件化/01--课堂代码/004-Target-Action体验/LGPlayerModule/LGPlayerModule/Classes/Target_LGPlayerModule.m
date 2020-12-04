//
//  Target_LGPlayerModule.m
//  AFNetworking
//
//  Created by vampire on 2020/3/18.
//

#import "Target_LGPlayerModule.h"
#import "LGPlayerViewController.h"

@implementation Target_LGPlayerModule

- (UIViewController *)Action_nativeLGPlayerViewController:(NSDictionary * _Nonnull )param{
    LGPlayerViewController *vc = [[LGPlayerViewController alloc] init];
    vc.videoId = param[@"videoID"];
    vc.videoTitle = param[@"videoTitle"];
    return vc;
}

@end

//
//  LGMediator.m
//  LGVideo
//
//  Created by LG on 2018/5/16.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGMediator.h"
#import "LGPlayerViewController.h"
#import "HomeTemplateResponse.h"

@implementation LGMediator

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [LGMediator topViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController*)vc;
        if (svc.viewControllers.count > 0) {
            return [LGMediator topViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navC = (UINavigationController*)vc;
        if (navC.viewControllers.count > 0) {
            return [LGMediator topViewController:navC.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabC = (UITabBarController*)vc;
        if (tabC.viewControllers.count > 0) {
            return [LGMediator topViewController:tabC.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

+ (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [LGMediator topViewController:keyWindow.rootViewController];
    return vc;
}
//跳转到播放页面
+ (void)jumpToPlayerVC:(id)data {
    LGPlayerViewController *vc = [LGPlayerViewController new];
    [[LGMediator currentViewController].navigationController pushViewController:vc animated:YES];
}

@end

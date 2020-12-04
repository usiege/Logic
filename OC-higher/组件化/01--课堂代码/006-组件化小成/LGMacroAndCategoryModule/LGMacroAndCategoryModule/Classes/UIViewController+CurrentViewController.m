//
//  UIViewController+CurrentViewController.m
//  LGMacroAndCategoryModule
//
//  Created by LG on 2018/3/19.
//

#import "UIViewController+CurrentViewController.h"

@implementation UIViewController (CurrentViewController)

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self topViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController*)vc;
        if (svc.viewControllers.count > 0) {
            return [self topViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navC = (UINavigationController*)vc;
        if (navC.viewControllers.count > 0) {
            return [self topViewController:navC.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabC = (UITabBarController*)vc;
        if (tabC.viewControllers.count > 0) {
            return [self topViewController:tabC.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

+ (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [self topViewController:keyWindow.rootViewController];
    return vc;
}



@end

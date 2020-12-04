//
//  ViewController.m
//  LGVideo
//
//  Created by LG on 2018/1/24.
//  Copyright © 2018年 LG. All rights reserved.
//

#import "MainViewController.h"
#import "LGNavigationViewController.h"
#import "HomeViewController.h"
#import "FollowViewController.h"
#import "DiscoveryViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIColor *backgroundColor = LGBackgroundColor;
    UIColor *foregroundColor = LGForegroundColor;
    
    self.tabBar.barTintColor = backgroundColor;
    self.tabBar.tintColor = foregroundColor;
    NSArray *titlesArr = @[@"首页", @"发现", @"关注"];
    NSArray *imagesArr = @[@"tabbar_home", @"tabbar_discovery", @"tabbar_follow"];
    self.viewControllers = @[[[LGNavigationViewController alloc] initWithRootViewController:[HomeViewController new]],
                             [[LGNavigationViewController alloc] initWithRootViewController:[DiscoveryViewController new]],
                             [[LGNavigationViewController alloc] initWithRootViewController:[FollowViewController new]]];
    for (int index = 0; index < self.viewControllers.count; index++) {
        LGNavigationViewController *vc = self.viewControllers[index];
        vc.tabBarItem.title = titlesArr[index];
        vc.tabBarItem.image = [UIImage imageNamed:imagesArr[index]];

        vc.navigationBar.barTintColor = backgroundColor;
        vc.navigationBar.tintColor = foregroundColor;
        vc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: foregroundColor};
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Rotate
- (BOOL)shouldAutorotate {
    return [[LGMediator currentViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[LGMediator currentViewController] supportedInterfaceOrientations];
}

@end

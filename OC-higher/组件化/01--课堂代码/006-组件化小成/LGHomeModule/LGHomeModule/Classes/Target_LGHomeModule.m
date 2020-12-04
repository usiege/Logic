//
//  Target_LGHomeModule.m
//  AFNetworking
//
//  Created by vampire on 2020/3/25.
//

#import "Target_LGHomeModule.h"
#import "HomeViewController.h"

@implementation Target_LGHomeModule

- (UIViewController *)Action_nativeHomeViewController:(NSDictionary * _Nonnull )params{
    HomeViewController *vc = [HomeViewController new];
    return vc;
}

@end

//
//  LGNavigationViewController.m
//  LGVideo
//
//  Created by LG on 25/02/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGNavigationViewController.h"

@interface LGNavigationViewController ()

@end

@implementation LGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [ self.topViewController supportedInterfaceOrientations];
}

@end

//
//  ViewController.m
//  006--CoreAnimation
//
//  Created by CC老师 on 2018/12/18.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "ViewController.h"
#import "CCViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//固定图层
- (IBAction)PushViewController:(id)sender {
    CCViewController *CV = [[CCViewController
                             alloc]init];
    [self presentViewController:CV animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

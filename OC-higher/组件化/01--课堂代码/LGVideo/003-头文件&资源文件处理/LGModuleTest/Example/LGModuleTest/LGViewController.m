//
//  LGViewController.m
//  LGModuleTest
//
//  Created by cooci_tz@163.com on 03/23/2020.
//  Copyright (c) 2020 cooci_tz@163.com. All rights reserved.
//

#import "LGViewController.h"

@interface LGViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageView.image = [UIImage imageNamed:@"share_wechat"];
   
    NSLog(@"加载图片");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

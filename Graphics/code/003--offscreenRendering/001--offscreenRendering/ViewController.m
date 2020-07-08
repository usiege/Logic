//
//  ViewController.m
//  001--offscreenRendering
//
//  Created by CC老师 on 2020/6/30.
//  Copyright © 2020年 CC老师. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.按钮存在背景图片
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 30, 100, 100);
    btn1.layer.cornerRadius = 50;
    [self.view addSubview:btn1];
    
    [btn1 setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    btn1.clipsToBounds = YES;
    
    //2.按钮不存在背景图片
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 180, 100, 100);
    btn2.layer.cornerRadius = 50;
    btn2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn2];
    btn2.clipsToBounds = YES;
    
    //3.UIImageView 设置了图片+背景色;
    UIImageView *img1 = [[UIImageView alloc]init];
    img1.frame = CGRectMake(100, 320, 100, 100);
    img1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:img1];
    img1.layer.cornerRadius = 50;
    img1.layer.masksToBounds = YES;
    img1.image = [UIImage imageNamed:@"btn.png"];
    
    //4.UIImageView 只设置了图片,无背景色;
    UIImageView *img2 = [[UIImageView alloc]init];
    img2.frame = CGRectMake(100, 480, 100, 100);
    [self.view addSubview:img2];
    img2.layer.cornerRadius = 50;
    img2.layer.masksToBounds = YES;
    img2.image = [UIImage imageNamed:@"btn.png"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

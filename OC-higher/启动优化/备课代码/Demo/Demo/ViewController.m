//
//  ViewController.m
//  Demo
//
//  Created by hank on 2020/3/16.
//  Copyright © 2020 hank. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
+(void)load
{
    NSLog(@"ViewController");
}

-(void)test2{
    
}

-(void)test1{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self test2];
}


@end

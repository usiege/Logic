//
//  ViewController.m
//  Demo
//
//  Created by hank on 2020/11/18.
//  Copyright © 2020 hank. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

+(void)load
{
    
    printf("load");
    test2();
}


void test1(){
    printf("1");
}


void  test2(){
    
    printf("2");
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    printf("viewDidLoad");
    test1();//MachO 文件中.创建一个符号!NSLog --> NSLog地址
}



@end

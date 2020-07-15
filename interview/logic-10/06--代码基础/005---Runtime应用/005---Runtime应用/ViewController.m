//
//  ViewController.m
//  005---Runtime应用
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"Hank",@"Cooci",@"Kody",@"CC"];
    [NSArray load];
    NSLog(@"%@",self.dataArray[4]);
    
}


@end

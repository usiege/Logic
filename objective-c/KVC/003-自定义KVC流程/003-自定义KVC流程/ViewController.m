//
//  ViewController.m
//  03-自定义KVC流程
//
//  Created by Cooci on 2019/12/9.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"
#import "NSObject+LGKVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LGPerson *person = [[LGPerson alloc] init];
    [person lg_setValue:@"大师班牛逼" forKey:@"name"];
    
}


@end

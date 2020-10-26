//
//  ViewController.m
//  006---Method-Swizzling坑
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"
#import "LGStudent.h"
#import "LGStudent+LG.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LGStudent *s = [[LGStudent alloc] init];
    [s helloword];
 
}


@end

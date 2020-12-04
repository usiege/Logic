//
//  LGViewController.m
//  LGCommonUIModule
//
//  Created by LGCooci on 02/25/2020.
//  Copyright (c) 2020 LGCooci. All rights reserved.
//

#import "LGViewController.h"
#import "LGErrorView.h"

@interface LGViewController ()

@end

@implementation LGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LGErrorView *error = [LGErrorView errorViewWith:LGErrorViewType_Unknown];
    [self.view addSubview:error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

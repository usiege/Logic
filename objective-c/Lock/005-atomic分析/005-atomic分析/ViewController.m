//
//  ViewController.m
//  005-atomic分析
//
//  Created by Cooci on 2019/2/29.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (atomic, copy) NSString *lg_name;
@property (atomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [self lg_test_atomic1];
    [self lg_test_atomic2];
}

- (void)lg_test_atomic1{
    self.lg_name = @"LG_Cooci";
}


- (void)lg_test_atomic2{
    //Thread A
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100000; i ++) {
            if (i % 2 == 0) {
                self.array = @[@"Hank", @"CC", @"Cooci"];
            }
            else {
                self.array = @[@"Kody"];
            }
            NSLog(@"Thread A: %@\n", self.array);
        }
    });
    
    //Thread B
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100000; i ++) {
            if (self.array.count >= 2) {
                NSString* str = [self.array objectAtIndex:1];
            }
            NSLog(@"Thread B: %@\n",self.array);
        }
    });
}

@end

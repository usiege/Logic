//
//  ViewController.m
//  006---FBKVOController探索
//
//  Created by cooci on 2019/3/6.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import <FBKVOController.h>
#import "LGPerson.h"

@interface ViewController ()
@property (nonatomic, strong) FBKVOController *kvoCtrl;
@property (nonatomic, strong) LGPerson *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.person = [[LGPerson alloc] init];
    self.person.name = @"cooci";
    self.person.age = 18;
    self.person.mArray = [NSMutableArray arrayWithObject:@"1"];

    [self.kvoCtrl observe:self.person keyPath:@"age" options:0 action:@selector(lg_observerAge)];
    [self.kvoCtrl observe:self.person keyPath:@"name" options:(NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"****%@****",change);
    }];
    [self.kvoCtrl observe:self.person keyPath:@"mArray" options:(NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"****%@****",change);
    }];
    
}

- (void)lg_observerAge{
    NSLog(@"来了 改变年级");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击屏幕");
    self.person.name = [NSString stringWithFormat:@"%@+",self.person];
    self.person.age ++;
    [[self.person mutableArrayValueForKey:@"mArray"] addObject:self.person.name];
}

#pragma mark - lazy
- (FBKVOController *)kvoCtrl{
    if (!_kvoCtrl) {
        _kvoCtrl = [FBKVOController controllerWithObserver:self];
    }
    return _kvoCtrl;
}

@end

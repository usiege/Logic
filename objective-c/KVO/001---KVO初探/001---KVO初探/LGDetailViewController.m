//
//  LGDetailViewController.m
//  001---KVO初探
//
//  Created by cooci on 2019/1/4.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGDetailViewController.h"
#import "LGStudent.h"

@interface LGDetailViewController ()
@property (nonatomic, strong) LGStudent *student;
@end

@implementation LGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.student = [LGStudent shareInstance];
    [self.student addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:NULL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.student.name = @"hello word";
}
#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"LGDetailViewController :%@",change);
}

- (void)dealloc{
    [self.student removeObserver:self forKeyPath:@"name"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

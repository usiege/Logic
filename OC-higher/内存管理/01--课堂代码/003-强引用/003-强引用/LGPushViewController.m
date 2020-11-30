//
//  LGPushViewController.m
//  003---强引用问题
//
//  Created by cooci on 2019/1/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGPushViewController.h"
#import "LGProxy.h"

@interface LGPushViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (nonatomic, strong) LGProxy *proxy;
@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *lgImageView;

@end

@implementation LGPushViewController


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tf resignFirstResponder];
    self.proxy = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self.proxy name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // self -> proxy -> self
    self.proxy = [LGProxy proxyWithTransformObject:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.proxy selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)note{
    NSLog(@"note == %@ --- %@",note,self);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tf resignFirstResponder];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
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

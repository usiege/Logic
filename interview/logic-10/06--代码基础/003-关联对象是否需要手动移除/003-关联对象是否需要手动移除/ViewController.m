//
//  ViewController.m
//  003-关联对象是否需要手动移除
//
//  Created by cooci on 2019/2/21.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "objc/runtime.h"
#import "LGPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self printClassAllMethod:[LGPerson class]];
}

#pragma mark - 遍历方法-ivar-property
- (void)printClassAllMethod:(Class)cls{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(cls, &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = propertyList[i];
        NSString *name = @(property_getName(property));
        NSLog(@"%@",name);
    }
    free(propertyList);
}



@end

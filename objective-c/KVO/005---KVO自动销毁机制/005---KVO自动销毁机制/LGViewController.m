//
//  LGViewController.m
//  005---KVO自动销毁机制
//
//  Created by cooci on 2019/1/5.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGViewController.h"
#import "LGPerson.h"
#import "NSObject+LGKVO.h"
#import <objc/runtime.h>

@interface LGViewController ()
@property (nonatomic, strong) LGPerson *person;
@end

@implementation LGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[LGPerson alloc] init];
    
    [self.person addObserver:self forKeyPath:@"nickName" options:(NSKeyValueObservingOptionNew) context:NULL];
    
//    [self.person lg_addObserver:self forKeyPath:@"nickName" block:^(id  _Nonnull observer, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
//        NSLog(@"%@-%@",oldValue,newValue);
//    }];
//
    self.person.nickName = @"KC";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.person.nickName = [NSString stringWithFormat:@"%@+",self.person.nickName];
}

- (void)dealloc{
    // 这里我们不想操作了我们的销毁代码
    // 我们就想把销毁的代码隐藏起来
    // 我们就在分类重写dealloc --- 两个问题
    // -| 我们要想dealloc 就需要这个对象销毁 --
    // -| 我们分类重写会导致所有的类都交换了
    
    NSLog(@"销毁 走你");
}

#pragma mark - 遍历方法-ivar-property
- (void)printClassAllMethod:(Class)cls{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        //IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@",NSStringFromSelector(sel));
    }
    free(methodList);
}

#pragma mark - 遍历类以及子类
- (void)printClasses:(Class)cls{
    /// 注册类的总数
    int count = objc_getClassList(NULL, 0);
    /// 创建一个数组， 其中包含给定对象
    NSMutableArray *mArray = [NSMutableArray arrayWithObject:cls];
    /// 获取所有已注册的类
    Class* classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    for (int i = 0; i<count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [mArray addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"classes = %@", mArray);
}
@end

//
//  KCImageManger.m
//  004--GCD进阶使用
//
//  Created by Cooci on 2018/7/2.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCImageManger.h"
// 保存在常量区
static id instance;

@implementation KCImageManger


/**
 每次类初始化的时候进行调用

 1、+load它不遵循那套继承规则。如果某个类本身没有实现+load方法，那么不管其它各级超类是否实现此方法，系统都不会调用。+load方法调用顺序是：SuperClass -->SubClass --> CategaryClass。
 
 3、+initialize是在类或者它的子类接受第一条消息前被调用，但是在它的超类接收到initialize之后。也就是说+initialize是以懒加载的方式被调用的，如果程序一直没有给某个类或它的子类发送消息，那么这个类的+initialize方法是不会被调用的。
 
 4、只有执行+initialize的那个线程可以操作类或类实例，其他线程都要阻塞等着+initialize执行完。
 5、+initialize  本身类的调用都会执行父类和分类实现 initialize方法都会被调多次
 
 */
+ (void)initialize{
    NSLog(@"父类");
    if (instance == nil) {
        instance = [[self alloc] init];
    }
}
/**
 配合上面 也能进行单利
 */
+ (instancetype)manager{
    return instance;
}

/**
 * 所有为类的对象分配空间的方法，最终都会调用到 allovWithZone 方法
 * 下面这样的操作相当于锁死 该类的所有初始化方法
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

/**
 单利
 */
+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end

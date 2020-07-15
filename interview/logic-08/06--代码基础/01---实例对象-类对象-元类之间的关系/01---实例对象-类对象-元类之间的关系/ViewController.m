//
//  ViewController.m
//  01---实例对象-类对象-元类之间的关系
//
//  Created by cooci on 2019/2/8.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "LGPerson.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LGPerson *p = [[LGPerson alloc] init];
    p.name      = @"Cooci";
    p.age       = 18;
    
    Class class1= [LGPerson class];
    Class class2= p.class;
    Class class3= object_getClass(p);
    NSLog(@"\n%p-\n%p-\n%p",class1,class2,class3);
    
    Class class4= object_getClass(class3);
    NSLog(@"\n%p",class4);
    NSLog(@"end");

}

- (void)lgPrintClassRelationshipWithObject:(id)objc{
    NSLog(@"*********************************************");

    NSLog(@"\n实例对象地址 - %p",objc);
    NSLog(@"\n类对象地址 - %p",[objc class]);
    NSLog(@"\n父类对象地址 - %p",[objc superclass]);
    NSLog(@"\n元类对象地址 - %p",object_getClass(objc));
    NSLog(@"\n元类的父类对象地址 - %p",[object_getClass(objc) superclass]);
    NSLog(@"\n根元类对象地址 - %p",object_getClass(object_getClass(objc)));
    NSLog(@"\n根元类的父类对象地址 - %p",[object_getClass(object_getClass(objc)) superclass]);
    NSLog(@"\n根根元类对象地址 - %p",object_getClass(object_getClass(object_getClass(objc))));
    NSLog(@"\n根根元类的父类对象地址 - %p",[object_getClass(object_getClass(object_getClass(objc))) superclass]);
    NSLog(@"*********************************************");

}


@end

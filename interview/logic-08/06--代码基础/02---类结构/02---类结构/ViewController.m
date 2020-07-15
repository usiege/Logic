//
//  ViewController.m
//  02---类结构
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
    
    Class class1= object_getClass(p);
    Class class2= object_getClass(class1);
    NSLog(@"\n%p - %p",class1,class2);
    NSLog(@"end");
    // b0 ae 60 55 02 00 00 00
    //
}


@end

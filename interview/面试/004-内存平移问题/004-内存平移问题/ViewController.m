//
//  ViewController.m
//  004-内存平移问题
//
//  Created by cooci on 2020/10/21.
//

#import "ViewController.h"
#import "LGPerson.h"

@interface ViewController ()

@end

@implementation ViewController

// 高地址 -> 低地址
void kcFunction(id person, id kcSel, id kcSel2){
    NSLog(@"person = %p",&person);
    NSLog(@"person = %p",&kcSel);
    NSLog(@"person = %p",&kcSel2);
}


// 1: 参数 会从前往后一直压
// 2: 结构体的属性 是怎么一个压栈情况 self superclass

struct kc_struct{
    NSNumber *num1;
    NSNumber *num2;
} kc_struct;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ViewController 当前的类
    // self cmd (id)class_getSuperclass(objc_getClass("LGTeacher")) self cls kc person
    
    Class cls = [LGPerson class];
    void  *kc = &cls;  // 
    LGPerson *person = [LGPerson alloc];
    NSLog(@"%p - %p",&person,kc);
    // 隐藏参数 会压入栈帧
    void *sp  = (void *)&self;
    void *end = (void *)&person;
    long count = (sp - end) / 0x8;
    
    for (long i = 0; i<count; i++) {
        void *address = sp - 0x8 * i;
        if ( i == 1) {
            NSLog(@"%p : %s",address, *(char **)address);
        }else{
            NSLog(@"%p : %@",address, *(void **)address);
        }
    }
    
    
    // LGPerson  - 0x7ffeea0c50f8
    [(__bridge id)kc saySomething]; // 1 2  - <ViewController: 0x7f7f7ec09490>
    
    [person saySomething]; // self.kc_name = nil - (null)

    //
}


@end

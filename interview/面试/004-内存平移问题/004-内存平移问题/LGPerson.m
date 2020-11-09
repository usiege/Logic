//
//  LGPerson.m
//  004-内存平移问题
//
//  Created by cooci on 2020/10/21.
//

#import "LGPerson.h"

@implementation LGPerson
- (void)saySomething{ // self 消息接受者 - LGPerson: 0x7ffee8a7c0e8
    // person -> kc_name  -> 8字节
    // 0x7ffee8a7c0e8 + 0x8 = 0x00007ffee8a7c0f0  <ViewController: 0x7feb9ef081d0>
    // LGPerson: 0x7ffee8a7c0e8
    // person VS LGPerson (实例化) (isa)
    // kc -> LGPerson (实例化) kc_name
    NSLog(@"%s - %@",__func__,self.kc_name);
}
@end

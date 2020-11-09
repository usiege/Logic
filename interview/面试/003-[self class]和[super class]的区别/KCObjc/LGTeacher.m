//
//  LGTeacher.m
//  KCObjc
//
//  Created by cooci on 2020/10/20.
//

#import "LGTeacher.h"

@implementation LGTeacher
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%@ - %@",[self class],[super class]);
    }
    return self;
}

// msgSend :
// LGTeacher

// super : 关键字
// [super class] (class)(id self , sel _cmd)
// self->isa LGTeacher
// self 消息的接受者 LGTeacher
// objc_msgSendSuper2  结构体
// 没有分析对

@end

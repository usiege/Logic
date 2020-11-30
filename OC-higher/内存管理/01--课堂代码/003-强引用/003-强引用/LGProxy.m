//
//  LGProxy.m
//  003---强引用问题
//
//  Created by cooci on 2019/1/17.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGProxy.h"

@interface LGProxy()
@property (nonatomic, weak) id object;
@end

@implementation LGProxy
+ (instancetype)proxyWithTransformObject:(id)object{
    LGProxy *proxy = [LGProxy alloc];
    proxy.object = object;
    return proxy;
}

// 仅仅添加了weak类型的属性还不够，为了保证中间件能够响应外部self的事件，需要通过消息转发机制，让实际的响应target还是外部self，这一步至关重要，主要涉及到runtime的消息机制。
// 转移
// 强引用 -> 消息转发

-(id)forwardingTargetForSelector:(SEL)aSelector {
    return self.object;
}

//// sel - imp -
//// 消息转发 self.object
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
//
//    if (self.object) {
//    }else{
//        NSLog(@"麻烦收集 stack111");
//    }
//    return [self.object methodSignatureForSelector:sel];
//
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation{
//
//    if (self.object) {
//        [invocation invokeWithTarget:self.object];
//    }else{
//        NSLog(@"麻烦收集 stack");
//    }
//
//}

@end

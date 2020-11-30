//
//  ViewController.m
//  TraceDemo
//
//  Created by hank on 2020/3/16.
//  Copyright © 2020 hank. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import <libkern/OSAtomic.h>
#import "TraceDemo-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

+(void)initialize
{
    
}

void(^block1)(void) = ^(void) {
    
};

void test(){
    block1();
    
}

+(void)load
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SwiftTest swiftTestLoad];
    test();
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray <NSString *> * symbolNames = [NSMutableArray array];
    
    while (YES) {
        SYNode * node = OSAtomicDequeue(&symbolList, offsetof(SYNode, next));
        if (node == NULL) {
            break;
        }
        Dl_info info;
        dladdr(node->pc, &info);
        NSString * name = @(info.dli_sname);
        BOOL  isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name: [@"_" stringByAppendingString:name];
        [symbolNames addObject:symbolName];
    }
    //取反
    NSEnumerator * emt = [symbolNames reverseObjectEnumerator];
    //去重
    NSMutableArray<NSString *> *funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString * name;
    while (name = [emt nextObject]) {
        if (![funcs containsObject:name]) {
            [funcs addObject:name];
        }
    }
    //干掉自己!
    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    //将数组变成字符串
    NSString * funcStr = [funcs  componentsJoinedByString:@"\n"];
    
    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"hank.order"];
    NSData * fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
    NSLog(@"%@",funcStr);
}

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;  // Guards should start from 1.
}

//原子队列
static  OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;
//定义符号结构体
typedef struct {
    void *pc;
    void *next;
}SYNode;

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
//    if (!*guard) return;  // Duplicate the guard check.
    /*  精确定位 哪里开始 到哪里结束!  在这里面做判断写条件!*/
    
    void *PC = __builtin_return_address(0);
    SYNode *node = malloc(sizeof(SYNode));
    *node = (SYNode){PC,NULL};
    //进入
    OSAtomicEnqueue(&symbolList, node, offsetof(SYNode, next));
    
    

    
    
    
//    printf("fname:%s \nfbase:%p \nsname:%s \nsaddr:%p\n",
//           info.dli_fname,
//           info.dli_fbase,
//           info.dli_sname,
//           info.dli_saddr);
//
}


@end

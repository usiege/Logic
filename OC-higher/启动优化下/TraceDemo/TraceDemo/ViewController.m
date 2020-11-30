//
//  ViewController.m
//  TraceDemo
//
//  Created by hank on 2020/11/21.
//  Copyright © 2020 hank. All rights reserved.
//

#import "ViewController.h"
#include <stdint.h>
#include <stdio.h>
#include <sanitizer/coverage_interface.h>
#import <dlfcn.h>
#import <libkern/OSAtomic.h>
#import "TraceDemo-Swift.h"


@interface ViewController ()


@end

@implementation ViewController
+(void)load
{
    [SwiftTest swiftTest];
}

//定义原子队列
static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

//定义符号结构体
typedef struct{
    void *pc;
    void *next;
} SYNode;


void test(){
    block1();
}


void(^block1)(void) = ^(void){
    
};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    test();
}


void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;
}


void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
//  if (!*guard) return;
  //当前函数返回到上一个调用的地址!!
    
    void *PC = __builtin_return_address(0);
    //创建结构体!
   SYNode * node = malloc(sizeof(SYNode));
    *node = (SYNode){PC,NULL};
    
    //加入结构!
    OSAtomicEnqueue(&symbolList, node, offsetof(SYNode, next));
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //定义数组
    NSMutableArray<NSString *> * symbolNames = [NSMutableArray array];
    
    while (YES) {//一次循环!也会被HOOK一次!!
       SYNode * node = OSAtomicDequeue(&symbolList, offsetof(SYNode, next));
        
        if (node == NULL) {
            break;
        }
        Dl_info info = {0};
        dladdr(node->pc, &info);
//        printf("%s \n",info.dli_sname);
        NSString * name = @(info.dli_sname);
        free(node);
        
        BOOL isObjc = [name hasPrefix:@"+["]||[name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];
        //是否去重??
        [symbolNames addObject:symbolName];
        /*
        if ([name hasPrefix:@"+["]||[name hasPrefix:@"-["]) {
            //如果是OC方法名称直接存!
            [symbolNames addObject:name];
            continue;
        }
        //如果不是OC直接加个_存!
        [symbolNames addObject:[@"_" stringByAppendingString:name]];
         */
    }
    //反向数组
//    symbolNames = (NSMutableArray<NSString *>*)[[symbolNames reverseObjectEnumerator] allObjects];
    NSEnumerator * enumerator = [symbolNames reverseObjectEnumerator];
    
    //创建一个新数组
    NSMutableArray * funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString * name;
    //去重!
    while (name = [enumerator nextObject]) {
        if (![funcs containsObject:name]) {//数组中不包含name
            [funcs addObject:name];
        }
    }
    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    //数组转成字符串
    NSString * funcStr = [funcs componentsJoinedByString:@"\n"];
    //字符串写入文件
    //文件路径
    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"hank.order"];
    //文件内容
    NSData * fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
}



@end

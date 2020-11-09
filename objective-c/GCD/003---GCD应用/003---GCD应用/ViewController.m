//
//  ViewController.m
//  003---GCD应用
//
//  Created by Cooci on 2018/6/21.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) id headData;
@property (nonatomic, strong) id listData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    __weak typeof(self) weakSelf = self;
    
    // 第一个地方 : 同步函数
    
    dispatch_block_t task = ^{
        dispatch_sync(queue, ^{
            
        })
        
        dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    }
    
    [self requestToken:^(id value) {
        weakSelf.token = value;

        [weakSelf requestHeadDataWithToken:value handle:^(id value) {
            NSLog(@"%@",value);
            weakSelf.headData = value;
        }];

        [weakSelf requestListDataWithToken:value handle:^(id value) {
            NSLog(@"%@",value);
            weakSelf.listData = value;
        }];
    }];
   
 
    NSLog(@"请求完毕了?我要去其他事情了");
}

/**
 token请求 -- 是否有访问权限

 @param successBlock 请求回来的token保存 通常还有时效性
 */
- (void)requestToken:(void(^)(id value))successBlock{
    NSLog(@"开始请求token");
    [NSThread sleepForTimeInterval:1];
    if (successBlock) {
        successBlock(@"b2a8f8523ab41f8b4b9b2a79ff47c3f1");
    }
}

/**
 头部数据的请求

 @param token token
 @param successBlock 成功数据回调
 */
- (void)requestHeadDataWithToken:(NSString *)token handle:(void(^)(id value))successBlock{
    if (token.length == 0) {
        NSLog(@"没有token,因为安全性无法请求数据");
        return;
    }
    [NSThread sleepForTimeInterval:2];
    if (successBlock) {
        successBlock(@"我是头,都听我的");
    }
}
/**
 列表数据的请求
 
 @param token token
 @param successBlock 成功数据回调 --> 刷新列表
 */
- (void)requestListDataWithToken:(NSString *)token handle:(void(^)(id value))successBlock{
    if (token.length == 0) {
        NSLog(@"没有token,因为安全性无法请求数据");
        return;
    }
    [NSThread sleepForTimeInterval:1];
    if (successBlock) {
        successBlock(@"我是列表数据");
    }
}


- (void)dealloc{
    NSLog(@"我走了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

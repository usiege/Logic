//
//  ViewController.m
//  005---GCD进阶使用(下)
//
//  Created by Cooci on 2018/7/2.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "KCImageManger.h"
#import "KCChildManger.h"
#import "KC_ImageTool.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 300, 200)];
    self.imageView.image = [UIImage imageNamed:@"backImage"];
    [self.view addSubview:self.imageView];
    
    [self groupDemo];
}


/**
 调度组测试
 */
- (void)groupDemo{
    
//    dispatch_group_enter(group);
//    dispatch_group_leave(group);
    
    // 1: 进组 出组 的搭配 奔溃
    // 2: 同步
    // 3: dispatch_group_async
    
    // 信号量
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_group_async(group, queue, ^{
//        //创建调度组
//        NSString *logoStr1 = @"https://f12.baidu.com/it/u=711217113,818398466&fm=72";
//        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr1]];
//        UIImage *image1 = [UIImage imageWithData:data1];
//        [self.mArray addObject:image1];
//    });
//
//
//    dispatch_group_async(group, queue, ^{
//        //创建调度组
//       NSString *logoStr2 = @"https://f12.baidu.com/it/u=3172787957,1000491180&fm=72";
//        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr2]];
//        UIImage *image2 = [UIImage imageWithData:data2];
//        [self.mArray addObject:image2];
//    });
    
     // 进组和出租 成对  先进后出
//    dispatch_group_leave(group);
//    dispatch_async(queue, ^{
//        //创建调度组
//       NSString *logoStr2 = @"https://f12.baidu.com/it/u=3172787957,1000491180&fm=72";
//        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr2]];
//        UIImage *image2 = [UIImage imageWithData:data2];
//        [self.mArray addObject:image2];
//        dispatch_group_enter(group);
//    });
    
//    long time = dispatch_group_wait(group, 1);
//
//    if (time == 0) {
//
//    }
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIImage *newImage = nil;
       NSLog(@"数组个数:%ld",self.mArray.count);
       for (int i = 0; i<self.mArray.count; i++) {
           UIImage *waterImage = self.mArray[i];
           newImage =[KC_ImageTool kc_WaterImageWithWaterImage:waterImage backImage:newImage waterImageRect:CGRectMake(20, 100*(i+1), 100, 40)];
       }
        self.imageView.image = newImage;
    });

}

/**
 调度组内部方法 enter - leave
 */
- (void)groupDemo2{
    
}

/**
 延迟测试
 */
- (void)delayDemo{
    
    //NSEC_PER_SEC : 1000000000ull 纳秒每秒 0.0000001 可以这么做参数
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
    //串行队列来测试 延迟的方法是不是异步的!
    dispatch_queue_t queue = dispatch_queue_create("com.lg.cn", DISPATCH_QUEUE_SERIAL);
    dispatch_after(time, queue, ^{
        NSLog(@"延迟打印");
    });
    NSLog(@"打印完了?");
}


/**
 单利测试
 */
- (void)onceDemo{
//    KCImageManger *manger1 = [KCImageManger shareManager];
//    KCImageManger *manger2 = [KCImageManger shareManager];
//    KCImageManger *manger3 = [KCImageManger shareManager];
    
//    KCImageManger *manger1 = [[KCImageManger alloc] init];
//    KCImageManger *manger2 = [[KCImageManger alloc] init];
//    KCImageManger *manger3 = [KCImageManger new];
    
    KCImageManger *manger1 = [[KCImageManger alloc] init];
    KCImageManger *manger2 = [KCImageManger manager];
    KCImageManger *manger3 = [KCImageManger manager];
    
    NSLog(@"%@---%@---%@",manger1,manger2,manger3);
}


#pragma mark - lazy

- (NSMutableArray *)mArray{
    if (!_mArray) {
        _mArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _mArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

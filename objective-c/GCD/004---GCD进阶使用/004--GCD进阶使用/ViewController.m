//
//  ViewController.m
//  004--GCD进阶使用
//
//  Created by Cooci on 2018/6/22.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "KC_ImageTool.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    UIImage *filterImage = [KC_ImageTool kc_filterImage:nil];
    //    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[KC_ImageTool kc_WaterImageWithText:@"LG_GCD多线程" backImage:filterImage]];
    //    imageView1.frame = CGRectMake(20, 40, 300, 200);
    //    [self.view addSubview:imageView1];
    //
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 300, 200)];
    self.imageView.image = [UIImage imageNamed:@"backImage"];
    [self.view addSubview:self.imageView];
    
    [self demo2];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"start");
    
    NSLog(@"数组的个数:%zd",self.mArray.count);
    
}

//水印 栅栏函数影响
- (void)demo1{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("cooci", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSString *logoStr = @"https://f12.baidu.com/it/u=711217113,818398466&fm=72";
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr]];
        UIImage *image = [UIImage imageWithData:data];
        [self.mArray addObject:image];
    });
    
    dispatch_async(concurrentQueue, ^{
        NSString *logoStr = @"https://f12.baidu.com/it/u=3172787957,1000491180&fm=72";
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr]];
        UIImage *image = [UIImage imageWithData:data];
        [self.mArray addObject:image];
    });
    
    //加载完毕了
    UIImage *newImage = nil;
    
    for (int i = 0; i<self.mArray.count; i++) {
        UIImage *waterImage = self.mArray[i];
        newImage =[KC_ImageTool kc_WaterImageWithWaterImage:waterImage backImage:newImage waterImageRect:CGRectMake(20, 100*(i+1), 100, 40)];
    }
    
    
    
}

/**
 栅栏函数的演示说明:dispatch_barrier_sync/dispatch_barrier_async
 */
- (void)demo2{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("cooci", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(0, 0);
    // 这里是可以的额!
    /* 1.异步函数 */
    dispatch_async(concurrentQueue, ^{
        sleep(1);
        NSLog(@"123");
    });
    /* 2. 栅栏函数 */ // - dispatch_barrier_sync
    dispatch_barrier_async(concurrentQueue, ^{
        NSLog(@"---------------------%@------------------------",[NSThread currentThread]);
    });
    /* 3. 异步函数 */
    dispatch_async(concurrentQueue, ^{
        NSLog(@"加载那么多,喘口气!!!");
    });
    NSLog(@"**********起来干!!");
 
}

/**
 可变数组 线程不安全 解决办法
 */
- (void)demo3{
    
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("cooci", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(0, 0);
    
    // 不安全
    // 栅栏函数的时候 一定要注意 : 一定是自定义的并发队列 - 堵塞队列
    // 不是同一个队列可以?  -- 经常在网络请求 - 栅栏不行 (AFN)
    
    
    for (int i = 0; i<1000; i++) {
        dispatch_async(concurrentQueue, ^{
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg", (i % 10)];
            NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_barrier_async(concurrentQueue , ^{
                [self.mArray addObject:image];
            });
        });
    }
}


#pragma mark - 水印处理

- (void)demo{
    
    UIImage *filterImage = [KC_ImageTool kc_filterImage:nil];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[KC_ImageTool kc_WaterImageWithText:@"LG_GCD多线程" backImage:filterImage]];
    imageView1.frame = CGRectMake(20, 40, 300, 200);
    [self.view addSubview:imageView1];
    
    
    UIImage *logoImage = [UIImage imageNamed:@"lg_icon"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[KC_ImageTool kc_WaterImageWithWaterImage:logoImage backImage:nil waterImageRect:CGRectMake(20, 100, 100, 40)]];
    imageView2.frame = CGRectMake(20, 300, 300, 200);
    [self.view addSubview:imageView2];
    
    NSLog(@"end");
}

#pragma mark - lazy

- (NSMutableArray *)mArray{
    if (!_mArray) {
        _mArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _mArray;
}


@end


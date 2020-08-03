//
//  ViewController.m
//  012--CoreAnimation-CAEmitterLayer
//
//  Created by CC老师 on 2018/12/20.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAEmitterLayer * colorBallLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    [self setupEmitter];
    
}
- (void)setupEmitter{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.text = @"轻点或拖动来改变发射源位置";
    label.textAlignment = NSTextAlignmentCenter;
    
    
    /*
     emitterShape: 形状:
     1. 点;kCAEmitterLayerPoint .
     2. 线;kCAEmitterLayerLine
     3. 矩形框: kCAEmitterLayerRectangle
     4. 立体矩形框: kCAEmitterLayerCuboid
     5. 圆形: kCAEmitterLayerCircle
     6. 立体圆形: kCAEmitterLayerSphere

     emitterMode:
     kCAEmitterLayerPoints
     kCAEmitterLayerOutline
     kCAEmitterLayerSurface
     kCAEmitterLayerVolume
     
     */
 
     //1. 设置CAEmitterLayer
    CAEmitterLayer *colorBallLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:colorBallLayer];
    self.colorBallLayer = colorBallLayer;
    
    colorBallLayer.emitterSize = self.view.frame.size;
    colorBallLayer.emitterShape = kCAEmitterLayerPoint;
    colorBallLayer.emitterMode = kCAEmitterLayerPoints;
    colorBallLayer.emitterPosition = CGPointMake(self.view.layer.bounds.size.width, 0.0f);
    
    //2.配置CAEmitterCell
    CAEmitterCell *colorBarCell = [CAEmitterCell emitterCell];
    colorBarCell.name = @"colorBarCell";
    colorBarCell.birthRate = 20.0f;
    colorBarCell.lifetime = 10.0f;
    colorBarCell.velocity = 40.0f;
    colorBarCell.velocityRange = 100.0f;
    colorBarCell.yAcceleration = 15.0f;
    colorBarCell.emissionLatitude = M_PI;
    colorBarCell.emissionRange = M_PI_4;
    colorBarCell.scale = 0.2;
    colorBarCell.scaleRange = 0.1;
    colorBarCell.scaleSpeed = 0.02;
    colorBarCell.contents = (id)[[UIImage imageNamed:@"circle_white"]CGImage];
    colorBarCell.color = [[UIColor colorWithRed:0.5 green:0.0f blue:0.5f alpha:1.0f]CGColor];
    colorBarCell.redRange = 1.0f;
    colorBarCell.greenRange = 1.0f;
    colorBarCell.alphaRange = 0.8f;
    colorBarCell.blueSpeed = 1.0f;
    colorBarCell.alphaSpeed = -0.1f;
    colorBarCell.emitterCells = @[colorBarCell];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [self locationFromTouchEvent:event];
    [self setBallInPsition:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self locationFromTouchEvent:event];
    [self setBallInPsition:point];
}

/**
 * 获取手指所在点
 */
- (CGPoint)locationFromTouchEvent:(UIEvent *)event{
    UITouch * touch = [[event allTouches] anyObject];
    return [touch locationInView:self.view];
}

/**
 * 移动发射源到某个点上
 */
- (void)setBallInPsition:(CGPoint)position{
    
 
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

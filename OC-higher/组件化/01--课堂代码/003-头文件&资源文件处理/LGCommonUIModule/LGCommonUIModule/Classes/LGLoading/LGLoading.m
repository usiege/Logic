//
//  LGLoading.m
//  LGVideo
//
//  Created by LG on 2018/7/14.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGLoading.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface LGLoading() {
    CAShapeLayer *_lineLayer;
}
@end

@implementation LGLoading

+ (instancetype)defaultLoading {
    LGLoading *loading = [[LGLoading alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    loading.lineColor = LGForegroundColor;
    loading.lineWidth = 2.;
    [loading setup];
    return loading;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.hidden = YES;
    }
    return self;
}

- (void)setup {
    [LGForegroundColor set];
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    int width = _lineWidth ? _lineWidth : 2;
    UIColor *color = _lineColor ? _lineColor : LGForegroundColor;

    CGFloat radius = MIN(self.frame.size.width, self.frame.size.height)/2 - width - 2;
    UIBezierPath *linePath = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:DEGREES_TO_RADIANS(-90)
                                                          endAngle:DEGREES_TO_RADIANS(270)
                                                         clockwise:YES];
    linePath.lineWidth = width;
    linePath.lineCapStyle = kCGLineCapRound;
    linePath.lineJoinStyle = kCGLineCapRound;
    [linePath stroke];
    
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.frame = self.bounds;
    [self.layer insertSublayer:_lineLayer atIndex:1];
    
    _lineLayer.fillColor = [[UIColor clearColor] CGColor];
    _lineLayer.strokeColor = color.CGColor;
    _lineLayer.lineCap = kCALineCapRound;
    _lineLayer.lineJoin = kCALineJoinRound;
    _lineLayer.lineWidth = width;
    _lineLayer.path =[linePath CGPath];
}

- (void)startLoading {
    self.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.repeatCount = CGFLOAT_MAX;
    [_lineLayer addAnimation:animation forKey:@"strokeEnd"];
}

- (void)stopLoading {
    self.hidden = YES;
    [_lineLayer removeAllAnimations];
}

@end

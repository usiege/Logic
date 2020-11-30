//
//  LGView.m
//  LGViewRenderExplore
//
//  Created by cooci on 2020/4/12.
//



#import "LGView.h"
#import "LGLayer.h"

@implementation LGView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code， 绘制的操作， BackingStore(额外的存储区域产于的) -- GPU
}

// 这一个操作分解
// 1: view layer


////子视图的布局
//- (void)layoutSubviews{
//    [super layoutSubviews];
//}
//
+ (Class)layerClass{
    return [LGLayer class];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    [self layoutSubviews];
}

- (CGContextRef)createContext{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.layer.opaque, self.layer.contentsScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    return context;
}


- (void)layerWillDraw:(CALayer *)layer{
    //绘制的准备工作,do nontihing
}
//
////绘制的操作
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
    [[UIColor redColor] set];
       //Core Graphics
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(self.bounds.size.width / 2- 20, self.bounds.size.height / 2- 20, 40, 40)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
}
//
////layer.contents = (位图)
- (void)displayLayer:(CALayer *)layer{
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    dispatch_async(dispatch_get_main_queue(), ^{
        layer.contents = (__bridge id)(image.CGImage);
    });
}

- (void)closeContext{
    UIGraphicsEndImageContext();
}

@end

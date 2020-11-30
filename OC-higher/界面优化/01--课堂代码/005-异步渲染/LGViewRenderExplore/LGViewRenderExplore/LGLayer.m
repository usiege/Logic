//
//  LGLayer.m
//  LGViewRenderExplore
//
//  Created by vampire on 2020/3/11.
//  Copyright © 2020 LGEDU. All rights reserved.
//

#import "LGLayer.h"

@implementation LGLayer

//前面断点调用写下的代码
- (void)layoutSublayers{
    if (self.delegate && [self.delegate respondsToSelector:@selector(layoutSublayersOfLayer:)]) {
        //UIView
        [self.delegate layoutSublayersOfLayer:self];
    }else{
        [super layoutSublayers];
    }
}


//绘制流程的发起函数
- (void)display{
    
    // Graver 实现思路

    CGContextRef context = (__bridge CGContextRef)([self.delegate performSelector:@selector(createContext)]);
    
    [self.delegate layerWillDraw:self];
    
    [self drawInContext:context];
    
    [self.delegate displayLayer:self];

    [self.delegate performSelector:@selector(closeContext)];
}

@end

//
//  ViewController.m
//  000--HelloOpenGLES
//
//  Created by CC老师 on 2019/5/25.
//  Copyright © 2019年 CC老师. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>

@interface ViewController ()
{
    EAGLContext *context;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.初始化上下文&设置当前上下文
    /*
     EAGLContext 是苹果iOS平台下实现OpenGLES 渲染层.
     kEAGLRenderingAPIOpenGLES1 = 1, 固定管线
     kEAGLRenderingAPIOpenGLES2 = 2,
     kEAGLRenderingAPIOpenGLES3 = 3,
     */
    context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES3];
    //判断context是否创建成功
    if (!context) {
        NSLog(@"Create ES context Failed");
    }
    //设置当前上下文
    [EAGLContext setCurrentContext:context];
    
    //2.获取GLKView & 设置context
    GLKView *view =(GLKView *) self.view;
    view.context = context;
    
    //3.设置背景颜色
    glClearColor(1, 0, 0, 1.0);
    
}


#pragma mark -- GLKViewDelegate
//绘制视图的内容
/*
 GLKView对象使其OpenGL ES上下文成为当前上下文，并将其framebuffer绑定为OpenGL ES呈现命令的目标。然后，委托方法应该绘制视图的内容。
*/
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

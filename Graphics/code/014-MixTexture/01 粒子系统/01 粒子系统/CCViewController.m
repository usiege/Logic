//
//  CCViewController.m
//  01 粒子系统
//
//  Created by CC老师 on 2018/2/25.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "CCViewController.h"
#import "CCVertexAttribArrayBuffer.h"
#import "CCPointParticleEffect.h"


@interface CCViewController ()

//上下文
@property (nonatomic , strong) EAGLContext* mContext;

//管理并且绘制所有的粒子对象
@property (strong, nonatomic) CCPointParticleEffect *particleEffect;

@property (assign, nonatomic) NSTimeInterval autoSpawnDelta;
@property (assign, nonatomic) NSTimeInterval lastSpawnTime;

@property (assign, nonatomic) NSInteger currentEmitterIndex;
@property (strong, nonatomic) NSArray *emitterBlocks;

//粒子纹理对象
@property (strong, nonatomic) GLKTextureInfo *ballParticleTexture;

@end

@implementation CCViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
  
}

//MVP矩阵
- (void)preparePointOfViewWithAspectRatio:(GLfloat)aspectRatio
{
   
}

//更新
- (void)update
{
    
 
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{

}

- (IBAction)ChangeIndex:(UISegmentedControl *)sender {
    
    //选择不同的效果
    self.currentEmitterIndex = [sender selectedSegmentIndex];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation !=
            UIInterfaceOrientationPortraitUpsideDown);
}


@end

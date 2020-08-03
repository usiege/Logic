//
//  CCPointParticleEffect.m
//  01 粒子系统
//
//  Created by CC老师 on 2018/2/25.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "CCPointParticleEffect.h"
#import "CCVertexAttribArrayBuffer.h"
//用于定义粒子属性的类型
typedef struct
{
    GLKVector3 emissionPosition;//发射位置
    GLKVector3 emissionVelocity;//发射速度
    GLKVector3 emissionForce;//发射重力
    GLKVector2 size;//发射大小
    GLKVector2 emissionTimeAndLife;//发射时间和寿命
}CCParticleAttributes;

//GLSL程序Uniform 参数
enum
{
    CCMVPMatrix,//MVP矩阵
    CCSamplers2D,//Samplers2D纹理
    CCElapsedSeconds,//耗时
    CCGravity,//重力
    CCNumUniforms//Uniforms个数
};

//属性标识符
typedef enum {
    CCParticleEmissionPosition = 0,//粒子发射位置
    CCParticleEmissionVelocity,//粒子发射速度
    CCParticleEmissionForce,//粒子发射重力
    CCParticleSize,//粒子发射大小
    CCParticleEmissionTimeAndLife,//粒子发射时间和寿命
} CCParticleAttrib;

@interface CCPointParticleEffect()
{
    GLfloat elapsedSeconds;//耗时
    GLuint program;//程序
    GLint uniforms[CCNumUniforms];//Uniforms数组
}

//顶点属性数组缓冲区
@property (strong, nonatomic, readwrite)CCVertexAttribArrayBuffer  * particleAttributeBuffer;

//粒子个数
@property (nonatomic, assign, readonly) NSUInteger numberOfParticles;

//粒子属性数据
@property (nonatomic, strong, readonly) NSMutableData *particleAttributesData;

//是否更新粒子数据
@property (nonatomic, assign, readwrite) BOOL particleDataWasUpdated;

//加载shaders
- (BOOL)loadShaders;

//编译shaders
- (BOOL)compileShader:(GLuint *)shader
                 type:(GLenum)type
                 file:(NSString *)file;
//链接Program
- (BOOL)linkProgram:(GLuint)prog;

//验证Program
- (BOOL)validateProgram:(GLuint)prog;

@end

@implementation CCPointParticleEffect

@synthesize gravity;
@synthesize elapsedSeconds;
@synthesize texture2d0;
@synthesize transform;
@synthesize particleAttributeBuffer;
@synthesize particleAttributesData;
@synthesize particleDataWasUpdated;

//初始化
-(id)init
{
    self = [super init];
    if (self != nil) {
        
    
        //1.
        texture2d0 = [[GLKEffectPropertyTexture alloc]init];
        texture2d0.enabled = YES;
        texture2d0.name = 0;
        texture2d0.target = GLKTextureTarget2D;
        texture2d0.envMode = GLKTextureEnvModeReplace;
        
        //2.
        transform = [[GLKEffectPropertyTransform alloc]init];
        
        //3.
        gravity = CCDefaultGravity;
        
        //4.
        elapsedSeconds = 0.0f;
        
        //5.
        particleAttributesData = [NSMutableData data];

    }
    
    return self;
}

//获取粒子的属性值
- (CCParticleAttributes)particleAtIndex:(NSUInteger)anIndex
{
    
    //bytes:指向接收者内容的指针
    //获取粒子属性结构体内容 粒子[10]
    const CCParticleAttributes *particlesPtr = (const CCParticleAttributes *)[self.particleAttributesData bytes];
    
    //获取属性结构体中的某一个指标 粒子[1]
    return particlesPtr[anIndex];
}


//设置粒子的属性
- (void)setParticle:(CCParticleAttributes)aParticle
            atIndex:(NSUInteger)anIndex
{
  
    //1.
    CCParticleAttributes *particlesPtr =(CCParticleAttributes *) [self.particleAttributesData mutableBytes];
    
    //2.
    particlesPtr[anIndex] = aParticle;
    
    //3.
    self.particleDataWasUpdated = YES;
    
}

//添加一个粒子
- (void)addParticleAtPosition:(GLKVector3)aPosition
                     velocity:(GLKVector3)aVelocity
                        force:(GLKVector3)aForce
                         size:(float)aSize
              lifeSpanSeconds:(NSTimeInterval)aSpan
          fadeDurationSeconds:(NSTimeInterval)aDuration;
{
    //1. 创建一个新粒子;
    CCParticleAttributes newParticle;
    
    //2. 设置相关的参数;
    newParticle.emissionPosition = aPosition;
    newParticle.emissionVelocity = aVelocity;
    newParticle.emissionForce = aForce;
    newParticle.size = GLKVector2Make(aSize, aDuration);
    newParticle.emissionTimeAndLife = GLKVector2Make(elapsedSeconds, elapsedSeconds+aSpan);
    
    //3. 下一节在讲~
    //1. 非常重要: GLKit/GLSL 纹理和颜色混合;
    //2. 阅读/亲自研究一下核心动画粒子效果;
    //3. 预习: 粒子效果GLSL -> 实现代码
    //课后会发完整源码: 真不需要你敲. 阅读一下 等下一节讲解;
    //这周三见~ 14次. 节骨眼丢课.
    //第一遍: 直播肯定会晦涩难懂.
    //第二遍: 顿悟
    
}

//获取粒子个数
- (NSUInteger)numberOfParticles;
{
  
    
    return 0;
}


- (void)prepareToDraw
{
   
}

//绘制
- (void)draw;
{

}

#pragma mark -  OpenGL ES shader compilation

- (BOOL)loadShaders
{
   
    
    return YES;
}


//编译shader
- (BOOL)compileShader:(GLuint *)shader
                 type:(GLenum)type
                 file:(NSString *)file
{
    
    return YES;
}

//链接program
- (BOOL)linkProgram:(GLuint)prog
{
  
    return YES;
}

//验证Program
- (BOOL)validateProgram:(GLuint)prog
{
    //日志长度,验证状态
    GLint logLength, status;
    
    //验证prgogram
    //http://www.dreamingwish.com/frontui/article/default/glvalidateprogram.html
    /*
     glValidateProgram 检测program中包含的执行段在给定的当前OpenGL状态下是否可执行。验证过程产生的信息会被存储在program日志中。验证信息可能由一个空字符串组成，或者可能是一个包含当前程序对象如何与余下的OpenGL当前状态交互的信息的字符串。这为OpenGL实现提供了一个方法来调查更多关于程序效率低下、低优化、执行失败等的信息。
     验证操作的结果状态值会被存储为程序对象状态的一部分。如果验证成功，这个值会被置为GL_TURE，反之置为GL_FALSE。调用函数 glGetProgramiv 传入参数 program和GL_VALIDATE_STATUS可以查询这个值。在给定当前状态下，如果验证成功，那么 program保证可以执行，反之保证不会执行
     
     GL_INVALID_VALUE 错误：如果 program 不是由 OpenGL生成的值.
     GL_INVALID_OPERATION 错误：如果 program 不是一个程序对象.
     */
    glValidateProgram(prog);
    
    //获取验证的日志信息
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    //获取验证的状态--验证结果
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    //根据验证结果返回NO or YES
    if (status == 0)
    {
        return NO;
    }
    
    return YES;
}

//默认重力加速度向量与地球的匹配
//{ 0，（-9.80665米/秒/秒），0 }假设+ Y坐标系的建立
//默认重力
const GLKVector3 CCDefaultGravity = {0.0f, -9.80665f, 0.0f};

@end

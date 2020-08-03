//
//  CCVertexAttribArrayBuffer.m
//  01 粒子系统
//
//  Created by CC老师 on 2018/2/25.
//  Copyright © 2018年 CC老师. All rights reserved.
//

#import "CCVertexAttribArrayBuffer.h"

@implementation CCVertexAttribArrayBuffer


//此方法在当前的OpenGL ES上下文中创建一个顶点属性数组缓冲区
- (id)initWithAttribStride:(GLsizeiptr)aStride
          numberOfVertices:(GLsizei)count
                     bytes:(const GLvoid *)dataPtr
                     usage:(GLenum)usage;
{
    self = [super init];
    
    if(self != nil)
    {
        _stride = aStride;
        _bufferSizeBytes = _stride * count;
        
        glGenBuffers(1, &_name);
        glBindBuffer(GL_ARRAY_BUFFER, self.name);
        /*
         GL_STATIC_DRAW
         GL_STATIC_READ
         GL_STATIC_COPY
         GL_DYNAMIC_DRAW
         GL_DYNAMIC_READ
         GL_DYNAMIC_COPY
         GL_STREAM_DRAW
         GL_STREAM_READ
         GL_STREAM_COPY
         
         ”static“表示VBO中的数据将不会被改动（一次指定多次使用），
         ”dynamic“表示数据将会被频繁改动（反复指定与使用），
         ”stream“表示每帧数据都要改变（一次指定一次使用）。
         ”draw“表示数据将被发送到GPU以待绘制（应用程序到GL），
         ”read“表示数据将被客户端程序读取（GL到应用程序），”
         */
        glBufferData(GL_ARRAY_BUFFER, _bufferSizeBytes, dataPtr, usage);
        
    }
    
    return self;
}

//此方法加载由接收存储的数据
- (void)reinitWithAttribStride:(GLsizeiptr)aStride
              numberOfVertices:(GLsizei)count
                         bytes:(const GLvoid *)dataPtr
{
    _stride = aStride;
    _bufferSizeBytes = aStride * count;
    
    glBindBuffer(GL_ARRAY_BUFFER, self.name);
    glBufferData(GL_ARRAY_BUFFER, _bufferSizeBytes, dataPtr, GL_DYNAMIC_DRAW);
    
    
}

//当应用程序希望使用缓冲区呈现任何几何图形时，必须准备一个顶点属性数组缓冲区。当你的应用程序准备一个缓冲区时，一些OpenGL ES状态被改变，允许绑定缓冲区和配置指针。
- (void)prepareToDrawWithAttrib:(GLuint)index
            numberOfCoordinates:(GLint)count
                   attribOffset:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable
{
   
    glBindBuffer(GL_ARRAY_BUFFER, self.name);
    if (shouldEnable) {
        glEnableVertexAttribArray(index);
    }
    glVertexAttribPointer(index, count, GL_FLOAT, GL_FALSE, (int)self.stride,(GLfloat *) NULL + offset);
}

//绘制
//提交由模式标识的绘图命令，并指示OpenGL ES从准备好的缓冲区中的顶点开始，从先前准备好的缓冲区中使用计数顶点。
+ (void)drawPreparedArraysWithMode:(GLenum)mode
                  startVertexIndex:(GLint)first
                  numberOfVertices:(GLsizei)count;
{
    glDrawArrays(mode, first, count);
}

//将绘图命令模式和instructsopengl ES确定使用缓冲区从顶点索引的第一个数的顶点。顶点索引从0开始。
- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count
{
    glDrawArrays(mode, first, count);
}


- (void)dealloc
{
    //从当前上下文删除缓冲区
    if (0 != _name)
    {
        glDeleteBuffers (1, &_name);
        _name = 0;
    }
}


@end

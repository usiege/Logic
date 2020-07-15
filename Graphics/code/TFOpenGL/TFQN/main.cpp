//
//  main.cpp
//  TFQN
//
//  Created by charles on 2020/7/13.
//  Copyright © 2020 charles. All rights reserved.
//

//#include <iostream>

#include <stdio.h>
#include <stdlib.h>

#include <GL/gl3w.h>
#include <GLFW/glfw3.h>


static int width = 600, height = 600;

enum VAO_IDs
{
    Triangles,
    NumVAOs
};
enum Buffer_IDs
{
    ArrayBuffer,
    NumBuffers
};
enum Attrib_IDs
{
    vPosition = 0
};

GLuint VAOs[NumVAOs];
GLuint Buffers[NumBuffers];

const GLuint NumVertices = 6;

void init(void)
{
    glGenVertexArrays(NumVAOs, VAOs);
    glBindVertexArray(VAOs[Triangles]);

    GLfloat vertices[NumVertices][2] = {
        {-0.90f, -0.90f}, {0.85f, -0.90f}, {-0.90f, 0.85f}, // Triangle 1
        {0.90f, -0.85f},
        {0.90f, 0.90f},
        {-0.85f, 0.90f} // Triangle 2
    };

    glCreateBuffers(NumBuffers, Buffers);
    glBindBuffer(GL_ARRAY_BUFFER, Buffers[ArrayBuffer]);
    glBufferStorage(GL_ARRAY_BUFFER, sizeof(vertices), vertices, 0);

    GLuint program = 1;
    glUseProgram(program);
    glVertexAttribPointer(vPosition, 2, GL_FLOAT,
                          GL_FALSE, 0, 0);
    glEnableVertexAttribArray(vPosition);
}


static void reshape(GLFWwindow *window, int w, int h)
{
    width = w > 1 ? w : 1;
    height = h > 1 ? h : 1;
    glViewport(0, 0, width, height);
    glClearDepth(1.0);
    
    glClearColor(0.98f, 0.40f, 0.7f, 1.0f);
    glEnable(GL_DEPTH_TEST);
    
    GLfloat vVerts[] = {
        -0.5f, 0.0f, 0.0f,
        0.5f, 0.0f, 0.0f,
        0.0f, 0.5f, 0.0f
    };
    
}

static void display(GLFWwindow *window)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    
    GLfloat vRed[] = {1.0, 1.00, 0.0, 0.5f};
    glClearBufferfv(GL_COLOR, 0, vRed);

    glBindVertexArray(VAOs[Triangles]);
    glDrawArrays(GL_TRIANGLES, 0, NumVertices);
    
    glfwSwapBuffers(window);
}

//static int keyevent(GLFWwindow *window, int a, int b, int c, int d)
//{
//    return 0;
//}

int main(int argc, const char * argv[]) {
    
    GLFWwindow *window;
    glfwInit();
        
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    
    window = glfwCreateWindow(width, height, "Trangle", NULL, NULL);
    glfwSetFramebufferSizeCallback(window, reshape);
    glfwSetWindowRefreshCallback(window, display);

    //显示
    glfwMakeContextCurrent(window);
    if (gl3wInit()) {
        fprintf(stderr, "failed to initialize OpenGL\n");
        return -1;
    }
    if (!gl3wIsSupported(3, 2)) {
        fprintf(stderr, "OpenGL 3.2 not supported\n");
        return -1;
    }
    printf("OpenGL %s, GLSL %s\n", glGetString(GL_VERSION),
           glGetString(GL_SHADING_LANGUAGE_VERSION));

    while (!glfwWindowShouldClose(window)) {
        display(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}

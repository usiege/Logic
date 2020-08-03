attribute vec4 position;
attribute vec4 positionColor;
attribute vec2 textCoor;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

varying lowp vec4 varyColor;
varying lowp vec2 vTextCoor;

void main()
{
    vTextCoor = textCoor;
    varyColor = positionColor;
    
    vec4 vPos;
   
    vPos = projectionMatrix * modelViewMatrix * position;
    
    gl_Position = vPos;
}



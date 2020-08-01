attribute vec4 position;
attribute vec4 positionColor;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

varying lowp vec4 varyColor;

void main()
{
    varyColor = positionColor;
    
    vec4 vPos;
   
    //4*4 * 4*4 * 4*1
    vPos = projectionMatrix * modelViewMatrix * position;
   
    //ERROR
    //vPos = position * modelViewMatrix  * projectionMatrix ;
    gl_Position = vPos;
}

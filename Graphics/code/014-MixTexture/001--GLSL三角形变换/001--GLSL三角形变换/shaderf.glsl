precision highp float;

varying lowp vec4 varyColor;
varying lowp vec2 vTextCoor;
uniform sampler2D colorMap;

void main(){
    
    //(1)
    //gl_FragColor = varyColor;
    
    //(2).
    //gl_FragColor = texture2D(colorMap,vTextCoor);
    
    //(3).color&texture
    vec4 weakMask = texture2D(colorMap,vTextCoor);
    vec4 mask = varyColor;
    float alpha = 0.3;
    
    vec4 tempColor = mask * (1.0 - alpha) + weakMask * alpha;
    gl_FragColor = tempColor;
    
}

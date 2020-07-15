# Metal 

YUV & RGB

ijkplayer / AVFoundation
GPUImage -> OpenGL ES/Metal

## 使用Metal 渲染MOV/MP4视频

- AVFoundation
MP4文件容器，压缩后的音频文件AAC，压缩后的视频文件H264；

*AVAssetReader*：
1. MP4->H264->视频片段->解码；
2. 420v (YUV：4:2:0)

*RGB颜色编码*：
png/jpge是压缩格式，显示的时候需要解压缩，解压缩之后如何显示；


## Meatl初探

Metal 2014年
OpenGL ES 1992年

Metal优化
低CPU消耗，overhead

UIKit -> Core Graphic -> Metal -> GPU Driver -> GPU

MTLDivece -> GPU 
图形渲染 -> MTLRenderConmmandEncoder
计算 -> MTLComputerCommandEncoder
内存管理 -> MTLBlitCommandEncoder
并行编码 -> MTLParallelCommandEncoder

```
//Separate your rendering loop
view.delegate = TFRender

//Respond to view events
MTKViewDelegate

//Metal command objects
MTLCreateSystemDefaultDevice()
```

Metal 在5s以上设备才可以真机执行；至少是A7的处理器；必须真机执行，不直持模拟器；














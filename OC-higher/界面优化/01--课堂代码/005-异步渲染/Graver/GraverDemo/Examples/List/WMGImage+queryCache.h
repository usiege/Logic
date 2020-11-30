//
//  WMGImage+queryCache.h
//  GraverDemo
//
//  Created by 王文轩 on 2019/1/8.
//

#import "WMGImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMGImage (queryCache)

/**
 根据 url 到内存里查找
 
 @param url 图片的url
 @return 缓存结果，没有就返回 nil
 */
-(nullable UIImage *)wmg_queryCacheImageWithUrl:(NSString *)url;


@end

NS_ASSUME_NONNULL_END

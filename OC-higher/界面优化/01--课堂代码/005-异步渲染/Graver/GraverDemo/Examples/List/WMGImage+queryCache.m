//
//  WMGImage+queryCache.m
//  GraverDemo
//
//  Created by 王文轩 on 2019/1/8.
//

#import "WMGImage+queryCache.h"

@implementation WMGImage (queryCache)

-(nullable UIImage *)wmg_queryCacheImageWithUrl:(NSString *)url {
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
    if (IsStrEmpty(key)) {
        return nil;
    }
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:key];
    return image;
}

@end

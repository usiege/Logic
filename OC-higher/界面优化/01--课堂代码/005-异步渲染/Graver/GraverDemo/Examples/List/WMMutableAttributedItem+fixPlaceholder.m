//
//  WMMutableAttributedItem+fixPlaceholder.m
//  GraverDemo
//
//  Created by 王文轩 on 2019/1/8.
//

#import "WMMutableAttributedItem+fixPlaceholder.h"
#import "WMGImage.h"

@implementation WMMutableAttributedItem (fixPlaceholder)

- (WMMutableAttributedItem *)fixed_appendImageWithUrl:(NSString *)imgUrl size:(CGSize)size placeholder:(NSString *)placeholder
{
    if (IsStrEmpty(imgUrl) && IsStrEmpty(placeholder)) {
        return self;
    }
    WMGImage *image = [[WMGImage alloc] init];
    image.downloadUrl = imgUrl;
    image.placeholderName = placeholder;
    image.size = size;
    WMGTextAttachment *att = [WMGTextAttachment textAttachmentWithContents:image type:WMGAttachmentTypeStaticImage size:size];    
    return [self appendAttachment:att];
}

@end

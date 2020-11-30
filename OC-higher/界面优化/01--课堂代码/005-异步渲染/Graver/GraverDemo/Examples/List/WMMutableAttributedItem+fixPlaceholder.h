//
//  WMMutableAttributedItem+fixPlaceholder.h
//  GraverDemo
//
//  Created by 王文轩 on 2019/1/8.
//

#import "WMMutableAttributedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMMutableAttributedItem (fixPlaceholder)

/**
 * 拼接指定Url的图片
 *
 * @param imgUrl 图片Url
 * @param size 图片size
 * @param placeholder 占位图
 *
 * @return WMMutableAttributedItem
 *
 */
- (WMMutableAttributedItem *)fixed_appendImageWithUrl:(NSString *)imgUrl size:(CGSize)size placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END

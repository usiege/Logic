//
//  LGPlayerVideoInfoResponse.m
//  LGVideo
//
//  Created by LG on 2018/6/30.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerVideoInfoResponse.h"
#import "LGPlayerVideoInfoCell.h"

@implementation LGPlayerTemplateData
@end

@implementation LGPlayerVideoInfoItem
@end

@implementation LGPlayerVideoInfoResponse
@end

@implementation LGComment

- (NSNumber *)cellHeight {
    if (!_cellHeight) {
        CGFloat height = 65;    //头部高度
        
        if (self.content && self.content.length){
            CGSize size = [self.content boundingRectWithSize:CGSizeMake(LGScreenWidth-30, 500)
                                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}
                                                     context:nil].size;
            CGFloat contentH = ceilf(size.height);
            height += contentH;
        }
        
        height += 40;//底部按钮
        _cellHeight = @(height);
    }
    return _cellHeight;
}
@end

@implementation LGCommentResponse
@end

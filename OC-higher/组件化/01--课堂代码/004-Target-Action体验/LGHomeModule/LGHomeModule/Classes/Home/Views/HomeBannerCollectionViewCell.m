//
//  HomeBannerCollectionViewCell.m
//  LGVideo
//
//  Created by LG on 2018/5/9.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeBannerCollectionViewCell.h"
#import "HomeTemplateResponse.h"

@implementation HomeBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateData class]]) {
        HomeTemplateData *item = (HomeTemplateData *)data;
        self.titleLabel.text = item.title;
        self.subTitleLabel.text = item.subTitle;
        [self.imageView setImageWithURL:[NSURL URLWithString:item.img]];
    }
}

@end

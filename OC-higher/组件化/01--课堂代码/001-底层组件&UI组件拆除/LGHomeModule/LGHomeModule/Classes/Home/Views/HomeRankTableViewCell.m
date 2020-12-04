//
//  HomeRankTableViewCell.m
//  LGVideo
//
//  Created by LG on 2018/5/15.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeRankTableViewCell.h"
#import "HomeTemplateResponse.h"

@implementation HomeRankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateItem class]]) {
        HomeTemplateItem *item = (HomeTemplateItem *)data;
        for (int index = 0; index < 3; index++) {
            HomeBaseTemplateView *view = self.templateViews[index];
            view.imageRatio = (CGFloat)5/7;
            if (item.templateData.count > index) {
                HomeTemplateData *config = item.templateData[index];
                view.backgroundColor = self.contentView.backgroundColor;
                [view setupWithTemplateData:config];
            }
        }
    }
}
@end

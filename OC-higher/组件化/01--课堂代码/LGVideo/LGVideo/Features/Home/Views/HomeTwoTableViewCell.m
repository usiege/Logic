//
//  HomeTwoTableViewCell.m
//  LGVideo
//
//  Created by LG on 2018/4/10.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeTwoTableViewCell.h"
#import "HomeTemplateResponse.h"

@implementation HomeTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateItem class]]) {
        HomeTemplateItem *item = (HomeTemplateItem *)data;
        for (int index = 0; index < 2; index++) {
            HomeBaseTemplateView *view = self.templateViews[index];
            if (item.templateData.count > index) {
                HomeTemplateData *config = item.templateData[index];
                view.backgroundColor = self.contentView.backgroundColor;
                [view setupWithTemplateData:config];
            }
        }
    }
}
@end

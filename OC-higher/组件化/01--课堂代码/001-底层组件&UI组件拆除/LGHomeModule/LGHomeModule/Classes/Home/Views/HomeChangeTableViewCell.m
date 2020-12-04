//
//  HomeChangeTableViewCell.m
//  LGVideo
//
//  Created by LG on 2018/4/10.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeChangeTableViewCell.h"
#import "HomeTemplateResponse.h"

@implementation HomeChangeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconView.tintColor = LGForegroundColor;
    self.iconView.image = [[UIImage imageNamed:@"refresh_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.titleLabel.textColor = LGForegroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateItem class]]) {
        HomeTemplateData *item = [[(HomeTemplateItem *)data templateData] firstObject];
        if (item) {
            self.titleLabel.text = item.title;
        }
    }
}

@end

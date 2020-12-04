//
//  HomeOneBigTableViewCell.m
//  LGVideo
//
//  Created by LG on 2018/5/14.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeOneBigTableViewCell.h"
#import "HomeTemplateResponse.h"

@implementation HomeOneBigTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateItem class]]) {
        HomeTemplateItem *item = (HomeTemplateItem *)data;
        HomeTemplateData *config = item.templateData.firstObject;
        _templateView.backgroundColor = self.contentView.backgroundColor;
        [_templateView setupWithTemplateData:config];
    }
}

@end

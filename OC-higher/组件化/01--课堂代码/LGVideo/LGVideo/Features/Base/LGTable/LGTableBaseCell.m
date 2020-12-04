//
//  LGTableBaseCell.m
//  LGVideo
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LG. All rights reserved.
//

#import "LGTableBaseCell.h"
#import "LGDefaultRow.h"


@implementation LGTableBaseCell

- (void)renderWithRowModel:(id<LGRowProtocol>)row{
    if ([row isKindOfClass:[LGDefaultRow class]]) {
        LGDefaultRow *lgRow = (LGDefaultRow *)row;
        self.textLabel.text = lgRow.title;
        self.imageView.image = lgRow.image;
        self.detailTextLabel.text = lgRow.detailTitle;
        self.accessoryType = lgRow.accessoryType;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HomeTitleTableViewCell.m
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeTitleTableViewCell.h"
#import "HomeTemplateResponse.h"

@implementation HomeTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconView.tintColor = LGForegroundColor;
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)configWithData:(id)data {
    if ([data isKindOfClass:[HomeTemplateItem class]]) {
        HomeTemplateData *item = [[(HomeTemplateItem *)data templateData] firstObject];
        if (item) {
            self.titleLabel.text = item.title;
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:item.img]];
            [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
            [self.iconView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                self.iconView.image = image;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
            }];
        }
    }
}
@end

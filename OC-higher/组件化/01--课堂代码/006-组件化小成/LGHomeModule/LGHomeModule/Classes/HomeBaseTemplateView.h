//
//  HomeBaseTemplateView.h
//  LGVideo
//
//  Created by LG on 2018/5/12.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeTemplateData;
@interface HomeBaseTemplateView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (assign, nonatomic) CGFloat imageRatio;

@property (weak, nonatomic) id templateData;

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageUrl;
- (void)setupWithTemplateData:(HomeTemplateData *)data;
@end

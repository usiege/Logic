//
//  HomeBaseTemplateView.m
//  LGVideo
//
//  Created by LG on 2018/5/12.
//  Copyright © 2018 LG. All rights reserved.
//

#import "HomeBaseTemplateView.h"
#import "HomeTemplateResponse.h"

@interface HomeBaseTemplateView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageRatioConstraint;

@end

@implementation HomeBaseTemplateView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    HomeBaseTemplateView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    view.frame = self.bounds;
    [self addSubview:view];
    
    return self;
}

- (void)setImageRatio:(CGFloat)imageRatio {
    _imageRatio = imageRatio;
    
    NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:_imageRatioConstraint.firstItem
                                                                     attribute:_imageRatioConstraint.firstAttribute
                                                                     relatedBy:_imageRatioConstraint.relation
                                                                        toItem:_imageRatioConstraint.secondItem
                                                                     attribute:_imageRatioConstraint.secondAttribute
                                                                    multiplier:imageRatio
                                                                      constant:_imageRatioConstraint.constant];
    newConstraint.priority = _imageRatioConstraint.priority;
    newConstraint.shouldBeArchived = _imageRatioConstraint.shouldBeArchived;
    newConstraint.identifier = _imageRatioConstraint.identifier;
    _imageRatioConstraint.active = NO;
    _imageRatioConstraint = newConstraint;
    _imageRatioConstraint.active = YES;
    [self layoutIfNeeded];
}

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageUrl {
    self.titleLabel.text = title;
    self.subTitleLabel.text = subTitle;
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setupWithTemplateData:(HomeTemplateData *)data {
    if ([data isKindOfClass:[HomeTemplateData class]]) {
        self.templateData = data;
        [self setTitle:data.title subTitle:data.subTitle image:data.img];
    }
}

- (IBAction)actionButtonAction:(UIButton *)sender {
    [LGMediator jumpToPlayerVC:self.templateData];
}
@end

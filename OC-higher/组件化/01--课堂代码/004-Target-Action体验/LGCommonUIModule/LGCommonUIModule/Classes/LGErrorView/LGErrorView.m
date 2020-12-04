//
//  LGErrorView.m
//  LGVideo
//
//  Created by LG on 2018/5/13.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGErrorView.h"

@interface LGErrorView ()

@end

@implementation LGErrorView

+ (instancetype)errorViewWith:(LGErrorViewType)type {
    
    NSString *bundlePath = [NSBundle bundleForClass:[self class]].resourcePath;
    
    NSBundle *resoure_bundle = [NSBundle bundleWithPath:bundlePath];
        
    LGErrorView *error = [[resoure_bundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    error.errorType = LGErrorViewType_Unknown;
    
    return error;
}

- (void)setTitle:(NSString *)title image:(NSString *)imageUrl action:(void (^)(void))actionBlock {
    self.titleLabel.text = title;
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (IBAction)buttonAction:(id)sender {
    
}

- (void)setErrorType:(LGErrorViewType)errorType {
    _errorType = errorType;
    
    NSArray *config = [LGErrorConfigDic objectForKey:@(errorType)];
    if (config && config.count == 2) {
        
    }
}
@end

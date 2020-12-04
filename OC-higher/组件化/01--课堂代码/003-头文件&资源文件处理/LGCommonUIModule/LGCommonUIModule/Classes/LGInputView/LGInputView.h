//
//  LGInputView.h
//  LGVideo
//
//  Created by LG on 2018/7/8.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LGInputCompletionBlock)(NSString *);

@interface LGInputView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;

- (void)showInView:(UIView *)superview completion:(LGInputCompletionBlock)block;

@end

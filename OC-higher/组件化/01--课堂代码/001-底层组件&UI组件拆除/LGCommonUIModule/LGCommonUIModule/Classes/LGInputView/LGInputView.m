//
//  LGInputView.m
//  LGVideo
//
//  Created by LG on 2018/7/8.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGInputView.h"


@interface LGInputView () <UITextViewDelegate>
@property (nonatomic, copy) LGInputCompletionBlock completionBlock;
@end

@implementation LGInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, LGScreenWidth, LGScreenHeight)]) {
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
        [self addGestureRecognizer:tap];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        _textView = [UITextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.delegate = self;
        [self addSubview:_textView];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@40);
            make.bottom.equalTo(_textView.mas_top);
        }];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self);
            make.height.equalTo(@100);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGFloat height = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-height);
        }];
        [self layoutIfNeeded];
        self.alpha = 1.0;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
        [self layoutIfNeeded];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)cancelAction {
    [_textView resignFirstResponder];
    [self removeFromSuperview];
}

- (void)doneAction {
    [_textView resignFirstResponder];
    [self removeFromSuperview];
    if (self.completionBlock) {
        self.completionBlock(_textView.text);
    }
}

- (void)showInView:(UIView *)superview completion:(LGInputCompletionBlock)block {
    [superview addSubview:self];
    [_textView becomeFirstResponder];
    self.completionBlock = block;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self doneAction];
        return NO;
    }
    return YES;
}
@end

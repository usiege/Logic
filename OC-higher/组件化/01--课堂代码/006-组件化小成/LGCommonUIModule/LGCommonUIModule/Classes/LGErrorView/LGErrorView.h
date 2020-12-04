//
//  LGErrorView.h
//  LGVideo
//
//  Created by LG on 2018/5/13.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGErrorViewType) {
    LGErrorViewType_Unknown,
    LGErrorViewType_NoNetwork,
    LGErrorViewType_NoData,
    LGErrorViewType_ParseError,
};

#define LGErrorConfigDic @{@(LGErrorViewType_NoNetwork):@[@"请检查网络，点击重试", @""]}

@interface LGErrorView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (assign, nonatomic) LGErrorViewType errorType;

+ (instancetype)errorViewWith:(LGErrorViewType)type;

- (void)setTitle:(NSString *)title image:(NSString *)imageUrl action:(void (^)(void))actionBlock;

@end

//
//  LGSegmentedControl.h
//  LGVideo
//
//  Created by LG on 2018/4/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGSegmentedControl;
@protocol LGSegmentedControlDelegate <UIToolbarDelegate>
- (void)segmentedControl:(LGSegmentedControl *)segmentedControl didSelectItemAtIndex:(NSInteger)selectedIndex fromIndex:(NSInteger)fromIndex;
@end

@interface LGSegmentedControl : UIToolbar

@property (nonatomic, weak) id<LGSegmentedControlDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger currentIndex;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;

- (instancetype)initWithFrame:(CGRect)frame itemWidth:(CGFloat)itemWidth itemTitles:(NSArray *)itemTitles;
- (void)setItemTitles:(NSArray *)itemTitles;
- (void)didMoveTo:(CGFloat)index;

@end

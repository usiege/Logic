//
//  LGTimeLineCellLayout.h
//  LGInterfaceOptDemo
//
//  Created by cooci on 2020/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LGTimeLineModel;

@interface LGTimeLineCellLayout : NSObject

- (instancetype)initWithModel:(LGTimeLineModel *)timeLineModel;

@property (nonatomic, assign) CGRect iconRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect expandRect;
@property (nonatomic, assign) BOOL expandHidden;
@property (nonatomic, strong) NSMutableArray *imageRects;

@property (nonatomic, assign) CGRect seperatorViewRect;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) LGTimeLineModel *timeLineModel;

@end

NS_ASSUME_NONNULL_END

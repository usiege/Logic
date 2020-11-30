//
//  LGTimeLineCell.h
//  LGInterfaceOptDemo
//
//  Created by cooci on 2020/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *ResuseID;

@class LGTimeLineModel,LGTimeLineCellLayout;

typedef void(^LGExpandBlock)(BOOL isExpand);
typedef void(^LGPreviewPhotosBlock)(NSMutableArray *icons,int i);

@interface LGTimeLineCell : UITableViewCell

@property (nonatomic, copy) LGExpandBlock expandBlock;
@property (nonatomic, copy) LGPreviewPhotosBlock previewPhotosBlock;

- (void)configureTimeLineCell:(LGTimeLineModel *)timeLineModel;
- (void)configureLayout:(LGTimeLineCellLayout *)layout;


@end

NS_ASSUME_NONNULL_END

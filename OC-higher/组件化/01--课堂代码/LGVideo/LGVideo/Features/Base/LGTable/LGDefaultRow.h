//
//  LGDefaultRow.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGBaseRow.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGDefaultRow : LGBaseRow

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;

- (id)initWithTitle:(NSString *)title;

- (id)initWithTitle:(NSString *)title
              image:(nullable UIImage *)image
        detailTitle:(nullable NSString *)detailTitle
          rowHeight:(CGFloat)rowHeight
      accessoryType:(UITableViewCellAccessoryType)accessoryType;

@end

NS_ASSUME_NONNULL_END

//
//  LGDefaultRow.m
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGDefaultRow.h"

@implementation LGDefaultRow

- (id)initWithTitle:(NSString *)title{
    return [self initWithTitle:title image:nil detailTitle:nil rowHeight:44.0 accessoryType:UITableViewCellAccessoryNone];
}

- (id)initWithTitle:(NSString *)title
              image:(nullable UIImage *)image
        detailTitle:(nullable NSString *)detailTitle
          rowHeight:(CGFloat)rowHeight
      accessoryType:(UITableViewCellAccessoryType)accessoryType{
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.detailTitle = detailTitle;
        self.rowHeight = rowHeight;
        self.accessoryType = accessoryType;
        self.cellStyle = UITableViewCellStyleDefault;
    }
    return self;
}

@end

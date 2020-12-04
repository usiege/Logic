//
//  LGBaseRow.m
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "LGBaseRow.h"
#import "LGTableBaseCell.h"


@implementation LGBaseRow

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rowHeight = 44.0;
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.initalType = LGCODE;
        self.registerName = NSStringFromClass([UITableViewCell class]);
    }
    return self;
}

- (LGCellForRow)cellForRowBlock{
    __weak typeof(self) weakSelf = self;
    return ^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
         LGTableBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:strongSelf.reuseIdentifier];
        if (cell) {
            //render
             [cell renderWithRowModel:strongSelf];
        }else{
            //regist
            switch (strongSelf.initalType) {
                case LGCODE:{
                    [tableView registerClass:NSClassFromString(strongSelf.registerName) forCellReuseIdentifier:strongSelf.reuseIdentifier];
                }
                    break;
                case LGXIB:{
                    UINib *nib = [UINib nibWithNibName:strongSelf.registerName bundle:nil];
                    [tableView registerNib:nib forCellReuseIdentifier:strongSelf.reuseIdentifier];
                }
                    break;
                default:
                    break;
            }
            cell = [tableView dequeueReusableCellWithIdentifier:strongSelf.reuseIdentifier];
            if ([cell respondsToSelector:@selector(renderWithRowModel:)]) {
                [cell renderWithRowModel:strongSelf];
            }
        }
        return cell;
    };
}

@end

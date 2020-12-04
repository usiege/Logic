//
//  LGTableBaseCell.h
//  LGVideo
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGRowProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGTableBaseCell : UITableViewCell

- (void)renderWithRowModel:(id<LGRowProtocol>)row;

@end

NS_ASSUME_NONNULL_END

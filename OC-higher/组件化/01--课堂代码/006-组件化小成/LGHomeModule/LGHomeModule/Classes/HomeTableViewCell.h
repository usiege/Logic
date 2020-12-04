//
//  HomeTableViewCell.h
//  LGVideo
//
//  Created by LG on 03/02/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGTableViewDataConfigProtocol.h"

@interface HomeTableViewCell : UITableViewCell<LGTableViewDataConfigProtocol>

@property (nonatomic, strong) id cellData;

@end

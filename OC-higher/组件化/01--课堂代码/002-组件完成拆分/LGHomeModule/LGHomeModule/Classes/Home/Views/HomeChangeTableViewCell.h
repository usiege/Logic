//
//  HomeChangeTableViewCell.h
//  LGVideo
//
//  Created by LG on 2018/4/10.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewDataConfigProtocol.h"

@interface HomeChangeTableViewCell<LGTableViewDataConfigProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

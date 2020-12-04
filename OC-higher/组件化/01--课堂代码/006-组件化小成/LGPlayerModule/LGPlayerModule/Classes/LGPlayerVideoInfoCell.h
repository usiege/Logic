//
//  LGPlayerVideoInfoCell.h
//  LGVideo
//
//  Created by LG on 2018/6/30.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"

@interface LGPlayerVideoInfoCell : LGTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;
@property (nonatomic, weak) IBOutlet UIButton *commentButton;
@property (nonatomic, weak) IBOutlet UIButton *favButton;
@property (nonatomic, weak) IBOutlet UIButton *downloadButton;
@property (nonatomic, weak) IBOutlet UIButton *shareButton;

@end

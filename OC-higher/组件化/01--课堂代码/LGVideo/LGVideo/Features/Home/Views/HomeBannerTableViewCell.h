//
//  HomeBannerTableViewCell.h
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"
#import "TYCyclePagerView.h"

@interface HomeBannerTableViewCell : LGTableViewCell

@property (weak, nonatomic) IBOutlet TYCyclePagerView *cycleView;

@end

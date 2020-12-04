//
//  HomeBannerTableViewCell.h
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewDataConfigProtocol.h"
#import "TYCyclePagerView.h"

@interface HomeBannerTableViewCell: UITableViewCell<LGTableViewDataConfigProtocol>

@property (weak, nonatomic) IBOutlet TYCyclePagerView *cycleView;

@end

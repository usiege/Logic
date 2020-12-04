//
//  HomeTwoTableViewCell.h
//  LGVideo
//
//  Created by LG on 2018/4/10.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewDataConfigProtocol.h"
#import "HomeBaseTemplateView.h"

@interface HomeTwoTableViewCell : UITableViewCell<LGTableViewDataConfigProtocol>

@property (strong, nonatomic) IBOutletCollection(HomeBaseTemplateView) NSArray *templateViews;

@end

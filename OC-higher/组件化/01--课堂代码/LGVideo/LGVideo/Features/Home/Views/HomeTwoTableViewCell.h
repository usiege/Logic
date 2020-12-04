//
//  HomeTwoTableViewCell.h
//  LGVideo
//
//  Created by LG on 2018/4/10.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"
#import "HomeBaseTemplateView.h"

@interface HomeTwoTableViewCell : LGTableViewCell

@property (strong, nonatomic) IBOutletCollection(HomeBaseTemplateView) NSArray *templateViews;

@end

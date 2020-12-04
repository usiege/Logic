//
//  HomeRankTableViewCell.h
//  LGVideo
//
//  Created by LG on 2018/5/15.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewCell.h"
#import "HomeBaseTemplateView.h"

@interface HomeRankTableViewCell : LGTableViewCell

@property (strong, nonatomic) IBOutletCollection(HomeBaseTemplateView) NSArray *templateViews;

@end

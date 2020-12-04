//
//  HomeOneBigTableViewCell.h
//  LGVideo
//
//  Created by LG on 2018/5/14.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGTableViewDataConfigProtocol.h"
#import "HomeBaseTemplateView.h"

@interface HomeOneBigTableViewCell : UITableViewCell<LGTableViewDataConfigProtocol>

@property (weak, nonatomic) IBOutlet HomeBaseTemplateView *templateView;

@end

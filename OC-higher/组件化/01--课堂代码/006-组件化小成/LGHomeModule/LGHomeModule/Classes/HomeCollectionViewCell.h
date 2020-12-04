//
//  HomeCollectionViewCell.h
//  LGVideo
//
//  Created by LG on 24/03/2018.
//  Copyright © 2018 LG. All rights reserved.
//


#import "HomeTableViewProxy.h"
#import "HomeTemplateResponse.h"

@interface HomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HomeTableViewProxy *tableViewProxy;

- (void)configWithResponse:(HomeTemplateResponse *)response;

@end

//
//  HomeBannerCollectionViewCell.h
//  LGVideo
//
//  Created by LG on 2018/5/9.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBannerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)configWithData:(id)data;

@end

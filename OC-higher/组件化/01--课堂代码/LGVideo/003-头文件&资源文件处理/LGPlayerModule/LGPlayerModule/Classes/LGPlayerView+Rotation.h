//
//  LGPlayerView+Rotation.h
//  LGVideo
//
//  Created by LG on 2018/5/19.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerView.h"

@interface LGPlayerView (Rotation)

- (void)setupRotation;
- (void)disableRotation;
- (void)setOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

@end

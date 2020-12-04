//
//  LGDLNAViewController.h
//  LGVideo
//
//  Created by LG on 2018/6/13.
//  Copyright © 2018 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGCastDevice;
@protocol LGDLNAViewControllerDelegate <NSObject>
- (void)didChooseCastDevice:(LGCastDevice *)device;
@end

@interface LGDLNAViewController : UITableViewController
@property (weak, nonatomic) id<LGDLNAViewControllerDelegate> delegate;
@end

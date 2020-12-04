//
//  UITableView+Manager.m
//  LGTable
//
//  Created by vampire on 2019/2/12.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import "UITableView+Manager.h"
#import <objc/runtime.h>
#import "LGTableManager.h"

static const NSString *AssociateKey = @"LGTableAccessoryKey";

@implementation UITableView (Manager)

- (void)setManager:(LGTableManager *)manager{
    [manager bindToTableView:self];
    objc_setAssociatedObject(self, &AssociateKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LGTableManager *)manager{
   return objc_getAssociatedObject(self, &AssociateKey);
}

@end

//
//  LGTableManager.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGSectionProtocol.h"
#import "LGTableDelegateHandler.h"
#import "LGTablePreloader.h"


NS_ASSUME_NONNULL_BEGIN

@interface LGTableManager : NSObject

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray<id<LGSectionProtocol>> *sections;
@property (nonatomic, strong) LGTableDelegateHandler *delegateHandler;
@property (nonatomic, strong) LGTablePreloader *preloader;


- (id)initWithSections:(NSArray<id<LGSectionProtocol>> *)sections delegateHandler:(LGTableDelegateHandler *)handler;

- (void)bindToTableView:(UITableView *)tableView;

- (id<LGRowProtocol>)rowAtIndexPath:(NSIndexPath *)indexPath;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

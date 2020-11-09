//
//  LGPerson.h
//  001---KVO初探
//
//  Created by cooci on 2019/1/3.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *downloadProgress;
@property (nonatomic, assign) double writtenData;
@property (nonatomic, assign) double totalData;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) LGStudent *st;

@end

NS_ASSUME_NONNULL_END

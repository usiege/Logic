//
//  LGStudent.h
//  001-KVC简介
//
//  Created by Cooci on 2019/12/7.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGStudent : NSObject
@property (nonatomic, copy)   NSString          *name;
@property (nonatomic, copy)   NSString          *subject;
@property (nonatomic, copy)   NSString          *nick;
@property (nonatomic, assign) int               age;
@property (nonatomic, assign) int               length;
@property (nonatomic, strong) NSMutableArray    *penArr;
@end

NS_ASSUME_NONNULL_END

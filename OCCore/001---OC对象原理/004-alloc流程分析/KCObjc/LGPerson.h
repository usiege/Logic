//
//  LGPerson.h
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject

// 影响的因素的 对象: 属性 : 8 + 8 + 8 + 8 = 32
// 内存的布局 属性
// isa
@property (nonatomic,strong) NSString *name;     // Cooci
@property (nonatomic,strong) NSString *nickName; // KC
@property (nonatomic) int hobby; // KC

@end

NS_ASSUME_NONNULL_END

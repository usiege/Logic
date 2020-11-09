//
//  LGPerson.h
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
@property (nonatomic, copy) NSString *kc_name;
@property (nonatomic, assign) int kc_age;

- (void)kc_instanceMethod1;
- (void)kc_instanceMethod2;
- (void)kc_instanceMethod3;

+ (void)kc_classMethod;

// macho -> data -> rw -> rwe
// 非懒加载的类 lazy-class
// 拓展 - 分析思维
// 整体 - 局部 - 细节

@end

NS_ASSUME_NONNULL_END

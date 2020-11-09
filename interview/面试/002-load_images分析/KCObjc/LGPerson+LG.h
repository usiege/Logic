//
//  LGPerson+LG.h
//  KCObjc
//
//  Created by cooci on 2020/10/20.
//

#import "LGPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson (LG)
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, assign) int cate_age;

- (void)cate_instanceMethod1;
- (void)cate_instanceMethod3;
- (void)cate_instanceMethod2;
+ (void)cate_sayClassMethod;
@end

NS_ASSUME_NONNULL_END

//
//  LGPerson+LGEXT.h
//  KCObjc
//
//  Created by cooci on 2020/10/19.
//

#import "LGPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson ()

@property (nonatomic, copy) NSString *ext_name;

- (void)ext_instanceMethod;
- (void)ext_classMethod;

@end

NS_ASSUME_NONNULL_END

//
//  LGStudent.h
//  LGTest
//
//  Created by cooci on 2019/2/12.
//

#import <Foundation/Foundation.h>
#import "LGProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGStudent : NSObject<LGProtocol>
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END

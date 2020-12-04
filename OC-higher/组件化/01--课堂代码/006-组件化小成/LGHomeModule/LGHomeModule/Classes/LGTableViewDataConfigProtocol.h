//
//  LGTableViewDataConfigProtocol.h
//  LGHomeModule
//
//  Created by vampire on 2020/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LGTableViewDataConfigProtocol <NSObject>

@required

- (void)configWithData:(id)data;

@end

NS_ASSUME_NONNULL_END

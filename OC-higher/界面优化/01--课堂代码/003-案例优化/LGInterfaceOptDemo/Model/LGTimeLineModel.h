//
//  LGTimeLineModel.h
//  LGInterfaceOptDemo
//
//  Created by cooci on 2020/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGTimeLineModel : NSObject

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *contentImages;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *location;

@property (nonatomic, assign) NSUInteger cacheId;
@property (nonatomic, assign, getter=isExpand) BOOL expand;

@end

NS_ASSUME_NONNULL_END

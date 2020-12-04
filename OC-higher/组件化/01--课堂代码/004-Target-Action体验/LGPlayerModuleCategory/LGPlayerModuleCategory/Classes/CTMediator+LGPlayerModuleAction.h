//
//  CTMediator+LGPlayerModuleAction.h
//  CTMediator
//
//  Created by vampire on 2020/3/19.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (LGPlayerModuleAction)

- (UIViewController *)CTMediator_naviagetPlayerVC:(NSString *)videoID title:(NSString *)videoTitle;

@end

NS_ASSUME_NONNULL_END

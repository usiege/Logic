//
//  LGView.h
//  LGViewRenderExplore
//
//  Created by cooci on 2020/4/12.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGView : UIView

- (CGContextRef)createContext;

- (void)closeContext;

@end

NS_ASSUME_NONNULL_END

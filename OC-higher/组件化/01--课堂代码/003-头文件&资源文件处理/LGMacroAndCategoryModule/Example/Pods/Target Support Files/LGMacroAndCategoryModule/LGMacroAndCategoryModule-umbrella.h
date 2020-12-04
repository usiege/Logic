#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LGMacros.h"
#import "NSString+Custom.h"
#import "UIColor+Custom.h"
#import "UIViewController+CurrentViewController.h"

FOUNDATION_EXPORT double LGMacroAndCategoryModuleVersionNumber;
FOUNDATION_EXPORT const unsigned char LGMacroAndCategoryModuleVersionString[];


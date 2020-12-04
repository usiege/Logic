//
//  LGMacros.h
//  Pods
//
//  Created by vampire on 2020/2/25.
//

#ifndef LGMacros_h
#define LGMacros_h

#define LGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define LGBackgroundColor           [UIColor colorWithHexString:@"0E121B"]
#define LGForegroundColor           [UIColor colorWithHexString:@"FCCA07"]
#define LGScreenWidth               [UIScreen mainScreen].bounds.size.width
#define LGScreenHeight              [UIScreen mainScreen].bounds.size.height
#define LGMaxScreenWidth            MAX(LGScreenWidth, LGScreenHeight)
#define LGMinScreenHeight           MIN(LGScreenWidth, LGScreenHeight)
#define LGIsiPhoneX                 (LGMaxScreenWidth >= 812 ? YES : NO)
#define LGNavigationBarHeight       (LGIsiPhoneX ? 88 : 64)
#define LGTabbarHeight              (LGIsiPhoneX ? 83 : 49)
#define LGStatusBarHeight           (LGIsiPhoneX ? 44 : 20)
#define LGBottomBarHeight           (LGIsiPhoneX ? 20 : 0)

#import "NSString+Custom.h"
#import "UIColor+Custom.h"

#endif /* LGMacros_h */

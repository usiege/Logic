//
//  LGPerson.h
//  002-KVC取值&赋值过程
//
//  Created by Cooci on 2019/12/7.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject{
    @public
        NSString *_isName;
       NSString *name;
      NSString *isName;
    NSString *_name;

}

@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSSet   *set;

@end

NS_ASSUME_NONNULL_END

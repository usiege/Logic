//
//  LGPerson.h
//  004-KVC异常小技巧
//
//  Created by Cooci on 2019/12/9.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    float x, y, z;
} ThreeFloats;

@interface LGPerson : NSObject{
    @public
    NSString *name;
    NSString *_name;
    NSString *_isName;
    NSString *isName;
}

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, assign) int  age;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic) ThreeFloats  threeFloats;

@end

NS_ASSUME_NONNULL_END

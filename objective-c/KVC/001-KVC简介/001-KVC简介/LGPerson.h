//
//  LGPerson.h
//  objc-debug
//
//  Created by Cooci on 2019/10/28.
//

#import <Foundation/Foundation.h>
#import "LGStudent.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    float x, y, z;
} ThreeFloats;

@interface LGPerson : NSObject{
   @public
   NSString *myName;
}

@property (nonatomic, copy)   NSString          *name;
@property (nonatomic, strong) NSArray           *array;
@property (nonatomic, strong) NSMutableArray    *mArray;
@property (nonatomic, assign) int age;
@property (nonatomic)         ThreeFloats       threeFloats;
@property (nonatomic, strong) LGStudent         *student;

@end

NS_ASSUME_NONNULL_END

//
//  LGTaskDispatch.h
//  LGTableExample
//
//  Created by vampire on 2019/4/19.
//  Copyright © 2019 LGEDU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LGTaskMode){
    LGTaskModeDefault,
    LGTaskModeCommon
};

typedef NS_ENUM(NSUInteger, LGTaskState){
    LGTaskStateRunning,
    LGTaskStateSuspend
};

typedef void(^executeTask)(void);


@interface LGTask : NSObject

@property (nonatomic, strong) NSString *taskID;
@property (nonatomic, copy) executeTask task;

- (id)initWithIdentifier:(NSString *)identifier task:(executeTask)task;

- (void)excute;

@end


@interface LGTaskDispatch : NSObject

- (id)initWithModel:(LGTaskMode)mode;

- (void)addTask:(NSString *)taskID excute:(void(^)(void))excute;

- (void)cancelTask:(NSString *)taskID;

@end

NS_ASSUME_NONNULL_END

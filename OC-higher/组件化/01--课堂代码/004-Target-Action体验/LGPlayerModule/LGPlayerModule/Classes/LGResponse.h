//
//  LGResponse.h
//  LGVideo
//
//  Created by LG on 2018/4/10.
//  Copyright © 2018 LG. All rights reserved.
//

#import "JSONModel.h"

@interface LGResponse : JSONModel

@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, strong) NSString *msg;

@end

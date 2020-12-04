//
//  LGPlayerResponse.h
//  LGVideo
//
//  Created by LG on 2018/5/27.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGResponse.h"

@protocol LGPlayerVideoUrlItem
@end
@interface LGPlayerVideoUrlItem : JSONModel

@property (nonatomic, strong) NSString *definition;
@property (nonatomic, strong) NSString *url;

@end

@interface LGPlayerVideoUrlResponse : LGResponse

@property (nonatomic, strong) NSArray <LGPlayerVideoUrlItem> *data;

@end

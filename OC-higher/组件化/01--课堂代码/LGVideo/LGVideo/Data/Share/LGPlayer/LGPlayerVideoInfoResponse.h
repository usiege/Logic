//
//  LGPlayerVideoInfoResponse.h
//  LGVideo
//
//  Created by LG on 2018/6/30.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGResponse.h"

@protocol LGPlayerTemplateData
@end
@interface LGPlayerTemplateData : JSONModel

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *videoId;

@end

@protocol LGPlayerVideoInfoItem
@end
@interface LGPlayerVideoInfoItem : JSONModel

@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) NSArray <LGPlayerTemplateData> *templateData;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;

@end

@interface LGPlayerVideoInfoResponse : LGResponse

@property (nonatomic, strong) NSArray <LGPlayerVideoInfoItem> *data;

@end

@protocol LGComment
@end
@interface LGComment : JSONModel

@property (nonatomic, strong) NSNumber *commentId;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *replyCount;
@property (nonatomic, strong) NSString *praiseCount;

//缓存cell高度
@property (nonatomic, strong) NSNumber <Ignore> *cellHeight;

@end

@interface LGCommentResponse : LGResponse

@property (nonatomic, strong) NSArray <LGComment> *data;

@end

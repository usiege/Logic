//
//  FollowCellViewModel.h
//  LGVideo
//
//  Created by vampire on 2020/3/12.
//  Copyright © 2020 tztv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FollowCellViewModelProtocol <NSObject>

@required

@property (nonatomic, copy) NSString *cellClassName;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@optional

@property (nonatomic, strong, nullable) NSArray *imageURLArray;
@property (nonatomic, strong, nullable) NSString *videCoverImage;

@end



@interface FollowCellViewModel : NSObject<FollowCellViewModelProtocol>

@property (nonatomic, copy) NSString *cellClassName;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong, nullable) NSArray *imageURLArray;
@property (nonatomic, strong, nullable) NSString *videCoverImage;


 @end

NS_ASSUME_NONNULL_END

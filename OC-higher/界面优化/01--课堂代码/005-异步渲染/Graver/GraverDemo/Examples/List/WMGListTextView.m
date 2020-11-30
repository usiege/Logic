//
//  WMPoiListTextView.m
//  WMCoreText
//
//  Created by yan on 2018/11/26.
//  Copyright © 2018年 sankuai. All rights reserved.
//

#import "WMGListTextView.h"
#import <NSAttributedString+GCalculateAndDraw.h>
#import <WMGImage.h>
#import <WMGTextDrawer.h>
#import <WMGTextDrawer+Event.h>
#import <WMGTextLayout.h>
#import <WMGTextAttachment.h>
#import <WMGraverMacroDefine.h>
#import "WMGImage+queryCache.h"

@interface WMGListTextView ()<WMGTextDrawerDelegate,WMGTextLayoutDelegate,WMGTextDrawerEventDelegate>

@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic, strong) NSMutableArray <WMGTextAttachment *> *arrayAttachments;
@property (nonatomic, strong) WMGTextDrawer *textDrawer;
@property (nonatomic, strong) WMMutableAttributedItem *clickItem;

@end

@implementation WMGListTextView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _textDrawer = [[WMGTextDrawer alloc] init];
        _textDrawer.delegate = self;
        _textDrawer.textLayout.delegate = self;
        _textDrawer.eventDelegate = self;
        
        _lock = [[NSRecursiveLock alloc] init];
        _arrayAttachments = [NSMutableArray array];
        _drawerDates = [NSMutableArray array];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (!CGRectEqualToRect(frame, self.frame))
    {
        [super setFrame:frame];
    }
}


- (void)setDrawerDates:(NSArray<WMGVisionObject *> *)drawerDates {
    if (_drawerDates != drawerDates) {
        _drawerDates = drawerDates;
        [self setNeedsDisplay];
    }
}


- (BOOL)drawInRect:(CGRect)rect withContext:(CGContextRef)context asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo
{
    [super drawInRect:rect withContext:context asynchronously:asynchronously userInfo:userInfo];
    
    NSUInteger initialDrawingCount = self.drawingCount;
    if (self.drawerDates.count <= 0) {
        return YES;
    }
    __weak typeof(self)weakSelf = self;
    [self.drawerDates enumerateObjectsUsingBlock:^(WMGVisionObject * _Nonnull drawerData, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.textDrawer.frame = drawerData.frame;
        strongSelf.textDrawer.textLayout.attributedString = [drawerData.value resultString];
        CGRect visibleRect = CGRectNull;
        [strongSelf.textDrawer drawInContext:context visibleRect:visibleRect replaceAttachments:YES shouldInterruptBlock:^BOOL{
            return initialDrawingCount != strongSelf.drawingCount ? YES : NO;
        }];
    }];
    return YES;
}

- (void)drawingDidFinishAsynchronously:(BOOL)asynchronously success:(BOOL)success
{
    if (!success) {
        return;
    }
    
    [_lock lock];
    // 三个点： 锁重入、for循环遍历移除元素、多线程同步访问共享数据区
    for (__block int i = 0; i < _arrayAttachments.count; i++) {
        if (i >= 0) {
            WMGTextAttachment *att = [_arrayAttachments objectAtIndex:i];

            if (att.type == WMGAttachmentTypeStaticImage){
                WMGImage *ctImage = (WMGImage *)att.contents;
                if ([ctImage isKindOfClass:[WMGImage class]]) {
                    
                    // TODO: 图片下载流程
                    __weak typeof(self)weakSelf = self;
                    [ctImage wmg_loadImageWithUrl:ctImage.downloadUrl options:0 progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf.lock lock];
                        if ([strongSelf.arrayAttachments containsObject:att]) {
                            [strongSelf.arrayAttachments removeObject:att];
                            i--;
                            [strongSelf setNeedsDisplay];
                        }
                        [strongSelf.lock unlock];
                    }];
                }
            }
        }
    }
    [_lock unlock];
}

- (void)textDrawer:(WMGTextDrawer *)textDrawer replaceAttachment:(WMGTextAttachment *)att frame:(CGRect)frame context:(CGContextRef)context
{

    if (att.type == WMGAttachmentTypeStaticImage)
    {
        if ([att.contents isKindOfClass:[NSString class]]) {
            UIGraphicsPushContext(context);
            UIImage *image = [UIImage imageNamed:(NSString *)att.contents];
            [image drawInRect:frame];
            UIGraphicsPopContext();
        }
        else if ([att.contents isKindOfClass:[UIImage class]]) {
            UIGraphicsPushContext(context);
            [(UIImage *)att.contents drawInRect:frame];
            UIGraphicsPopContext();
        }
        else if ([att.contents isKindOfClass:[WMGImage class]]){
            WMGImage *ctImage = (WMGImage *)att.contents;
            UIImage *cachedImage;
            if (ctImage.downloadUrl) {
                cachedImage = [ctImage wmg_queryCacheImageWithUrl:ctImage.downloadUrl];
            }
            
            if (ctImage.image) {
                UIGraphicsPushContext(context);
                [ctImage.image drawInRect:frame];
                UIGraphicsPopContext();
            } else if (cachedImage) {
                ctImage.image = cachedImage;
                UIGraphicsPushContext(context);
                [ctImage.image drawInRect:frame];
                ctImage.downloadUrl = nil;
                UIGraphicsPopContext();
            }
            else
            {
                if (!IsStrEmpty(ctImage.placeholderName)) {
                    UIGraphicsPushContext(context);
                    UIImage *image = [UIImage imageNamed:ctImage.placeholderName];
                    [image drawInRect:frame];
                    UIGraphicsPopContext();
                }
            }
            
            if (!IsStrEmpty(ctImage.downloadUrl))
            {
                att.layoutFrame = frame;
                [_lock lock];
                [_arrayAttachments addObject:att];
                [_lock unlock];
            }
        }
    }
}


#pragma mark - Event Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self];
    
    __weak typeof(self)weakSelf = self;
    //self.drawerDates : 模型
    [self.drawerDates enumerateObjectsUsingBlock:^(WMGVisionObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CGRect frame = obj.frame;
        if (CGRectContainsPoint(frame, location)) {
            strongSelf.clickItem = obj.value;
            strongSelf.textDrawer.frame = frame;
            strongSelf.textDrawer.textLayout.attributedString = [obj.value resultString];
        }
    }];
    // _textDrawer : Core Text
    [_textDrawer touchesBegan:touches withEvent:event];
    

    if (!_textDrawer.pressingActiveRange)
    {
        //调用父类进行事件的传递
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textDrawer touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textDrawer touchesMoved:touches withEvent:event];
    
    if (!_textDrawer.pressingActiveRange)
    {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textDrawer touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}

#pragma mark - WMTextDrawerEventDelegate

- (UIView *)contextViewForTextDrawer:(WMGTextDrawer *)textDrawer
{
    return self;
}

- (NSArray *)activeRangesForTextDrawer:(WMGTextDrawer *)textDrawer
{
    
    NSMutableArray *arrayActiveRanges = [NSMutableArray array];
    for (WMGTextAttachment *att in _clickItem.arrayAttachments) {
        WMGTextActiveRange *range = [WMGTextActiveRange activeRange:NSMakeRange(att.position, att.length) type:WMGActiveRangeTypeAttachment text:@""];
        range.bindingData = att;
        [arrayActiveRanges addObject:range];
    }
    
    return arrayActiveRanges;
}

- (void)textDrawer:(WMGTextDrawer *)textDrawer didPressActiveRange:(id<WMGActiveRange>)activeRange
{
    if (activeRange.type == WMGActiveRangeTypeAttachment) {
        //文本附件（图片，事件响应）
        WMGTextAttachment *att = (WMGTextAttachment *)activeRange.bindingData;
        [att handleEvent:att.userInfo];
    }
}

- (BOOL)textDrawer:(WMGTextDrawer *)textDrawer shouldInteractWithActiveRange:(id<WMGActiveRange>)activeRange
{
    return YES;
}

//Control  ： 不会分发事件了！
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return NO;
}

#pragma mark - WMGTextLayoutDelegate

- (CGFloat)textLayout:(WMGTextLayout *)textLayout maximumWidthForTruncatedLine:(CTLineRef)lineRef atIndex:(NSUInteger)index {
    return WMGTextLayoutMaximumWidth;
}

@end

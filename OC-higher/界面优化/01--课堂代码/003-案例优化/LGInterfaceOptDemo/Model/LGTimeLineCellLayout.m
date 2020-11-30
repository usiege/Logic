//
//  LGTimeLineCellLayout.m
//  LGInterfaceOptDemo
//
//  Created by cooci on 2020/4/12.
//

#import "LGTimeLineCellLayout.h"
#import "LGTimeLineModel.h"
#import <CoreText/CoreText.h>

static const CGFloat nameLeftSpaceToHeadIcon = 10;
static const CGFloat titleFont = 15;
static const CGFloat msgFont = 15;
static const CGFloat msgExpandLimitHeight = 140;
static const CGFloat timeAndLocationFont = 13;

@interface LGTimeLineCellLayout ()


@end

@implementation LGTimeLineCellLayout

- (instancetype)initWithModel:(LGTimeLineModel *)timeLineModel{
    if (!timeLineModel) return nil;
    self = [super init];
    if (self) {
        _timeLineModel = timeLineModel;
        [self layout];
    }
    return self;
}

- (void)setTimeLineModel:(LGTimeLineModel *)timeLineModel{
    _timeLineModel = timeLineModel;
    [self layout];
}

- (void)layout{

    CGFloat sWidth = [UIScreen mainScreen].bounds.size.width;

    self.iconRect = CGRectMake(10, 10, 45, 45);
    CGFloat nameWidth = [self calcWidthWithTitle:_timeLineModel.name font:titleFont];
    CGFloat nameHeight = [self calcLabelHeight:_timeLineModel.name fontSize:titleFont width:nameWidth];
    self.nameRect = CGRectMake(CGRectGetMaxX(self.iconRect) + nameLeftSpaceToHeadIcon, 17, nameWidth, nameHeight);

    CGFloat msgWidth = sWidth - 10 - 16;
    CGFloat msgHeight = 0;

    //文本信息高度计算
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:msgFont],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1]
                                 ,NSParagraphStyleAttributeName: paragraphStyle
                                 ,NSKernAttributeName:@0
                                 };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_timeLineModel.msgContent attributes:attributes];
    msgHeight = [self caculateAttributeLabelHeightWithString:attrStr width:msgWidth];


    if (attrStr.length > msgExpandLimitHeight) {
        if (_timeLineModel.isExpand) {
            self.contentRect = CGRectMake(10, CGRectGetMaxY(self.iconRect) + 10, msgWidth, msgHeight);
        } else {
            attrStr = [[NSMutableAttributedString alloc] initWithString:[_timeLineModel.msgContent substringToIndex:msgExpandLimitHeight] attributes:attributes];
            msgHeight = [self caculateAttributeLabelHeightWithString:attrStr width:msgWidth];
            self.contentRect = CGRectMake(10, CGRectGetMaxY(self.iconRect) + 10, msgWidth, msgHeight);
        }
    } else {
        self.contentRect = CGRectMake(10, CGRectGetMaxY(self.iconRect) + 10, msgWidth, msgHeight);
    }

    if (attrStr.length < msgExpandLimitHeight) {
        self.expandHidden = YES;
        self.expandRect = CGRectMake(10, CGRectGetMaxY(self.contentRect) - 20, 30, 20);
    } else {
        self.expandHidden = NO;
        self.expandRect = CGRectMake(10, CGRectGetMaxY(self.contentRect) + 10, 30, 20);
    }
    
    
    CGFloat timeWidth = [self calcWidthWithTitle:_timeLineModel.time font:timeAndLocationFont];
    CGFloat timeHeight = [self calcLabelHeight:_timeLineModel.time fontSize:timeAndLocationFont width:timeWidth];
    self.imageRects = [NSMutableArray array];
    if (_timeLineModel.contentImages.count == 0) {
//        self.timeRect = CGRectMake(10, CGRectGetMaxY(self.expandRect) + 10, timeWidth, timeHeight);
    } else {
        if (_timeLineModel.contentImages.count == 1) {
            CGRect imageRect = CGRectMake(11, CGRectGetMaxY(self.expandRect) + 10, 250, 150);
            [self.imageRects addObject:@(imageRect)];
        } else if (_timeLineModel.contentImages.count == 2 || _timeLineModel.contentImages.count == 3) {
            for (int i = 0; i < _timeLineModel.contentImages.count; i++) {
                CGRect imageRect = CGRectMake(11 + i * (10 + 90), CGRectGetMaxY(self.expandRect) + 10, 90, 90);
                [self.imageRects addObject:@(imageRect)];
            }
        } else if (_timeLineModel.contentImages.count == 4) {
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 2; j++) {
                    CGRect imageRect = CGRectMake(11 + j * (10 + 90), CGRectGetMaxY(self.expandRect) + 10 + i * (10 + 90), 90, 90);
                    [self.imageRects addObject:@(imageRect)];
                }
            }
        } else if (_timeLineModel.contentImages.count == 5 || _timeLineModel.contentImages.count == 6 || _timeLineModel.contentImages.count == 7 || _timeLineModel.contentImages.count == 8 || _timeLineModel.contentImages.count == 9) {
            for (int i = 0; i < _timeLineModel.contentImages.count; i++) {
                CGRect imageRect = CGRectMake(11 + (i % 3) * (10 + 90), CGRectGetMaxY(self.expandRect) + 10 + (i / 3) * (10 + 90), 90, 90);
                [self.imageRects addObject:@(imageRect)];
            }
        }
    }

    if (self.imageRects.count > 0) {
        CGRect lastRect = [self.imageRects[self.imageRects.count - 1] CGRectValue];
        self.seperatorViewRect = CGRectMake(0, CGRectGetMaxY(lastRect) + 10, sWidth, 15);
    }
    
    self.height = CGRectGetMaxY(self.seperatorViewRect);
}

#pragma mark -- Caculate Method

- (CGFloat)calcWidthWithTitle:(NSString *)title font:(CGFloat)font {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    CGFloat realWidth = ceilf(rect.size.width);
    return realWidth;
    
}

- (CGFloat)calcLabelHeight:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}

- (int)caculateAttributeLabelHeightWithString:(NSAttributedString *)string  width:(int)width {
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}

@end

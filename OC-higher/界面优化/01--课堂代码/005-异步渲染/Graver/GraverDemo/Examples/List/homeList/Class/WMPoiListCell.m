//
//  WMPoiCell.m
//  WMHomelist
//
//  Created by yan on 2018/11/14.
//  Copyright © 2018年 yan. All rights reserved.
//

#import "WMPoiListCell.h"
#import "WMGListTextView.h"

@interface WMPoiListCell ()
@property (nonatomic, strong) WMGListTextView *drawView;  //AsyncView
@end

@implementation WMPoiListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _drawView = [[WMGListTextView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_drawView];
        
    }
    return self;
}

- (void)setupCellData:(WMPoiListCellData *)cellData {
    [super setupCellData:cellData];
    //WMGListTextView
    _drawView.frame = CGRectMake(0, 0, cellData.cellWidth, cellData.cellHeight);
    _drawView.drawerDates = cellData.mutableAttributedTexts;
    [_drawView addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
}

- (void)test{
    NSLog(@"view 点击了");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"cell touchBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"cell touchesMoved");

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"cell touchesEnded");
}

@end

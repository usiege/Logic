//
//  HomeListEngine.m
//  GraverDemo
//
//  Created by yan on 2018/12/5.
//

#import "WMPoiListEngine.h"
#import "WMPoiListModel.h"
#import "WMGResultSet.h"

@implementation WMPoiListEngine

- (void)reloadDataWithParams:(NSDictionary *)params completion:(WMGEngineLoadCompletion)completion
{
    if (_loadState == WMGEngineLoadStateLoading) {
        return;
    }
    
    _loadState = WMGEngineLoadStateLoading;
    
    // 模拟网络请求
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"poi.json" ofType:nil]];
    NSMutableArray *result = [NSMutableArray array];
    NSArray *newDataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [newDataArray enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WMPoiListModel *model = [WMPoiListModel modelWithDictionary:obj];
        
        //占位符由客户端控制，这里硬编码，实际项目中可以利用类似yymodel/jsonmodel的map功能map过来
        model.restaurantLogoPlaceholder = @"icon_logo";
        model.restaurantIconPlaceholder = @"icon_logo_top";
        
        [result addObject:model];
    }];
    
    [self.resultSet reset];
    [self.resultSet addItems:result];
    
    _loadState = WMGEngineLoadStateLoaded;
    if (completion) {
        completion(self.resultSet, nil);
    }
}

- (void)loadMoreDataWithParams:(NSDictionary *)params completion:(WMGEngineLoadCompletion)completion
{
    
}

@end

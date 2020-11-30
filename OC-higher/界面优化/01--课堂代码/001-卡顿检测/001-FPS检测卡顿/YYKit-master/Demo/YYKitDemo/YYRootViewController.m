//
//  YERootViewController.m
//  YYKitExample
//
//  Created by ibireme on 14-10-13.
//  Copyright (c) 2014 ibireme. All rights reserved.
//

#import "YYRootViewController.h"
#import "YYKit.h"
#import <sys/param.h>
#import <sys/mount.h>

@interface YYRootViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation YYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYKit Example";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"Model" class:@"YYModelExample"];
    [self addCell:@"Image" class:@"YYImageExample"];
    [self addCell:@"Text" class:@"YYTextExample"];
//    [self addCell:@"Utility" class:@"YYUtilityExample"];
    [self addCell:@"Feed List Demo" class:@"YYFeedListExample"];
    [self.tableView reloadData];
    
    [self log];
//
    [self memoryCount];
    
    [self memoryTest];
}

- (void)memoryTest{
    
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"手机剩余存储空间为：%0.2lld MB",freeSpace/1024/1024]);
    
}

- (void)memoryCount{
    
    /// 总大小
    float totalsize = 0.0;
    /// 剩余大小
    float freesize = 0.0;
    /// 是否登录
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary)
    {
        NSNumber *_free = [dictionary objectForKey:NSFileSystemFreeSize];
        freesize = [_free unsignedLongLongValue]*1.0/(1024);
        
        NSNumber *_total = [dictionary objectForKey:NSFileSystemSize];
        totalsize = [_total unsignedLongLongValue]*1.0/(1024);
    } else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    NSLog(@"totalsize = %.2f, freesize = %f",totalsize/1024/1024, freesize/1024/1024);
}

- (void)log {
    printf("all:%.2f MB   used:%.2f MB   free:%.2f MB   active:%.2f MB  inactive:%.2f MB  wird:%.2f MB  purgable:%.2f MB\n",
           [UIDevice currentDevice].memoryTotal / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryUsed / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryFree / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryActive / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryInactive / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryWired / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryPurgable / 1024.0 / 1024.0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self log];
    });
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

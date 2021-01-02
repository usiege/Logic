//
//  LGDLNAViewController.m
//  LGVideo
//
//  Created by LG on 2018/6/13.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGDLNAViewController.h"
#import "LGCastManager.h"

@interface LGDLNAViewController ()
@property (nonatomic, strong) NSArray *devicesArray;
@end

@implementation LGDLNAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择投屏设备";
    self.tableView.backgroundColor = LGBackgroundColor;
    self.tableView.separatorColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    [self refreshAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)refreshAction {
    [[LGCastManager sharedManager] searchForDevices];
    self.devicesArray = [[LGCastManager sharedManager] availableDevices];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {         //AirPlay
        return 1;
    }else {      //DLNA
        return _devicesArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGDLNACell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LGDLNACell"];
        cell.backgroundColor = LGBackgroundColor;
        cell.contentView.backgroundColor = LGBackgroundColor;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"AirPlay";
    } else {
        LGCastDevice *device = _devicesArray[indexPath.row];
        cell.textLabel.text = device.name;
        if ([[[LGCastManager sharedManager] currentDevice] isEqual:device]) {
            cell.textLabel.textColor = LGForegroundColor;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14.];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    LGCastDevice *device = nil;
    if (indexPath.section == 0) {
        device = [LGCastDevice new];
        device.deviceType = LGCast_AirPlay;
    } else {
        device = _devicesArray[indexPath.row];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChooseCastDevice:)]) {
        [self.delegate didChooseCastDevice:device];
    }
}
@end

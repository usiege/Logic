//
//  LGPlayerViewController.m
//  LGVideo
//
//  Created by LG on 2018/5/16.
//  Copyright © 2018 LG. All rights reserved.
//

#import "LGPlayerViewController.h"
#import "LGPlayerViewProxy.h"
#import "LGPlayerVideoInfoSource.h"

@interface LGPlayerViewController ()

@property (strong, nonatomic) LGPlayerViewProxy *playerViewProxy;
@property (strong, nonatomic) LGPlayerVideoInfoSource *infoSource;

@end

@implementation LGPlayerViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = LGBackgroundColor;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    [self.contentView addSubview:self.playerViewProxy.playerView];
    [self.playerViewProxy.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(9.0/16);
    }];
    
    [self.contentView addSubview:self.playerViewProxy.tableView];
    self.playerViewProxy.tableView.backgroundColor = LGBackgroundColor;
    [self.playerViewProxy.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playerViewProxy.playerView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.contentView);
    }];
    
//    [self.playerViewProxy.playerView loadVideoUrl:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    [self.playerViewProxy.playerView loadVideo:_videoInfo.videoId];
    
    self.infoSource = [LGPlayerVideoInfoSource new];
    [self.infoSource getVideoInfoResponse:_videoInfo.videoId completion:^(LGPlayerVideoInfoResponse *response) {
        if (response.data && response.data.count) {
            self.playerViewProxy.dataArray = [NSArray arrayWithObject:response.data];
            [self.playerViewProxy.tableView reloadData];
        }
    }];
    
    [self.infoSource getVideoComment:_videoInfo.videoId completion:^(LGCommentResponse *response) {
        if (response.data && response.data.count) {
            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.playerViewProxy.dataArray];
            [temp addObject:response.data];
            self.playerViewProxy.dataArray = temp.copy;
            [self.playerViewProxy.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}

- (LGPlayerViewProxy *)playerViewProxy {
    if (!_playerViewProxy) {
        _playerViewProxy = [[LGPlayerViewProxy alloc] initWithReuseIdentifier:@"LGPlayerTableViewCell" configuration:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            [cell configWithData:cellData];
        } action:^(LGTableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            
        }];
    }
    return _playerViewProxy;
}

- (void)setVideoInfo:(HomeTemplateData *)videoInfo {
    self.playerViewProxy.playerView.controlView.titleLabel.text = videoInfo.title;
    self.playerViewProxy.playerView.controlView.videoNameLabel.text = videoInfo.title;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)dealloc {
    LGLog(@"");
}
@end

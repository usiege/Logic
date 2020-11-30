//
//  LGTimeLineViewController.m
//  LGInterfaceOptDemo
//
//  Created by cooci on 2020/4/12.
//

#import "LGTimeLineViewController.h"
#import "Masonry.h"
#import "LGTimeLineModel.h"
#import "LGTimeLineCell.h"
#import "LGTimeLineCellLayout.h"
#import "YYModel.h"

@interface LGTimeLineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *timeLineTableView;
@property (nonatomic, strong) NSMutableArray<LGTimeLineModel *> *timeLineModels;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray<LGTimeLineCellLayout *> *layouts;

@end

@implementation LGTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的动态";
    
    [self combineUI];
    
    [self loadData];
}

#pragma mark -- Private Method

- (void)combineUI{
    [self.view addSubview:self.timeLineTableView];
    [self.timeLineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(isiPhonex ? 88 : 64);
    }];
}

- (void)loadData{
   //外面的异步线程：网络请求的线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
           //加载`JSON 文件`
              NSString *path = [[NSBundle mainBundle] pathForResource:@"timeLine" ofType:@"json"];
              NSData *data = [[NSData alloc] initWithContentsOfFile:path];
              NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              for (id json in dicJson[@"data"]) {
                  LGTimeLineModel *timeLineModel = [LGTimeLineModel yy_modelWithJSON:json];
                  [self.timeLineModels addObject:timeLineModel];
              }
           
               for (LGTimeLineModel *timeLineModel in self.timeLineModels) {
                   LGTimeLineCellLayout *cellLayout = [[LGTimeLineCellLayout alloc] initWithModel:timeLineModel];
                   [self.layouts addObject:cellLayout];
               }
           
               dispatch_async(dispatch_get_main_queue(), ^{
                    [self.timeLineTableView reloadData];
               });

       });
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  self.layouts[indexPath.row].height;
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return  self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       LGTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:ResuseID];

       [cell configureLayout:self.layouts[indexPath.row]];
        cell.expandBlock = ^(BOOL isExpand) {
            LGTimeLineModel *timeLineModel = self.layouts[indexPath.row].timeLineModel;
            timeLineModel.expand = !isExpand;
            self.layouts[indexPath.row].timeLineModel = timeLineModel;
            [tableView reloadRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        };
        return cell;
}


#pragma mark -- Getter and Setter

- (UITableView *)timeLineTableView{
    if (!_timeLineTableView) {
        _timeLineTableView = [[UITableView alloc] init];
        _timeLineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _timeLineTableView.dataSource = self;
        _timeLineTableView.delegate = self;
        _timeLineTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [_timeLineTableView registerClass:[LGTimeLineCell class] forCellReuseIdentifier:ResuseID];
    }
    return _timeLineTableView;
}

- (NSMutableArray<LGTimeLineModel *> *)timeLineModels{
    if (!_timeLineModels) {
        _timeLineModels = [NSMutableArray arrayWithCapacity:0];
    }
    return _timeLineModels;
}

- (NSMutableArray<LGTimeLineCellLayout *> *)layouts{
    if (!_layouts) {
        _layouts = [NSMutableArray arrayWithCapacity:0];
    }
    return _layouts;
}

@end

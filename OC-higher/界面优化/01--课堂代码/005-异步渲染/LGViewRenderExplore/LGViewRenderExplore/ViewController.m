//
//  ViewController.m
//  LGViewRenderExplore
//
//  Created by cooci on 2020/4/12.
//

#import "ViewController.h"
#import "LGView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LGView *lgView;
@property (nonatomic, strong) LGView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _lgView.backgroundColor = [UIColor redColor];
//    self.customView = [LGView new];
    
    [self.view addSubview:self.customView];
    
//    [self registeObserver];
    
    NSLog(@"123");
        
}

#pragma mark -- Observer

static void __runloop_callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSString *str;
    switch (activity) {
        case kCFRunLoopEntry:
            str = @"Min Entry";
            break;
        case kCFRunLoopBeforeTimers:
             str = @"Min Before Timersr";
             break;
        case kCFRunLoopBeforeSources:
             str = @"Min Before Sources";
             break;
        case kCFRunLoopBeforeWaiting:
             str = @"Min Before Waiting";
             break;
        case kCFRunLoopAfterWaiting:
             str = @"Min After Waiting";
             break;
        case kCFRunLoopExit:
             str = @"Min Exit";
            break;
        case kCFRunLoopAllActivities:
             str = @"Min AllActivities";
             break;
        default:
            break;
    }
    NSLog(@"current activity:%@",str);
}

static void __runloop_before_waiting_callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSString *str;
    switch (activity) {
        case kCFRunLoopEntry:
            str = @"Max Entry";
            break;
        case kCFRunLoopBeforeTimers:
             str = @"Max Before Timersr";
             break;
        case kCFRunLoopBeforeSources:
             str = @"Max Before Sources";
             break;
        case kCFRunLoopBeforeWaiting:
             str = @"Max Before Waiting";
             break;
        case kCFRunLoopAfterWaiting:
             str = @"Max After Waiting";
             break;
        case kCFRunLoopExit:
             str = @"Max Exit";
            break;
        case kCFRunLoopAllActivities:
             str = @"Max AllActivities";
             break;
        default:
            break;
    }
    NSLog(@"current activity:%@",str);
}

- (void)registeObserver{
    CFRunLoopObserverContext ctx = { 0, (__bridge void *)self, NULL, NULL };
           CFRunLoopObserverRef allActivitiesObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, YES, NSIntegerMin, &__runloop_callback, &ctx);
           CFRunLoopAddObserver(CFRunLoopGetCurrent(), allActivitiesObserver, kCFRunLoopCommonModes);
           
           CFRunLoopObserverRef beforeWaitingObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, YES, NSIntegerMax, &__runloop_before_waiting_callback, &ctx);
           CFRunLoopAddObserver(CFRunLoopGetCurrent(), beforeWaitingObserver, kCFRunLoopCommonModes);
}

- (LGView *)customView{
    if (!_customView) {
        _customView = [LGView new];
        _customView.frame = CGRectMake(100, 100, 200, 200);
        _customView.backgroundColor = [UIColor blackColor];
    }
    return _customView;
}

@end

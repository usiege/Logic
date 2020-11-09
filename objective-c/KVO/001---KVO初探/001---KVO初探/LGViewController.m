//
//  LGViewController.m
//  001---KVO初探
//
//  Created by cooci on 2019/1/3.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGViewController.h"
#import "LGDetailViewController.h"
#import "LGStudent.h"

static void *PersonNickContext = &PersonNickContext;
static void *PersonNameContext = &PersonNameContext;

@interface LGViewController ()
@property (nonatomic, strong) LGPerson  *person;
@property (nonatomic, strong) LGStudent *student;
@end

@implementation LGViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.person  = [LGPerson new];
    self.student = [LGStudent new];
    
    [self.student addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:NULL];
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:PersonNameContext];
    [self.person addObserver:self forKeyPath:@"nick" options:(NSKeyValueObservingOptionNew) context:PersonNickContext];
    [self.person addObserver:self forKeyPath:@"downloadProgress" options:(NSKeyValueObservingOptionNew) context:NULL];
//    [self.person addObserver:self forKeyPath:@"dateArray" options:(NSKeyValueObservingOptionNew) context:NULL];
//    [self.person addObserver:self forKeyPath:@"setArray" options:(NSKeyValueObservingOptionNew) context:NULL];

}


- (IBAction)didClickRightItmePushItem:(id)sender {
    
    LGDetailViewController *detailVC = [[LGDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self willChangeValueForKey:@"nick"];
//    self.person.nick = @"iOS";
//    [self didChangeValueForKey:@"nick"];
//    
//    self.person.name = @"person";
//    self.student.name= @"student";
    
    self.person.writtenData += 10;
    self.person.totalData  += 1;

//    self.person.dateArray = [NSMutableArray arrayWithCapacity:1];
//    [self.person.dateArray addObject:@"hello"];
//    [[self.person mutableArrayValueForKey:@"dateArray"] addObject:@"hello"];
//

}

#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSLog(@"%@",change);
    NSLog(@"downloadProgress == %@",self.person.downloadProgress);
}

- (void)dealloc{
    [self.student removeObserver:self forKeyPath:@"name"];
    [self.person removeObserver:self forKeyPath:@"name"];
    [self.person removeObserver:self forKeyPath:@"nick"];
    [self.person removeObserver:self forKeyPath:@"downloadProgress"];
    [self.person removeObserver:self forKeyPath:@"dateArray"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  001-KVC简介
//
//  Created by Cooci on 2019/12/7.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"
#import "LGStudent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int x = arc4random() % 11;
    NSLog(@"%d",x);
  
    LGPerson *person = [[LGPerson alloc] init];
    // 一般setter 方法
    person.name      = @"LG_Cooci"; // setter -- llvm
    person.age       = 18;
    person->myName   = @"cooci";
    NSLog(@"%@ - %d - %@",person.name,person.age,person->myName);
   
    // 1:Key-Value Coding (KVC) : 基本类型 - 看底层原理
    // 非正式协议 - 间接访问
    [person setValue:@"KC" forKey:@"name"];
    
    // 2:KVC - 集合类型
    person.array = @[@"1",@"2",@"3"];
    // 修改数组
    // person.array[0] = @"100";
    // 第一种:搞一个新的数组 - KVC 赋值就OK
    NSArray *array = [person valueForKey:@"array"];
    array = @[@"100",@"2",@"3"];
    [person setValue:array forKey:@"array"];
    NSLog(@"%@",[person valueForKey:@"array"]);
    // 第二种
    NSMutableArray *mArray = [person mutableArrayValueForKey:@"array"];
    mArray[0] = @"200";
    NSLog(@"%@",[person valueForKey:@"array"]);

    // 3:KVC - 集合操作符

    // 4:KVC - 访问非对象属性 - 面试可能问到
    // 结构体
    ThreeFloats floats = {1.,2.,3.};
    NSValue *value     = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
    [person setValue:value forKey:@"threeFloats"];
    NSValue *value1    = [person valueForKey:@"threeFloats"];
    NSLog(@"%@",value1);
    
    ThreeFloats th;
    [value1 getValue:&th];
    NSLog(@"%f-%f-%f",th.x,th.y,th.z);
    // 5:KVC - 层层访问 - keyPath
    LGStudent *student = [LGStudent alloc];
    student.subject    = @"大师班";
    person.student     = student;
    
    [person setValue:@"Swift" forKeyPath:@"student.subject"];
    NSLog(@"%@",[person valueForKeyPath:@"student.subject"]);

}


#pragma mark - array取值
- (void)arrayDemo{
    LGStudent *p = [LGStudent new];
    p.penArr = [NSMutableArray arrayWithObjects:@"pen0", @"pen1", @"pen2", @"pen3", nil];
    NSArray *arr = [p valueForKey:@"pens"]; // 动态成员变量
    NSLog(@"pens = %@", arr);
    //NSLog(@"%@",arr[0]);
    NSLog(@"%d",[arr containsObject:@"pen9"]);
    // 遍历
    NSEnumerator *enumerator = [arr objectEnumerator];
    NSString* str = nil;
    while (str = [enumerator nextObject]) {
        NSLog(@"%@", str);
    }
}

#pragma mark - 字典操作

- (void)dictionaryTest{
    
    NSDictionary* dict = @{
                           @"name":@"Cooci",
                           @"nick":@"KC",
                           @"subject":@"iOS",
                           @"age":@18,
                           @"length":@180
                           };
    LGStudent *p = [[LGStudent alloc] init];
    // 字典转模型
    [p setValuesForKeysWithDictionary:dict];
    NSLog(@"%@",p);
    // 键数组转模型到字典
    NSArray *array = @[@"name",@"age"];
    NSDictionary *dic = [p dictionaryWithValuesForKeys:array];
    NSLog(@"%@",dic);
}

#pragma mark - KVC消息传递
- (void)arrayMessagePass{
    NSArray *array = @[@"Hank",@"Cooci",@"Kody",@"CC"];
    NSArray *lenStr= [array valueForKeyPath:@"length"];
    NSLog(@"%@",lenStr);// 消息从array传递给了string
    NSArray *lowStr= [array valueForKeyPath:@"lowercaseString"];
    NSLog(@"%@",lowStr);
}

#pragma mark - 聚合操作符
// @avg、@count、@max、@min、@sum
- (void)aggregationOperator{
    NSMutableArray *personArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        LGStudent *p = [LGStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [p setValuesForKeysWithDictionary:dict];
        [personArray addObject:p];
    }
    NSLog(@"%@", [personArray valueForKey:@"length"]);
    
    /// 平均身高
    float avg = [[personArray valueForKeyPath:@"@avg.length"] floatValue];
    NSLog(@"%f", avg);
    
    int count = [[personArray valueForKeyPath:@"@count.length"] intValue];
    NSLog(@"%d", count);
    
    int sum = [[personArray valueForKeyPath:@"@sum.length"] intValue];
    NSLog(@"%d", sum);
    
    int max = [[personArray valueForKeyPath:@"@max.length"] intValue];
    NSLog(@"%d", max);
    
    int min = [[personArray valueForKeyPath:@"@min.length"] intValue];
    NSLog(@"%d", min);
}

// 数组操作符 @distinctUnionOfObjects @unionOfObjects
- (void)arrayOperator{
    NSMutableArray *personArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        LGStudent *p = [LGStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [p setValuesForKeysWithDictionary:dict];
        [personArray addObject:p];
    }
    NSLog(@"%@", [personArray valueForKey:@"length"]);
    // 返回操作对象指定属性的集合
    NSArray* arr1 = [personArray valueForKeyPath:@"@unionOfObjects.length"];
    NSLog(@"arr1 = %@", arr1);
    // 返回操作对象指定属性的集合 -- 去重
    NSArray* arr2 = [personArray valueForKeyPath:@"@distinctUnionOfObjects.length"];
    NSLog(@"arr2 = %@", arr2);
    
}

// 嵌套集合(array&set)操作 @distinctUnionOfArrays @unionOfArrays @distinctUnionOfSets
- (void)arrayNesting{
    
    NSMutableArray *personArray1 = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        LGStudent *student = [LGStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [student setValuesForKeysWithDictionary:dict];
        [personArray1 addObject:student];
    }
    
    NSMutableArray *personArray2 = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        LGPerson *person = [LGPerson new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [person setValuesForKeysWithDictionary:dict];
        [personArray2 addObject:person];
    }
    
    // 嵌套数组
    NSArray* nestArr = @[personArray1, personArray2];
    
    NSArray* arr = [nestArr valueForKeyPath:@"@distinctUnionOfArrays.length"];
    NSLog(@"arr = %@", arr);
    
    NSArray* arr1 = [nestArr valueForKeyPath:@"@unionOfArrays.length"];
    NSLog(@"arr1 = %@", arr1);
}

- (void)setNesting{
    
    NSMutableSet *personSet1 = [NSMutableSet set];
    for (int i = 0; i < 6; i++) {
        LGStudent *person = [LGStudent new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [person setValuesForKeysWithDictionary:dict];
        [personSet1 addObject:person];
    }
    NSLog(@"personSet1 = %@", [personSet1 valueForKey:@"length"]);
    
    NSMutableSet *personSet2 = [NSMutableSet set];
    for (int i = 0; i < 6; i++) {
        LGPerson *person = [LGPerson new];
        NSDictionary* dict = @{
                               @"name":@"Tom",
                               @"age":@(18+i),
                               @"nick":@"Cat",
                               @"length":@(175 + 2*arc4random_uniform(6)),
                               };
        [person setValuesForKeysWithDictionary:dict];
        [personSet2 addObject:person];
    }
    NSLog(@"personSet2 = %@", [personSet2 valueForKey:@"length"]);

    // 嵌套set
    NSSet* nestSet = [NSSet setWithObjects:personSet1, personSet2, nil];
    // 交集
    NSArray* arr1 = [nestSet valueForKeyPath:@"@distinctUnionOfSets.length"];
    NSLog(@"arr1 = %@", arr1);
}


@end

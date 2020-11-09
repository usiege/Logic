//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "LGPerson+LGEXT.h"

// 分类 怎么研究?

//
//@interface LGTeacher : NSObject
//- (void)instanceMethod;
//- (void)classMethod;
//@end
//
//@interface LGTeacher ()
//
//@property (nonatomic, copy) NSString *ext_name;
//
//- (void)ext_instanceMethod;
//- (void)ext_classMethod;
//
//@end
//
//@implementation LGTeacher
//
//- (void)ext_instanceMethod{
//    
//}
//- (void)ext_classMethod{
//    
//}
//
//- (void)instanceMethod{
//    
//}
//- (void)classMethod{
//    
//}
//
//@end


@interface LGPerson (LG)

@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, assign) int cate_age;

- (void)cate_instanceMethod1;
- (void)cate_instanceMethod3;
- (void)cate_instanceMethod2;
+ (void)cate_sayClassMethod;

@end

@implementation LGPerson (LG)

- (void)cate_instanceMethod1{
    NSLog(@"%s",__func__);
}

- (void)cate_instanceMethod3{
    NSLog(@"%s",__func__);
}

- (void)cate_instanceMethod2{
    NSLog(@"%s",__func__);
}

+ (void)cate_sayClassMethod{
    NSLog(@"%s",__func__);
}

- (void)setCate_name:(NSString *)cate_name{
    /**
     1: 对象
     2: 标识符
     3: value
     4: 策略
     */
    objc_setAssociatedObject(self, "cate_name", cate_name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)cate_name{
    return  objc_getAssociatedObject(self, "cate_name");
}

@end


struct LGObjc {
    LGObjc()   { printf("来了");}
    ~LGObjc()  {  printf("走了"); }
};

// 1024 节日
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        
        // insert code here...
        // 0x00007ffffffffff8ULL
        // class_data_bits_t bits;
        // class_rw_t *data()
        // read_images - main
        // 消息的发送 realizeClassWithoutSwift - 懒加载 - load
        // 有很多的代码 排序 临时变量 main 调用
        LGPerson *person = [LGPerson alloc];
        person.cate_name = @"KC";
        [person ext_instanceMethod];  // load -- 自己玩一下 load 非懒加载的类的扩展
        NSLog(@"%p",person);
    }
    return 0;
}

//
//(std::pair<
// objc
// bool>)
//
//
//objc::DenseMapIterator<DisguisedPtr<objc_object>,
//
//objc::DenseMap<const void *, objc::ObjcAssociation, objc::DenseMapValueInfo<objc::ObjcAssociation>, objc::DenseMapInfo<const void *>, objc::detail::DenseMapPair<const void *, objc::ObjcAssociation> >,
//
//objc::DenseMapValueInfo<objc::DenseMap<const void *, objc::ObjcAssociation, objc::DenseMapValueInfo<objc::ObjcAssociation>, objc::DenseMapInfo<const void *>, objc::detail::DenseMapPair<const void *, objc::ObjcAssociation> > >,
//
//objc::DenseMapInfo<DisguisedPtr<objc_object> >,
//
//objc::detail::DenseMapPair<DisguisedPtr<objc_object>, objc::DenseMap<const void *, objc::ObjcAssociation, objc::DenseMapValueInfo<objc::ObjcAssociation>, objc::DenseMapInfo<const void *>, objc::detail::DenseMapPair<const void *, objc::ObjcAssociation> > >,
//
//
//false>,


//(objc::detail::DenseMapPair<DisguisedPtr<objc_object>, objc::DenseMap<const void *, objc::ObjcAssociation, objc::DenseMapValueInfo<objc::ObjcAssociation>, objc::DenseMapInfo<const void *>, objc::detail::DenseMapPair<const void *, objc::ObjcAssociation> > > *)

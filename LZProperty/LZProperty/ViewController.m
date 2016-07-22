//
//  ViewController.m
//  LZProperty
//
//  Created by comst on 16/4/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "YYModel.h"

@interface LZStudent : NSObject<YYModel>
@property (nonatomic, copy) NSString *name;

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper ;

@end



@implementation LZStudent

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    
    return @{
             @"name":@"n"
             };
}
@end

@interface LZPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) char sex;
@property (nonatomic, strong) LZPerson *teacher;
@property (nonatomic, copy) void(^op)(int, int);
@property (nonatomic, weak) id delegate;
@end

@implementation LZPerson
@end


@interface ClassA  : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^op)();
@end

@implementation ClassA

- (instancetype)init{
    self = [super init];
    if (self) {
         __weak typeof(self) weakSelf = self;
        self.op = ^{
            typeof(weakSelf) strongSelf = weakSelf;
            
            NSLog(@"%@", strongSelf.name);
        };
    }
    return self;
}

- (void)dealloc{
    NSLog(@" ClassA dealloc");
}

@end


@interface Dog : NSObject
- (void)run;
- (void)eat;
@end

@implementation Dog




- (void)eat{
    
    NSLog(@"%@ eat", NSStringFromClass([self class]));
}


- (void)run{
    NSLog(@"%s run", class_getName([self class]));
}

@end


@interface HSQ : Dog{
    
}

@end

@implementation HSQ

+ (void)load{
    
    Class cls = object_getClass(self);
    BOOL isMeta = class_isMetaClass(cls);
    
    NSString *className = NSStringFromClass(self);
    Method eatM = class_getInstanceMethod(self, @selector(eat));
    Method runM = class_getInstanceMethod(self, @selector(run));
    
    BOOL suc1 =  class_addMethod(self, @selector(eat), method_getImplementation(eatM), method_getTypeEncoding(eatM));
    BOOL suc2 =  class_addMethod(self, @selector(run), method_getImplementation(runM), method_getTypeEncoding(runM));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(eat)), runM = class_getInstanceMethod(self, @selector(run)));
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testEmoji];
//    [self testMethodSwizzing];
//    [self testMethdSignature];
//    [self testmodf];
//    [self testWeakRef];
//    [self testSwap];
//    [self testYYModle1];
    
//    NSNumber *num = nil;
//    NSInteger val = [num integerValue];
    
//    [self testcls];
//    [self testVar];
       // Do any additional setup after loading the view, typically from a nib.
}

- (void)testEmoji{
    NSString *str = @"😇";
    
    NSInteger len = [str length];
    
    NSLog(@"hello");
}

- (void)testMethodSwizzing{
    
    Dog *dog = [[Dog alloc] init];
    
    [dog run];
    [dog eat];
    
    HSQ *hsq = [[HSQ alloc] init];
    [hsq run];
    [hsq eat];
}

typedef union Sex{
    int m;
    char ch;
}Sex;
- (void)testMethdSignature{
    
     NSMethodSignature *sig = [self methodSignatureForSelector:@selector(actionWithArray:dic:cArray:)];
    
    NSInteger count = [sig numberOfArguments];
    
    for (NSInteger i = 0; i < count; i ++) {
        const char * cType = [sig getArgumentTypeAtIndex:i];
        NSLog(@"%s", cType);
    }
}

- (void)actionWithArray:(NSArray *)arr dic:(NSDictionary *)dic cArray:(int [10])intArr {
    
}
- (void)testmodf{
    
    double pi = 3.1415926;
    double part1, part2;
    part2 =  modf(pi, &part1);
    
    NSLog(@"%f %f", part1, part2);
}

- (void)testWeakRef{
    
    ClassA *obj = [[ClassA alloc] init];
    obj.name = @"Comst";
    __weak typeof(obj) weakobj = obj;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)                       , ^{
        
        __strong typeof(weakobj) strongobj = weakobj;
        strongobj.op();
    });
    
    NSLog(@"%s %s", __DATE__, __TIME__);
    
}

- (void)testSwap{
    
    int _a_ = 3;
    int _b_ = 4;
    
    typeof(_a_) c ;
    __typeof__(_a_) _tmp_ = (_a_);
    
    (_a_) = (_b_);
    (_b_) = _tmp_;
    NSLog(@"hello");
}

- (void)testYYModle1{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"n"] = @"comst";
    dic[@"a"] = @23;
    LZStudent *stu1 = [[LZStudent alloc] init];
    stu1.name = @"zhangsan";
    dic[@"stu"] = stu1;
   
    NSArray *arr = dic.allValues.copy;
    
    [dic removeObjectForKey:@"n"];
    stu1.name = @"lisi";
    
    
    LZStudent *stu = [LZStudent yy_modelWithDictionary:dic];
    
    NSLog(@"hello");
}
- (void)testcls{
    LZPerson *p = [[LZPerson alloc] init];
    BOOL pIsMeta = class_isMetaClass([p class]);
    
    Class  metaCls = objc_getMetaClass("LZPerson");
    Class metaCls2 = [[LZPerson class] class];
    Class metaClass3 = object_getClass([LZPerson class]);
    Class metaClass4 = object_getClass([p class]);
    
    Class metaClass5 = object_getClass(@"LZPerson");
    
    BOOL isMeta5 = class_isMetaClass(metaClass5);
    BOOL isMeta4 = class_isMetaClass(metaClass4);
    BOOL isMeta3 = class_isMetaClass(metaClass3);
    
    
    BOOL isM3 =  class_isMetaClass(object_getClass(p));
    
    BOOL isM2 = class_isMetaClass(metaCls2);
    
    
    NSString *metaStr = NSStringFromClass(metaCls);
    
    BOOL isM = class_isMetaClass(metaCls);
    BOOL isMeta = class_isMetaClass([LZPerson class]);
    
    BOOL isEqual = [p class] == [LZPerson class];
    
    NSString *pStr = NSStringFromClass([p class]);
    NSString *cStr = NSStringFromClass([LZPerson class]);
    
    NSLog(@"hello world");
}

- (void)testVar{
    id metaClass = objc_getMetaClass("LZPerson");
    id class = objc_getClass("LZPerson");
//    NSLog(@"%@, %@", NSStringFromClass(metaClass), NSStringFromClass(class`) );
    unsigned int propertyCount ;
    unsigned int attrCount;
    objc_property_t *arr ;
    arr  = class_copyPropertyList(objc_getClass("LZPerson"), &propertyCount);
    
    for (NSInteger i = 0; i < propertyCount; i ++) {
        const char * name =  property_getName(arr[i]);
        const char * attrs =  property_getAttributes(arr[i]);
        
        NSLog(@"%s\t%s", name, attrs);
        
        objc_property_attribute_t *attrArray ;
        attrArray =  property_copyAttributeList(arr[i],  &attrCount);
        //NSLog(@"%@", @(attrCount));
        for (NSInteger j = 0; j < attrCount; j ++) {
            NSLog(@"\t%s\t|%s|", attrArray[j].name, attrArray[j].value);
        }
        
    }
    
}

- (void)testTypeEncode{
    NSLog(@"%s", @encode(LZPerson));
}
@end

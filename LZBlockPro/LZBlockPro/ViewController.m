//
//  ViewController.m
//  LZBlockPro
//
//  Created by comst on 16/3/29.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

void (^functionReturnBlock(NSString *arg))(NSString *arg){
    
    return ^void(NSString *arg){
        NSLog(@"arg: %@", arg);
    };
}

@interface ViewController ()
//定义一个属性
@property (nonatomic, copy) NSInteger (^returnIntBlock)(NSInteger, NSInteger);
@property (nonatomic, assign) NSInteger sum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定义一个返回值为整型，带有两个整形参数的block变量
    NSInteger (^returnIntVar)(NSInteger, NSInteger);
    
    //给block变量赋值
    returnIntVar = ^NSInteger(NSInteger left, NSInteger right){
        
        return left + right;
    };
    
    __block NSInteger a = 3;
    void(^blockOp)() = ^(){
        a = 5;
    };
    blockOp();
    
     __weak typeof(self) weakSelf = self;
    self.returnIntBlock = ^(NSInteger left, NSInteger right){
      
         weakSelf.sum =    left + right ;
        
        return weakSelf.sum;
    };
    
}


- (void)methodWithBlockArg:(NSInteger (^)(NSInteger, NSInteger))blockArg{
    NSInteger sum ;
    sum =  blockArg(3, 4);
}

- (void (^)(NSString *arg))methodReturnBlock{
    
    return ^void(NSString *arg){
        NSLog(@"arg: %@", arg);
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

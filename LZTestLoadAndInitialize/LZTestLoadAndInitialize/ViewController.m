//
//  ViewController.m
//  LZTestLoadAndInitialize
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZClassA.h"
#import "LZClassB.h"
#import "LZClassA+LZACategory.h"
#import "LZClassB+LZBCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LZClassA *objcA = [[LZClassA alloc] init];
    LZClassB *objcB = [[LZClassB alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

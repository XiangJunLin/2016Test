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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
   
    //LZClassB *objB = [[LZClassB alloc] init];
    LZClassA *objA = [[LZClassA alloc] init];
    //NSLog(@"A class %@, objA class %@", [LZClassA class], [objA class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

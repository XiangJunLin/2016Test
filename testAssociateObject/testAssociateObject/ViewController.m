//
//  ViewController.m
//  testAssociateObject
//
//  Created by comst on 16/3/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //定义一个继承NSobject的person对象，没有给person对象声明任何属性，方法和变量。
    
    LZPerson *person = [[LZPerson alloc] init];
    
    //通过kvc给刚才添加到NSObject的属性name赋值。
    [person setValue:@"Comst" forKey:@"name"];
    
    NSLog(@"%@", [person valueForKey:@"name"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

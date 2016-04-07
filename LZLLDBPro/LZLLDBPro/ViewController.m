//
//  ViewController.m
//  LZLLDBPro
//
//  Created by comst on 16/4/3.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController
{
    NSInteger _count ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger res = [self testThreadReturn];
    NSLog(@"%li", res);
 
    NSInteger sum = 0;
    for (NSInteger i = 0; i < 100; i ++) {
        sum = sum + i ;
    }
    
    //[self testLookup];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"touch begin");
}

- (NSInteger)testThreadReturn{
    
    NSLog(@"thread return");
    
    return 10;
}

- (void)testLookup{
    
    NSArray *arr = @[@"hello"];
    
    NSString *str = arr[2];
    
    NSLog(@"%@", str);
}
@end

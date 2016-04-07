//
//  ViewController.m
//  LZTestFramework
//
//  Created by comst on 16/3/30.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import <LZCircleSlider/LZCircleSlider.h>

@interface ViewController ()
@property (nonatomic, strong) RWKnobControl *circleSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.circleSlider = [[RWKnobControl alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.circleSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

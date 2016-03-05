//
//  LZMeViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZMeViewController.h"

@interface LZMeViewController ()

@end

@implementation LZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LZBKColor;
    UIBarButtonItem *item1 = [UIBarButtonItem buttonitemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self selector:@selector(btnClick)];
    
    UIBarButtonItem *item2 = [UIBarButtonItem buttonitemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self selector:@selector(btnClick1)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}


- (void)btnClick{
    LZFUN;
}

- (void)btnClick1{
    LZFUN;
}
@end

//
//  LZEssenceViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZEssenceViewController.h"

@interface LZEssenceViewController ()

@end

@implementation LZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LZBKColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonitemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self selector:@selector(btnClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}


- (void)btnClick{
    LZFUN;
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = LZColor(30, 40, 50);
    vc.navigationItem.title = @"Comst";
    vc.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end

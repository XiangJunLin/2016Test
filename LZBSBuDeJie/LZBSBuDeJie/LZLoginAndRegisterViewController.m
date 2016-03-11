//
//  LZLoginAndRegisterViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/11.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZLoginAndRegisterViewController.h"

@interface LZLoginAndRegisterViewController ()

@end

@implementation LZLoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

//
//  LZLoginAndRegisterViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/11.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZLoginAndRegisterViewController.h"

@interface LZLoginAndRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftConstraint;

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


- (IBAction)registerClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.loginLeftConstraint.constant == 0) {
        self.loginLeftConstraint.constant = - screenWidth ;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
        [btn setTitle:@"已有账号" forState:UIControlStateNormal];
    }else{
        self.loginLeftConstraint.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
        [btn setTitle:@"快速注册" forState:UIControlStateNormal];
    }
}




- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

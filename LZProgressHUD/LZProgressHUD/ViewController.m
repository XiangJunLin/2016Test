//
//  ViewController.m
//  LZProgressHUD
//
//  Created by comst on 16/3/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)successAction:(id)sender {
    
    [LZProgressHUD showSuccess:@"加载成功"];
}


- (IBAction)errorAction:(id)sender {
    
    [LZProgressHUD showError:@"加载失败"];
}


- (IBAction)imageAction:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"error"];
    [LZProgressHUD showMessage:@"吊炸天" image:image];
    
}

- (IBAction)indicatorAction:(id)sender {
    
    [LZProgressHUD showIndicatorWithMessage:@"玩命加载中..."];
}


- (IBAction)hideAction:(id)sender {
    [LZProgressHUD hide];
}

@end

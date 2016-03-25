//
//  LZComposeController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZComposeController.h"

@interface LZComposeController ()

@end

@implementation LZComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNav];
}

- (void)configNav{
    
    self.title = @"发帖";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar layoutIfNeeded];
}


- (void)publishAction{
    
}

- (void)cancelAction{
    
}

@end

//
//  LZFocusViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZFocusViewController.h"

@interface LZFocusViewController ()

@end

@implementation LZFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LZBKColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonitemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self selector:@selector(btnClick)];
    
}



- (void)btnClick{
    LZFUN;
}

@end

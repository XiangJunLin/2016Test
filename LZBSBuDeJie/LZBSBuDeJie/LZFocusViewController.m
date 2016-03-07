//
//  LZFocusViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZFocusViewController.h"
#import "Masonry.h"
@interface LZFocusViewController ()

@end

@implementation LZFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LZBKColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonitemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self selector:@selector(btnClick)];
    
    [self initSubview];
}

- (void)initSubview{
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:17];
    
    label.text = @"快快登录吧， 关注百思最in牛人\n好友动态让你过把瘾~\n欧耶~~~！";
    
    [self.view addSubview:label];
    
     __weak typeof(self) weakSelf = self;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@250);
        
        make.center.equalTo(weakSelf.view);
        
    }];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"header_cry_icon"];
    imageview.image = image;
    
    [self.view addSubview:imageview];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top).offset(-40);
        make.centerX.equalTo(label);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"快快登录吧" forState:UIControlStateNormal];
    [btn setTitle:@"快快登录吧" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(label);
        
        make.top.equalTo(label.mas_bottom).offset(40);
        
        make.centerX.equalTo(label);
        
    }];
}

- (void)login{
    
}

- (void)btnClick{
    LZFUN;
}

@end

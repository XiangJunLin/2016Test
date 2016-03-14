//
//  LZEssenceViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZEssenceViewController.h"

@interface LZEssenceViewController ()

@property (nonatomic, strong) UIButton *selectedTitleButton;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation LZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LZBKColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonitemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self selector:@selector(btnClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    [self loadTitleView];
}

- (void)loadTitleView{
    UIView *titleView = [[UIView alloc] init];
    [self.view addSubview:titleView];
    
    NSArray *titles = @[@"全部",@"视频",@"段子",@"图片",@"声音"];
    
    titleView.y = 64;
    titleView.height = 35;
    titleView.width = self.view.width;
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    CGFloat btnWidth = self.view.width / titles.count;
    CGFloat btnHeight = titleView.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.x = i * btnWidth;
        btn.y = btnY;
        btn.width = btnWidth;
        btn.height = btnHeight;
        [titleView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateDisabled];
        [btn.titleLabel sizeToFit];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(titleSelected:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            self.selectedTitleButton = btn;
            btn.enabled = NO;
        }
    }
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    [titleView addSubview:indicatorView];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - 2;
    self.indicatorView = indicatorView;
   
   
    self.indicatorView.width = self.selectedTitleButton.titleLabel.width;
    indicatorView.centerX = self.selectedTitleButton.centerX;
    NSLog(@"%@ --%@", NSStringFromCGRect(self.selectedTitleButton.frame), NSStringFromCGRect(indicatorView.frame));
}

- (void)titleSelected:(UIButton *)sender{
    self.selectedTitleButton.enabled = YES;
    sender.enabled = NO;
    self.selectedTitleButton = sender;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = self.selectedTitleButton.titleLabel.width;
        self.indicatorView.centerX = self.selectedTitleButton.centerX;
    }];
}

- (void)loadContentView{
    
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

//
//  LZMeViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZMeViewController.h"
#import "LZCommon.h"
#import "LZMeFooterView.h"
#import "UIImage+LZCircleImage.h"
#import "LZMeCell.h"


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
    
    [self configTableView];
}

- (void)configTableView{
    [self.tableView registerClass:[LZMeCell class] forCellReuseIdentifier:@"LZMeCell"];
    self.tableView.sectionFooterHeight = LZCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    UIEdgeInsets edge  = self.tableView.contentInset;
    edge.top =  edge.top - 2 * LZCellMargin;
    self.tableView.contentInset = edge;
    
    LZMeFooterView *footerView = [[LZMeFooterView alloc] init] ;
    
    self.tableView.tableFooterView = footerView;
    
    CGSize size = self.tableView.contentSize;
    size.height = size.height + screenHeight;
    self.tableView.contentSize = size;
    
}

- (void)btnClick{
    LZFUN;
}

- (void)btnClick1{
    LZFUN;
}

#pragma mark - tableview data source 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZMeCell"];
   
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage  imageNamed:@"defaultUserIcon"].circleImage;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"tabBar_me_icon"];
        cell.textLabel.text = @"离线下载";
    }
    
    
    
    return cell;
}



@end

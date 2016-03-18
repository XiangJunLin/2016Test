//
//  LZEssenceViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZEssenceViewController.h"

#import "LZBudeJIeViewController.h"

@interface LZEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedTitleButton;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, copy) NSArray *titlleButtons;
@property (nonatomic, strong) UIView *titleView;

@end

@implementation LZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LZBKColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonitemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self selector:@selector(btnClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    [self loadChildControllers];
    [self loadContentView];
    [self loadTitleView];
}

- (void)loadTitleView{
    UIView *titleView = [[UIView alloc] init];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    
    titleView.y = 64;
    titleView.height = 35;
    titleView.width = self.view.width;
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    
    NSMutableArray *arraM = [NSMutableArray array];
    
    NSInteger titleCount = self.childViewControllers.count;
    CGFloat btnWidth = self.view.width / titleCount;
    CGFloat btnHeight = titleView.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titleCount; i ++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        UIButton *btn = [[UIButton alloc] init];
        [arraM addObject:btn];
        
        btn.x = i * btnWidth;
        btn.y = btnY;
        btn.width = btnWidth;
        btn.height = btnHeight;
        [titleView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitle:vc.title forState:UIControlStateDisabled];
        [btn.titleLabel sizeToFit];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(titleSelected:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    
    self.titlleButtons = arraM;
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    [titleView addSubview:indicatorView];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - 2;
    self.indicatorView = indicatorView;
    
    UIButton *btn = arraM[0];
    [self titleSelected:btn];
    [self scrollViewDidEndScrollingAnimation:self.contentView];
    
    
}

- (void)loadContentView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    
    
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    
    
    
}

- (void)loadChildControllers{
    
   
    
    LZBudeJIeViewController *vedioVC = [[LZBudeJIeViewController alloc] init];
    vedioVC.title = @"视频";
    vedioVC.budejieType = LZTypeVedio;
    [self addChildViewController:vedioVC];
    
    LZBudeJIeViewController *soundVC = [[LZBudeJIeViewController alloc] init];
    soundVC.title = @"声音";
    soundVC.budejieType = LZTypeSound;
    [self addChildViewController:soundVC];
    
    LZBudeJIeViewController *pictureVC = [[LZBudeJIeViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.budejieType = LZTypePicture;
    [self addChildViewController:pictureVC];
    
    LZBudeJIeViewController *topicVC = [[LZBudeJIeViewController alloc] init];
    topicVC.title = @"段子";
    topicVC.budejieType = LZTypeTopic;
    [self addChildViewController:topicVC];
    
    LZBudeJIeViewController *allVC = [[LZBudeJIeViewController alloc] init];
    allVC.title = @"全部";
    allVC.budejieType = LZTypeAll;
    [self addChildViewController:allVC];
    
}

- (void)titleSelected:(UIButton *)sender{
    
    self.selectedTitleButton.enabled = YES;
    sender.enabled = NO;
    self.selectedTitleButton = sender;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = self.selectedTitleButton.titleLabel.width;
        self.indicatorView.centerX = self.selectedTitleButton.centerX;
    }];
    
    NSInteger index = [self.titlleButtons indexOfObject:self.selectedTitleButton];
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.view.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    
    
}



- (void)btnClick{
    LZFUN;
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = LZColor(30, 40, 50);
    vc.navigationItem.title = @"Comst";
    vc.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self showTableView];
}

- (void)showTableView{
    
    NSInteger index = [self.titlleButtons indexOfObject:self.selectedTitleButton];
    UITableViewController *tableVC = self.childViewControllers[index];
    
    UITableView *tableView = tableVC.tableView;
    
    CGFloat top = self.titleView.height + self.navigationController.navigationBar.height + 20;
    CGFloat bottom = self.tabBarController.tabBar.height;
    tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    tableView.scrollIndicatorInsets =tableView.contentInset;
    tableView.x = index * self.view.width;
    tableView.y = 0;
    tableView.height = screenHeight;
    
    [self.contentView addSubview:tableView];
    [tableView reloadData];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    UIButton *btn = self.titlleButtons[index];
    [self titleSelected:btn];
    [self showTableView];
}
@end

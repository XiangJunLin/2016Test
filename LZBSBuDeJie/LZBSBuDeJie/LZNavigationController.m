//
//  LZNavigationController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZNavigationController.h"

@interface LZNavigationController ()

@end

@implementation LZNavigationController

+ (void)initialize{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    //bar.tintColor = [UIColor clearColor];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]}];
    
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    [item setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12 ], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        btn.bounds = CGRectMake(0, 0, 70, 30);
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)popAction{
    [self popViewControllerAnimated:YES];
}


@end

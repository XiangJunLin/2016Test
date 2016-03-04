//
//  LZTabBarController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTabBarController.h"
#import "LZTabBar.h"

@interface LZTabBarController ()

@end

@implementation LZTabBarController

+ (void)initialize{
    
    UITabBarItem *itemAppearance = [UITabBarItem appearance];
    NSDictionary *normalAttr = @{
                                 NSFontAttributeName :[UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                 };
    
    NSDictionary *selectAttr = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                 };
    
    
    [itemAppearance setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [itemAppearance setTitleTextAttributes:selectAttr forState:UIControlStateSelected];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    
    [self addChildController:vc1 itemTitle:@"精华" normalItemImageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor greenColor];
    [self addChildController:vc2 itemTitle:@"新帖" normalItemImageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor blueColor];
    [self addChildController:vc3 itemTitle:@"关注" normalItemImageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];

    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:1];
    
    [self addChildController:vc4 itemTitle:@"我" normalItemImageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
    
    LZTabBar *tabBar = [[LZTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"] ];
    

}

- (void)addChildController:(UIViewController *)vc itemTitle:(NSString *)title normalItemImageName:(NSString *)normalName selectedImageName:(NSString *)selectedName{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normalName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedName];

    [self addChildViewController:vc];
    
}

@end

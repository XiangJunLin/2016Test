//
//  LZTabBar.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTabBar.h"
#import "LZPublishViewController.h"
#import "LZCommon.h"
#import "LZPublishView.h"

@interface LZTabBar ()
@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation LZTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addButtonWithNormalImage:@"tabBar_publish_icon" highlightImageName:@"tabBar_publish_click_icon" target:self selector:@selector(publishButtonClick)];
        return self;
    }
    
    return nil;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat itemW = (self.width - self.publishButton.width ) / 4 ;
    CGFloat itemX = 0;
    CGFloat itemH = self.height;
    CGFloat itemY = 0;
    NSInteger itemIndex = 0;
    
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    for (UIView *btn in self.subviews) {
        
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (itemIndex > 1) {
                itemX = itemIndex * itemW + self.publishButton.width ;
            }else{
                itemX = itemIndex * itemW ;
            }
            itemIndex ++;
            btn.frame = CGRectMake(itemX, itemY, itemW, itemH);
        }
    }
}

- (void)addButtonWithNormalImage:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName target:(id)target selector:(SEL)sel{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.publishButton = btn;
    
    [self addSubview:btn];
    
}

#pragma mark - add subview

- (void)publishViewShow{
    
    LZPublishView *publishView = [LZPublishView publishview];
    publishView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    publishView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [rootVC.view addSubview:publishView];
    
    [publishView show];
    
}

#pragma mark - present VC
- (void)publishButtonClick{
    
    [self publishViewShow];
//    
//    LZPublishViewController *publishVC = [[LZPublishViewController alloc] init];
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:^{
//         
//    }];
}

@end

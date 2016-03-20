//
//  LZProgressHUD.m
//  LZProgressHUD
//
//  Created by comst on 16/3/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZProgressHUD.h"


static UIWindow *window_;

static CGRect windowStartRect;
static CGRect windowMidRect;

static NSTimer *timer_;
@implementation LZProgressHUD

+ (void)initWindow{
    
    [timer_ invalidate];
    timer_ = nil;
    
    window_ .hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.windowLevel = UIWindowLevelAlert;
    windowStartRect = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20);
    windowMidRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.frame = windowStartRect;
    
}

+ (void)showAnimatedWithAutoHide:(BOOL)autoHide{
    

    
    [UIView animateWithDuration:0.25 animations:^{
        window_.frame = windowMidRect;
        window_.hidden = NO;
    } completion:^(BOOL finished) {
        
        if (autoHide) {
            timer_ = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1.5] interval:2 target:self selector:@selector(hide) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSRunLoopCommonModes];
        }
    }];
    
}

+ (void)showSuccess:(NSString *)msg{
    
    UIImage *image = [UIImage imageNamed:@"images.bundle/Ok"];
    
    [self showMessage:msg image:image];
    
}

+ (void)showError:(NSString *)msg{
    
    UIImage *image = [UIImage imageNamed:@"images.bundle/error"];
    
    [self showMessage:msg image:image];
}

+ (void)showMessage:(NSString *)msg image:(UIImage *)img{
    
    [self initWindow];
    UIButton *btn = [[UIButton alloc] init];
    [window_ addSubview:btn];
    btn.userInteractionEnabled = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = window_.bounds;
    [btn setTitle:msg forState:UIControlStateNormal];
    
    [self showAnimatedWithAutoHide:YES];
    
}

+ (void)showIndicatorWithMessage:(NSString *)msg{
    
    [self initWindow];
    UILabel *label = [[UILabel alloc] init];
    label.frame = window_.bounds;
    [window_ addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.text = msg;
    
    CGFloat textW = [msg sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
    CGFloat indicatorX = (window_.bounds.size.width - textW ) * 0.5;
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
    indicatorView.hidesWhenStopped = YES;
    
    indicatorView.center = CGPointMake(indicatorX - 20, 10);
    [indicatorView startAnimating];
    [window_ addSubview:indicatorView];
    [self showAnimatedWithAutoHide:NO];
    
}

+ (void)hide{
    
    [timer_ invalidate];
    timer_ = nil;
    [UIView animateWithDuration:0.25 animations:^{
        window_.frame = windowStartRect;
        
        
    } completion:^(BOOL finished) {
        window_.hidden = YES;
        window_ = nil;
    }];
    
}


@end

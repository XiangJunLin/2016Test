//
//  LZStatusWindow.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/24.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZStatusWindow.h"
#import "LZCommon.h"
#import "UIView+LZShow.h"

static UIWindow *statusWindow_ ;
@implementation LZStatusWindow
+ (void)initialize{
    
    statusWindow_ = [[UIWindow alloc] init];
    statusWindow_.frame = CGRectMake(0, 0, screenWidth, 20);
    statusWindow_.backgroundColor = [UIColor clearColor];
    statusWindow_.windowLevel = UIWindowLevelAlert;
    statusWindow_.hidden = NO;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [statusWindow_ addGestureRecognizer:gesture];
}

+ (void)show{
    statusWindow_.hidden = NO;
}

+ (void)hide{
    statusWindow_.hidden = YES;
}


+ (void)gestureAction:(UITapGestureRecognizer *)gesture{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:keyWindow];
}


+ (void)searchScrollViewInView:(UIView *)superView{
    
    for (UIView *itemView in superView.subviews) {
        if ([itemView isKindOfClass:[UIScrollView class]] && [itemView ShowInWindow]) {
            
            UIScrollView *scrollView = (UIScrollView *)itemView;
            CGPoint offset = scrollView.contentOffset;
            offset.y = - scrollView.contentInset.top;
            [scrollView setContentOffset:offset animated:YES];
            
        }
        [self searchScrollViewInView:itemView];
    }
}

@end

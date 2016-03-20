//
//  LZPublishView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPublishView.h"
#import "LZVerticalButton.h"
#import "LZCommon.h"
#import <pop/POP.h>

@interface LZPublishView ()

@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation LZPublishView

+ (instancetype)publishview{
    
    LZPublishView *publishView = [[[NSBundle mainBundle] loadNibNamed:@"LZPublishViewController" owner:nil options:0] lastObject];
    
    return publishView;
}

- (void)show{
    
    
    self.superview.userInteractionEnabled = NO;
    CGFloat margin = 20;
    CGFloat buttonW = 72;
    CGFloat buttonH = 100;
    CGFloat padding = (screenWidth - 2 * margin - 3 * buttonW) / 2;
    CGFloat startY = (screenHeight - 2 * buttonH) * 0.5;
    CGFloat buttonX ;
    CGFloat buttonY ;
    
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"发链接"];
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    for (NSInteger i = 0; i < 6; i ++) {
        LZVerticalButton *button = [[LZVerticalButton alloc] init];
        [self addSubview:button];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 10000 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonX = margin + (i % 3) * (buttonW + padding);
        buttonY = startY + buttonH * (i / 3);
        CGRect startFrame = CGRectMake(buttonX, -buttonH, buttonW, buttonH);
        CGRect midFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //button.frame = midFrame;
        
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        springAnimation.springBounciness = 6;
        springAnimation.springSpeed = 6;
        springAnimation.fromValue = [NSValue valueWithCGRect:startFrame];
        springAnimation.toValue = [NSValue valueWithCGRect:midFrame];
        springAnimation.beginTime = CACurrentMediaTime() + i * 0.1;
        [springAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            [button pop_removeAllAnimations];
        }];
        [button pop_addAnimation:springAnimation forKey:nil];
    }
    
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:self.logoImageView];
    
    CGFloat logoImageViewX = (screenWidth - self.logoImageView.image.size.width) * 0.5;
    CGFloat logoImageViewY = screenHeight * 0.2;
    CGFloat logoImageViewW = self.logoImageView.image.size.width;
    CGFloat logoImageViewH = self.logoImageView.image.size.height;
    
    POPSpringAnimation *logoAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    logoAnimation.springBounciness = 6;
    logoAnimation.springSpeed = 6;
    logoAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(logoImageViewX, -logoImageViewH, logoImageViewW, logoImageViewH)];
    logoAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(logoImageViewX, logoImageViewY, logoImageViewW, logoImageViewH)];
    logoAnimation.beginTime = CACurrentMediaTime() + 0.6;
    logoAnimation.completionBlock = ^void(POPAnimation *animation, BOOL finished){
        [self.logoImageView pop_removeAllAnimations];
        self.superview.userInteractionEnabled = YES;
    };
    [self.logoImageView pop_addAnimation:logoAnimation forKey:@"logo"];
    
}

- (IBAction)hide{
    [self hideWithPopCompletion:^{
        [self removeFromSuperview];
    }];
}

- (void)btnClick:(UIButton *)btn{
    
    [self hideWithPopCompletion:^{
        [self removeFromSuperview];
        NSLog(@"%@", btn.titleLabel.text);
    }];
}

- (void)hideWithPop{
    [self hideWithPopCompletion:nil];
}

- (void)hideWithPopCompletion:(void (^)())completionBlock{
    
    self.superview.userInteractionEnabled = NO;
    for (NSInteger i = 0; i < 6; i ++) {
        
        UIButton *btn = (UIButton *)[self viewWithTag:i + 10000];
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.beginTime = CACurrentMediaTime() + i * 0.1;
        CGRect endFrame = btn.frame;
        endFrame.origin.y = screenHeight;
        animation.toValue = [NSValue valueWithCGRect:endFrame];
        animation.completionBlock = ^void(POPAnimation *animation, BOOL finished){
            
            [btn pop_removeAllAnimations];
        };
        
        [btn pop_addAnimation:animation forKey:nil];
    }
    
    POPBasicAnimation *logoAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    logoAnimation.beginTime = CACurrentMediaTime() + 0.6;
    CGRect endFrame = self.logoImageView.frame;
    endFrame.origin.y = screenHeight;
    logoAnimation.toValue = [NSValue valueWithCGRect:endFrame];
    logoAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished){
        
        [self.logoImageView pop_removeAllAnimations];
        
        self.superview.userInteractionEnabled = YES;
        !completionBlock? :completionBlock();
        
        
    };
    [self.logoImageView pop_addAnimation:logoAnimation forKey:nil];
}
@end

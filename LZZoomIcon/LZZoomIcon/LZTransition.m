//
//  LZTransition.m
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTransition.h"
#import "LZMenuViewController.h"
#import "LZDetailViewController.h"

typedef NS_OPTIONS(NSInteger, LZTransitionState) {
    kTransitionStateBefore,
    kTransitionStateAfter
};

@interface LZTransition ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation LZTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.6;
}


- (void)setupForState:(LZTransitionState)state fromViewController:(LZMenuViewController *)fromVC bgColorViewForMenuVC:(UIView *)bgViewForMenuVC iconImageViewForMenuVC:(UIImageView *)iconImageViewFormenuVC snapColorView:(UIView *)snapColorView snapIconImageView:(UIImageView *)snapIconImageView bgColorViewForDetaiLVC:(UIView *)bgColorViewForDetailVC iconImageViewForDetailVC:(UIImageView *)iconImageViewForDetailVC{
    
    switch (state) {
        case kTransitionStateBefore:
            fromVC.view.transform = CGAffineTransformIdentity;
            fromVC.view.alpha = 1;
            
            snapColorView.transform = CGAffineTransformIdentity;
            snapColorView.frame = [self.containerView convertRect:bgViewForMenuVC.frame fromView:bgViewForMenuVC.superview];
            snapIconImageView.frame = [self.containerView convertRect:iconImageViewFormenuVC.frame fromView:iconImageViewFormenuVC.superview];
            
            break;
            
        case kTransitionStateAfter:
            fromVC.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
            fromVC.view.alpha = 0;
            
            snapColorView.transform = CGAffineTransformMakeScale(15, 15);
            snapColorView.center = [self.containerView convertPoint:iconImageViewForDetailVC.center fromView:iconImageViewForDetailVC.superview];
            snapIconImageView.frame = [self.containerView convertRect:iconImageViewForDetailVC.frame fromView:iconImageViewForDetailVC.superview];
            
            break;
            
        default:
            break;
    }
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *containerView = [transitionContext containerView];
    self.containerView = containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    LZMenuViewController *menuVC = (LZMenuViewController *)fromVC;
    LZDetailViewController *detailVC = (LZDetailViewController *)toVC;
    
    if (self.operation == UINavigationControllerOperationPop) {
        menuVC = (LZMenuViewController *)toVC;
        detailVC = (LZDetailViewController *)fromVC;
    }
    
    UIView *bgColorViewForMenuVC = [menuVC bgColoredViewForTransition];
    UIImageView *iconImageViewForMenuVC = [menuVC iconImageVIewForTransition];
    
    UIView *bgColorViewForDetailVC = [detailVC bgColoredViewForTransition];
    UIImageView *iconImageViewForDetailVC = [detailVC iconImageVIewForTransition];
    
    [containerView addSubview:menuVC.view];
    
    UIView *snapBgColorView = [bgColorViewForMenuVC snapshotViewAfterScreenUpdates:NO];
    UIImageView *snapIconImageView = [[UIImageView alloc] initWithImage:iconImageViewForMenuVC.image];
//    snapIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [containerView addSubview:menuVC.view];
    [containerView addSubview:snapBgColorView];
    [containerView addSubview:detailVC.view];
    [containerView addSubview:snapIconImageView];
    
    UIColor *detailVCbgColor = detailVC.view.backgroundColor;
    
    detailVC.view.backgroundColor  = [UIColor clearColor];
    
    bgColorViewForMenuVC.hidden = YES;
    iconImageViewForMenuVC.hidden = YES;
    
    bgColorViewForDetailVC.hidden = YES;
    iconImageViewForDetailVC.hidden = YES;
    
    LZTransitionState preState = kTransitionStateBefore;
    LZTransitionState postState = kTransitionStateAfter;
    if (self.operation == UINavigationControllerOperationPop) {
        preState = kTransitionStateAfter;
        postState = kTransitionStateBefore;
    }
    
    [detailVC transition:self willAnimatedForOperation:self.operation];
    
    [self setupForState:preState fromViewController:menuVC bgColorViewForMenuVC:bgColorViewForMenuVC iconImageViewForMenuVC:iconImageViewForMenuVC snapColorView:snapBgColorView snapIconImageView:snapIconImageView bgColorViewForDetaiLVC:bgColorViewForDetailVC iconImageViewForDetailVC:iconImageViewForDetailVC];
    
    [detailVC.view  layoutIfNeeded];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [self setupForState:postState fromViewController:menuVC bgColorViewForMenuVC:bgColorViewForMenuVC iconImageViewForMenuVC:iconImageViewForMenuVC snapColorView:snapBgColorView snapIconImageView:snapIconImageView bgColorViewForDetaiLVC:bgColorViewForDetailVC iconImageViewForDetailVC:iconImageViewForDetailVC];
        
    } completion:^(BOOL finished) {
        
        menuVC.view.transform = CGAffineTransformIdentity;
        
        bgColorViewForMenuVC.hidden = NO;
        iconImageViewForMenuVC.hidden = NO;
        
        bgColorViewForDetailVC.hidden = NO;
        iconImageViewForDetailVC.hidden = NO;
        
        detailVC.view.backgroundColor = detailVCbgColor;
        
        [snapIconImageView removeFromSuperview];
        [snapBgColorView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    self.operation = operation;
    
    return self;
}

@end

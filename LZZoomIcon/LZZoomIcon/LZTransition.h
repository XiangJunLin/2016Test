//
//  LZTransition.h
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LZTransition ;

@protocol LZZoomingTransition <NSObject>

- (UIView *)bgColoredViewForTransition;

- (UIImageView *)iconImageVIewForTransition;

@optional

- (void)transition:(LZTransition *)transition willAnimatedForOperation:(UINavigationControllerOperation)operation ;

@end

@interface LZTransition : NSObject <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

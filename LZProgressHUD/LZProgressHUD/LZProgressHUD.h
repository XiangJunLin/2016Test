//
//  LZProgressHUD.h
//  LZProgressHUD
//
//  Created by comst on 16/3/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZProgressHUD : UIView

+ (void)showSuccess:(NSString *)msg;

+ (void)showError:(NSString *)msg;

+ (void)showMessage:(NSString *)msg image:(UIImage *)img;

+ (void)showIndicatorWithMessage:(NSString *)msg;

+ (void)hide;

@end

//
//  UIView+LZShow.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/24.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "UIView+LZShow.h"

@implementation UIView (LZShow)

- (BOOL)ShowInWindow{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect windowRectInSuperview = [keyWindow convertRect:keyWindow.frame toView:self.superview];
    BOOL isInterset = CGRectIntersectsRect(self.frame, windowRectInSuperview);
    
    return self.userInteractionEnabled  && self.alpha > 0.01 && self.window == keyWindow && isInterset ;
}

@end

//
//  UIView+LZBarbuttonItem.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "UIView+LZBarbuttonItem.h"
#import "LZCommon.h"

@implementation UIBarButtonItem (LZBarbuttonItem)

+ (UIBarButtonItem *) buttonitemWithImage:(NSString *)normal highlightedImage:(NSString *)highlighted target:(id)target selector:(SEL)sel {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.width = btn.currentBackgroundImage.size.width;
    btn.height = btn.currentBackgroundImage.size.height;

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end

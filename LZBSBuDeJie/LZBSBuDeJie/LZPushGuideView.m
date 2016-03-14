//
//  LZPushGuideView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/14.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPushGuideView.h"

@implementation LZPushGuideView

+ (instancetype)guideView{
    
    LZPushGuideView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    return view;
}
- (IBAction)btnClick:(id)sender {
    
    [self removeFromSuperview];
}

@end

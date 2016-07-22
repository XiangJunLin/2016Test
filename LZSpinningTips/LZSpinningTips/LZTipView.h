//
//  LZTipView.h
//  LZSpinningTips
//
//  Created by comst on 16/7/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTipItem.h"

@interface LZTipView : UIView

@property (nonatomic, strong) NSArray *tipList;

+ (instancetype)tipView;


- (void)setupTip:(NSInteger)index;
@end

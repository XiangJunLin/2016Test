//
//  LZIconCell.m
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZIconCell.h"

@interface LZIconCell ()


@end

@implementation LZIconCell
- (void)setCurrentItem:(LZIconItem *)currentItem{
    _currentItem = currentItem;
    self.bgColorView.backgroundColor = currentItem.color;
    self.iconImageView.image = [UIImage imageNamed: currentItem.image];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bgColorView.layer.cornerRadius = self.bounds.size.width / 2;
    self.bgColorView.layer.masksToBounds = YES;
    
}
@end

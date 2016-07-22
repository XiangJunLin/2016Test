//
//  LZItemCell.m
//  LZStretchHeader
//
//  Created by comst on 16/7/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZItemCell.h"

@interface LZItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *conctentLabel;

@end

@implementation LZItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCurrentItem:(LZItem *)currentItem{
    _currentItem = currentItem;
    
    self.titleLabel.text = currentItem.title;
    self.titleLabel.textColor = currentItem.color;
    self.conctentLabel.text = currentItem.content;
    
    
}

@end

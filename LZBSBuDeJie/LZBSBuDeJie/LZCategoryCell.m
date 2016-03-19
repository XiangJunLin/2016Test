//
//  LZCategoryCell.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/8.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCategoryCell.h"
#import "LZCommon.h"

@implementation LZCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = LZBKColor;
    self.tilteLabel.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    self.indicatorView.hidden = !selected;
    self.tilteLabel.textColor = selected ? [UIColor redColor]:[UIColor grayColor];
    self.backgroundColor = selected ? [UIColor whiteColor]:LZBKColor;
    
}

@end

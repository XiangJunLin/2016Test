//
//  LZSubCategoryCell.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/8.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZSubCategoryCell.h"

@implementation LZSubCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.iconView.layer.cornerRadius = 25;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

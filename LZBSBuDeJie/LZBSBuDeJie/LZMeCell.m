//
//  LZMeCell.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/25.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZMeCell.h"
#import "LZCommon.h"

@implementation LZMeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.imageView.width = 30;
    self.imageView.height = 30;
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    self.imageView.centerY =  self.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
    
}
@end

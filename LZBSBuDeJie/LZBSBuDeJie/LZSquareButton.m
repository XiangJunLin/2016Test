//
//  LZSquareButton.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/25.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZSquareButton.h"
#import "LZCommon.h"
#import "UIButton+WebCache.h"

@implementation LZSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat imageW = self.width * 0.5;
    CGFloat imageH = imageW;
    
    self.imageView.x = (self.width - imageW) * 0.5 ;
    
    self.imageView.y = self.height * 0.1;

    self.imageView.width = imageW;
    self.imageView.height =imageH;
    
    
    
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.width = self.width;
}


@end

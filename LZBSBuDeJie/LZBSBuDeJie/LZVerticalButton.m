//
//  LZVerticalButton.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/11.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZVerticalButton.h"
#import "LZCommon.h"

@implementation LZVerticalButton

- (void)awakeFromNib{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        return self;
    }
    return nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end

//
//  LZCommentTableViewHeader.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCommentTableViewHeader.h"
#import "LZCommon.h"

@interface LZCommentTableViewHeader ()
@property (nonatomic, strong) UILabel *label;
@end
@implementation LZCommentTableViewHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = LZBKColor;
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.x = LZCellMargin;
        label.textColor = LZColor(67, 67, 67);
        label.backgroundColor = [UIColor clearColor];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}
@end

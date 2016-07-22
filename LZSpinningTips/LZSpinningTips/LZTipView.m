//
//  LZTipView.m
//  LZSpinningTips
//
//  Created by comst on 16/7/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTipView.h"

@interface LZTipView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageview;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation LZTipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)tipView{
    
    return [[[UINib nibWithNibName:@"LZTipView" bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil] firstObject];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

//- (void)setCurrentTip:(LZTipItem *)currentTip{
//    
//    _currentTip = currentTip;
//    self.titleLabel.text = currentTip.tipTitle;
//    self.contentLabel.text = currentTip.tipContent;
//    self.iconImageview.image = [UIImage imageNamed:currentTip.tipImage];
//    
//}

- (void)setupTip:(NSInteger)index{
    if (index < 0 || index > self.tipList.count) {
        return;
    }
    LZTipItem *currentTip = self.tipList[index];
    
    self.titleLabel.text = currentTip.tipTitle;
    self.contentLabel.text = currentTip.tipContent;
    self.iconImageview.image = [UIImage imageNamed:currentTip.tipImage];
    self.pageControl.currentPage = index;
    self.pageControl.numberOfPages = self.tipList.count;
}

- (CGRect)alignmentRectForFrame:(CGRect)frame{
    
    return self.bounds;
}
@end

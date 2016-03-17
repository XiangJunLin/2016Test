//
//  LZCustomCellTableViewCell.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/17.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCustomCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface LZCustomCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@end

@implementation LZCustomCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headImageView.layer.cornerRadius = self.headImageView.width * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    self.vipImageView.hidden = YES;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}



- (void)setCurrentModel:(LZTopicModel *)currentModel{
    currentModel.user.is_v = (arc4random_uniform(10000) % 2 == 0);
    _currentModel = currentModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:currentModel.user.iconURL] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.usernameLabel.text = currentModel.user.name;
    self.publishTimeLabel.text = currentModel.passtime;
    
    self.vipImageView.hidden = !currentModel.user.is_v;
    [self setNumberOnButton:self.dingButton number:currentModel.up placeholder:@"顶"];
    [self setNumberOnButton:self.caiButton number:currentModel.down placeholder:@"踩"];
    [self setNumberOnButton:self.forwardButton number:currentModel.forward placeholder:@"转发"];
    [self setNumberOnButton:self.commentButton number:currentModel.comment placeholder:@"评论"];
    
}

- (void)setNumberOnButton:(UIButton *)btn number:(NSInteger)number placeholder:(NSString *)placeholderstring{
    
    if (number > 0) {
        
        NSString *numberString = [NSString stringWithFormat:@"%li", number];
//        btn.titleLabel.text = numberString;
        
        [btn setTitle:numberString forState:UIControlStateNormal];
        [btn setTitle:numberString forState:UIControlStateHighlighted];
        
    }else{
//        btn.titleLabel.text = placeholderstring;
        [btn setTitle:placeholderstring forState:UIControlStateNormal];
        [btn setTitle:placeholderstring forState:UIControlStateHighlighted];
        
    }
}

- (void)setFrame:(CGRect)frame{
    
    CGPoint origin = frame.origin;
    origin.x = 5;
    origin.y += 10;
    frame.size.width -= origin.x * 2;
    frame.size.height -= 10;
    frame.origin = origin;
    [super setFrame:frame];
}
@end

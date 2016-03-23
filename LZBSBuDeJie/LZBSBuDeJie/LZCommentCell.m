//
//  LZCommentCell.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCommentCell.h"
#import "UIImageView+WebCache.h"


@interface LZCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end


@implementation LZCommentCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCurrentItem:(LZCommentModel *)currentItem{
    _currentItem = currentItem;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:currentItem.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.vipImageView.hidden = currentItem.user.is_vip ? YES : NO;
    self.sexImageView.image = [currentItem.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.userNameLabel.text = currentItem.user.username;
    self.praiseCountLabel.text = [NSString stringWithFormat:@"%@", currentItem.likeCount];
    self.contentLabel.text = currentItem.content;
    
}
@end

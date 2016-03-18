//
//  LZPictureView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/18.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPictureView.h"
#import "UIImageView+WebCache.h"
@interface LZPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gitPictureView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation LZPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)pictureView{
    
    LZPictureView *pictureView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    return pictureView;
    
}

- (void)setCurrentItem:(LZTopicModel *)currentItem{
    _currentItem = currentItem;
    
    self.gitPictureView.hidden = [currentItem.type isEqualToString:@"image"];
    if (currentItem.seeBig) {
        self.seeBigButton.hidden = NO;
        self.pictureImageView.contentMode = UIViewContentModeTop;
    }else{
        self.seeBigButton.hidden = YES;
        self.pictureImageView.contentMode = UIViewContentModeScaleToFill;
    }
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:currentItem.picture.imageURL]];
}
@end

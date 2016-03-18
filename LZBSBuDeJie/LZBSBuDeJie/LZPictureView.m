//
//  LZPictureView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/18.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPictureView.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"

@interface LZPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gitPictureView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation LZPictureView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.seeBigButton.hidden = YES;
    self.gitPictureView.hidden = YES;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 10;
    
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
        self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.pictureImageView.contentMode = UIViewContentModeScaleToFill;
    }
    NSURL *imageURL = [NSURL URLWithString:currentItem.picture.imageURL];
    
    self.progressView.hidden = NO;
    [self.pictureImageView sd_setImageWithURL:imageURL placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:NO];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%li", (NSInteger)(progress * 100)];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}
@end

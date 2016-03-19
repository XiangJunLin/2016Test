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
#import "LZSeeBigViewController.h"
#import "AppDelegate.h"

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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigGesture:)];
    
    [self.pictureImageView addGestureRecognizer:tapGesture];
    
}


#pragma mark - see big
- (void)seeBigGesture:(UIGestureRecognizer *)ges{
    
    [self presentSeeBigVC];
}

- (IBAction)seeBigImage:(UIButton *)sender {
    [self presentSeeBigVC];
}

- (void)presentSeeBigVC{
    
    LZSeeBigViewController *seeBigVC = [[LZSeeBigViewController alloc] init];
    seeBigVC.currrentItem = self.currentItem;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVC animated:YES completion:^{
        
    }];
}

+ (instancetype)pictureView{
    
    LZPictureView *pictureView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    return pictureView;
    
}

- (void)setCurrentItem:(LZTopicModel *)currentItem{
    _currentItem = currentItem;
    
    self.pictureImageView.userInteractionEnabled = NO;
    [self.progressView setProgress:self.currentItem.picture.progress animated:NO];
    self.progressView.progressLabel.text = [NSString stringWithFormat:@"%li", (NSInteger)(self.currentItem.picture.progress * 100)];
    
    NSURL *imageURL = [NSURL URLWithString:currentItem.picture.imageURL];
    
    self.progressView.hidden = NO;
    
     __weak typeof(self) weakSelf = self;
    [self.pictureImageView sd_setImageWithURL:imageURL placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
       
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        weakSelf.currentItem.picture.progress = progress;
        
        [weakSelf.progressView setProgress:weakSelf.currentItem.picture.progress animated:NO];
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%li", (NSInteger)(weakSelf.currentItem.picture.progress * 100)];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        weakSelf.progressView.hidden = YES;
        weakSelf.pictureImageView.userInteractionEnabled = YES;
        
        weakSelf.gitPictureView.hidden = [currentItem.type isEqualToString:@"image"];
        
        if (currentItem.seeBig) {
            weakSelf.seeBigButton.hidden = NO;
            weakSelf.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        }else{
            weakSelf.seeBigButton.hidden = YES;
            weakSelf.pictureImageView.contentMode = UIViewContentModeScaleToFill;
        }
        
        if (currentItem.seeBig) {
            
            CGSize contextSize  = CGSizeMake(screenWidth - LZCellMargin * 2 - LZItemPadding * 2, LZSeeBigPictureHeight);
            UIGraphicsBeginImageContextWithOptions(contextSize, YES, 0.0);
            
            
            CGRect imgRect ;
            imgRect.origin = CGPointMake(0, 0);
            imgRect.size.width = contextSize.width;
            imgRect.size.height = contextSize.width * currentItem.picture.height / currentItem.picture.width;
            [image drawInRect:imgRect];
            weakSelf.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        
    }];
}
@end

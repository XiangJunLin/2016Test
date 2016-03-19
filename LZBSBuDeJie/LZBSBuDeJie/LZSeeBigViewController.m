//
//  LZSeeBigViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/19.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZSeeBigViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "LZCommon.h"

@interface LZSeeBigViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (nonatomic, strong) UIImageView *pictureView;
@end

@implementation LZSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pictureView = [[UIImageView alloc] init];
    [self.containerView addSubview:self.pictureView];
    
    
    NSString *shareCountString = [NSString stringWithFormat:@"%li", _currrentItem.forward];
    NSString *commentCountString = [NSString stringWithFormat:@"%li", _currrentItem.comment];
    
    [self.shareButton setTitle:shareCountString forState:UIControlStateNormal];
    [self.commentButton setTitle:commentCountString forState:UIControlStateNormal];
    [self configPictureView];
}


- (void)configPictureView{
    
    CGFloat pictureViewW = screenWidth;
    CGFloat pictureViewH = pictureViewW * self.currrentItem.picture.height / self.currrentItem.picture.width;
    CGFloat pictureViewX = 0;
    CGFloat pictureViewY = 0;
    if (pictureViewH <= screenHeight) {
        pictureViewY = (screenHeight - pictureViewH) * 0.5;
        self.containerView.contentSize = CGSizeMake(screenWidth, screenHeight);
        
    }else{
        pictureViewY = 0;
        self.containerView.contentSize = CGSizeMake(screenWidth, pictureViewH);
    }
    self.pictureView.frame = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:self.currrentItem.picture.imageURL]];
}

- (IBAction)saveAction:(UIButton *)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.pictureView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
- (IBAction)backAction:(UIButton *)sender {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
         
    }];
}





@end

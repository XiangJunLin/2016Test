//
//  LZCommentHeaderView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCommentHeaderView.h"
#import "LZPictureView.h"
#import "LZAudioView.h"
#import "LZVedioView.h"
#import "LZCommon.h"
#import "UIImageView+WebCache.h"

@interface LZCommentHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;


@property (nonatomic, strong) LZPictureView *pictureView;
@property (nonatomic, strong) LZAudioView *audioVIew;
@property (nonatomic, strong) LZVedioView *vedioView;

@end

@implementation LZCommentHeaderView

+ (instancetype)commentHeaderView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LZCommentHeaderView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.headImageView.layer.cornerRadius = self.headImageView.width * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    self.vipImageView.hidden = YES;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setCurrentModel:(LZTopicModel *)currentModel{
    currentModel.user.is_v = (arc4random_uniform(10000) % 2 == 0);
    _currentModel = currentModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:currentModel.user.iconURL] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.usernameLabel.text = currentModel.user.name;
    self.publishTimeLabel.text = currentModel.passtime;
    self.topicLabel.text = currentModel.text;
    
    if ([currentModel.type isEqualToString:@"gif"] || [currentModel.type isEqualToString:@"image"]) {
        
     
        self.pictureView.width = screenWidth - 2 * LZCellMargin - 2 * LZItemPadding;
        
        //CGFloat pictureViewHeight = self.pictureView.width * currentModel.picture.height / currentModel.picture.width;
        self.pictureView.height = currentModel.pictureViewHeight;
        
        self.pictureView.x = LZItemPadding;
        self.pictureView.y = LZItemPadding + LZHeadHeight + LZItemPadding + currentModel.textHeight + LZItemPadding;
        self.pictureView.currentItem = currentModel;
    }else if ([currentModel.type isEqualToString:@"audio"]) {
      
        self.audioVIew.frame = currentModel.audioViewFrame;
        self.audioVIew.currentModel = currentModel;
    }else if ([currentModel.type isEqualToString:@"video"]) {
       
        self.vedioView.frame = currentModel.vedioViewFrame;
        self.vedioView.currentModel = currentModel;
    }else{
      
    }
    
   
    
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

#pragma mark - lazy load

- (LZPictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = [LZPictureView pictureView];
        [self addSubview:_pictureView];
        
    }
    return _pictureView;
}

- (LZAudioView *)audioVIew{
    
    if (!_audioVIew) {
        _audioVIew = [LZAudioView audioView];
        [self addSubview:_audioVIew];
    }
    return _audioVIew;
}

- (LZVedioView *)vedioView{
    if (!_vedioView) {
        _vedioView = [LZVedioView vedioView] ;
        [self addSubview:_vedioView];
    }
    return _vedioView;
}

@end

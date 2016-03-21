//
//  LZAudioView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZAudioView.h"
#import "UIImageView+WebCache.h"

@interface LZAudioView ()

@property (weak, nonatomic) IBOutlet UIImageView *coverageImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation LZAudioView

+ (instancetype)audioView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LZAudioView" owner:nil options:nil] firstObject];
    
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setCurrentModel:(LZTopicModel *)currentModel{
    
    _currentModel = currentModel;
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%li次播放", currentModel.audio.playCount];
    self.durationLabel.text = [NSString stringWithFormat:@"%02li:%02li", currentModel.audio.duration / 60 , currentModel.audio.duration % 60];
    [self.coverageImageVIew sd_setImageWithURL:[NSURL URLWithString:currentModel.audio.coverImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
@end

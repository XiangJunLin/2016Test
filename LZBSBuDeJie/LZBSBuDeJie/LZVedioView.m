//
//  LZVedioView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZVedioView.h"
#import "UIImageView+WebCache.h"

@interface LZVedioView ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;


@end

@implementation LZVedioView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)vedioView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LZVedioView" owner:nil options:nil] lastObject];
}

- (void)setCurrentModel:(LZTopicModel *)currentModel{
    
    _currentModel = currentModel;
    
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:currentModel.vedio.thumbnail] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.playcountLabel.text = [NSString stringWithFormat:@"%li次播放", currentModel.vedio.playCount];
    self.durationLabel.text = [NSString stringWithFormat:@"%02li:%02li", currentModel.vedio.duration / 60, currentModel.vedio.duration % 60];
}
@end

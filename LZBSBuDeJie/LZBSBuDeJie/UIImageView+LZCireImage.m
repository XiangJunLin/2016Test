//
//  UIImageView+LZCireImage.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/24.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "UIImageView+LZCireImage.h"
#import "UIImage+LZCircleImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (LZCireImage)

- (void)setCircleImage:(NSString *)imageURL{
    
    UIImage *placeHolder = [UIImage imageNamed:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = !image ? placeHolder.circleImage : image.circleImage;
    }];
    
}
@end

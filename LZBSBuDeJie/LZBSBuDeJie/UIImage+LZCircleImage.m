//
//  UIImage+LZCircleImage.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/24.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "UIImage+LZCircleImage.h"

@implementation UIImage (LZCircleImage)
- (instancetype)circleImage{
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect circleRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, circleRect);
    CGContextClip(context);
    
    [self drawInRect:circleRect];    
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return circleImage;
}
@end

//
//  LZTopicModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/16.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTopicModel.h"
#import "LZCommon.h"

@implementation LZTopicModel
- (CGFloat)textHeight{
    
    if (_textHeight == 0) {
        
        _textHeight = [self.text boundingRectWithSize:CGSizeMake(screenWidth - 2 * LZCellMargin - 2 * LZItemPadding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size.height;
    }
    return _textHeight;
}

- (CGFloat)totalHeight{
    
    if (_totalHeight == 0) {
        _totalHeight = LZItemPadding + LZHeadHeight + LZItemPadding + self.textHeight + LZBottomContainerHeight + LZSeperatorHeight + LZCellMargin + LZCellMargin;
        
        if ([self.type isEqualToString:@"image"] || [self.type isEqualToString:@"gif"]) {
            CGFloat pictureviewWidth =screenWidth - 2 * LZCellMargin - 2 * LZItemPadding;
            self.pictureViewHeight = pictureviewWidth * self.picture.height / self.picture.width;
            self.seeBig = NO;
            if (self.pictureViewHeight > LZMaxPictureHeight) {
                self.seeBig = YES;
                self.pictureViewHeight = LZSeeBigPictureHeight;
               
                
            }
            _totalHeight += self.pictureViewHeight + LZCellMargin;
        }
    }
    
    return _totalHeight;
}
@end

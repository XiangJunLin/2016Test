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


+ (instancetype)topicModelWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        
        self.user = [LZUserModel userModelWithDic:dict[@"u"]];
        self.topicID = dict[@"id"];
        self.text = dict[@"text"];
        self.up = [dict[@"up"] integerValue];
        self.down = [dict[@"down"] integerValue];
        self.forward = [dict[@"forward"] integerValue];
        self.comment = [dict[@"comment"] integerValue];
        self.passtime = dict[@"passtime"];
        self.type = dict[@"type"];
        if ([[dict allKeys] containsObject:@"top_comment"]) {
            self.top_comment = [LZCommentModel commentModelWithDic:dict[@"top_comment"]];
        }
        
        if ([self.type isEqualToString:@"audio"]) {
            self.audio = [LZAudioModel audioModelWithDic:dict[@"audio"]];
        } else if ([self.type isEqualToString:@"video"]){
        
            self.vedio = [LZVedioModel vedioModelWithDic:dict[@"video"]];
        }else if ([self.type isEqualToString:@"gif"] || [self.type isEqualToString:@"image"]){
            self.picture = [LZPictureModel pictureWithDic:dict];
        }
        return self;
    }
    
    return nil;
}


- (CGFloat)textHeight{
    
    if (_textHeight == 0) {
        
        _textHeight = [self.text boundingRectWithSize:CGSizeMake(screenWidth - 2 * LZCellMargin - 2 * LZItemPadding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size.height;
    }
    return _textHeight;
}

- (CGFloat)totalHeight{
    
    if (_totalHeight == 0) {
        _totalHeight = LZItemPadding + LZHeadHeight + LZItemPadding + self.textHeight + LZCellMargin + LZSeperatorHeight  +LZBottomContainerHeight +  LZCellMargin;
        CGFloat frameX = LZItemPadding;
        CGFloat frameY = LZItemPadding + LZHeadHeight + LZItemPadding + self.textHeight + LZItemPadding;
        CGFloat frameW = screenWidth - 2 * LZItemPadding - 2 * LZCellMargin;
        CGFloat frameH ;
        
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
        
        if ([self.type isEqualToString:@"audio"]) {
            frameH = frameW * self.audio.coverHeight / self.audio.coverWidth;
            self.audioViewFrame = CGRectMake(frameX, frameY, frameW, frameH);
            
            _totalHeight += frameH + LZCellMargin;
        }
        
        if ([self.type isEqualToString:@"video"]) {
            frameH = frameW * self.vedio.height / self.vedio.width;
            self.vedioViewFrame = CGRectMake(frameX, frameY, frameW, frameH);
            
            _totalHeight += frameH + LZCellMargin;
        }
        
        if (self.top_comment) {
            
            NSString *totalContent = [NSString stringWithFormat:@"%@ : %@", self.top_comment.username, self.top_comment.content];
            CGFloat contentH = [totalContent boundingRectWithSize:CGSizeMake(frameW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
            _totalHeight += contentH + LZTopCommentLabelHeight ;
        }
        
    }
    
    return _totalHeight;
}
@end

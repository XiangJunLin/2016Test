//
//  LZTopicModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/16.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZUserModel.h"
#import "LZPictureModel.h"
#import "LZAudioModel.h"
#import "LZVedioModel.h"
#import "LZCommentModel.h"

@interface LZTopicModel : NSObject
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *topicID;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger down;
@property (nonatomic, assign) NSInteger up;
@property (nonatomic, assign) NSInteger forward;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, strong) LZUserModel *user;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) LZPictureModel *picture;
@property (nonatomic, strong) LZAudioModel *audio;
@property (nonatomic, strong) LZVedioModel *vedio;
@property (nonatomic, strong) LZCommentModel *top_comment;

@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, assign) CGFloat pictureViewHeight;
@property (nonatomic, assign) BOOL seeBig;

@property (nonatomic, assign) CGRect audioViewFrame;
@property (nonatomic, assign) CGRect vedioViewFrame;

+ (instancetype)topicModelWithDict:(NSDictionary *)dict;
@end

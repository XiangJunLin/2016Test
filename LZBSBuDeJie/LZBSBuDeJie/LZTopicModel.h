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

@interface LZTopicModel : NSObject
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger down;
@property (nonatomic, assign) NSInteger up;
@property (nonatomic, assign) NSInteger forward;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, strong) LZUserModel *user;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) LZPictureModel *picture;

@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, assign) CGFloat pictureViewHeight;
@property (nonatomic, assign) BOOL seeBig;
@end

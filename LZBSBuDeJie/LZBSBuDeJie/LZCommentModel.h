//
//  LZCommentModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LZCommentUserModel.h"
@interface LZCommentModel : NSObject
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *topicID;
@property (nonatomic, copy) NSString *voiceURI;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, strong) LZCommentUserModel *user;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger voiceTime;
@property (nonatomic, copy) NSString *commentID;
+ (instancetype)commentModelWithDic:(NSDictionary *)dict;

@end

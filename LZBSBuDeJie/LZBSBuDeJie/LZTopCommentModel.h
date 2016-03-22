//
//  LZCommentModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LZTopCommentModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, copy) NSString *voiceurl;

+ (instancetype)commentModelWithDic:(NSDictionary *)dict;

@end

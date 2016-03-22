//
//  LZCommentUserModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LZCommentUserModel : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, assign) BOOL is_vip;
@property (nonatomic, copy) NSString *sex;


+ (instancetype)commentUserWithDic:(NSDictionary *)dict;
@end

//
//  LZCommentUserModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCommentUserModel.h"

@implementation LZCommentUserModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.username = dict[@"username"];
        self.profile_image = dict[@"profile_image"];
        self.is_vip = dict[@"is_vip"];
        self.sex = dict[@"sex"];
        
    }
    return self;
}

+ (instancetype)commentUserWithDic:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}
@end

//
//  LZCommentModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTopCommentModel.h"

@implementation LZTopCommentModel

+ (instancetype)commentModelWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        
        NSDictionary *userDic = dict[@"u"];
        self.content = dict[@"content"];
        self.like_count = [dict[@"like_count"] integerValue];
        self.username = userDic[@"name"];
        self.header = [userDic[@"header"] firstObject];
        self.sex = userDic[@"sex"];
        self.voiceurl = dict[@"voiceurl"];
        self.voicetime = [dict[@"voicetime"] integerValue];
        
    }
    return self;
}
@end

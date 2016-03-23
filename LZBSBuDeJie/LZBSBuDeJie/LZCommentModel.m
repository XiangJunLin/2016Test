//
//  LZCommentModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCommentModel.h"

@implementation LZCommentModel

- (instancetype)initWithDic:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.commentID = dict[@"id"];
        self.likeCount = dict[@"like_count"];
        self.topicID = dict[@"data_id"];
        self.voiceURI = dict[@"voiceuri"];
        self.ctime = dict[@"ctime"];
        self.user = [LZCommentUserModel commentUserWithDic:dict[@"user"]];
        self.content = dict[@"content"];
        self.voiceTime = [dict[@"voicetime"] integerValue];
    }
    return self;
}

+ (instancetype)commentModelWithDic:(NSDictionary *)dict{
    
    return [[self alloc] initWithDic:dict];
}
@end

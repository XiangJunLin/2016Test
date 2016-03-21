//
//  LZAudioModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZAudioModel.h"

@implementation LZAudioModel

+ (instancetype)audioModelWithDic:(NSDictionary *)dic{
    
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.audio = [dict[@"audio"] firstObject];
        self.coverImage = [dict[@"download_url"] firstObject];
        self.duration = [dict[@"duration"] integerValue];
        self.coverHeight = [dict[@"height"] floatValue];
        self.coverWidth = [dict[@"width"] floatValue];
        self.playCount = [dict[@"playcount"] integerValue];
    }
    return self;
}
@end

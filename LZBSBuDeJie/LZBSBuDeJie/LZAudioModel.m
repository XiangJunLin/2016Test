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
        NSDictionary *audioDict = dict[@"audio"];
        self.audio = [audioDict[@"audio"] firstObject];
        self.coverImage = [audioDict[@"download_url"] firstObject];
        self.duration = [audioDict[@"duration"] integerValue];
        self.coverHeight = [audioDict[@"height"] floatValue];
        self.coverWidth = [audioDict[@"width"] floatValue];
        self.playCount = [audioDict[@"playcount"] integerValue];
    }
    return self;
}
@end

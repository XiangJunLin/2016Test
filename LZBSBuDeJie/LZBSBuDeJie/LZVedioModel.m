//
//  LZVedioModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZVedioModel.h"

@implementation LZVedioModel

+ (instancetype)vedioModelWithDic:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
        
        NSDictionary *vedioDic = dict[@"video"];
        self.vedio = [vedioDic[@"video"] firstObject];
        self.thumbnail = [vedioDic[@"thumbnail"] firstObject];
        self.width = [vedioDic[@"width"] integerValue];
        self.height = [vedioDic[@"height"] integerValue];
        self.playCount = [vedioDic[@"playcount"] integerValue];
        self.duration = [vedioDic[@"duration"] integerValue];
        
        return self;
    }
    
    return nil;
}
@end

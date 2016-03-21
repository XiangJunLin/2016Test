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
        
       
        self.vedio = [dict[@"video"] firstObject];
        self.thumbnail = [dict[@"thumbnail"] firstObject];
        self.width = [dict[@"width"] integerValue];
        self.height = [dict[@"height"] integerValue];
        self.playCount = [dict[@"playcount"] integerValue];
        self.duration = [dict[@"duration"] integerValue];
        
        return self;
    }
    
    return nil;
}
@end

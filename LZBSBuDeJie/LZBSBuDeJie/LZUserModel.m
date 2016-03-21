//
//  LZUserModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/16.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZUserModel.h"

@implementation LZUserModel

+ (instancetype)userModelWithDic:(NSDictionary *)dict{
    
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.is_v = dict[@"is_v"];
        self.is_vip = dict[@"is_vip"];
        self.name = dict[@"name"];
        self.iconURL = [dict[@"header"]  firstObject];
        return self;
    }
    return nil;
}
@end

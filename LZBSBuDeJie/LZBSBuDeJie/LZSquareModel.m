//
//  LZSquareModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/25.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZSquareModel.h"

@implementation LZSquareModel

+ (instancetype)suareModelWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        self.url = dict[@"url"];
    }
    
    return self;
}
@end

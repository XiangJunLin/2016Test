//
//  LZPictureModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/18.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPictureModel.h"

@implementation LZPictureModel

+ (instancetype)pictureWithDic:(NSDictionary *)dict{
    LZPictureModel *model ;
    
    NSString *picType = dict[@"type"];
    
    if ([picType isEqualToString:@"gif"]) {
        model = [self gifPictureWithDic:dict[@"gif"]];
    }else{
        model = [self normalPictureWithDic:dict[@"image"]];
    }
    return model;
}

+ (instancetype)normalPictureWithDic:(NSDictionary *)dict{
    
    LZPictureModel *model = [[LZPictureModel alloc] init];
    model.width = [dict[@"width"] floatValue];
    model.height = [dict[@"height"] floatValue];
    model.imageURL = [dict[@"big"] firstObject];
    return model;
    
}

+ (instancetype)gifPictureWithDic:(NSDictionary *)dict{
    
    LZPictureModel *model = [[LZPictureModel alloc] init];
    model.width = [dict[@"width"] floatValue];
    model.height = [dict[@"height"] floatValue];
    model.imageURL = [dict[@"images"] firstObject];
    return model;
    
}
@end

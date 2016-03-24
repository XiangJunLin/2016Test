//
//  LZSquareModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/25.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZSquareModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *url;

+ (instancetype)suareModelWithDict:(NSDictionary *)dict;

@end

//
//  LZVedioModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LZVedioModel : NSObject
@property (nonatomic, copy) NSString *vedio;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger duration;

+ (instancetype)vedioModelWithDic:(NSDictionary *)dict;

@end

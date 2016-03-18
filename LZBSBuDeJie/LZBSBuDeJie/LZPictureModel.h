//
//  LZPictureModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/18.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LZPictureModel : NSObject
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *imageURL;

+ (instancetype)pictureWithDic:(NSDictionary *)dict;
@end

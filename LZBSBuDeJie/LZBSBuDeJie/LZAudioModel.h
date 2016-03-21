//
//  LZAudioModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LZAudioModel : NSObject

@property (nonatomic, copy) NSString *audio;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) CGFloat coverHeight;
@property (nonatomic, assign) CGFloat coverWidth;


+ (instancetype)audioModelWithDic:(NSDictionary *)dic;

@end

//
//  LZUserModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/16.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZUserModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL is_v;
@property (nonatomic, assign) BOOL is_vip;
@property (nonatomic, copy) NSString *iconURL;
@end

//
//  LZCategoryModel.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/7.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZCategoryModel : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSMutableArray *subcategories;
@property (nonatomic, strong) NSDictionary *lastRequestParams;
@property (nonatomic, strong) NSDictionary *lastPollUpParams;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger pageNumber;
@end

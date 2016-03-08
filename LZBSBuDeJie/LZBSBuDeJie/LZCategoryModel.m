//
//  LZCategoryModel.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/7.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCategoryModel.h"

@implementation LZCategoryModel
- (NSMutableArray *)subcategories{
    if (!_subcategories) {
        _subcategories = [[NSMutableArray alloc] init];
    }
    return _subcategories;
}
@end

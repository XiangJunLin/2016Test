//
//  LZCategoryItem.h
//  LZParentChildPro2
//
//  Created by comst on 16/3/2.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel/YYModel.h"
@interface LZCategoryItem : NSObject<YYModel>
@property (nonatomic, copy) NSString *highlighted_icon;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSArray *subcategories;
@end

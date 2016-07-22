//
//  LZClassA+LZACategory.m
//  LZTestLoadAndInitialize
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZClassA+LZACategory.h"

@implementation LZClassA (LZACategory)
+ (void)load{
    NSLog(@"A categoery load");
}

//+ (void)initialize{
//    
//    NSLog(@"A category initialize");
//    
//}
@end

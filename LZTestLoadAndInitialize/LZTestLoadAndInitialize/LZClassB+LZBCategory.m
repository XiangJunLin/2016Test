//
//  LZClassB+LZBCategory.m
//  LZTestLoadAndInitialize
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZClassB+LZBCategory.h"

@implementation LZClassB (LZBCategory)

+ (void)load{
    
    NSLog(@"B category load");
}

//+ (void)initialize{
//    NSLog(@"B category initialize");
//}
@end

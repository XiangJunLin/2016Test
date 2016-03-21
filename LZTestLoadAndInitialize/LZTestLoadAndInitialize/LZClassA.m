//
//  LZClassA.m
//  LZTestLoadAndInitialize
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZClassA.h"

@implementation LZClassA
+ (void)load{
    if (self == [LZClassA class]) {
         NSLog(@"A Load");
    }
   
}

+ (void)initialize{
    
    if (self == [LZClassA class]) {
        NSLog(@"A initialize");
    }
    
    
}
@end

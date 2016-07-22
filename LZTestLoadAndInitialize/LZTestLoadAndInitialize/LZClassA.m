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

         NSLog(@"A Load,");
    
   
}

+ (void)initialize{
    
    
        NSLog(@"A initialize");
    
    
    
}
@end

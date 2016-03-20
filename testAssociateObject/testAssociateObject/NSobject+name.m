//
//  NSobject+name.m
//  testAssociateObject
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "NSobject+name.h"
#import <objc/runtime.h>

@implementation NSObject (name)


/**
 *  通过分类给NSObject声明一个属性，然后手动实现该属性的setter，getter（如果不手动实现，会报错）。
 *
 *
 */
- (NSString *)name{
    
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setName:(NSString *)name{
    
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

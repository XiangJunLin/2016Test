//
//  UIView+LZBarbuttonItem.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LZBarbuttonItem)

+ (UIBarButtonItem *) buttonitemWithImage:(NSString *)normal highlightedImage:(NSString *)highlighted target:(id)target selector:(SEL)sel ;

@end

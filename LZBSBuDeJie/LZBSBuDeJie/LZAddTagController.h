//
//  LZAddTagController.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZAddTagController : UIViewController
@property (nonatomic, copy)  void (^completeBlock)(NSArray *tagsArray);
@property (nonatomic, copy) NSArray *sourceTags;
@end

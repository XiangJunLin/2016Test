//
//  LZPlaceHolderTextView.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZPlaceHolderTextView : UITextView

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong) UIFont *placeHolderFont;
@property (nonatomic, strong) UIColor *placeHolderColor;

@end

//
//  LZDeleteTagTextField.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/29.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LZDeleteBlock)();

@interface LZDeleteTagTextField : UITextField
@property (nonatomic, copy) LZDeleteBlock op;
@end

//
//  LZCustomTextfield.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/11.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCustomTextfield.h"

@implementation LZCustomTextfield


- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder{
    
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super becomeFirstResponder];
    
}

- (BOOL)resignFirstResponder{
    
    [self setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];
}

@end

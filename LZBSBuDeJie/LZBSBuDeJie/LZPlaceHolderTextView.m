//
//  LZPlaceHolderTextView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPlaceHolderTextView.h"
#import "LZCommon.h"

@interface LZPlaceHolderTextView  ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation LZPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self config];
}

- (void)config{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    self.alwaysBounceVertical = YES;
    _placeHolderLabel = [[UILabel alloc] init];

    [self addSubview:_placeHolderLabel];
    _placeHolderLabel.numberOfLines = 0;
    _placeHolderLabel.x = 4;
    _placeHolderLabel.y = 7;
    
    _placeHolderLabel.font = [UIFont systemFontOfSize:14];
   _placeHolderLabel.textColor = [UIColor lightGrayColor];
    
}

- (void)layoutSubviews{
    
    self.placeHolderLabel.width = self.width - 2 * self.placeHolderLabel.x;
    [self.placeHolderLabel sizeToFit];
    
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    _placeHolderLabel.text = placeHolder;
    [self setNeedsLayout];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    _placeHolderColor = placeHolderColor;
    _placeHolderLabel.textColor = placeHolderColor;
    [self setNeedsLayout];
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont{
    _placeHolderFont = placeHolderFont;
    _placeHolderLabel.font = placeHolderFont;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    self.placeHolderLabel.hidden = self.hasText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    self.placeHolderLabel.hidden = self.hasText;
}

- (void)textChanged:(NSNotification *)notif{
    
    self.placeHolderLabel.hidden = self.hasText;
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

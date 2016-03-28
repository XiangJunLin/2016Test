//
//  LZAddTagController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZAddTagController.h"
#import "LZCommon.h"
#import "LZDeleteTagTextField.h"
#import "SVProgressHUD.h"
#define LZContainerMargin 10
#define LZTagBgColor LZColor(74, 139, 209)
@interface LZAddTagController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) LZDeleteTagTextField *textfiled;
@property (nonatomic, strong) UIButton *tagButton;
@property (nonatomic, strong) NSMutableArray *tags;

@end

@implementation LZAddTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    [self configContainer];
    [self configTextfiled];
    [self confgSourceTags];
}


- (void)confgSourceTags{
    if (self.sourceTags && self.sourceTags.count > 0) {
        for (NSString *title in self.sourceTags) {
            self.textfiled.text = title;
            [self addTagAction];
        }
    }
}

- (void)configContainer{
    self.containerView = [[UIView alloc] init];
    [self.view addSubview:self.containerView];
    self.containerView.y = 64 + LZContainerMargin;
    self.containerView.x = LZContainerMargin ;
    self.containerView.width = screenWidth - 2 * self.containerView.x ;
    self.containerView.height = screenHeight - self.containerView.y - LZContainerMargin;
//    self.containerView.backgroundColor = [UIColor redColor];
    
}

- (void)configTextfiled{
    
    self.textfiled = [[LZDeleteTagTextField alloc] init];
     __weak typeof(self) weakSelf = self;
    self.textfiled.op = ^void(){
        if (weakSelf.textfiled.text.length == 0 || weakSelf.textfiled.text == nil) {
            UIButton *btn = [weakSelf.tags lastObject];
            [weakSelf deleteAction:btn];
        }
    };
    self.textfiled.x = 0;
    self.textfiled.y = 0;
    self.textfiled.height = 30;
    self.textfiled.delegate = self;
//    self.textfiled.backgroundColor = [UIColor redColor];
    self.textfiled.width = self.containerView.width;
    self.textfiled.font = [UIFont systemFontOfSize:14];
    self.textfiled.placeholder = @"请输入标签逗号分隔";
    [self.textfiled setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.containerView addSubview:self.textfiled];
    [self.textfiled addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self.textfiled becomeFirstResponder];
    
}

- (void)configNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction)];
    self.title = @"添加标签";
}


#pragma mark - textfile editing changed

- (void)textChanged{
    
    if ([self.textfiled hasText]) {
        if (self.textfiled.text.length > 5) {
            
            self.textfiled.text = [self.textfiled.text substringToIndex:[self.textfiled.text length] - 1];
            [SVProgressHUD showErrorWithStatus:@"长度不能超过5"];
            return;
        }
        NSString *lastString = [self.textfiled.text substringFromIndex:self.textfiled.text.length - 1] ;
        if ([lastString isEqualToString:@","] || [lastString isEqualToString:@"，"]) {
            self.textfiled.text = [self.textfiled.text stringByReplacingOccurrencesOfString:@"," withString:@""];
            self.textfiled.text = [self.textfiled.text stringByReplacingOccurrencesOfString:@"，" withString:@""];
            if (self.textfiled.text== nil || self.textfiled.text.length
                 == 0) {
                return;
            }
            [self addTagAction];
            return;
        }
        self.tagButton.y = CGRectGetMaxY(self.textfiled.frame);
        self.tagButton.hidden = NO;
        NSString *title = [NSString stringWithFormat:@"添加标签: %@", self.textfiled.text];
        [self.tagButton setTitle:title forState:UIControlStateNormal];
        
    }else{
        self.tagButton.hidden = YES;
    }
}


- (void)addTagAction{
    
    UIButton *newTagButton = [[UIButton alloc] init];
    [self.containerView addSubview:newTagButton];
    [self.tags addObject:newTagButton];
    
    [newTagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    newTagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [newTagButton setBackgroundColor:LZTagBgColor];
    [newTagButton setTitle:self.textfiled.text forState:UIControlStateNormal];
    [newTagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [newTagButton sizeToFit];
    newTagButton.height = 30;
//    newTagButton.width = newTagButton.width + 3 * LZContainerMargin;
    
//    newTagButton.titleLabel.x = LZContainerMargin;
//    newTagButton.imageView.x = CGRectGetMaxX(newTagButton.titleLabel.frame) + LZContainerMargin;
    
   
    [newTagButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.textfiled.text = @"";
    [self textChanged];
    [self resetContainerSubviewFrame];
}

- (void)deleteAction:(UIButton *)btn{
   
    [btn removeFromSuperview];
    
    
    
    [self.tags removeObject:btn];
    
    [UIView animateWithDuration:0.25 animations:^{
        
          [self resetContainerSubviewFrame];
    }];
}

#pragma mark - reset frame

- (void)resetContainerSubviewFrame{
   
    UIButton *preButton = nil;
    CGFloat leftW ;
    CGFloat rightW ;
    for (NSInteger index = 0; index < self.tags.count; index ++) {
        UIButton *btn  = self.tags[index];
        if (index == 0) {
            btn.x = 0;
            btn.y = 0;
        }else{
            leftW = CGRectGetMaxX(preButton.frame) + LZContainerMargin;
            rightW = self.containerView.width - leftW;
            if (rightW >= btn.width) {
                btn.x = leftW;
                btn.y = preButton.y;
            }else{
                btn.x = 0;
                btn.y = CGRectGetMaxY(preButton.frame) + LZContainerMargin;
            }
        }
        preButton = btn;
    }
    
    leftW = CGRectGetMaxX(preButton.frame);
    rightW = self.containerView.width - leftW;
    if (rightW >= 100) {
        self.textfiled.width = rightW;
        self.textfiled.x = leftW;
        self.textfiled.y = preButton.y;
    }else{
        self.textfiled.y = CGRectGetMaxY(preButton.frame);
        self.textfiled.x = 0;
        self.textfiled.width = self.containerView.width;
    }
}


#pragma mark - lazy load

- (UIButton *)tagButton{
    if (!_tagButton) {
        _tagButton = [[UIButton alloc] init];
        [self.containerView addSubview:_tagButton];
        [_tagButton addTarget:self action:@selector(addTagAction) forControlEvents:UIControlEventTouchUpInside];
        _tagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_tagButton setBackgroundColor:LZTagBgColor];
        _tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _tagButton.width = self.containerView.width;
        _tagButton.height = 40;
        _tagButton.x = 0;
    }
    return _tagButton;
}

- (NSMutableArray *)tags{
    if (!_tags) {
        _tags = [[NSMutableArray alloc] init];
    }
    return _tags;
}


#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self addTagAction];
    return YES;
}

#pragma mark - navigation item action
- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneAction{
    
    NSArray *tagsArray = [self.tags valueForKeyPath:@"currentTitle"];
    
    !self.completeBlock?:self.completeBlock(tagsArray);
     [self.navigationController popViewControllerAnimated:YES];
}

@end

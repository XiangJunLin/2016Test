//
//  LZComposeController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZComposeController.h"
#import "LZPlaceHolderTextView.h"
#import "LZCommon.h"

@interface LZComposeController ()<UITextViewDelegate>

@property (nonatomic, strong) LZPlaceHolderTextView *textView;

@end

@implementation LZComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNav];
    [self configTextView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)configTextView{
    
    self.textView = [[LZPlaceHolderTextView alloc] init];
    [self.view addSubview:self.textView];

    self.textView.frame = self.view.bounds;
    
    self.textView.font = [UIFont systemFontOfSize:20];
    self.textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    
    self.textView.delegate = self;
    
}

- (void)configNav{
    
    self.title = @"发帖";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar layoutIfNeeded];
}


- (void)publishAction{
    
}

- (void)cancelAction{
    
}

#pragma mark - textview delegate

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
@end

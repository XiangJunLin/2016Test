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
#import "LZComposeToolView.h"

@interface LZComposeController ()<UITextViewDelegate>

@property (nonatomic, strong) LZPlaceHolderTextView *textView;
@property (nonatomic, strong) LZComposeToolView *toolView;
@end

@implementation LZComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNav];
    [self configTextView];
    [self configBottomToolView];
    [self configNotification];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)configNotification{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardFrameChange:(NSNotification *)notify{
    CGRect endFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolView.transform = CGAffineTransformMakeTranslation(0, -(self.view.height - endFrame.origin.y));
    }];
    
    
}

- (void)configBottomToolView{
    
    self.toolView = [LZComposeToolView composeToolView];
    [self.view addSubview:self.toolView];
    self.toolView.width = self.view.width;
    self.toolView.height = 100;
    self.toolView.x = 0;
    self.toolView.y = self.view.height - self.toolView.height;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

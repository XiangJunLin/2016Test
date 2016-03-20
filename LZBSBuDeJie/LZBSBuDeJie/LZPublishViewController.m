//
//  LZPublishViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/19.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZPublishViewController.h"
#import "LZVerticalButton.h"
#import "LZCommon.h"

typedef struct LZAnimationFrames{
    CGRect startFrame;
    CGRect endFrame;
    CGRect midFrame;
    
} LZAnimationFrames;

@interface LZPublishViewController ()
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, assign) LZAnimationFrames logoImageViewFrames;

@property (nonatomic, strong) LZVerticalButton *vedioButton;
@property (nonatomic, assign) LZAnimationFrames vedioButtonFrames;

@property (nonatomic, strong) LZVerticalButton *pictureButton;
@property (nonatomic, assign) LZAnimationFrames pictureButtonFrames;

@property (nonatomic, strong) LZVerticalButton *topicButton;
@property (nonatomic, assign) LZAnimationFrames topicButtonFrames;

@property (nonatomic, strong) LZVerticalButton *audioButton;
@property (nonatomic, assign) LZAnimationFrames audioButtonFrames;

@property (nonatomic, strong) LZVerticalButton *checkButton;
@property (nonatomic, assign) LZAnimationFrames checkButtonFrames;

@property (nonatomic, strong) LZVerticalButton *linkButton;
@property (nonatomic, assign) LZAnimationFrames linkButtonFrames;



@end

@implementation LZPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self configView];
    [self showWithPop];
  
    
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self showWithPop];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self showContentView];
}

#pragma mark - show by popspring animation

- (void)showWithPop{
    
    self.view.userInteractionEnabled = NO;
    CGFloat margin = 20;
    CGFloat buttonW = 72;
    CGFloat buttonH = 100;
    CGFloat padding = (screenWidth - 2 * margin - 3 * buttonW) / 2;
    CGFloat startY = (screenHeight - 2 * buttonH) * 0.5;
    CGFloat buttonX ;
    CGFloat buttonY ;
    
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"发链接"];
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    for (NSInteger i = 0; i < 6; i ++) {
        LZVerticalButton *button = [[LZVerticalButton alloc] init];
        [self.view addSubview:button];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 10000 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonX = margin + (i % 3) * (buttonW + padding);
        buttonY = startY + buttonH * (i / 3);
        CGRect startFrame = CGRectMake(buttonX, -buttonH, buttonW, buttonH);
        CGRect midFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //button.frame = midFrame;
        
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        springAnimation.springBounciness = 6;
        springAnimation.springSpeed = 6;
        springAnimation.fromValue = [NSValue valueWithCGRect:startFrame];
        springAnimation.toValue = [NSValue valueWithCGRect:midFrame];
        springAnimation.beginTime = CACurrentMediaTime() + i * 0.1;
        [springAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            [button pop_removeAllAnimations];
        }];
        [button pop_addAnimation:springAnimation forKey:nil];
    }
    
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:self.logoImageView];
    
    CGFloat logoImageViewX = (screenWidth - self.logoImageView.image.size.width) * 0.5;
    CGFloat logoImageViewY = screenHeight * 0.2;
    CGFloat logoImageViewW = self.logoImageView.image.size.width;
    CGFloat logoImageViewH = self.logoImageView.image.size.height;
    
    POPSpringAnimation *logoAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    logoAnimation.springBounciness = 6;
    logoAnimation.springSpeed = 6;
    logoAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(logoImageViewX, -logoImageViewH, logoImageViewW, logoImageViewH)];
    logoAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(logoImageViewX, logoImageViewY, logoImageViewW, logoImageViewH)];
    logoAnimation.beginTime = CACurrentMediaTime() + 0.6;
    logoAnimation.completionBlock = ^void(POPAnimation *animation, BOOL finished){
        [self.logoImageView pop_removeAllAnimations];
        self.view.userInteractionEnabled = YES;
    };
    [self.logoImageView pop_addAnimation:logoAnimation forKey:@"logo"];
    
}

- (void)btnClick:(UIButton *)btn{
    
    [self hideWithPopCompletion:^{
        NSLog(@"%@", btn.titleLabel.text);
    }];
}

- (void)hideWithPop{
    [self hideWithPopCompletion:nil];
}

- (void)hideWithPopCompletion:(void (^)())completionBlock{
    
    self.view.userInteractionEnabled = NO;
    for (NSInteger i = 0; i < 6; i ++) {
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:i + 10000];
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.beginTime = CACurrentMediaTime() + i * 0.1;
        CGRect endFrame = btn.frame;
        endFrame.origin.y = screenHeight;
        animation.toValue = [NSValue valueWithCGRect:endFrame];
        animation.completionBlock = ^void(POPAnimation *animation, BOOL finished){
          
            [btn pop_removeAllAnimations];
        };
        
        [btn pop_addAnimation:animation forKey:nil];
    }
    
    POPBasicAnimation *logoAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    logoAnimation.beginTime = CACurrentMediaTime() + 0.6;
    CGRect endFrame = self.logoImageView.frame;
    endFrame.origin.y = screenHeight;
    logoAnimation.toValue = [NSValue valueWithCGRect:endFrame];
    logoAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished){
        
        [self.logoImageView pop_removeAllAnimations];
        
        self.view.userInteractionEnabled = YES;
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:NO completion:^{
            
             !completionBlock? :completionBlock();
        }];
       
    };
    [self.logoImageView pop_addAnimation:logoAnimation forKey:nil];
}

#pragma mark - show by UIView Spring animation
- (void)configView{
    
    CGFloat margin = 20;
    CGFloat buttonW = 72;
    CGFloat buttonH = 100;
    CGFloat padding = (screenWidth - 2 * margin - 3 * buttonW) / 2;
    CGFloat startY = (screenHeight - 2 * buttonH) * 0.5;
    
    
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:self.logoImageView];
    
    CGFloat logoImageViewX = (screenWidth - self.logoImageView.image.size.width) * 0.5;
    CGFloat logoImageViewY = screenHeight * 0.2;
    CGFloat logoImageViewW = self.logoImageView.image.size.width;
    CGFloat logoImageViewH = self.logoImageView.image.size.height;
    
    _logoImageViewFrames.midFrame = CGRectMake(logoImageViewX, logoImageViewY, logoImageViewW, logoImageViewH);
    _logoImageViewFrames.startFrame = CGRectMake(logoImageViewX, -logoImageViewH, logoImageViewW, logoImageViewH);
    _logoImageViewFrames.endFrame = CGRectMake(logoImageViewX, screenHeight + buttonH, logoImageViewW, logoImageViewH);
    
    self.logoImageView.frame = _logoImageViewFrames.startFrame;
    
    
    CGFloat buttonX ;
    CGFloat buttonY ;
    
    // vedio
    self.vedioButton = [[LZVerticalButton alloc] init];
    [self.view addSubview:self.vedioButton];
    [self.vedioButton setImage:[UIImage imageNamed:@"publish-video"] forState:UIControlStateNormal];
    [self.vedioButton setTitle:@"发视频" forState:UIControlStateNormal];
    self.vedioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    buttonX = margin;
    buttonY = startY;
    _vedioButtonFrames.midFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    _vedioButtonFrames.startFrame = CGRectMake(buttonX, - buttonH, buttonW, buttonH);
    _vedioButtonFrames.endFrame = CGRectMake(buttonX, screenHeight + buttonH, buttonW, buttonH);
    self.vedioButton.frame = _vedioButtonFrames.startFrame;
    
    //audio
    
    self.audioButton = [[LZVerticalButton alloc] init];
    [self.view addSubview:self.audioButton];
    [self.audioButton setImage:[UIImage imageNamed:@"publish-audio"] forState:UIControlStateNormal];
    [self.audioButton setTitle:@"发声音" forState:UIControlStateNormal];
    self.audioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _audioButtonFrames.midFrame = CGRectMake(buttonX, buttonY + buttonH, buttonW, buttonH);
    _audioButtonFrames.startFrame = CGRectMake(buttonX, - buttonH, buttonW, buttonH);
    _audioButtonFrames.endFrame = CGRectMake(buttonX, screenHeight + buttonH, buttonW, buttonH);
    
    self.audioButton.frame = _audioButtonFrames.startFrame;
    
    //picture
    self.pictureButton = [[LZVerticalButton alloc] init];
    [self.view addSubview:self.pictureButton];
    [self.pictureButton setImage:[UIImage imageNamed:@"publish-picture"] forState:UIControlStateNormal];
    [self.pictureButton setTitle:@"发图片" forState:UIControlStateNormal];
     self.pictureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    buttonX = margin + buttonW + padding;
    buttonY = startY;
    _pictureButtonFrames.midFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    _pictureButtonFrames.startFrame = CGRectMake(buttonX, -buttonH, buttonW, buttonH);
    _pictureButtonFrames.endFrame = CGRectMake(buttonX, screenHeight + buttonH, buttonW, buttonH);
    
    self.pictureButton.frame = _pictureButtonFrames.startFrame;
    
    // check
    self.checkButton = [[LZVerticalButton alloc] init];
    [self.view addSubview:self.checkButton];
    [self.checkButton setImage:[UIImage imageNamed:@"publish-review"] forState:UIControlStateNormal];
    [self.checkButton setTitle:@"审帖" forState:UIControlStateNormal];
    self.checkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _checkButtonFrames.midFrame = CGRectMake(buttonX, buttonY + buttonH, buttonW, buttonH);
    _checkButtonFrames.startFrame = CGRectMake(buttonX, -buttonH, buttonW, buttonH);
    _checkButtonFrames.endFrame = CGRectMake(buttonX, screenHeight + buttonH, buttonW, buttonH);
    
    self.checkButton.frame = _checkButtonFrames.startFrame;
    
    
    //topic
    self.topicButton = [[LZVerticalButton alloc] init];
    [self.view addSubview:self.topicButton];
    [self.topicButton setImage:[UIImage imageNamed:@"publish-text"] forState:UIControlStateNormal];
    [self.topicButton setTitle:@"发段子" forState:UIControlStateNormal];
    self.topicButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    buttonX = margin + 2 * (buttonW + padding);
    buttonY = startY;
    
    _topicButtonFrames.midFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    _topicButtonFrames.startFrame = CGRectMake(buttonX, -buttonH, buttonW, buttonH);
    _topicButtonFrames.endFrame = CGRectMake(buttonX, screenHeight + buttonH, buttonW, buttonH);
    self.topicButton.frame = _topicButtonFrames.startFrame;
    
    // link
    self.linkButton = [[LZVerticalButton alloc] init];
    [self.view addSubview:self.linkButton];
    [self.linkButton setImage:[UIImage imageNamed:@"publish-offline"] forState:UIControlStateNormal];
    [self.linkButton setTitle:@"发链接" forState:UIControlStateNormal];
    self.linkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    _linkButtonFrames.midFrame = CGRectMake(buttonX, buttonY + buttonH, buttonW, buttonH);
    _linkButtonFrames.startFrame = CGRectMake(buttonX, -buttonH, buttonW, buttonH);
    _linkButtonFrames.endFrame = CGRectMake(buttonX, screenHeight + buttonH, buttonW, buttonH);
    self.linkButton.frame = _linkButtonFrames.startFrame;
    
}

- (void)showContentView {
    
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:0 animations:^{
        
        self.audioButton.frame = _audioButtonFrames.midFrame;
        self.checkButton.frame = _checkButtonFrames.midFrame;
        self.linkButton.frame = _linkButtonFrames.midFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [UIView animateWithDuration:1.5 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:0 animations:^{
        self.logoImageView.frame = _logoImageViewFrames.midFrame;
        self.vedioButton.frame = _vedioButtonFrames.midFrame;
        self.pictureButton.frame = _pictureButtonFrames.midFrame;
        self.topicButton.frame = _topicButtonFrames.midFrame;
        
    } completion:^(BOOL finished) {
        
    }];

    
    
}

- (void)hideContentView{
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.logoImageView.frame = _logoImageViewFrames.endFrame;
        self.vedioButton.frame = _vedioButtonFrames.endFrame;
        self.pictureButton.frame = _pictureButtonFrames.endFrame;
        self.topicButton.frame = _topicButtonFrames.endFrame;
        self.audioButton.frame = _audioButtonFrames.endFrame;
        self.checkButton.frame = _checkButtonFrames.endFrame;
        self.linkButton.frame = _linkButtonFrames.endFrame;
        
    } completion:^(BOOL finished) {
        self.logoImageView.frame = _logoImageViewFrames.startFrame;
        self.vedioButton.frame = _vedioButtonFrames.startFrame;
        self.pictureButton.frame = _pictureButtonFrames.startFrame;
        self.topicButton.frame = _topicButtonFrames.startFrame;
        self.audioButton.frame = _audioButtonFrames.startFrame;
        self.checkButton.frame = _checkButtonFrames.startFrame;
        self.linkButton.frame = _linkButtonFrames.startFrame;
        
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(UIButton *)sender {
//    [self hideContentView];
    [self hideWithPop];
}


@end

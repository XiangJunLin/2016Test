//
//  LZDetailViewController.m
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZDetailViewController.h"

@interface LZDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgColorView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelBottomConstraint;


@end

@implementation LZDetailViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgColorView.backgroundColor = _currentItem.color;
    self.iconImageView.image = [UIImage imageNamed:_currentItem.image];
    self.titleLabel.text = _currentItem.title;
    self.contentLabel.text = _currentItem.content;
    // Do any additional setup after loading the view.
}

- (void)setforState:(BOOL)beforePush{
    if (beforePush) {
        self.backButtonTopConstraint.constant = - 64;
        self.contentLabelBottomConstraint.constant = - 200;
    }else{
        self.backButtonTopConstraint.constant = 0;
        self.contentLabelBottomConstraint.constant = 80;
    }
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setCurrentItem:(LZIconItem *)currentItem{
    _currentItem = currentItem;
    self.bgColorView.backgroundColor = currentItem.color;
    self.iconImageView.image = [UIImage imageNamed:currentItem.image];
    self.titleLabel.text = currentItem.title;
    self.contentLabel.text = currentItem.content;
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController  popViewControllerAnimated:YES];
}

- (UIView *)bgColoredViewForTransition{
    return self.bgColorView;
}

-(UIImageView *)iconImageVIewForTransition{
    
    return self.iconImageView;
}

- (void)transition:(LZTransition *)transition willAnimatedForOperation:(UINavigationControllerOperation)operation{
    if (operation == UINavigationControllerOperationPush) {
        
        [self setforState:YES];
        
        [UIView animateWithDuration:0.6 delay:0.2 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self setforState:NO];
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [self setforState:NO];
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self setforState:YES];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}
@end

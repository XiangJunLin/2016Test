//
//  ViewController.m
//  LZParentChildPro
//
//  Created by comst on 16/3/1.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZOneViewController.h"
#import "LZTwoViewController.h"
#import "LZThreeViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIViewController *currentVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LZOneViewController *oneVC = [[LZOneViewController alloc] init];
    LZTwoViewController *twoVC = [[LZTwoViewController alloc] init];
    LZThreeViewController *threeVC = [[LZThreeViewController alloc] init];
    [self addChildViewController:oneVC];
    [self addChildViewController:twoVC];
    [self addChildViewController:threeVC];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        LZOneViewController *oneVC = self.childViewControllers[0];
        [self.currentVC.view removeFromSuperview];
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0;
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromRight;
        [oneVC.view.layer addAnimation:transition forKey:nil];
        [self.view addSubview:oneVC.view];
        self.currentVC = oneVC;
        
    }else if (sender.tag == 1){
        LZTwoViewController *twoVC = self.childViewControllers[1];
        [self.currentVC.view removeFromSuperview];
        [self.view addSubview:twoVC.view];
        self.currentVC = twoVC;

        
    }else{
        
        LZThreeViewController *threeVC = self.childViewControllers[2];
        [self.currentVC.view removeFromSuperview];
        [self.view addSubview:threeVC.view];
        self.currentVC = threeVC;

    }
}

@end

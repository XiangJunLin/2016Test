//
//  ViewController.m
//  LZScrollViewPro
//
//  Created by comst on 16/7/19.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.delegate = self;
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.frame = CGRectMake(10, 0, 50, 100);
    [self.scrollView addSubview:redView];
    self.redView = redView;
    
    self.scrollView.backgroundColor = [UIColor blueColor];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    self.scrollView.contentInset = UIEdgeInsetsMake(200, 100 , 200, 0);
    
    [self.scrollView setContentOffset:CGPointMake(0, -300) animated:YES];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.scrollView setContentOffset:CGPointMake(0, -100) animated:YES];
    NSLog(@"frame : %@", NSStringFromCGRect(self.redView.frame));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"contentsize : %@", NSStringFromCGSize(self.scrollView.contentSize));
    NSLog(@"contentOffset : %@", NSStringFromCGPoint(self.scrollView.contentOffset));
    NSLog(@"frame : %@", NSStringFromCGRect(self.redView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

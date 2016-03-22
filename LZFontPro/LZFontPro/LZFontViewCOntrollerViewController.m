//
//  LZFontViewCOntrollerViewController.m
//  LZFontPro
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZFontViewCOntrollerViewController.h"

@interface LZFontViewCOntrollerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;

@end

@implementation LZFontViewCOntrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *desDic = @{
                             UIFontDescriptorNameAttribute:@"FZuanSu",
                             UIFontDescriptorSizeAttribute:@24,
                             };
    UIFontDescriptor *fontDes = [UIFontDescriptor fontDescriptorWithFontAttributes:desDic];
    
    self.fontLabel.font = [UIFont fontWithDescriptor:fontDes size:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

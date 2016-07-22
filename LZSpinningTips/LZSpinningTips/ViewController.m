//
//  ViewController.m
//  LZSpinningTips
//
//  Created by comst on 16/7/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZTipViewController.h"
#import "LZTipItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


/**
 *   Tip(title: "Tip #1: Don't Blink", summary: "Fantastic shot of Sarah for the ALS Ice Bucket Challenge - And yes, she tried her hardest not to blink!", image: UIImage(named: "als-ice-bucket-challenge")),
 Tip(title: "Tip #2: Explore", summary: "Get out of the house!", image: UIImage(named: "arch-architecture")),
 Tip(title: "Tip #3: Take in the Moment", summary: "Remember that each moment is unique and will never come again.", image: UIImage(named: "man-mountains"))
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LZTipItem *item1 = [[LZTipItem alloc] init];
    item1.tipTitle = @"Tip #1: Don't Blink";
    item1.tipContent = @"Fantastic shot of Sarah for the ALS Ice Bucket Challenge - And yes, she tried her hardest not to blink!";
    item1.tipImage = @"als-ice-bucket-challenge";
    
    LZTipItem *item2 = [[LZTipItem alloc] init];
    item2.tipTitle = @"Tip #2: Explore";
    item2.tipContent = @"Get out of the house!";
    item2.tipImage = @"arch-architecture";
    
    LZTipItem *item3 = [[LZTipItem alloc] init];
    item3.tipTitle = @"Tip #3: Take in the Moment";
    item3.tipContent = @"Remember that each moment is unique and will never come again.";
    item3.tipImage = @"man-mountains";
    
    
    LZTipViewController *tipVC = [[LZTipViewController alloc] init];
    tipVC.view.backgroundColor = [UIColor redColor];
    tipVC.tips = @[item1, item2, item3];
    
    tipVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    tipVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:tipVC animated:YES completion:nil];
}
@end

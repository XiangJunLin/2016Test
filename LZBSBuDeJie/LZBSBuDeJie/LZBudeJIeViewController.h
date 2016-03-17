//
//  LZBudeJIeViewController.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/17.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *LZTypeAll = @"1";
static NSString *LZTypeVedio = @"41";
static NSString *LZTypePicture = @"10";
static NSString *LZTypeSound = @"31";
static NSString *LZTypeTopic = @"29";
@interface LZBudeJIeViewController : UITableViewController
@property (nonatomic, copy) NSString *budejieType;

@end

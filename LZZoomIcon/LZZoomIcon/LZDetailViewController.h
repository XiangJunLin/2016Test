//
//  LZDetailViewController.h
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZIconItem.h"
#import "LZTransition.h"

@interface LZDetailViewController : UIViewController<LZZoomingTransition>
@property (nonatomic, strong) LZIconItem *currentItem;
@end

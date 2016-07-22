//
//  LZIconCell.h
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZIconItem.h"

@interface LZIconCell : UICollectionViewCell

@property (nonatomic, strong) LZIconItem *currentItem;

@property (weak, nonatomic) IBOutlet UIView *bgColorView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

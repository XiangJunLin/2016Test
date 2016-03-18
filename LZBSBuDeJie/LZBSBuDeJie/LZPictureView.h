//
//  LZPictureView.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/18.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTopicModel.h"

@interface LZPictureView : UIView

@property (nonatomic, strong) LZTopicModel *currentItem;
+ (instancetype)pictureView;
@end

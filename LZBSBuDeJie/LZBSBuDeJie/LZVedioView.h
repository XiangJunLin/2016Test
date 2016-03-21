//
//  LZVedioView.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTopicModel.h"

@interface LZVedioView : UIView

+ (instancetype)vedioView;
@property (nonatomic, strong) LZTopicModel *currentModel;
@end

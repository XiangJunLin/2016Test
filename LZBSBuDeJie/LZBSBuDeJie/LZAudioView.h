//
//  LZAudioView.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTopicModel.h"

@interface LZAudioView : UIView
@property (nonatomic, strong) LZTopicModel *currentModel;
+ (instancetype)audioView;
@end

//
//  LZCommentHeaderView.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTopicModel.h"

@interface LZCommentHeaderView : UITableViewCell

@property (nonatomic, strong) LZTopicModel *currentModel;
+ (instancetype)commentHeaderView;

@end

//
//  LZCommon.h
//  LZBSBuDeJie
//
//  Created by comst on 16/3/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#ifndef LZCommon_h
#define LZCommon_h

#import "UIView+LZFrame.h"
#import "UIView+LZBarbuttonItem.h"
#import "LZConst.h"
#import "LZStatusWindow.h"
#import "UIImageView+LZCireImage.h"

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define LZColor(a,b,c)  [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:1]
#define LZBKColor LZColor(223, 223,223)
#ifdef DEBUG
#define LZLOG(...) NSLog(__VA_ARGS__)

#else
#define LZLOG(...)
#endif

#define LZFUN LZLOG(@"%s", __func__)

#endif /* LZCommon_h */

//
//  QWSSendOrderOperation.h
//  WEBluetooth
//
//  Created by Tilink on 15/7/24.
//  Copyright (c) 2015年 Tilink. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    orderStyleAuthentication = 1,   // 鉴权
    orderStyleWritePassword,        // 写密码
    orderStyleLockOrUnLock,         // 加解锁
    orderStyleOpenDevBarrel,        // 开坐桶
    orderStyleLockEMachinery,       // 锁定电机
    orderStyleSetLockEMCode,        // 设置索电机码
    orderStyleFindDev,              // 寻车
    orderStyleClearDis              // 清除里程
} OrderStytle;

// 发送指令后的回调     0:OK    1:未知错误  2:鉴权失败
typedef void (^ExecutingBlock)();
typedef void(^CompleteBlock)(NSInteger errCode, NSString * errDesc, id data);

@interface QWSSendOrderOperation : NSOperation

// 发送数据
@property (assign, nonatomic) OrderStytle orderStyle;
@property (copy, nonatomic) NSString * orderContent;

// 执行块
@property (copy, nonatomic) ExecutingBlock executingBlock;
// 请求完成后的回调
@property (copy, nonatomic) CompleteBlock finishedBlock;

/**
 *  @author ThinkerDown, 15-07-24 14:07:59
 *
 *  @brief  <#Description#>
 *
 *  @param orderStyle     <#orderStyle description#>
 *  @param orderContent   <#orderContent description#>
 *  @param executingBlock <#executingBlock description#>
 *  @param finishedBlock  <#finishedBlock description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithOrderStyle:(OrderStytle)orderStyle
                     orderContent:(NSString *)orderContent
                   executingBlock:(ExecutingBlock)executingBlock
                         finished:(CompleteBlock)finishedBlock;

///-------------------------------
/// @name Accessing Run Loop Modes
///-------------------------------

/**
 The run loop modes in which the operation will run on the network thread. By default, this is a single-member set containing `NSRunLoopCommonModes`.
 */
@property (nonatomic, strong) NSSet *runLoopModes;

// 完成
- (void)finish;

@end
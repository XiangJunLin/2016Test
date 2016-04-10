//
//  QWSSendOrderOperation.m
//  WEBluetooth
//
//  Created by Tilink on 15/7/24.
//  Copyright (c) 2015年 Tilink. All rights reserved.
//

#import "QWSSenderOperation.h"

typedef NS_ENUM(NSInteger, QWSOperationState) {
    QWSOperationPausedState     = -1,
    QWSOperationReadyState      = 1,
    QWSOperationExecutingState  = 2,
    QWSOperationFinishedState   = 3,
};

static NSString * const kQWSSendOrderLockName = @"com.qws.sendorder.operation.lock";

NSString * const QWSSendOrderOperationDidStartNotification  = @"com.qws.sendorder.operation.start";
NSString * const QWSSendOrderOperationDidFinishNotification = @"com.qws.sendorder.operation.finish";

static inline NSString * QWSKeyPathFromOperationState(QWSOperationState state) {
    switch (state) {
        case QWSOperationReadyState:
            return @"isReady";
        case QWSOperationExecutingState:
            return @"isExecuting";
        case QWSOperationFinishedState:
            return @"isFinished";
        case QWSOperationPausedState:
            return @"isPaused";
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            return @"state";
#pragma clang diagnostic pop
        }
    }
}

static inline BOOL QWSStateTransitionIsValid(QWSOperationState fromState, QWSOperationState toState, BOOL isCancelled) {
    switch (fromState) {
        case QWSOperationReadyState:
            switch (toState) {
                case QWSOperationPausedState:
                case QWSOperationExecutingState:
                    return YES;
                case QWSOperationFinishedState:
                    return isCancelled;
                default:
                    return NO;
            }
        case QWSOperationExecutingState:
            switch (toState) {
                case QWSOperationPausedState:
                case QWSOperationFinishedState:
                    return YES;
                default:
                    return NO;
            }
        case QWSOperationFinishedState:
            return NO;
        case QWSOperationPausedState:
            return toState == QWSOperationReadyState;
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            switch (toState) {
                case QWSOperationPausedState:
                case QWSOperationReadyState:
                case QWSOperationExecutingState:
                case QWSOperationFinishedState:
                    return YES;
                default:
                    return NO;
            }
        }
#pragma clang diagnostic pop
    }
}

@interface QWSSendOrderOperation ()

@property (readwrite, nonatomic, assign) QWSOperationState  state;
@property (readwrite, nonatomic, strong) NSRecursiveLock    *lock;

- (void)operationDidStart;
- (void)finish;
- (void)cancelConnection;

@end

@implementation QWSSendOrderOperation

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"QWSSendOrder"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

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
                         finished:(CompleteBlock)finishedBlock {
    if (self = [super init]) {
        
        _state = QWSOperationReadyState;
        
        self.lock = [[NSRecursiveLock alloc] init];
        self.lock.name = kQWSSendOrderLockName;
        
        self.orderStyle = orderStyle;
        self.orderContent = orderContent;
        
        self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
        
        self.executingBlock = executingBlock;
        self.finishedBlock = finishedBlock;
    }
    
    return self;
}

#pragma mark -

- (void)setState:(QWSOperationState)state {
    if (!QWSStateTransitionIsValid(self.state, state, [self isCancelled])) {
        return;
    }
    
    [self.lock lock];
    NSString *oldStateKey = QWSKeyPathFromOperationState(self.state);
    NSString *newStateKey = QWSKeyPathFromOperationState(state);
    
    [self willChangeValueForKey:newStateKey];
    [self willChangeValueForKey:oldStateKey];
    _state = state;
    [self didChangeValueForKey:oldStateKey];
    [self didChangeValueForKey:newStateKey];
    [self.lock unlock];
}

- (void)pause {
    if ([self isPaused] || [self isFinished] || [self isCancelled]) {
        return;
    }
    
    [self.lock lock];
    if ([self isExecuting]) {
        [self performSelector:@selector(operationDidPause) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
            [notificationCenter postNotificationName:QWSSendOrderOperationDidFinishNotification object:self];
        });
    }
    
    self.state = QWSOperationPausedState;
    [self.lock unlock];
}

- (void)operationDidPause {
    [self.lock lock];
    // 发送指令不能取消
    [self.lock unlock];
}

- (BOOL)isPaused {
    return self.state == QWSOperationPausedState;
}

- (void)resume {
    if (![self isPaused]) {
        return;
    }
    
    [self.lock lock];
    self.state = QWSOperationReadyState;
    
    [self start];
    [self.lock unlock];
}

#pragma mark - NSOperation
- (BOOL)isReady {
    return self.state == QWSOperationReadyState && [super isReady];
}

- (BOOL)isExecuting {
    return self.state == QWSOperationExecutingState;
}

- (BOOL)isFinished {
    return self.state == QWSOperationFinishedState;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)start {
    [self.lock lock];
    if ([self isCancelled]) {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    } else if ([self isReady]) {
        self.state = QWSOperationExecutingState;
        
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

- (void)operationDidStart {
    [self.lock lock];
    if (![self isCancelled]) {
        if (_executingBlock) {
            self.executingBlock();
        }
    }
    [self.lock unlock];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:QWSSendOrderOperationDidStartNotification object:self];
    });
}

- (void)finish {
    [self.lock lock];
    self.state = QWSOperationFinishedState;
    [self.lock unlock];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:QWSSendOrderOperationDidFinishNotification object:self];
    });
}

- (void)cancel {
    [self.lock lock];
    if (![self isFinished] && ![self isCancelled]) {
        [super cancel];
        
        if ([self isExecuting]) {
            [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        }
    }
    [self.lock unlock];
}

- (void)cancelConnection {
    if (![self isFinished]) {
        [self finish];
    }
}

@end
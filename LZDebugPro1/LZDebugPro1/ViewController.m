//
//  ViewController.m
//  LZDebugPro1
//
//  Created by comst on 16/3/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#define NSLog(format, ...) do { \
fprintf(stderr, "<%s : %d> %s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__); \
fprintf(stderr, "-------\n"); \
} while (0)

#define TICK   NSDate *startTime = [NSDate date]

#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#ifdef __OPTIMIZE__
    NSLog(@"release");
#else
    NSLog(@"debug");
#endif
    
#if defined (__i386__) || (__x86_64__)
    NSLog(@"模拟器");
#else
    NSLog(@"真机");
#endif
    
//    NSInteger sum = 0;
//    TICK;
//    for (NSInteger i = 0; i < 5; i ++) {
//        
//        sum = sum + i;
//        NSLog(@"sum : %li",  sum);
//        
//    }
//    TOCK;
//    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)message1{
    
    NSLog(@"meaage1");
}

- (void)message2{
    
    [self message1];
}

@end

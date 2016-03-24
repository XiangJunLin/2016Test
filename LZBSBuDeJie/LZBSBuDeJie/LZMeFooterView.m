//
//  LZMeFooterView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/25.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZMeFooterView.h"
#import "LZSquareModel.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LZSquareButton.h"
#import "LZCommon.h"
#import "UIButton+WebCache.h"
#import "LZVerticalButton.h"

@interface LZMeFooterView ()

@property (nonatomic, strong) NSArray *squareList;

@end
@implementation LZMeFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSString *url = @"http://api.budejie.com/api/api_open.php";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        params[@"sex"] = @"m";
        
        [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArr = responseObject[@"square_list"];
            NSMutableArray *arrM = [NSMutableArray array];
            
            for (NSDictionary *dict in dataArr) {
                LZSquareModel *item = [LZSquareModel suareModelWithDict:dict];
                [arrM addObject:item];
            }
            self.squareList = arrM;
            [self configSquares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];
        
    }
    
    return self;
}

- (void)configSquares{
    
    NSInteger countInRow = 4;
    
    CGFloat buttonW = screenWidth / countInRow;
    CGFloat buttonH = buttonW;
    NSInteger sumRows = (self.squareList.count + countInRow - 1) / countInRow ;
    self.height = sumRows * buttonH;
    CGFloat buttonX;
    CGFloat buttonY;
    NSInteger row;
    NSInteger col;
    
    for (NSInteger index = 0; index < self.squareList.count; index ++) {
        
       
        
        
        LZSquareButton *btn = [LZSquareButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        LZSquareModel *currentItem = self.squareList[index];
        btn.currentItem = currentItem;
        [btn setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        [btn setTitle:currentItem.name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:currentItem.icon] forState:UIControlStateNormal];
        row = index / countInRow;
        col = index % countInRow;
        buttonX = buttonW * col;
        buttonY = buttonH * row;
        
        btn.x = buttonX;
        btn.y = buttonY;
        btn.width = buttonW;
        btn.height = buttonH;
        [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    [self setNeedsDisplay];
    
    
}

- (void)clickAction{
    NSLog(@"btn click");
}

- (void)drawRect:(CGRect)rect{
    
    UIImage *image = [UIImage imageNamed:@"mainCellBackground"];
    
    [image drawInRect:rect];
}
@end

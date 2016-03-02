//
//  LZCustomLayout.m
//  LZCollectionViewPro
//
//  Created by comst on 16/3/2.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCustomLayout.h"

@interface LZCustomLayout ()

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) NSInteger numberOfColumn;
@property (nonatomic, assign) NSInteger numberOfItem;
@property (nonatomic, strong) NSMutableArray *cellX;
@property (nonatomic, strong) NSMutableArray *cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray *cellY;

@end
@implementation LZCustomLayout

- (void)prepareLayout{
    
    [super prepareLayout];
    [self initPara];
    
}

- (void)initPara{
    
    self.margin = 8;
    self.padding = 3;
    self.numberOfColumn = 3;
    self.numberOfItem = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.cellWidth = (screenWidth - self.margin * 2 - (self.numberOfColumn - 1) * self.padding) / self.numberOfColumn;
    
    self.cellX = [NSMutableArray array];
    self.cellY = [NSMutableArray array];
    
    //cellX, cellY
    CGFloat cellx ;
    for (NSInteger i = 0; i < self.numberOfColumn; i ++) {
        cellx = self.margin + i * (self.cellWidth + self.padding);
        [self.cellX addObject:@(cellx)];
        [self.cellY addObject:@(0.0)];
    }
    
    // cells height
    self.cellHeight = [NSMutableArray array];
    CGFloat height ;
    for (NSInteger i = 0; i < self.numberOfItem; i ++) {
        height = 50 + arc4random_uniform(200);
        [self.cellHeight addObject:@(height)];
    }
    
}

- (NSInteger)minCellY{
    
    CGFloat temp = [self.cellY[0] floatValue];
    NSInteger minIndex = 0 ;
    
    for (NSInteger i = 1; i < self.numberOfColumn; i ++) {
        
        if ([self.cellY[i] floatValue] < temp) {
            temp = [self.cellY[i] floatValue];
            minIndex = i;
        }
    }
    
    return minIndex;
}

- (NSInteger)maxCellY{
    
    CGFloat temp = [self.cellY[0] floatValue];
    NSInteger maxIndex = 0 ;
    
    for (NSInteger i = 1; i < self.numberOfColumn; i ++) {
        
        if ([self.cellY[i] floatValue] > temp) {
            temp = [self.cellY[i] floatValue];
            maxIndex = i;
        }
    }
    
    return maxIndex;
   
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i = 0; i < self.numberOfItem; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [arrM addObject:attr];
    }
    return arrM;
}

- (CGSize)collectionViewContentSize{
    
    NSInteger maxIndex = [self maxCellY];
    CGFloat height = [self.cellY[maxIndex] floatValue];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [self.cellY[maxIndex] floatValue]);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger index = [self minCellY];
    
    CGFloat cellX = [self.cellX[index] floatValue];
    CGFloat cellY = [self.cellY[index] floatValue];
    CGFloat cellWidth = self.cellWidth;
    CGFloat cellHeight = [self.cellHeight[indexPath.row] floatValue];
    
    self.cellY[index] = @(cellY + cellHeight + self.padding);
    
    attr.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    
    
    return attr;
}

@end

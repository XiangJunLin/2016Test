//
//  ViewController.m
//  LZCollectionViewPro
//
//  Created by comst on 16/3/2.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZCollectionFooter.h"
#import "LZColletionHeader.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINib *headerNib = [UINib nibWithNibName:@"LZColletionHeader" bundle:[NSBundle mainBundle]];
    UINib *footerNib = [UINib nibWithNibName:@"LZCollectionFooter" bundle:[NSBundle mainBundle]];
    
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LZHeader"];
    [self.collectionView registerNib:footerNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LZFooter"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LZCell" forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        LZCollectionFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LZFooter" forIndexPath:indexPath];
        return footerView;
    }else{
        LZColletionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LZHeader" forIndexPath:indexPath];
        return headerView;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(200, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(200, 50);
}
@end

//
//  LZMenuViewController.m
//  LZZoomIcon
//
//  Created by comst on 16/7/23.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZMenuViewController.h"
#import "LZIconItem.h"
#import "LZIconCell.h"
#import "LZDetailViewController.h"

#define COLOR(r, g, b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]


@interface LZMenuViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSArray *iconList;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation LZMenuViewController

static NSString * const reuseIdentifier = @"LZCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    self.collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    // Do any additional setup after loading the view.
    [self setupData];
    
}
/**
 *   SocialItem(image: UIImage(named: "icon-twitter"), color: UIColor(red: 0.255, green: 0.557, blue: 0.910, alpha: 1), name: "Twitter", summary: "Twitter is an online social networking service that enables users to send and read short 140-character messages called \"tweets\"."),
 SocialItem(image: UIImage(named: "icon-facebook"), color: UIColor(red: 0.239, green: 0.353, blue: 0.588, alpha: 1), name: "Facebook", summary: "Facebook (formerly thefacebook) is an online social networking service headquartered in Menlo Park, California. Its name comes from a colloquialism for the directory given to students at some American universities."),
 SocialItem(image: UIImage(named: "icon-youtube"), color: UIColor(red: 0.729, green: 0.188, blue: 0.180, alpha: 1), name: "Youtube", summary: "YouTube is a video-sharing website headquartered in San Bruno, California. The service was created by three former PayPal employees in February 2005 and has been owned by Google since late 2006. The site allows users to upload, view, and share videos."),
 SocialItem(image: UIImage(named: "icon-vimeo"), color: UIColor(red: 0.329, green: 0.737, blue: 0.988, alpha: 1), name: "Vimeo", summary: "Vimeo is a U.S.-based video-sharing website on which users can upload, share and view videos. Vimeo was founded in November 2004 by Jake Lodwick and Zach Klein."),
 SocialItem(image: UIImage(named: "icon-instagram"), color: UIColor(red: 0.325, green: 0.498, blue: 0.635, alpha: 1), name: "Instagram", summary: "Instagram is an online mobile photo-sharing, video-sharing and social networking service that enables its users to take pictures and videos, and share them on a variety of social networking platforms, such as Facebook, Twitter, Tumblr and Flickr.")
 ]

 */
- (void)setupData{
    NSArray *imgNameArr = @[@"icon-twitter", @"icon-facebook", @"icon-youtube", @"icon-vimeo", @"icon-instagram"];
    
    NSArray *colorArr = @[COLOR(0.255, 0.557, 0.910),
                          COLOR(0.239, 0.353, 0.588),
                          COLOR(0.729, 0.188, 0.180),
                          COLOR(0.329, 0.737, 0.988),
                          COLOR(0.325, 0.498, 0.635)];
    
    NSArray *titleArr = @[@"Twitter", @"Facebook", @"Youtube", @"Vimeo", @"Instagram"];
    
    NSArray *contentArr = @[
                            @"Twitter is an online social networking service that enables users to send and read short 140-character messages called \"tweets\"",
                            @"Facebook (formerly thefacebook) is an online social networking service headquartered in Menlo Park, California. Its name comes from a colloquialism for the directory given to students at some American universities.",
                            @"YouTube is a video-sharing website headquartered in San Bruno, California. The service was created by three former PayPal employees in February 2005 and has been owned by Google since late 2006. The site allows users to upload, view, and share videos.",
                            @"Vimeo is a U.S.-based video-sharing website on which users can upload, share and view videos. Vimeo was founded in November 2004 by Jake Lodwick and Zach Klein.",
                            @"Instagram is an online mobile photo-sharing, video-sharing and social networking service that enables its users to take pictures and videos, and share them on a variety of social networking platforms, such as Facebook, Twitter, Tumblr and Flickr."
                            ];
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i ++) {
        LZIconItem *item  =  [[LZIconItem alloc] init];
        item.title = titleArr[i];
        item.color = colorArr[i];
        item.content = contentArr[i];
        item.image = imgNameArr[i];
        [arrM addObject:item];
    }
    
    self.iconList = arrM;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if (section == 0) {
        return 2;
    }else{
        return 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSInteger index = 0 ;
    for (NSInteger i = 0; i < indexPath.section; i ++) {
        index += [collectionView numberOfItemsInSection:i];
    }
    index += indexPath.row;
    
    LZIconItem * currentItem = self.iconList[index];
    
    cell.currentItem = currentItem;
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    NSInteger count = [collectionView numberOfItemsInSection:section];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
    CGFloat cellsW = layout.itemSize.width * count;
    CGFloat paddingW = layout.minimumInteritemSpacing * (count - 1);
    
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cellsW - paddingW) / 2 ;
    
    
    return UIEdgeInsetsMake(0, margin, 40, margin);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    
    NSInteger index = 0 ;
    for (NSInteger i = 0; i < indexPath.section; i ++) {
        index += [collectionView numberOfItemsInSection:i];
    }
    index += indexPath.row;
    
    LZIconItem * currentItem = self.iconList[index];
    
    LZDetailViewController *detailVC = (LZDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LZDetailVC"];
    
    detailVC.currentItem = currentItem;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (UIView *)bgColoredViewForTransition{
    LZIconCell *cell = (LZIconCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
    return cell.bgColorView;
}

- (UIImageView *)iconImageVIewForTransition{
    LZIconCell *cell = (LZIconCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
    return cell.iconImageView;
}

@end

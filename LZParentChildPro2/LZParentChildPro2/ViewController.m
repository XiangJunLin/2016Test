//
//  ViewController.m
//  LZParentChildPro2
//
//  Created by comst on 16/3/1.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZCategoryItem.h"
#import "LZLeftTableViewController.h"
#import "LZRightTableViewController.h"

@interface ViewController ()<LZLefTableViewControllerDelegate>
@property (nonatomic, copy) NSArray *itemList;
@property (nonatomic, strong) LZRightTableViewController *rightVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    [self congifTable];
}

- (void)loadData{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary *dict in arr) {
        
        LZCategoryItem *item = [LZCategoryItem yy_modelWithDictionary:dict];
        [arrM addObject:item];
        
    }
    
    self.itemList = arrM;
}

- (void)congifTable{
    
    LZLeftTableViewController *leftVC = [[LZLeftTableViewController alloc] initWithStyle:UITableViewStylePlain];
    LZRightTableViewController *rightVC = [[LZRightTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.5;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    leftVC.view.frame = CGRectMake(0, 0, width, height);
    rightVC.view.frame = CGRectMake(width , 0, width, height);
    rightVC.view.backgroundColor = [UIColor cyanColor];
    
    leftVC.view.backgroundColor = [UIColor yellowColor]; ;
    
    [self.view addSubview:leftVC.view];
    [self.view addSubview:rightVC.view];
    [self addChildViewController:leftVC];
    [self addChildViewController:rightVC];
    leftVC.categories = self.itemList;
    leftVC.delegate = self;
    self.rightVC = rightVC;
    rightVC.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
     
   
    
}

- (void)tableviewController:(LZLeftTableViewController *)leftVC didSelectAtIndex:(NSInteger)index{
    
    NSArray *subCategories = [self.itemList[index] subcategories];
    self.rightVC.subCategories = subCategories;
    
    
}
@end

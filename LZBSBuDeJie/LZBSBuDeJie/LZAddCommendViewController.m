//
//  LZAddCommendViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/7.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZAddCommendViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "SVProgressHUD.h"
#import "LZCategoryModel.h"

#define LZCategoryID @"LZCategoryID"
#define LZSubCategoryID @"LZSubcategoryID"

@interface LZAddCommendViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *categoryView;
@property (nonatomic, strong) UITableView *subCategoryView;
@property (nonatomic, copy) NSArray *categories;
@end

@implementation LZAddCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = LZBKColor;
    self.navigationItem.title = @"添加关注";
    [self configView];
    
    [SVProgressHUD showWithStatus:@"请求"];
    
    //http://api.budejie.com/api/api_open.php?a=category&appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&c=subscribe&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&udid=&ver=4.0
    
    NSString *url = @"http://api.budejie.com/api/api_open.php?a=category&appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&c=subscribe&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&udid=&ver=4.0";
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"total:%@", responseObject[@"list"]);
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            LZCategoryModel *item = [LZCategoryModel yy_modelWithDictionary:dict];
            [arrM addObject:item];
        }
        self.categories = arrM;
        [self.categoryView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
    
    
}

- (void)configView{
    
    self.categoryView = [[UITableView alloc] init];
    self.categoryView.backgroundColor = LZBKColor;
    self.categoryView.delegate = self;
    self.categoryView.dataSource = self;
    self.categoryView.frame = CGRectMake(0, 0, 70, screenHeight);
    [self.view addSubview:self.categoryView];
    
    
    self.subCategoryView = [[UITableView alloc] init];
    self.subCategoryView.backgroundColor = LZBKColor;
    self.subCategoryView.delegate = self;
    self.subCategoryView.dataSource = self;
    self.subCategoryView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.subCategoryView.frame = CGRectMake(70, 0, screenWidth - 70, screenHeight);
    [self.view addSubview:self.subCategoryView];
    
    [self.categoryView registerClass:[UITableViewCell class] forCellReuseIdentifier:LZCategoryID];
    [self.subCategoryView registerClass:[UITableViewCell class] forCellReuseIdentifier:LZSubCategoryID];
    
    
    [self.categoryView reloadData];
    [self.subCategoryView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryView) {
        return self.categories.count;
    }
    return  50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LZCategoryID];
        LZCategoryModel *item = self.categories[indexPath.row];
        
        cell.textLabel.text = item.name;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LZSubCategoryID];
        cell.textLabel.text = [NSString stringWithFormat:@"subcategory - %ld", indexPath.row];
        return cell;
    }
    
}



@end

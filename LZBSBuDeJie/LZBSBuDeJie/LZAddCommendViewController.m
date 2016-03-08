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
#import "LZSubCategoryModel.h"
#import "MJRefresh.h"

#define LZCategoryID @"LZCategoryID"
#define LZSubCategoryID @"LZSubcategoryID"

@interface LZAddCommendViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *categoryView;
@property (nonatomic, strong) UITableView *subCategoryView;
@property (nonatomic, copy) NSArray *categories;
@property (nonatomic, strong) NSArray *subCategories;
@property (nonatomic, strong) AFHTTPSessionManager *requestManager;
@property (nonatomic, strong) NSDictionary *lastRequestParams;
@end

@implementation LZAddCommendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = LZBKColor;
    self.navigationItem.title = @"添加关注";
    [self configView];
    [self loadcategory];
    
    self.subCategoryView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    
    
    

}

#pragma mark - selected category id

- (NSInteger)selectedCategoryIndex{
    
    NSIndexPath *selectedIndexPath = [self.categoryView indexPathForSelectedRow];
    
    if (selectedIndexPath == 0) {
        
        return 0;
    }
   
    return selectedIndexPath.row;
}



#pragma mark - MJRefresh

- (void)pullDownRefresh{
    
   
    
    NSInteger categoryIndex = [self selectedCategoryIndex];
    
    
        [self loadSubcategories:categoryIndex];
    
    
    
    
}

- (void)pullUpToLoadMore{
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    NSInteger index = [self selectedCategoryIndex];
    
    LZCategoryModel *currentItem = self.categories[index];
    
    params[@"category_id"] = @(currentItem.id);
    params[@"page"] = @(currentItem.pageNumber + 1);
    
    if ([currentItem.lastPollUpParams isEqualToDictionary:params]) {
        
        if ([self.subCategoryView.mj_footer isRefreshing]) {
            [self.subCategoryView.mj_footer endRefreshing];
        }
        //[self.subCategoryView reloadData];
        return;
    }
    currentItem.lastPollUpParams = params;
    
    [self.requestManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        currentItem.pageNumber = currentItem.pageNumber + 1;
        currentItem.total = [responseObject[@"total"] integerValue];
        
        NSMutableArray *arrm = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            LZSubCategoryModel *item = [LZSubCategoryModel yy_modelWithDictionary:dict];
            [arrm addObject:item];
        }
        
        
        [currentItem.subcategories addObjectsFromArray:arrm];
        
        if (index == [self selectedCategoryIndex]) {
            
            self.subCategories = currentItem.subcategories;
            if ([self.subCategoryView.mj_footer isRefreshing]) {
                [self.subCategoryView.mj_footer endRefreshing];
            }
            [self.subCategoryView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (index == [self selectedCategoryIndex]) {
            
            if ([self.subCategoryView.mj_footer isRefreshing]) {
                [self.subCategoryView.mj_footer endRefreshing];
            }
            
        }
        
    }];
    

}

#pragma mark - load category

- (void)loadcategory{
    
     [SVProgressHUD showWithStatus:@"请求"];
    
    //http://api.budejie.com/api/api_open.php?a=category&appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&c=subscribe&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&udid=&ver=4.0
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    
    [self.requestManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"total:%@", responseObject[@"list"]);
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            LZCategoryModel *item = [LZCategoryModel yy_modelWithDictionary:dict];
            
            [arrM addObject:item];
        }
        
        self.categories = arrM;
        [self.categoryView reloadData];
        [self.categoryView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.subCategoryView.mj_header beginRefreshing];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
}

#pragma mark - load subcategories

- (void)loadSubcategories:(NSInteger)index{
    
    LZCategoryModel *currentItem = self.categories[index];
    
    if (currentItem.subcategories.count > 0) {
        
        if ([self.subCategoryView.mj_header isRefreshing]) {
            [self.subCategoryView.mj_header endRefreshing];
        }
        
        self.subCategories = currentItem.subcategories;
        [self.subCategoryView reloadData];
        
    }else{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self loadSubcategoriesFromServer:index];
        });
        
    }
    
}

- (void)loadSubcategoriesFromServer:(NSInteger)index{
   
   // http://api.budejie.com/api/api_open.php?a=list&appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&c=subscribe&category_id=36&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&page=1&pagesize=50&udid=&ver=4.0
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    
    LZCategoryModel *currentItem = self.categories[index];
    
    params[@"category_id"] = @(currentItem.id);
    
    if ([currentItem.lastRequestParams isEqualToDictionary:params]) {
        
        if ([self.subCategoryView.mj_header isRefreshing]) {
            [self.subCategoryView.mj_header endRefreshing];
        }
        [self.subCategoryView reloadData];
        return;
    }
    currentItem.lastRequestParams = params;
    
    [self.requestManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        currentItem.pageNumber = 1;
        currentItem.total = [responseObject[@"total"] integerValue];
        
        NSMutableArray *arrm = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            LZSubCategoryModel *item = [LZSubCategoryModel yy_modelWithDictionary:dict];
            [arrm addObject:item];
        }
        
        
        [currentItem.subcategories addObjectsFromArray:arrm];
        
        if (index == [self selectedCategoryIndex]) {
            
            self.subCategories = currentItem.subcategories;
            if ([self.subCategoryView.mj_header isRefreshing]) {
                [self.subCategoryView.mj_header endRefreshing];
            }
            [self.subCategoryView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (index == [self selectedCategoryIndex]) {
            
            if ([self.subCategoryView.mj_header isRefreshing]) {
                [self.subCategoryView.mj_header endRefreshing];
            }
            
        }
        
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

#pragma mark - lazy load

- (AFHTTPSessionManager *)requestManager{
    if (!_requestManager) {
        _requestManager = [AFHTTPSessionManager manager];
    }
    return _requestManager;
}

#pragma mark - tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryView) {
        return self.categories.count;
    }else if (tableView == self.subCategoryView){
       
        NSInteger categoryIndex = [self selectedCategoryIndex];
        LZCategoryModel *currentItem = self.categories[categoryIndex];
        if (currentItem.total != currentItem.subcategories.count) {
            self.subCategoryView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpToLoadMore)];
        }else{
            self.subCategoryView.mj_footer = nil;
        }

        return self.subCategories.count;
        
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LZCategoryID];
        LZCategoryModel *item = self.categories[indexPath.row];
        
        cell.textLabel.text = item.name;
        return cell;
        
    }else if (tableView == self.subCategoryView){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LZSubCategoryID];
        LZSubCategoryModel *item = self.subCategories[indexPath.row];
        
        cell.textLabel.text = item.screen_name;
        
        return cell;
        
    }else{
        
        return nil;
    }
    
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryView) {
        
        if ([self.subCategoryView.mj_header isRefreshing]) {
            [self.subCategoryView.mj_header endRefreshing];
        }
        if (self.subCategoryView.mj_footer != nil && [self.subCategoryView.mj_footer isRefreshing]) {
            [self.subCategoryView.mj_footer endRefreshing];
        }
        self.subCategories = nil;
        [self.subCategoryView reloadData];

        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryView) {
        
        
        
        [self.subCategoryView.mj_header beginRefreshing];
        
        /*
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self loadSubcategories:indexPath.row];
        });
         */
        
    }
    
    
}

- (void)dealloc{
    
    if ([self.subCategoryView.mj_header isRefreshing]) {
        [self.subCategoryView.mj_header endRefreshing];
    }
    if (self.subCategoryView.mj_footer != nil && [self.subCategoryView.mj_footer isRefreshing]) {
        [self.subCategoryView.mj_footer endRefreshing];
    }
    [self.requestManager.operationQueue cancelAllOperations];
    
}


@end

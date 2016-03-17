//
//  LZTopicTableViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/15.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTopicTableViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "LZTopicModel.h"
#import "LZCustomCellTableViewCell.h"

//http://d.api.budejie.com/topic/list/chuanyue/29/baisishequ-iphone-4.0/0-20.json?appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&udid=&ver=4.0
@interface LZTopicTableViewController ()
@property (nonatomic, copy) NSMutableArray *dataList;
@end

@implementation LZTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    
    
}

- (void)configTableView{
    
    self.tableView.backgroundColor = LZBKColor;
    self.tableView.rowHeight = 150;
    [self.tableView registerNib:[UINib nibWithNibName:@"LZCustomCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LZCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
}


#pragma mark - mjrefresh

- (void)loadNewData{
    
    NSString *urlStr = @"http://d.api.budejie.com/topic/list/chuanyue/29/baisishequ-iphone-4.0/0-20.json";
    
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *list = responseObject[@"list"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in list) {
            LZTopicModel *item = [LZTopicModel yy_modelWithDictionary:dict];
            item.user = [LZUserModel yy_modelWithDictionary:dict[@"u"]];
            item.user.iconURL = [dict[@"u"][@"header"] firstObject];
            
            [arrM addObject:item];
        }
        
        if (self.dataList == nil) {
            self.dataList = arrM;
        }else{
            [arrM addObjectsFromArray:self.dataList];
            self.dataList = arrM;
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZCustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    cell.currentModel = self.dataList[indexPath.row];
    return cell;
}
@end

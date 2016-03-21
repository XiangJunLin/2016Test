//
//  LZTopicTableViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/15.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZBudeJIeViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "LZTopicModel.h"
#import "LZCustomCellTableViewCell.h"
#import "LZCommon.h"
#import "LZCommenViewController.h"

//http://d.api.budejie.com/topic/list/chuanyue/29/baisishequ-iphone-4.0/0-20.json?appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&udid=&ver=4.0
@interface LZBudeJIeViewController ()
@property (nonatomic, copy) NSMutableArray *dataList;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation LZBudeJIeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    
    
}

- (void)configTableView{
    
    self.tableView.backgroundColor = LZBKColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"LZCustomCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LZCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
}


#pragma mark - mjrefresh

- (void)loadNewData{
    
    //http://d.api.budejie.com/topic/list/chuanyue/31/baisishequ-iphone-4.0/0-20.json
    NSString *urlStr = [NSString stringWithFormat:@"http://d.api.budejie.com/topic/list/chuanyue/%@/baisishequ-iphone-4.0/0-20.json", self.budejieType];
    [self.manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"response: %@", responseObject);
        NSArray *list = responseObject[@"list"];
        
//        NSString *filePath = @"/Users/comst/Desktop";
//        NSString *fullPath = [NSString stringWithFormat:@"%@/%@.plist", filePath, [list[0] valueForKey:@"type"]];
//        [list writeToFile:fullPath atomically:YES];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in list) {
            
            LZTopicModel *item = [LZTopicModel topicModelWithDict:dict];
            
            
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

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)loadMoreData{
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    if (self.tableView.mj_header && ![self.tableView.mj_header isRefreshing]) {
//        [self.tableView.mj_header beginRefreshing];
//    }
//}

- (void)viewWillDisappear:(BOOL)animated{
    if (self.tableView.mj_header && [self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    self.dataList = nil;
    [self.manager.operationQueue cancelAllOperations];
    [super viewWillDisappear:animated];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZTopicModel *currentItem = self.dataList[indexPath.row];
    return currentItem.totalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZCommenViewController *commentVC = [[LZCommenViewController alloc] init];
    
    [self.navigationController pushViewController:commentVC animated:YES];
}



@end

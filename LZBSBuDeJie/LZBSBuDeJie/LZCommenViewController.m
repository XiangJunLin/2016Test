//
//  LZCommenViewController.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZCommenViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "LZCommon.h"
#import "LZCommentModel.h"
#import "LZCustomCellTableViewCell.h"
#import "LZCommentHeaderView.h"

@interface LZCommenViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, strong) NSArray *hotList;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@end

@implementation LZCommenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configView];
    
    
}


- (void)configView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.commentTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonitemWithImage:@"comment_nav_item_share_icon" highlightedImage:@"comment_nav_item_share_icon_click" target:self selector:@selector(rightAction)];
    
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.commentTableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.commentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LZCommentCell"];
    //[self configTableHeadView];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self configTableHeadView];
}


- (void)configTableHeadView{
    
    LZCommentHeaderView *headerView = [LZCommentHeaderView commentHeaderView];
    UIView * headerViewContainer = [[UIView alloc] init];
    headerViewContainer.width =screenWidth;
    headerViewContainer.height = self.currentModel.totalHeight - self.currentModel.topCommentHeight - LZTopCommentLabelHeight;
    
    headerView.width = screenWidth - 2 * LZCellMargin;
    headerView.height = self.currentModel.totalHeight - self.currentModel.topCommentHeight - LZTopCommentLabelHeight - 2 *LZCellMargin;
    headerView.x = LZCellMargin;
    headerView.y = LZCellMargin;
    
    headerView.currentModel = self.currentModel;
    [headerViewContainer addSubview:headerView];
    
    self.commentTableView.tableHeaderView = headerViewContainer;
    
}
//http://api.budejie.com/api/api_open.php?a=dataList&appname=baisishequ&asid=1174A626-EA12-49B6-8625-FC73F2DEB8D1&c=comment&client=iphone&data_id=14286203&device=ios%20device&from=ios&hot=1&jbk=0&mac=&market=&openudid=605e95e1917e8443318a53b3d7414e49da59fd5a&page=1&per=50&udid=&ver=4.0
#pragma mark - load data from server
- (void)loadData{
    NSString *requestString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.currentModel.topicID;
    params[@"hot"] = @"1";
    [[AFHTTPSessionManager manager] GET:requestString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dataArray = [responseObject valueForKey:@"data"];
        NSArray *hotArray = [responseObject valueForKey:@"hot"];
        
        if (dataArray.count > 0) {
            
            NSMutableArray *dataM = [NSMutableArray array];
            
            for (NSDictionary *dict in dataArray) {
                LZCommentModel *item = [LZCommentModel commentModelWithDic:dict];
                [dataM addObject:item];
            }
            self.commentList = dataM;
            
            
        }
        if (hotArray.count > 0) {
            NSMutableArray *hotM = [NSMutableArray array];
            
            for (NSDictionary *dict in hotArray) {
                LZCommentModel *item = [LZCommentModel commentModelWithDic:dict];
                [hotM addObject:item];
            }
            self.hotList = hotM;
        }
        
        LZLOG(@"get comment success");
        [self.commentTableView.mj_header endRefreshing];
        [self.commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LZLOG(@"get comment fail");
        [self.commentTableView.mj_header endRefreshing];
    }];
}

#pragma mark - rightBar action
- (void)rightAction{
    
    UIAlertController *actionVC = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"action1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"action1 triggered");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"action2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"action2 triggered");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"action3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"action3 triggered");
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"action4" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"action4 triggered");
    }];
    
    [actionVC addAction:action1];
    [actionVC addAction:action2];
    [actionVC addAction:action3];
    [actionVC addAction:action4];
    [self presentViewController:actionVC animated:YES completion:^{
        
    }];
}

#pragma mark - tableview datasource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.commentList) {
        
        if (self.hotList) {
            return 2;
        }
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.hotList) {
        
        if (section == 0) {
            
            return self.hotList.count;
            
        }else{
            
            return self.commentList.count;
            
        }
        
        
    }else{
        
        return self.commentList.count;
        
    }
    
}


- (NSArray *)arrayWithSection:(NSInteger)section{
    
    if (section == 1) {
        
        return self.commentList;
        
    }else{
        if (self.hotList) {
            return self.hotList;
        }else{
            return self.commentList;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [self arrayWithSection:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCommentCell"];
    LZCommentModel *currentItem = arr[indexPath.row];
    cell.textLabel.text = currentItem.content;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.hotList) {
        if (section == 0) {
             return @"最热评论";
        }else{
            return @"最新评论";
        }
    }else{
        return @"最新评论";
    }
}

#pragma mark - scrollview delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)keyboardAction:(NSNotification *)notif{
    //UIKeyboardFrameEndUserInfoKey
    //UIKeyboardAnimationDurationUserInfoKey
    CGRect endFrame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat deltY = screenHeight - endFrame.origin.y;
    
    self.bottomViewConstraint.constant = deltY;
    [UIView animateWithDuration:duration animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

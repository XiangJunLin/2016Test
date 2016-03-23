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
#import "LZCommentTableViewHeader.h"
#import "LZCommentCell.h"

@interface LZCommenViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *commentList;
@property (nonatomic, strong) NSArray *hotList;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@property (nonatomic, assign) NSInteger requestPage;
@property (nonatomic, assign) NSInteger totalComments;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
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
    
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.commentTableView.mj_footer.hidden = YES;
    
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.contentInset = UIEdgeInsetsMake(0, 0, LZCellMargin, 0);
    
    self.commentTableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.commentTableView registerNib:[UINib nibWithNibName:@"LZCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LZCommentCell"];
    [self.commentTableView registerClass:[LZCommentTableViewHeader class] forHeaderFooterViewReuseIdentifier:@"LZCommentHeader"];
    
  
    self.commentTableView.estimatedRowHeight = 44;
    self.commentTableView.rowHeight = UITableViewAutomaticDimension;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //[self configTableHeadView];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self configTableHeadView];
    [self.commentTableView.mj_header beginRefreshing];
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
- (void)loadNewData{
    NSString *requestString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.currentModel.topicID;
    params[@"hot"] = @"1";
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:requestString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.requestPage = 1;
        self.totalComments = [responseObject[@"total"] integerValue];
        
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

- (void)loadMoreData{
    
    NSString *requestString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.currentModel.topicID;
    params[@"hot"] = @"1";
    params[@"page"] = [NSString stringWithFormat:@"%li", self.requestPage + 1];
    LZCommentModel *lastItem = [self.commentList lastObject];
    params[@"lastcid"] = lastItem.commentID;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:requestString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.requestPage = self.requestPage + 1;
        NSArray *dataArray = [responseObject valueForKey:@"data"];
        NSArray *hotArray = [responseObject valueForKey:@"hot"];
        
        if (dataArray.count > 0) {
            
            NSMutableArray *dataM = [NSMutableArray array];
            
            for (NSDictionary *dict in dataArray) {
                LZCommentModel *item = [LZCommentModel commentModelWithDic:dict];
                [dataM addObject:item];
            }
            [self.commentList addObjectsFromArray:dataM];
            
            
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
        [self.commentTableView.mj_footer endRefreshing];
        [self.commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LZLOG(@"get comment fail");
        [self.commentTableView.mj_footer endRefreshing];
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
    
    if (self.commentList && [self.commentList count] < self.totalComments) {
        self.commentTableView.mj_footer.hidden = NO;
    }else{
        self.commentTableView.mj_footer.hidden = YES;
    }
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
    LZCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCommentCell"];
    LZCommentModel *currentItem = arr[indexPath.row];
    cell.currentItem = currentItem;
   
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LZCommentTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LZCommentHeader"];
    NSString *title ;
    if (self.hotList) {
        if (section == 0) {
            title = @"最热评论";
        }else{
            title = @"最新评论";
        }
    }else{
        title = @"最新评论";
    }
    headerView.title = title;
    return headerView;
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

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end

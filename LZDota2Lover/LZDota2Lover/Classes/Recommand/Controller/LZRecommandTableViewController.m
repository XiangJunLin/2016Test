//
//  LZRecommandTableViewController.m
//  LZDota2Lover
//
//  Created by comst on 16/4/15.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZRecommandTableViewController.h"
#import "MJRefresh.h"

static NSString *kLatestVedio = @"最新视频";
static NSString *kHotMonthly = @"本月最火";
static NSString *kHotWeekly = @"本周最火";

@interface LZRecommandTableViewController ()

@property (nonatomic, strong) NSDictionary *dataSourceDict;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@property (weak, nonatomic) IBOutlet UIButton *latestButton;

@property (weak, nonatomic) IBOutlet UIButton *weekButton;

@property (weak, nonatomic) IBOutlet UIButton *monthButton;

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation LZRecommandTableViewController

#pragma mark - VC About
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseConfig];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark - config 

- (void)baseConfig{
    [self btnClickAction:self.latestButton];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark - btn Action
- (IBAction)btnClickAction:(UIButton *)sender {
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;
    
    CGPoint center = self.indicatorView.center;
    center.x = sender.center.x;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.center = center;
    }];
}

#pragma mark - lazyload 

- (NSDictionary *)dataSourceDict{
    if (!_dataSourceDict) {
        
        NSMutableArray *arrayM1 = [NSMutableArray array];
        
        NSMutableArray *arrayM2 = [NSMutableArray array];
        
        NSMutableArray *arrayM3 = [NSMutableArray array];
        
        _dataSourceDict = @{
                            kLatestVedio : arrayM1,
                            kHotWeekly : arrayM2,
                            kHotMonthly : arrayM3
                            };
    }
    return _dataSourceDict;
}


#pragma mark - loadNewData

- (void)loadNewData{
    
}

- (void)loadMoreData{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

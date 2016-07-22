//
//  ViewController.m
//  LZStretchHeader
//
//  Created by comst on 16/7/20.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZItemCell.h"

#define COLOR(r, g , b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]

#define WorldColor COLOR(0.106, 0.686, 0.125)
#define AmericaColor COLOR(0.114, 0.639, 0.984)
#define EuropColor COLOR(0.322, 0.459, 0.984)
#define MidEastColor COLOR(0.502, 0.290, 0.984)
#define AfricaColor COLOR(0.988, 0.271, 0.282)
#define AsiaPacifictColor COLOR(0.620, 0.776, 0.153)


#define kHeaderViewHeight 300
#define kCutAwayHeight 80
@interface ViewController ()
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
    [self configDataSource];
    
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

/**
 *  NewsItem(category: .World, summary: "Climate change protests, divestments meet fossil fuels realities"),
 NewsItem(category: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
 NewsItem(category: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
 NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
 NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
 NewsItem(category: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
 NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
 NewsItem(category: .Europe, summary: "'One million babies' created by EU student exchanges"),
 
 
 
 case .World:
 return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1)
 case .Americas:
 return UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 1)
 case .Europe:
 return UIColor(red: 0.322, green: 0.459, blue: 0.984, alpha: 1)
 case .MiddleEast:
 return UIColor(red: 0.502, green: 0.290, blue: 0.984, alpha: 1)
 case .Africa:
 return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
 case .AsiaPacific:
 return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1)
 */


- (void)setup {
    
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.headerView = self.tableView.tableHeaderView;
    
    self.tableView.tableHeaderView = nil;
    
    [self.tableView addSubview:self.headerView];
    
    self.maskLayer = [[CAShapeLayer alloc] init];
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    self.headerView.layer.mask = self.maskLayer;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight - kCutAwayHeight / 2, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, - kHeaderViewHeight + kCutAwayHeight / 2);
    
    [self updateHeaderVIew];
    
    
    
}
- (void)configDataSource {
    
    LZItem *item1 = [[LZItem alloc] init];
    item1.title = @"World";
    item1.content = @"Climate change protests, divestments meet fossil fuels realities";
    item1.color = [UIColor colorWithRed:0.106 green:0.686 blue:0.125 alpha:1];
    
    LZItem *item2 = [[LZItem alloc] init];
    item2.title = @"Europe";
    item2.content = @"Scotland's 'Yes' leader says independence vote is 'once in a lifetime'";
    item2.color = EuropColor;
    
    LZItem *item3 = [[LZItem alloc] init];
    item3.title = @"MiddleEast";
    item3.content = @"Airstrikes boost Islamic State, FBI director warns more hostages possible";
    item3.color = MidEastColor;
    
    LZItem *item4 = [[LZItem alloc] init];
    item4.title = @"Africa";
    item4.content = @"Nigeria says 70 dead in building collapse; questions S. Africa victim claim";
    item4.color = AfricaColor;
    
    LZItem *item5 = [[LZItem alloc] init];
    item5.title = @"AsiaPacific";
    item5.content = @"Despite UN ruling, Japan seeks backing for whale hunting";
    item5.color = AsiaPacifictColor;
    
    LZItem *item6 = [[LZItem alloc] init];
    item6.title = @"Americas";
    item6.content = @"Officials: FBI is tracking 100 Americans who fought alongside IS in Syria";
    item6.color = AmericaColor;
    
    LZItem *item7 = [[LZItem alloc] init];
    item7.title = @"World";
    item7.content = @"South Africa in $40 billion deal for Russian nuclear reactors";
    item7.color  = WorldColor;
    
    LZItem *item8 = [[LZItem alloc] init];
    item8.title = @"Europe";
    item8.content = @"'One million babies' created by EU student exchanges";
    item8.color = EuropColor;
    
    self.list = @[item1, item2, item3, item4, item5, item6, item7, item8];
    
    [self.tableView reloadData];
    
    
    
}

- (void)updateHeaderVIew{
    
    CGRect headRect = CGRectMake(0, -kHeaderViewHeight + kCutAwayHeight / 2, [UIScreen mainScreen].bounds.size.width, kHeaderViewHeight);
    
    if (self.tableView.contentOffset.y < - kHeaderViewHeight + kCutAwayHeight / 2) {
        
        headRect.origin.y = self.tableView.contentOffset.y;
        headRect.size.height = - self.tableView.contentOffset.y + kCutAwayHeight / 2;
        
    }
    
    self.headerView.frame = headRect;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(headRect.size.width, 0)];
    [path addLineToPoint:CGPointMake(headRect.size.width, headRect.size.height)];
    [path addLineToPoint:CGPointMake(0, headRect.size.height - kCutAwayHeight)];
    [path addLineToPoint:CGPointMake(0, 0)];
    self.maskLayer.path = path.CGPath;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableVC delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
    cell.currentItem  = self.list[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self updateHeaderVIew];
}
@end

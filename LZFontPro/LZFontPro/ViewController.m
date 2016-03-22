//
//  ViewController.m
//  LZFontPro
//
//  Created by comst on 16/3/22.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZFontViewCOntrollerViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *text;

@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self loadFonts];
    
    
}

- (void)loadFonts{
    
    self.dataList = [UIFont familyNames];
    [self.tableView reloadData];
}



#pragma mark - data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *familyName = self.dataList[section];
    NSArray * fonts = [UIFont fontNamesForFamilyName:familyName];
    return fonts.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.dataList[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontCell"];
    NSString *familyName = self.dataList[indexPath.section];
    NSArray * fonts = [UIFont fontNamesForFamilyName:familyName];
    
    cell.textLabel.text = fonts[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZFontViewCOntrollerViewController *vc = [[LZFontViewCOntrollerViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end

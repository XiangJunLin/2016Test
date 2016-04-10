//
//  LZTableViewController.m
//  LZAttributeText
//
//  Created by comst on 16/4/10.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTableViewController.h"
#import "ViewController.h"

@interface LZTableViewController ()
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation LZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ViewController *destVC = (ViewController *)segue.destinationViewController;
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    destVC.type = self.dataList[selectedIndexPath.row];
    
}

- (NSArray *)dataList{
    if (!_dataList) {
        
        _dataList = @[@"NSFontAttributeName", @"NSForegroundColorAttributeName", @"NSBackgroundColorAttributeName", @"NSLigatureAttributeName", @"NSKernAttributeName", @"NSStrikethroughStyleAttributeName", @"NSStrikethroughColorAttributeName", @"NSUnderlineStyleAttributeName", @"NSUnderlineColorAttributeName", @"NSStrokeWidthAttributeName", @"NSStrokeColorAttributeName", @"NSShadowAttributeName", @"NSTextEffectAttributeName", @"NSBaselineOffsetAttributeName", @"NSObliquenessAttributeName", @"NSExpansionAttributeName", @"NSWritingDirectionAttributeName", @"NSVerticalGlyphFormAttributeName", @"NSLinkAttributeName", @"NSAttachmentAttributeName", @"NSParagraphStyleAttributeName"];
        
    }
    
    return _dataList;
}


@end

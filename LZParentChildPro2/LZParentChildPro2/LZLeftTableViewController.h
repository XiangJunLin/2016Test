//
//  LZLeftTableViewController.h
//  LZParentChildPro2
//
//  Created by comst on 16/3/2.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZLeftTableViewController;
@protocol LZLefTableViewControllerDelegate <NSObject>

@optional

- (void)tableviewController:(LZLeftTableViewController *)leftVC didSelectAtIndex:(NSInteger)index;

@end

@interface LZLeftTableViewController : UITableViewController
@property (nonatomic, weak) id<LZLefTableViewControllerDelegate> delegate;
@property (nonatomic, copy) NSArray *categories;
@end

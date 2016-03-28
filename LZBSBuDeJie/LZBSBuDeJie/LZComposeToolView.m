//
//  LZComposeToolView.m
//  LZBSBuDeJie
//
//  Created by comst on 16/3/26.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZComposeToolView.h"
#import "LZCommon.h"
#import "LZAddTagController.h"
#define LZTagBgColor LZColor(74, 139, 209)
@interface LZComposeToolView ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, strong)  NSMutableArray *tagsArray;
@property (nonatomic, strong) NSMutableArray *tagsBbutton;
@property (nonatomic, strong) UIButton *addButton;
@end
@implementation LZComposeToolView

+ (instancetype)composeToolView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib{
    [super awakeFromNib];
    NSArray *arr = @[@"吐槽",@"搞笑"];
    self.tagsArray = [arr mutableCopy];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [self.topView addSubview:button];
    button.height = button.currentImage.size.height;
    button.width = button.currentImage.size.width;
    button.x = LZCellMargin;
    button.y = LZCellMargin;
    [button addTarget:self action:@selector(addTagAction) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = button;
   
    [self configTags];
}

- (void)addTagAction{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UINavigationController *nVC = (UINavigationController *)rootVC.presentedViewController;
    
    LZAddTagController *addTagVc = [[LZAddTagController alloc] init];
    
     __weak typeof(self) weakSelf = self;
    addTagVc.completeBlock = ^void(NSArray *tagsArray){
        
        weakSelf.tagsArray = [tagsArray mutableCopy];
        [weakSelf configTags];
        
    };
    addTagVc.sourceTags = [self.tagsArray copy];
    [nVC pushViewController:addTagVc animated:YES];
    
}

- (void)configTags{
    [self.tagsBbutton makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.tagsBbutton = [NSMutableArray array];
    
    UIButton *preButton = nil;
    for (NSInteger index = 0; index < self.tagsArray.count; index ++) {
        
        NSString *text = self.tagsArray[index];
        
        UIButton *newTagButton = [[UIButton alloc] init];
        [self.topView addSubview:newTagButton];
        [self.tagsBbutton addObject:newTagButton];
        
        [newTagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        newTagButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [newTagButton setBackgroundColor:LZTagBgColor];
        
        [newTagButton setTitle:text forState:UIControlStateNormal];
        [newTagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        [newTagButton sizeToFit];
        //newTagButton.height = 30;
        
        [newTagButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 0) {
            newTagButton.x = LZCellMargin;
            newTagButton.y = 0;
        }else{
            CGFloat leftW = CGRectGetMaxX(preButton.frame) + 10;
            CGFloat rightW = screenWidth - leftW;
            if (rightW >= newTagButton.width) {
                newTagButton.x = leftW;
                newTagButton.y = preButton.y;
            }else{
                newTagButton.x = LZCellMargin;
                newTagButton.y = CGRectGetMaxY(preButton.frame)+ 5;
            }
        }
        preButton = newTagButton;
    }
    
    CGFloat leftW = CGRectGetMaxX(preButton.frame) + 10;
    CGFloat rightW = screenWidth - leftW;
    if (self.addButton.width <= rightW) {
        self.addButton.x = leftW;
        self.addButton.y = preButton.y;
    }else{
        self.addButton.x = LZCellMargin;
        self.addButton.y = CGRectGetMaxY(preButton.frame) + 5;
    }
    
   

}

- (void)deleteAction:(UIButton *)btn{
    NSInteger index = [self.tagsBbutton indexOfObject:btn];
    [self.tagsArray removeObjectAtIndex:index];
    
    [btn removeFromSuperview];
    [self.tagsBbutton removeObject:btn];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self configTags];
    }];
}

- (NSMutableArray *)tagsBbutton{
    if (!_tagsBbutton) {
        _tagsBbutton = [[NSMutableArray alloc] init];
    }
    return _tagsBbutton;
}
@end

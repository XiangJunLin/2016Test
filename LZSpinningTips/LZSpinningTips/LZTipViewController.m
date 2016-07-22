//
//  LZTipViewController.m
//  LZSpinningTips
//
//  Created by comst on 16/7/21.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZTipViewController.h"
#import "LZTipView.h"

#define xyOffset 500
#define tipViewWidth 300
#define tipViewHeight 400

typedef NS_OPTIONS(NSInteger, LZDirection) {
    
    kRotateLeft,
    kRotateRight
};


@interface LZTipViewController ()
@property (nonatomic, strong) LZTipView *tipView;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *panBehavior;

@property (nonatomic, assign) NSInteger currentIndex;


@end

@implementation LZTipViewController

- (void)loadView{
    self.view = [[UIView alloc] init];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self tipViewRotateToEndpoint:kRotateRight];
}

- (void)setupTipViewStartPoint:(LZDirection)dir{
    [self.tipView setupTip:self.currentIndex];
    CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    CGAffineTransform t = CGAffineTransformIdentity;
    center.y += xyOffset;
    switch (dir) {
            
        case kRotateLeft:
            center.x = center.x - xyOffset;
            t = CGAffineTransformMakeRotation(- M_PI_2);
            break;
        case kRotateRight:
            center.x += xyOffset;
            t = CGAffineTransformMakeRotation(M_PI_2);
            break;
        default:
            break;
    }
    
    self.tipView.center = center;
    self.tipView.transform = t;
}

- (void)tipViewRotateToEndpoint:(LZDirection)dir{
    
    [self.animator removeAllBehaviors];
    
    [self setupTipViewStartPoint:dir];
    
    [self.animator updateItemUsingCurrentState:self.tipView];
    
    [self.animator addBehavior:self.snapBehavior];
    [self.animator addBehavior:self.attachBehavior];
    
}

- (LZTipView *)tipView{
    if (!_tipView) {
        _tipView = [LZTipView tipView];
        _tipView.tipList = self.tips;
        [self.view addSubview:_tipView];
        _tipView.bounds = CGRectMake(0, 0, tipViewWidth, tipViewHeight);
        _tipView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    }
    return _tipView;
}

- (UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (UIAttachmentBehavior *)attachBehavior{
    if (!_attachBehavior) {
        CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        center.y += xyOffset;
        _attachBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.tipView offsetFromCenter:UIOffsetMake(0, xyOffset) attachedToAnchor:center];
    }
    return _attachBehavior;
}

- (UISnapBehavior *)snapBehavior{
    CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));

    if (!_snapBehavior) {
        _snapBehavior = [[UISnapBehavior alloc] initWithItem:self.tipView snapToPoint:center];
    }
    return _snapBehavior;
}

- (UIAttachmentBehavior *)panBehavior{
    CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));

    if (!_panBehavior) {
        _panBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.tipView attachedToAnchor:center];
    }
    return _panBehavior;
}

- (void)panAction:(UIPanGestureRecognizer *)gesture{
    CGPoint location = [gesture locationInView:self.view];
    CGPoint offset = [gesture translationInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self.animator removeBehavior:self.snapBehavior];
             self.panBehavior.anchorPoint = location;
            [self.animator addBehavior:self.panBehavior];
           
             break;
        
        case UIGestureRecognizerStateChanged:
            
            self.panBehavior.anchorPoint = location;
            
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (fabs(offset.x) < 100) {
                [self.animator removeBehavior:self.panBehavior];
                [self.animator addBehavior:self.snapBehavior];
            }else{
                //right
                
                CGPoint center = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
                CGPoint endPoint = center;
                LZDirection nextDirection ;
                endPoint.y += xyOffset;
                
                if (offset.x > 0) {
                    endPoint.x += xyOffset;
                    nextDirection = kRotateLeft;
                    self.currentIndex = (self.currentIndex + 1) % self.tips.count;
                    
                    
                }else{
                   //left
                    endPoint.x -= xyOffset;
                    nextDirection = kRotateRight;
                    
                    self.currentIndex = (self.currentIndex - 1 + self.tips.count) % self.tips.count;
                }
                
                self.panBehavior.anchorPoint = endPoint;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self tipViewRotateToEndpoint:nextDirection];
                });
            }
        default:
            break;
    }
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self tipViewRotateToEndpoint:kRotateRight];
//}
@end

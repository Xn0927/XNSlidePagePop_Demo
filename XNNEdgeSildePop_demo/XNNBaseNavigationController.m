//
//  XNNBaseNavigationController.m
//  XNNEdgeSildePop_demo
//
//  Created by ||X.H|| on 2016/11/14.
//  Copyright © 2016年 ||X.H||. All rights reserved.
//

#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#import "XNNBaseNavigationController.h"

@interface XNNBaseNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *screenShootArray;
@property (nonatomic, strong) UIView *screenShootView;
@property (nonatomic, strong) UIImageView *screenShootImg;
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation XNNBaseNavigationController

- (void)leftButtonWithTitle:(NSString *)title image:(UIImage *)image hlImage:(UIImage *)hlImage selector:(SEL)selector target:(id) target
{
    if([self.viewControllers lastObject])
    {
        UIViewController * vc = [self.viewControllers lastObject];
        id aTarget = target ? target : vc;
        if (![aTarget respondsToSelector:selector ? selector:@selector(leftButtonPress:)])
        {
            aTarget = nil;
        }
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 42)];
        but.contentMode = UIViewContentModeCenter;
        [but setImage:image forState:UIControlStateNormal];
        [but setImage:hlImage forState:UIControlStateHighlighted];
        [but setTitle:title forState:UIControlStateNormal];
        [but.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [but addTarget:aTarget action:@selector(leftButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 42)];
        [leftView addSubview:but];
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftView];
        vc.navigationItem.leftBarButtonItem = sendButtonItem;
    }
}

//截图
- (UIImage*)screenShot:(UIView*)screenshot{
    
    UIGraphicsBeginImageContextWithOptions(screenshot.bounds.size, YES, 0.0);
    [screenshot drawViewHierarchyInRect:screenshot.bounds afterScreenUpdates:YES];
    UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImg;
}

// 添加BG到view中
- (void)setUpBGView
{
    self.screenShootImg.image = self.screenShootArray.lastObject;
}

// view 偏移量
- (void)setMoveOffSet:(CGFloat)x
{
    x = MAX(0, x);
    x = MIN(SCREENWIDTH, x);
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    CGFloat scale = 0.95 + x/SCREENWIDTH*0.05;
    self.screenShootView.transform = CGAffineTransformMakeScale(scale, scale);
}

#pragma mark - POP 、PUSH
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        UIImage *shootImg = [self screenShot:[UIApplication sharedApplication].keyWindow];
        [self.screenShootArray addObject:shootImg];
    }
    self.screenShootView.hidden = YES;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    self.view.frame = frame;
    [self.screenShootArray removeLastObject];
    self.screenShootView.hidden = YES;
    return [super popViewControllerAnimated:animated];
}

#pragma mark - setter 、
// screenShoot IMG Arr
- (NSMutableArray *)screenShootArray
{
    if (!_screenShootArray) {
        _screenShootArray = [NSMutableArray array];
    }
    return _screenShootArray;
}

// self.view 's parent view
- (UIView *)screenShootView
{
    if (!_screenShootView) {
        _screenShootView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view.superview insertSubview:self.screenShootView belowSubview:self.view];
    }
    return _screenShootView;
}

// Screen Shoot Imgview in screenShootView
- (UIImageView *)screenShootImg
{
    if (!_screenShootImg) {
        _screenShootImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.screenShootView addSubview:self.screenShootImg];
    }
    return _screenShootImg;
}

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panchAction:)];
    panGR.delegate = self;
    [self.view addGestureRecognizer:panGR];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_screenShootView) {
        [self.view.superview insertSubview:self.screenShootView belowSubview:self.view];
    }
}

#pragma mark - action
- (void)panchAction:(UIPanGestureRecognizer *)panGR
{
    if (self.viewControllers.count < 1 || !_canMovedBack) {
        return;
    }
    CGPoint touchPoint = [panGR locationInView:[[UIApplication sharedApplication]keyWindow]];
    NSLogPoint(touchPoint);
    self.screenShootView.hidden = NO;
    if (panGR.state == UIGestureRecognizerStateBegan) {
        
        [self setUpBGView];
        self.startPoint = touchPoint;
        NSLogPoint(self.startPoint);
    }else if (panGR.state == UIGestureRecognizerStateChanged) {
        
        [self setMoveOffSet:touchPoint.x - self.startPoint.x];
        
    }else if (panGR.state == UIGestureRecognizerStateCancelled) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self setMoveOffSet:0];
            
        }];
        
    }else if (panGR.state == UIGestureRecognizerStateEnded) {
        
        if (touchPoint.x - self.startPoint.x < SCREENWIDTH/4) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self setMoveOffSet:0];
                
            }];
            
        }else{
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self setMoveOffSet:SCREENWIDTH];
                
            }completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                
            }];
            
        }
        
        NSLog(@" GESTURE END ");
    }
}

- (void)leftButtonPress:(UIButton *)sender
{
    
}

#pragma mark - Gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count != 1 && _canMovedBack;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

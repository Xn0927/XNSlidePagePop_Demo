//
//  XNNBaseViewController.m
//  XNNEdgeSildePop_demo
//
//  Created by ||X.H|| on 2016/11/14.
//  Copyright © 2016年 ||X.H||. All rights reserved.
//

#import "XNNBaseViewController.h"
#import "XNNBaseNavigationController.h"
#import "ThirdViewController.h"

@interface XNNBaseViewController ()

@end

@implementation XNNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    XNNBaseNavigationController *baseNC = (XNNBaseNavigationController *)self.navigationController;
    if (baseNC.viewControllers.count > 1) {
        [baseNC leftButtonWithTitle:nil image:[UIImage imageNamed:@"back"] hlImage:[UIImage imageNamed:@"back"] selector:@selector(leftButtonPress:) target:self];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    XNNBaseNavigationController *baseNC = (XNNBaseNavigationController *)self.navigationController;
    // 设置 ThirdViewController 页面为不可拖动返回
    if ([self isKindOfClass:[ThirdViewController class]]) {
        baseNC.canMovedBack = NO;
    }else{
        baseNC.canMovedBack = YES;
    }
}

- (void)leftButtonPress:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

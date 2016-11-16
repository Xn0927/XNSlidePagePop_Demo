//
//  ThirdViewController.m
//  XNNEdgeSildePop_demo
//
//  Created by ||X.H|| on 2016/11/15.
//  Copyright © 2016年 ||X.H||. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ThirdPage";
    self.view.backgroundColor = [UIColor orangeColor];
    [self setAlertLab];
}

- (void)setAlertLab
{
    UILabel *alertLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)];
    alertLab.text = @"This page cannot slide to pop";
    alertLab.font = [UIFont systemFontOfSize:20];
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.textColor = [UIColor redColor];
    [self.view addSubview:alertLab];
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

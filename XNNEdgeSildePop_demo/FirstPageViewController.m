//
//  FirstPageViewController.m
//  XNNEdgeSildePop_demo
//
//  Created by ||X.H|| on 2016/11/14.
//  Copyright © 2016年 ||X.H||. All rights reserved.
//

#import "FirstPageViewController.h"
#import "SecondViewController.h"

@interface FirstPageViewController ()

@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FirstPage";
    [self configImgView];
}

- (void)configImgView
{
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgV.image = [UIImage imageNamed:@"girl.jpg"];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgV];
}

// touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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

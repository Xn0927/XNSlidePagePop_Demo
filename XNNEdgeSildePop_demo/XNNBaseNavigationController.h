//
//  XNNBaseNavigationController.h
//  XNNEdgeSildePop_demo
//
//  Created by ||X.H|| on 2016/11/14.
//  Copyright © 2016年 ||X.H||. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNNBaseNavigationController : UINavigationController

@property (nonatomic, assign) BOOL canMovedBack;
- (void)leftButtonWithTitle:(NSString *)title image:(UIImage *)image hlImage:(UIImage *)hlImage selector:(SEL)selector target:(id) target;

@end

//
//  MCBaseNavigationController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCBaseNavigationController.h"

@interface MCBaseNavigationController ()

@end

@implementation MCBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ((self.viewControllers.count > 0) && (viewController != self.viewControllers[0])) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

    
 
   
    
}
@end

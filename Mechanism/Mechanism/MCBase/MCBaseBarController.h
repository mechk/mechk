//
//  MCBaseBarController.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCAdminsterViewController.h"
#import "MCToolViewController.h"
#import "MCMeViewController.h"
#import "MCBaseNavigationController.h"
@interface MCBaseBarController : UITabBarController
@property(nonatomic,strong)MCBaseNavigationController *AdminNavigationVC;
@property(nonatomic,strong)MCBaseNavigationController *ToolNavigationVC;
@property(nonatomic,strong)MCBaseNavigationController *MeNavigationVC;
@end

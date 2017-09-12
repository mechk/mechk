//
//  MCBaseViewController.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCBaseViewController : UIViewController
- (void)createBack;
- (NSString *)time:(NSString *)timeStampString;
- (void)hideTabBar;
- (void)showTabBar;
- (void)backAction;
@end

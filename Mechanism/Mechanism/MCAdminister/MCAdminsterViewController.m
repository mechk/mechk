//
//  MCAdminsterViewController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCAdminsterViewController.h"

@interface MCAdminsterViewController ()

@end

@implementation MCAdminsterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
         [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, def_width, 350*scaleH)];
    backView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:backView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    
    return UIStatusBarStyleLightContent;
}
@end

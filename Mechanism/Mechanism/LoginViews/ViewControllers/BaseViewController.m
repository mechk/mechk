//
//  BaseViewController.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "BaseViewController.h"
#import "CommonTool.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - View controller life cycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setupViewController];
    }
    return self;
}

- (void)setupViewController
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    _haveBack = YES;
    _showNavi = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_haveBack) {//默认有返回按钮
        button.frame = CGRectMake(0, 0, 20, 40);
        [button setImage:[UIImage imageNamed:@"Common_back_button"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(returnBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Common_back_button"] style:UIBarButtonItemStylePlain target:self action:@selector(returnBtnTapped:)];
//        UIImage *backButtonImage = [[UIImage imageNamed:@"Common_back_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
//        
//        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(922337203685, 922337203685) forBarMetrics:UIBarMetricsDefault];
    } else {
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

    }
    if (_showNavi) {//默认展示导航条
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    
    UIColor * color = [UIColor blackColor];
//    [self.navigationController.navigationBar setTintColor:color];
    
    //这里我们设置的是颜色，还可以设置shadow等
    self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : color, NSFontAttributeName : [UIFont systemFontOfSize:17] };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [self.navigationController setNavigationBarHidden:!_showNavi];
    
//    // 设置Navigation bar背景颜色
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    // 设置Navigation bar背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[CommonTool imageWithColor:[CommonTool colorWithHexString:@"#ffffff"]] forBarMetrics:UIBarMetricsDefault];
    // 去除navigation bar下面的黑线
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"Shape"]];
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor whiteColor];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}

- (void)returnBtnTapped:(id)sender {
    [self.view endEditing:YES];
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

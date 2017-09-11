//
//  MCBaseViewController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCBaseViewController.h"

@interface MCBaseViewController ()

@end

@implementation MCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)createBack{
    UIImage *back = [UIImage imageNamed:@"back"];
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithImage:back style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor colorWithHexString:@"#6d6d6d"]];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSString *)time:(NSString *)timeStampString{
    NSTimeInterval interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

@end

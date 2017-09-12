//
//  MCToolViewController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCToolViewController.h"
#import "MCDynamicViewController.h"
@interface MCToolViewController ()

@end

@implementation MCToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = BackColor;
         [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self initView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}
- (void)initView{
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, def_width, 350*scaleH)];
    backView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:backView];
    
    UIView* (^roomView)(CGRect ,NSString *,NSString *) = ^(CGRect frame,NSString *text,NSString *imageName){
       
        UIView *roomView = [[UIView alloc]initWithFrame:frame];
        roomView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        roomView.userInteractionEnabled = YES;
        [roomView addGestureRecognizer:tap];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/3, frame.size.height/6, frame.size.width/3, frame.size.width/3)];
//        imageV.backgroundColor = [UIColor blackColor];
        imageV.image = [UIImage imageNamed:imageName];
        [roomView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height/3*2, frame.size.width,  frame.size.height/3)];
        label.textColor = [UIColor blackColor];
        label.text = text;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [roomView addSubview:label];
        [self.view addSubview:roomView];
        return roomView;
        
    };
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"ac",@"notice",@"activity",@"qrcode",@"lingpan",@"living",@"yuyue",@"signin", nil];
    NSArray *nameArr = [NSArray arrayWithObjects:@"动态",@"公告",@"活动",@"二维码报名",@"铃盘共享",@"直播",@"预约记录",@"签到记录", nil];
    for (int i=0; i < 9; i ++) {
        if (i==8) {
            UIView *roomView = [[UIView alloc]initWithFrame:CGRectMake((def_width -2)/3*2 +2, 370*scaleH+(def_width-2)/3/5*4 *2 +2, (def_width-2)/3, (def_width-2)/3/5*4)];
            roomView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:roomView];
        }else{
           UIView *room= roomView(CGRectMake((i % 3) *(def_width -2)/3 +(i%3) , i <3?370*scaleH:i <6?370*scaleH+(def_width -2)/3/5*4 +1:370*scaleH+(def_width-2)/3/5*4 *2 +2 , (def_width-2)/3, (def_width-2)/3/5*4),nameArr[i],imageArr[i]);
            room.tag = i+9999;
           

        }
    }
}
- (void)tapView:(UITapGestureRecognizer *)sender{
      [self.navigationController setNavigationBarHidden:NO animated:NO];
  
     MCDynamicViewController *dy = [[MCDynamicViewController alloc]init];
    switch (sender.self.view.tag -9999) {
        case 0:
            [self.navigationController pushViewController:dy animated:YES];
      
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
            
            
        default:
            break;
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle {
  
    
    return UIStatusBarStyleLightContent;
}


@end

//
//  OrgLoginViewController.h
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,RegisterType)
{
    RegisterTypeUser                = 1, // 普通用户
    RegisterTypeOrg                 = 2, // 机构
    RegisterTypeResetPassword       = 3, // 重置密码
    RegisterTypePhoneNumber         = 4  // 绑定手机号码
};

@interface OrgRegisterViewController : BaseViewController

@property (nonatomic, assign) RegisterType registerType;

@property (nonatomic, copy) NSString *thirdId;
@property (nonatomic, copy) NSString *thirdWay;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *gender;

@end

//
//  OrgRegisterStepFourVC.h
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/13.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,IdentityImageType)
{
    IdentityImageTypeBusinesslicense           = 1,  // 营业执照
    IdentityImageTypeidentityFront             = 2,  // 身份证正面
    IdentityImageTypeidentityOpposite          = 3   // 身份证反面
};

@interface OrgRegisterStepFourVC : BaseViewController

@property (nonatomic, copy) NSString *orgName;             // 机构名称
@property (nonatomic, copy) NSString *orgAddress;          // 机构地址
@property (nonatomic, copy) NSString *phoneNumber;         // 手机号号码  请求参数 email
@property (nonatomic, copy) NSString *teleNumber;          // 座机号码    请求参数 phone
@property (nonatomic, copy) NSString *password;            // 密码
@property (nonatomic, copy) NSString *codeNumber;          // 验证码
@property (nonatomic, copy) NSString *logoStr;             // 机构LOGO 七牛返回的Str
@property (nonatomic, copy) NSArray *resourceListArray;    // 机构风采  七牛返回的Str数组

@end

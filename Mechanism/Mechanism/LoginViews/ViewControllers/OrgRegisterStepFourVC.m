//
//  OrgRegisterStepFourVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/13.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgRegisterStepFourVC.h"
#import "Masonry.h"
#import "Contant.h"
#import "CommonTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Agree.h"
#import "LoginViewController.h"

@interface OrgRegisterStepFourVC () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *businesslicenseButton;   // 营业执照
@property (nonatomic, strong) UILabel *businesslicenseLabel;     // 上传营业执照 label
@property (nonatomic, strong) UIButton *identityFrontButton;     // 身份证正面
@property (nonatomic, strong) UILabel *identityFrontLabel;       // 上传身份证正面照片 label
@property (nonatomic, strong) UIButton *identityOppositeButton;  // 身份证反面
@property (nonatomic, strong) UILabel *identityOppositeLabel;    // 上传身份证反面照片 label
@property (nonatomic, strong) UIButton *finishButton;            // 完成
@property (nonatomic, strong) UIButton *changeButton;            // 切换

@property (nonatomic, assign) BOOL isIdentity;  // 是否上传身份证
@property (nonatomic, assign) IdentityImageType identityImageType; // 选择照片的类型，方便赋值
@property (nonatomic, strong) UIImage *businessImage;   // 营业执照照片
@property (nonatomic, strong) UIImage *frontImage;      // 身份证正面照片
@property (nonatomic, strong) UIImage *oppositeImage;   // 身份证反面照片

@property (nonatomic, copy) NSString *businessStr;      // 营业执照照片 七牛返回的URL
@property (nonatomic, copy) NSString *frontStr;         // 身份证正面照片 七牛返回的URL
@property (nonatomic, copy) NSString *oppositeStr;      // 身份证反面照片 七牛返回的URL

@property (nonatomic, strong) UIButton *rightNavButton;

@end

@implementation OrgRegisterStepFourVC {
    SBJsonParser * parser;
}

- (UIButton *)businesslicenseButton {
    if (!_businesslicenseButton) {
        _businesslicenseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_businesslicenseButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Business_Photo"] forState:UIControlStateNormal];
        [self.view addSubview:_businesslicenseButton];
        [_businesslicenseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(40));
            make.centerX.offset(0);
            make.width.offset(KWIDTH(432));
            make.height.offset(KHEIGHT(290));
        }];
    }
    return _businesslicenseButton;
}

- (UILabel *)businesslicenseLabel {
    if (!_businesslicenseLabel) {
        _businesslicenseLabel = [[UILabel alloc] init];
        _businesslicenseLabel.text = @"上传营业执照";
        _businesslicenseLabel.textColor = [CommonTool colorWithHexString:@"#4a4a4a"];
        _businesslicenseLabel.textAlignment = NSTextAlignmentCenter;
        _businesslicenseLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_businesslicenseLabel];
        __weak typeof(self) weakSelf = self;
        [_businesslicenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(weakSelf.businesslicenseButton.mas_bottom).offset(KHEIGHT(20));
        }];
    }
    return _businesslicenseLabel;
}

- (UIButton *)identityFrontButton {
    if (!_identityFrontButton) {
        _identityFrontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_identityFrontButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_IdentityCard_Front"] forState:UIControlStateNormal];
        [self.view addSubview:_identityFrontButton];
        [_identityFrontButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(40));
            make.centerX.offset(0);
            make.width.offset(KWIDTH(310));
            make.height.offset(KHEIGHT(200));
        }];
    }
    return _identityFrontButton;
}

- (UILabel *)identityFrontLabel {
    if (!_identityFrontLabel) {
        _identityFrontLabel = [[UILabel alloc] init];
        _identityFrontLabel.text = @"上传身份证正面照";
        _identityFrontLabel.textColor = [CommonTool colorWithHexString:@"#4a4a4a"];
        _identityFrontLabel.textAlignment = NSTextAlignmentCenter;
        _identityFrontLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_identityFrontLabel];
        __weak typeof(self) weakSelf = self;
        [_identityFrontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(weakSelf.identityFrontButton.mas_bottom).offset(KHEIGHT(20));
        }];
    }
    return _identityFrontLabel;
}

- (UIButton *)identityOppositeButton {
    if (!_identityOppositeButton) {
        _identityOppositeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_identityOppositeButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_IdentityCard_Opposite"] forState:UIControlStateNormal];
        [self.view addSubview:_identityOppositeButton];
        __weak typeof(self) weakSelf = self;
        [_identityOppositeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.identityFrontButton.mas_bottom).offset(KHEIGHT(90));
            make.centerX.offset(0);
            make.width.offset(KWIDTH(310));
            make.height.offset(KHEIGHT(200));
        }];
    }
    return _identityOppositeButton;
}

- (UILabel *)identityOppositeLabel {
    if (!_identityOppositeLabel) {
        _identityOppositeLabel = [[UILabel alloc] init];
        _identityOppositeLabel.text = @"上传身份证反面照";
        _identityOppositeLabel.textColor = [CommonTool colorWithHexString:@"#4a4a4a"];
        _identityOppositeLabel.textAlignment = NSTextAlignmentCenter;
        _identityOppositeLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_identityOppositeLabel];
        __weak typeof(self) weakSelf = self;
        [_identityOppositeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(weakSelf.identityOppositeButton.mas_bottom).offset(KHEIGHT(20));
        }];
    }
    return _identityOppositeLabel;
}

- (UIButton *)finishButton {
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button"] forState:UIControlStateNormal];
        [_finishButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button_Select"] forState:UIControlStateSelected];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_finishButton];
        __weak typeof(self) weakSelf = self;
        [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.businesslicenseButton.mas_bottom).offset(KHEIGHT(100));
            make.centerX.offset(0);
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(90));
        }];
        
        UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [agreeButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Selected"] forState:UIControlStateNormal];
        [self.view addSubview:agreeButton];
        [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_finishButton);
            make.top.equalTo(_finishButton.mas_bottom).offset(KHEIGHT(20));
            make.width.offset(KWIDTH(30));
            make.height.offset(KHEIGHT(30));
        }];
        
        UILabel *agreeLabel = [[UILabel alloc] init];
        agreeLabel.text = @"点击完成即代表同意";
        agreeLabel.textColor = KDarkGrayColor;
        agreeLabel.textAlignment = NSTextAlignmentLeft;
        agreeLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
        [self.view addSubview:agreeLabel];
        [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(agreeButton.mas_right).offset(KWIDTH(5));
            make.centerY.equalTo(agreeButton);
        }];
        
        UIButton *serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [serviceButton setTitle:@"《铃铃服务协议》" forState:UIControlStateNormal];
        [serviceButton setTitleColor:[CommonTool colorWithHexString:@"#4990e2"] forState:UIControlStateNormal];
        serviceButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
        [serviceButton addTarget:self action:@selector(serviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:serviceButton];
        [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(agreeLabel.mas_right);
            make.centerY.equalTo(agreeLabel);
            make.height.offset(KHEIGHT(70));
        }];


    }
    return _finishButton;
}

- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeButton setImage:[UIImage imageNamed:@"Org_Register_IdentityCard"] forState:UIControlStateNormal];
        [self.view addSubview:_changeButton];
        [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(KHEIGHT(-60));
            make.width.offset(KWIDTH(330));
            make.height.offset(KHEIGHT(70));
        }];
    }
    return _changeButton;
}

#pragma mark - 按钮点击事件
// 上传营业执照
- (void)businesslicenseButtonAction:(UIButton *)sender {
    self.identityImageType = IdentityImageTypeBusinesslicense;
    [self addHead];
}

// 完成
- (void)finishButtonAction:(UIButton *)sender {
//    if (self.isIdentity == YES) {
//        if (self.frontImage == nil) {
//            [Util showMesssage:@"请选择身份证正面照片"];
//            return;
//        }
//        if (self.oppositeImage == nil) {
//            [Util showMesssage:@"请选择身份证反面照片"];
//            return;
//        }
//    } else {
//        if (self.businessImage == nil) {
//            [Util showMesssage:@"请选择营业执照照片"];
//            return;
//        }
//    }
    [self uploadToQN];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 铃铃服务协议
- (void)serviceButtonAction:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Agree *agreeVC = (Agree *)[sb instantiateViewControllerWithIdentifier:@"AGREE"];
    NSLog(@"%@", agreeVC);
    [self presentViewController:agreeVC animated:YES completion:nil];
}

// 上传身份证正面
- (void)identityFrontButtonAction:(UIButton *)sender {
    self.identityImageType = IdentityImageTypeidentityFront;
    [self addHead];

}

// 上传身份证反面
- (void)identityOppositeButtonAction:(UIButton *)sender {
    self.identityImageType = IdentityImageTypeidentityOpposite;
    [self addHead];

}

// 切换身份证或者营业执照
- (void)changeButtonAction:(UIButton *)sender {
    if (self.isIdentity == NO) {
        self.businesslicenseButton.hidden = YES;
        self.identityFrontButton.hidden = NO;
        self.identityOppositeButton.hidden = NO;
        self.identityFrontLabel.hidden = NO;
        self.identityOppositeLabel.hidden = NO;
        self.businesslicenseLabel.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [self.finishButton mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.identityOppositeButton.mas_bottom).offset(KHEIGHT(100));
            make.top.equalTo(weakSelf.view).offset(KHEIGHT(630));
        }];
        
        [self.changeButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(KWIDTH(370));
        }];
        [self.changeButton setImage:[UIImage imageNamed:@"Org_Register_Business"] forState:UIControlStateNormal];
        
        self.isIdentity = YES;
    } else {
        self.identityFrontButton.hidden = YES;
        self.identityOppositeButton.hidden = YES;
        self.businesslicenseButton.hidden = NO;
        
        self.identityFrontLabel.hidden = YES;
        self.identityOppositeLabel.hidden = YES;
        self.businesslicenseLabel.hidden = NO;
        
        __weak typeof(self) weakSelf = self;
        NSLog(@"%@", self.businesslicenseButton);
      
        [self.finishButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(KHEIGHT(430));
        }];
        [self.changeButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(KWIDTH(330));
        }];
        [self.changeButton setImage:[UIImage imageNamed:@"Org_Register_IdentityCard"] forState:UIControlStateNormal];
        
        self.isIdentity = NO;
    }
}

#pragma mark - 选择照片
-(void)addHead {
    UIActionSheet  *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    actionSheet.tag = 1000;
    [ actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex0 {
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex0) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限 做一个友好的提示
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相册\n设置>隐私>照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            return ;
        } else {
            //打开相机
        }
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info0 {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    UIImage *image = [info0 objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *smallImage = [Util  imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width*0.2, image.size.height*0.2)];
    
    if (self.identityImageType == IdentityImageTypeBusinesslicense) {
        self.businessImage = smallImage;
        [self.businesslicenseButton setBackgroundImage:smallImage forState:UIControlStateNormal];
    } else if (self.identityImageType == IdentityImageTypeidentityFront) {
        self.frontImage = smallImage;
        [self.identityFrontButton setBackgroundImage:smallImage forState:UIControlStateNormal];
    } else if (self.identityImageType == IdentityImageTypeidentityOpposite) {
        self.oppositeImage = smallImage;
        [self.identityOppositeButton setBackgroundImage:smallImage forState:UIControlStateNormal];
    }
}

#pragma mark - View controller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    parser = [[SBJsonParser alloc] init];

    self.navigationItem.title = @"机构注册";
    self.view.backgroundColor = [CommonTool colorWithHexString:@"#f8f8f8"];
    
    self.rightNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightNavButton setTitle:@"跳过" forState:UIControlStateNormal];
    self.rightNavButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
    [self.rightNavButton setTitleColor:KLabelBlueColor forState:UIControlStateNormal];
    self.rightNavButton.frame = CGRectMake(kLayoutScreenWidth - KHEIGHT(73), KHEIGHT(24), KWIDTH(100), KHEIGHT(50));
    [self.rightNavButton addTarget:self action:@selector(rightNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavButton];
    
    // 隐藏身份证按钮
    self.isIdentity = NO;
    self.identityFrontButton.hidden = YES;
    self.identityOppositeButton.hidden = YES;
    self.identityFrontLabel.hidden = YES;
    self.identityOppositeLabel.hidden = YES;
    self.businesslicenseLabel.hidden = NO;
    // 增加点击事件
    [self.businesslicenseButton addTarget:self action:@selector(businesslicenseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeButton addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.identityFrontButton addTarget:self action:@selector(identityFrontButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.identityOppositeButton addTarget:self action:@selector(identityOppositeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightNavButtonAction:(UIButton *)sender {
    [self upLoadData];
}

#pragma mark - 上传数据
- (void)uploadToQN {
    ////NSLog(@"getResourceList0");
    NSString *token =[ Util getUploadToken];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    if (token) {
        if (self.isIdentity == YES) {
            if (self.frontImage == nil) {
                [self upLoadData];
                return;
            }
            // 传正面
            NSData * data;
            UIImage* image = self.frontImage;
            data = UIImagePNGRepresentation(image);
            [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          self.frontStr = [NSString stringWithFormat:@"%@%@",QiNiu_HOST,key];
                          
                          // 传反面
                          NSData * data;
                          UIImage* image = self.oppositeImage;
                          if (self.oppositeImage == nil) {
                              [self upLoadData];
                              return;
                          }
                          data = UIImagePNGRepresentation(image);
                          
                          [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                                    complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                        self.oppositeStr = [NSString stringWithFormat:@"%@%@",QiNiu_HOST,key];
                                        
                                        [self upLoadData];
                                    } option:nil];

                      } option:nil];

            
        } else {
            NSData * data;
            UIImage* image = self.businessImage;
            if (self.businessImage == nil) {
                [self upLoadData];
                return;
            }
            data = UIImagePNGRepresentation(image);
            
            [upManager putData:data key:[NSString stringWithFormat:@"lingling/%@/%@", [CommonTool currentMonth], [Util getCurrentDate]] token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          self.businessStr = [NSString stringWithFormat:@"%@%@",QiNiu_HOST,key];
                          [self upLoadData];
                      } option:nil];
        }
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Util showMesssage:@"上传失败，请稍后再试"];
    }
    
}

- (void)upLoadData {
    /**
     *name       机构名称
     type       机构类型
     *pic        机构图片（点号“,”分割）
     *logo       机构Logo图片
     disc       机构描述
     *address    机构地址
     contacts   联系人
     phone      电话
     *email      管理员邮件（手机号）
     *password   密码
     *code   验证码
     yztype    验证类型（1：营业执照，2：身份证）
     yzmap    验证图片（点号“,”分割）
     */
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.orgName forKey:@"name"];
    [dict setValue:self.orgAddress forKey:@"address"];
    [dict setValue:self.phoneNumber forKey:@"email"];
    [dict setValue:self.teleNumber forKey:@"phone"];
    [dict setValue:self.password forKey:@"password"];
    [dict setValue:self.codeNumber forKey:@"code"];
    if (self.logoStr.length > 0) {
        [dict setValue:self.logoStr forKey:@"logo"];
    }

    if (self.resourceListArray.count > 0) {
        NSMutableString *string =[[NSMutableString alloc] init];
        for (int i = 0; i < self.resourceListArray.count; i++) {
            [string appendString:[NSString stringWithFormat:@"%@,",[self.resourceListArray objectAtIndex:i]]];
        }
        if (string.length>0) {
            [dict setValue:[string substringToIndex:string.length-1] forKey:@"pic"];
        }
    }
    
    if (self.isIdentity == YES) {
        if (self.frontStr.length > 0 && self.oppositeStr.length > 0) {
            [dict setValue:@"2" forKey:@"yztype"];
            [dict setValue:[NSString stringWithFormat:@"%@,%@", self.frontStr, self.oppositeStr] forKey:@"yzmap"];
        }
    } else {
        if (self.businessStr.length > 0) {
            [dict setValue:@"2" forKey:@"yztype"];
            [dict setValue:self.businessStr forKey:@"yzmap"];
        }
    }
    
    [MusicNetWorkTool POST:@"service/orgRegister2" parameters:dict success:^(id responseObject) {
        NSLog(@"orgRegister %@  %@", responseObject[@"msg"], responseObject);
        NSLog(@"orgRegister dict %@", dict);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObject[@"status"] intValue]==0) {
            [Util showMesssage:dict[@"msg"]];
            
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        } else {
            [Util showMesssage:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"orgRegister error %@", error);
        NSLog(@"orgRegister dict %@", dict);
    }];
    
//    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/orgRegister"];
//    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//    [request addPostValue:self.orgName forKey:@"name"];
//    [request addPostValue:self.orgAddress forKey:@"address"];
//    [request addPostValue:self.phoneNumber forKey:@"email"];
//    [request addPostValue:self.teleNumber forKey:@"phone"];
//    [request addPostValue:self.password forKey:@"password"];
//    [request addPostValue:self.codeNumber forKey:@"code"];
//    [request addPostValue:self.logoStr forKey:@"logo"];
//    
//    NSMutableString *string =[[NSMutableString alloc] init];
//    for (int i = 0; i < self.resourceListArray.count; i++) {
//        [string appendString:[NSString stringWithFormat:@"%@,",[self.resourceListArray objectAtIndex:i]]];
//    }
//    if (string.length>0) {
//        [request addPostValue:[string substringToIndex:string.length-1] forKey:@"pic"];
//    }
//    
//    if (self.isIdentity == YES) {
//        [request addPostValue:@"2" forKey:@"yztype"];
//        [request addPostValue:[NSString stringWithFormat:@"%@,%@", self.frontStr, self.oppositeStr] forKey:@"yzmap"];
//    } else {
//        [request addPostValue:@"1" forKey:@"yztype"];
//        [request addPostValue:self.businessStr forKey:@"yzmap"];
//    }
//    
//    [request startSynchronous];
//    if (request.responseString.length>0) {
//        
//        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self performSelectorOnMainThread:@selector(requestFinished:) withObject:string waitUntilDone:YES];
//        
//    }
//    else{
//        [Util showMesssage:@"出现未知错误，请重试！"];
//    }
    
}

//- (void)requestFinished:(NSString *)aString
//{
//    NSLog(@"requestFinished1%@",aString);
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    NSDictionary *dict = [parser objectWithString:aString ];
//    
//    if ([[dict objectForKey:@"status"] intValue]==0) {
//        [Util showMesssage:dict[@"msg"]];
//        
//        
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
////        [self.navigationController popToRootViewControllerAnimated:YES];
//        
////        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////        [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
//        
//    } else {
//        [Util showMesssage:dict[@"msg"]];
//    }
//}


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

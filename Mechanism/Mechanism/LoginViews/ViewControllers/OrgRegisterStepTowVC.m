//
//  OrgRegisterStepTowVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgRegisterStepTowVC.h"
#import "Masonry.h"
#import "Contant.h"
#import "CommonTool.h"
#import "OrgRegisterStepThreeVC.h"
#import "RegOrg.h"
#import "Agree.h"

@interface OrgRegisterStepTowVC () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) UIView *serviceView;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation OrgRegisterStepTowVC {
    SBJsonParser * parser;

}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"Org_Register_TextField"]];
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(40));
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(120));
        }];
        
        
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.delegate = self;
        
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _codeTextField.placeholder = @"请输入验证码";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(70), KHEIGHT(110))];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(20), KHEIGHT(40), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Rgister_Code"]];
        [leftView addSubview:phoneImageView];
        
        _codeTextField.leftView = leftView;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [imageView addSubview:_codeTextField];
        [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.offset(KHEIGHT(10));
            make.width.offset(KWIDTH(470));
            make.height.offset(KHEIGHT(100));
        }];
        
        
        self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.codeButton setTitleColor:[CommonTool colorWithHexString:@"#4990e2"] forState:UIControlStateNormal];
        self.codeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [imageView addSubview:self.codeButton];
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.top.offset(KHEIGHT(10));
            make.height.offset(KHEIGHT(100));
            make.width.offset(KWIDTH(210));
        }];
    }
    return _codeTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _passwordTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _passwordTextField.delegate = self;
        _passwordTextField.secureTextEntry = YES;
//        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _passwordTextField.placeholder = @"请输入密码(6-12位字符)";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(70), KHEIGHT(110))];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(20), KHEIGHT(40), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Register_Password"]];
        [leftView addSubview:phoneImageView];
        
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_passwordTextField];
        
//        __weak typeof(self) weakSelf = self;
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(180));
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(120));
        }];

    }
    return _passwordTextField;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button"] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button_Select"] forState:UIControlStateSelected];
        switch (self.registerType) {
            case RegisterTypeUser: {
                [_nextButton setTitle:@"完成" forState:UIControlStateNormal];
            }
                break;
            case RegisterTypeOrg: {
                [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
            }
                break;
            case RegisterTypeResetPassword: {
                [_nextButton setTitle:@"登录" forState:UIControlStateNormal];
            }
                break;
            case RegisterTypePhoneNumber: {
                [_nextButton setTitle:@"完成" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }

        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_nextButton];
        
        __weak typeof(self) weakSelf = self;
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.passwordTextField.mas_bottom).offset(KHEIGHT(40));
            make.left.equalTo(weakSelf.passwordTextField.mas_left);
            make.right.equalTo(weakSelf.passwordTextField.mas_right);
            make.height.offset(KHEIGHT(90));
        }];
    }
    return _nextButton;
}

- (UIView *)serviceView {
    if (!_serviceView) {
        UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [agreeButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Selected"] forState:UIControlStateNormal];
        [self.view addSubview:agreeButton];
        __weak typeof(self) weakSelf = self;
        [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.nextButton);
            make.top.equalTo(weakSelf.nextButton.mas_bottom).offset(KHEIGHT(20));
            make.width.offset(KWIDTH(30));
            make.height.offset(KHEIGHT(30));
        }];
        
        UILabel *agreeLabel = [[UILabel alloc] init];
        agreeLabel.text = @"点击完成即代表同意";
        agreeLabel.textColor = [CommonTool colorWithHexString:@"#4a4a4a"];
        agreeLabel.textAlignment = NSTextAlignmentLeft;
        agreeLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:agreeLabel];
        [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(agreeButton.mas_right).offset(KWIDTH(5));
            make.top.equalTo(agreeButton);
        }];
        
        UIButton *serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [serviceButton setTitle:@"《铃铃服务协议》" forState:UIControlStateNormal];
        [serviceButton setTitleColor:[CommonTool colorWithHexString:@"#4990e2"] forState:UIControlStateNormal];
        serviceButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [serviceButton addTarget:self action:@selector(serviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:serviceButton];
        [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(agreeLabel.mas_right);
            make.top.equalTo(weakSelf.nextButton.mas_bottom);
            make.height.offset(KHEIGHT(70));
        }];
    }
    return _serviceView;
}

#pragma mark - View controller life cycle
- (void)viewWillAppear:(BOOL)animated {
    [self.codeTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.passwordTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    parser = [[SBJsonParser alloc] init];

    self.codeTextField.delegate = self; //  为了调用懒加载
    
    switch (self.registerType) {
        case RegisterTypeUser: {
            self.navigationItem.title = @"用户注册";
            self.serviceView.hidden = NO;
        }
            break;
        case RegisterTypeOrg: {
            self.navigationItem.title = @"机构注册";
//            self.serviceView.hidden = YES;
        }
            break;
        case RegisterTypeResetPassword: {
            self.navigationItem.title = @"密码重置";
//            self.serviceView.hidden = YES;
        }
            break;
        case RegisterTypePhoneNumber: {
            self.navigationItem.title = @"绑定手机号码";
            self.serviceView.hidden = NO;
        }
            break;
        default:
            break;
    }
    self.view.backgroundColor = [CommonTool colorWithHexString:@"#f8f8f8"];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KHEIGHT(270) - 64 , [UIScreen mainScreen].bounds.size.width, KHEIGHT(270))];
    [bottomImageView setImage:[UIImage imageNamed:@"Org_Register_Background"]];
    [self.view addSubview:bottomImageView];
    
    [self.codeButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self successAction];

}

#pragma mark - 按钮点击事件
// 铃铃服务协议
- (void)serviceButtonAction:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Agree *agreeVC = (Agree *)[sb instantiateViewControllerWithIdentifier:@"AGREE"];
    NSLog(@"%@", agreeVC);
    [self presentViewController:agreeVC animated:YES completion:nil];
}

- (void)nextButtonAction:(UIButton *)sender {
    if (self.codeTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"验证码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 12) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码长度必须为6-12位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    // TODO:
    // 校验验证码
    [self conformCode];
    
//    OrgRegisterStepThreeVC *orgRegisterThreeVC = [[OrgRegisterStepThreeVC alloc] init];
//    orgRegisterThreeVC.phoneNum = self.phoneNum;
//    orgRegisterThreeVC.passWordNum = self.passwordTextField.text;
//    orgRegisterThreeVC.codeNum = self.codeTextField.text;
//    [self.navigationController pushViewController:orgRegisterThreeVC animated:YES];

}

- (void)codeButtonAction:(UIButton *)sender {
    // 重新获取验证码
    [self getCode];
    [self successAction];
}

// 获取验证码
- (void)getCode {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.phoneNum forKey:@"phone"];
    switch (self.registerType) {
        case RegisterTypeUser: {
            [dict setValue:@"0" forKey:@"type"];
        }
            break;
        case RegisterTypeOrg: {
            [dict setValue:@"3" forKey:@"type"];
        }
            break;
        case RegisterTypeResetPassword: {
            [dict setValue:@"1" forKey:@"type"];
        }
            break;
        case RegisterTypePhoneNumber: {
            [dict setValue:@"0" forKey:@"type"];
        }
            break;
        default:
            break;
    }
    [MusicNetWorkTool POST:@"service/sendSms" parameters:dict success:^(id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        
    }];
    
//    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/sendSms"];
//    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//    
//    switch (self.registerType) {
//        case RegisterTypeUser: {
//            [request addPostValue:@"0" forKey:@"type"];
//        }
//            break;
//        case RegisterTypeOrg: {
//            [request addPostValue:@"3" forKey:@"type"];
//        }
//            break;
//        case RegisterTypeResetPassword: {
//            [request addPostValue:@"1" forKey:@"type"];
//        }
//            break;
//        case RegisterTypePhoneNumber: {
//            [request addPostValue:@"0" forKey:@"type"];
//        }
//            break;
//        default:
//            break;
//    }
//    
////    [request addPostValue:@"3" forKey:@"type"];
//    [request addPostValue:self.phoneNum forKey:@"phone"];
//    
//    [request startSynchronous];
//    if (request.responseString.length>0) {
//        
//        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//        
//        [self performSelectorOnMainThread:@selector(requestFinished:) withObject:string waitUntilDone:YES];
//        
//    }
//    else{
//        [Util showMesssage:@"出现未知错误，请重试！"];
//    }
}

- (void)requestFinished:(NSString *)aString
{
    NSLog(@"requestFinished1%@",aString);
    
    NSDictionary *dict = [parser objectWithString:aString ];
    
    if ([[dict objectForKey:@"status"] intValue]==0) {
        
        
    } else {
        
    }
}

// 下一步  完成  重置
- (void)conformCode {
    switch (self.registerType) {
        case RegisterTypeUser: {
//            NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/register"];
//            
//            ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//            [request addPostValue:self.phoneNum  forKey:@"phone"];
//            [request addPostValue:self.passwordTextField.text  forKey:@"password"];
//            [request addPostValue:self.codeTextField.text  forKey:@"code"];
////            [request addPostValue:thirdID forKey:@"thirdId"];
//            
//            [request startSynchronous];
//            if (request.responseString.length>0) {
//                NSString *reStr = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//                [self performSelectorOnMainThread:@selector(registerRequestFinish:) withObject:reStr waitUntilDone:YES];
//                
//            }
//            else{
//                [Util showMesssage:@"出现未知错误，请重试！"];
//            }
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:self.phoneNum forKey:@"phone"];
            [dict setValue:self.passwordTextField.text forKey:@"password"];
            [dict setValue:self.codeTextField.text forKey:@"code"];
            [MusicNetWorkTool POST:@"service/register" parameters:dict success:^(id responseObject) {
                if ([[responseObject objectForKey:@"status"] intValue]==0) {
                    [DataManager writeDictionary:[responseObject objectForKey:@"user"] ToFile:@"user"];
                    //            [DataManager writeDictionary:[nil objectForKey:@"user"] ToFile:@"user"];
                    [DataManager setNSString:@"YES" forKey:@"isLogin"];
                    NSDictionary *userDict = [responseObject objectForKey:@"user"];
                    [DataManager setNSString:[userDict objectForKey:@"key"]  forKey:@"userKey"];
                    
                    ChooseInterestVC *chooseVC = [[ChooseInterestVC alloc] init];
                    [self.navigationController pushViewController:chooseVC animated:YES];
                    
                    //            OrgListVC *orgListVC = [[OrgListVC alloc] init];
                    //            orgListVC.type = 3;
                    //            orgListVC.navTitle = @"推荐机构";
                    //            orgListVC.buttonTitle = @"加入机构";
                    //            [self.navigationController pushViewController:orgListVC animated:YES];
                    
                    
                    // REGORG
                    //            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    //            RegOrg *regOrgVC = (RegOrg *)[sb instantiateViewControllerWithIdentifier:@"REGORG"];
                    ////            NSLog(@"%@", regOrgVC);
                    //            [self.navigationController pushViewController:regOrgVC animated:NO];
                    
                }
                
                else{
                    [Util showMesssage:[responseObject objectForKey:@"msg"] ];
                }
            } failure:^(NSError *error) {
                
            }];
        }
            break;
        case RegisterTypePhoneNumber: {
//            NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/register"];
//            
//            ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//            [request addPostValue:self.phoneNum  forKey:@"phone"];
//            [request addPostValue:self.passwordTextField.text  forKey:@"password"];
//            [request addPostValue:self.codeTextField.text  forKey:@"code"];
//            [request addPostValue:self.thirdId forKey:@"thirdId"];
//             NSLog(@"thirdWay = %@", self.thirdWay);
//            [request addPostValue:self.thirdWay forKey:@"thirdWay"];
//            [request addPostValue:self.name forKey:@"name"];
//            [request addPostValue:self.pic forKey:@"pic"];
//            [request addPostValue:self.gender forKey:@"sex"];
//
//            [request startSynchronous];
//            if (request.responseString.length>0) {
//                NSString *reStr = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//                [self performSelectorOnMainThread:@selector(registerRequestFinish:) withObject:reStr waitUntilDone:YES];
//                
//            }
//            else{
//                [Util showMesssage:@"出现未知错误，请重试！"];
//            }
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:self.phoneNum forKey:@"phone"];
            [dict setValue:self.passwordTextField.text forKey:@"password"];
            [dict setValue:self.codeTextField.text forKey:@"code"];
            [dict setValue:self.thirdId forKey:@"thirdId"];
            [dict setValue:self.thirdWay forKey:@"thirdWay"];
            [dict setValue:self.name forKey:@"name"];
            [dict setValue:self.pic forKey:@"pic"];
            [dict setValue:self.gender forKey:@"sex"];
            [MusicNetWorkTool POST:@"service/register" parameters:dict success:^(id responseObject) {
                if ([[responseObject objectForKey:@"status"] intValue]==0) {
                    [DataManager writeDictionary:[responseObject objectForKey:@"user"] ToFile:@"user"];
                    [DataManager setNSString:@"YES" forKey:@"isLogin"];
                    NSDictionary *userDict = [responseObject objectForKey:@"user"];
                    [DataManager setNSString:[userDict objectForKey:@"key"]  forKey:@"userKey"];
                    
                    ChooseInterestVC *chooseVC = [[ChooseInterestVC alloc] init];
                    [self.navigationController pushViewController:chooseVC animated:YES];
                }
                
                else{
                    [Util showMesssage:[responseObject objectForKey:@"msg"] ];
                }
            } failure:^(NSError *error) {
                
            }];
        }
            break;
        case RegisterTypeOrg: {
//            NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/checkSmsCode"];
//            ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//            [request addPostValue:self.codeTextField.text forKey:@"code"];
//            [request addPostValue:self.phoneNum forKey:@"phone"];
//            [request startSynchronous];
//            if (request.responseString.length>0) {
//                
//                NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//                
//                [self performSelectorOnMainThread:@selector(conformFinished:) withObject:string waitUntilDone:YES];
//                
//            }
//            else{
//                [Util showMesssage:@"出现未知错误，请重试！"];
//            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:self.phoneNum forKey:@"phone"];
            [dict setValue:self.codeTextField.text forKey:@"code"];
            [MusicNetWorkTool POST:@"service/checkSmsCode" parameters:dict success:^(id responseObject) {
                if ([[responseObject objectForKey:@"status"] intValue]==0) {
                    OrgRegisterStepThreeVC *orgRegisterThreeVC = [[OrgRegisterStepThreeVC alloc] init];
                    orgRegisterThreeVC.phoneNum = self.phoneNum;
                    orgRegisterThreeVC.passWordNum = self.passwordTextField.text;
                    orgRegisterThreeVC.codeNum = self.codeTextField.text;
                    [self.navigationController pushViewController:orgRegisterThreeVC animated:YES];
                    
                } else {
                    [Util showMesssage:responseObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                [Util showMesssage:@"出现未知错误，请重试！"];
            }];
            
        }
            break;
        case RegisterTypeResetPassword: {
//            NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/forget"];
//            
//            ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//            [request addPostValue:self.phoneNum  forKey:@"phone"];
//            [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
//            [request addPostValue:self.codeTextField.text  forKey:@"code"];
//            [request addPostValue:self.passwordTextField.text  forKey:@"newPassword"];
//            
//            [request startSynchronous];
//            if (request.responseString.length>0) {
//                
//                NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//                
//                //        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
//                [self performSelectorOnMainThread:@selector(forgetPasswordFinish:) withObject:string waitUntilDone:YES];
//                
//            }
//            else{
//                [Util showMesssage:@"出现未知错误，请重试！"];
//            }
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:self.phoneNum forKey:@"phone"];
            [dict setValue:self.codeTextField.text forKey:@"code"];
            [dict setValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
            [dict setValue:self.passwordTextField.text forKey:@"newPassword"];
            [MusicNetWorkTool POST:@"service/forget" parameters:dict success:^(id responseObject) {
                if ([[responseObject objectForKey:@"status"] intValue]==0) {
                    [Util showMesssage:[responseObject objectForKey:@"msg"]];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
                else{
                    [Util showMesssage:[responseObject objectForKey:@"msg"] ];
                    
                }
            } failure:^(NSError *error) {
                [Util showMesssage:@"出现未知错误，请重试！"];
            }];
        }
            break;
        default:
            break;
    }
}
// 完成  注册
- (void)registerRequestFinish:(NSString *)aString {
    NSLog(@"login%@",aString);
    if ([[parser objectWithString:aString]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dic = [parser objectWithString:aString ];
        
        if ([[dic objectForKey:@"status"] intValue]==0) {
            [DataManager writeDictionary:[dic objectForKey:@"user"] ToFile:@"user"];
//            [DataManager writeDictionary:[nil objectForKey:@"user"] ToFile:@"user"];
            [DataManager setNSString:@"YES" forKey:@"isLogin"];
            NSDictionary *userDict = [dic objectForKey:@"user"];
            [DataManager setNSString:[userDict objectForKey:@"key"]  forKey:@"userKey"];
            
            ChooseInterestVC *chooseVC = [[ChooseInterestVC alloc] init];
            [self.navigationController pushViewController:chooseVC animated:YES];
            
//            OrgListVC *orgListVC = [[OrgListVC alloc] init];
//            orgListVC.type = 3;
//            orgListVC.navTitle = @"推荐机构";
//            orgListVC.buttonTitle = @"加入机构";
//            [self.navigationController pushViewController:orgListVC animated:YES];
            
            
            // REGORG
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            RegOrg *regOrgVC = (RegOrg *)[sb instantiateViewControllerWithIdentifier:@"REGORG"];
////            NSLog(@"%@", regOrgVC);
//            [self.navigationController pushViewController:regOrgVC animated:NO];
            
        }
        
        else{
            [Util showMesssage:[dic objectForKey:@"msg"] ];
        }
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
}

// 下一步 校验验证码
- (void)conformFinished:(NSString *)aString {
    NSLog(@"requestFinished1%@",aString);
    
    NSDictionary *dict = [parser objectWithString:aString ];
    
    if ([[dict objectForKey:@"status"] intValue]==0) {
        OrgRegisterStepThreeVC *orgRegisterThreeVC = [[OrgRegisterStepThreeVC alloc] init];
        orgRegisterThreeVC.phoneNum = self.phoneNum;
        orgRegisterThreeVC.passWordNum = self.passwordTextField.text;
        orgRegisterThreeVC.codeNum = self.codeTextField.text;
        [self.navigationController pushViewController:orgRegisterThreeVC animated:YES];
        
    } else {
        [Util showMesssage:dict[@"msg"]];
    }
}

// 重置密码
- (void)forgetPasswordFinish:(NSString *)aString {
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dict = [parser objectWithString:aString ];
        
        if ([[dict objectForKey:@"status"] intValue]==0) {
            [Util showMesssage:[dict objectForKey:@"msg"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        else{
            [Util showMesssage:[dict objectForKey:@"msg"] ];
            
        }
        
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }

}

-(void)successAction {
    _codeButton.enabled =NO;
    _count = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
}

-(void)countTime {
    if (_count>0) {
        [_codeButton setTitle:[NSString stringWithFormat:@"重新获取(%ld)",_count] forState:UIControlStateNormal];
        _count--;
        
    }
    else{
        [_codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _codeButton.enabled=YES;
        [_timer invalidate];
    }
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

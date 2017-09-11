//
//  LoginViewController.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/12.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "Contant.h"
#import "CommonTool.h"
#import <UMSocialCore/UMSocialCore.h>
#import "OrgSelect.h"
#import "OrgRegisterViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *loginWithQQButton;
@property (nonatomic, strong) UIButton *loginWithWechatButton;
@property (nonatomic, strong) UIButton *loginWithWeiboButton;

@end

@implementation LoginViewController {
    BOOL isThird;
    NSMutableString *reString;
    NSString *thirdWay;
    NSString *openID;
    
    NSString *name;
    NSString *pic;
    NSString *gender;
    
    SBJsonParser * parser;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        
        // 玲玲LOGO
        UIImageView *logoImageView = [[UIImageView alloc] init];
        [logoImageView setImage:[UIImage imageNamed:@"Login_logo"]];
        [self.view addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(48));
            make.centerX.offset(0);
            make.width.offset(KWIDTH(179));
            make.height.offset(KHEIGHT(115));
        }];
        
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _phoneTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _phoneTextField.delegate = self;
        
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _phoneTextField.placeholder = @"请输入手机号";
        
        UIView *frontView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(185), KHEIGHT(110))];
        frontView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(22), KHEIGHT(34), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Register_PhoneNum"]];
        [frontView addSubview:phoneImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH(80), KHEIGHT(0), KWIDTH(100), KHEIGHT(110));
        [button setTitle:@"+86" forState:UIControlStateNormal];
        [button setTitleColor:[CommonTool colorWithHexString:@"4a4a4a"] forState:UIControlStateNormal];
        [frontView addSubview:button];
        
        _phoneTextField.leftView = frontView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_phoneTextField];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logoImageView.mas_bottom).offset(KHEIGHT(115));
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(120));
        }];
        

    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _passwordTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _passwordTextField.delegate = self;
        _passwordTextField.secureTextEntry = YES;
        //        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
//        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _passwordTextField.placeholder = @"请输入密码";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(5), KWIDTH(70), KHEIGHT(110))];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(20), KHEIGHT(30), KWIDTH(40), KHEIGHT(40))];
        [phoneImageView setImage:[UIImage imageNamed:@"Org_Register_Password"]];
        [leftView addSubview:phoneImageView];
        
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        [self.view addSubview:_passwordTextField];
        
        __weak typeof(self) weakSelf = self;
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.phoneTextField.mas_bottom).offset(KHEIGHT(20));
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(120));
        }];
        UIButton *fogotPWDButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fogotPWDButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [fogotPWDButton setTitleColor:[CommonTool colorWithHexString:@"#4990e2"] forState:UIControlStateNormal];
        fogotPWDButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
        [fogotPWDButton addTarget:self action:@selector(fogotPassword:) forControlEvents:UIControlEventTouchUpInside];
        [_passwordTextField addSubview:fogotPWDButton];
        [fogotPWDButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.bottom.offset(0);
            make.right.offset(KWIDTH(-20));
            make.left.equalTo(_passwordTextField.mas_right).offset(KWIDTH(-178));
        }];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button"] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button_Select"] forState:UIControlStateSelected];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_loginButton];
        
        __weak typeof(self) weakSelf = self;
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.passwordTextField.mas_bottom).offset(KHEIGHT(40));
            make.left.equalTo(weakSelf.passwordTextField.mas_left);
            make.right.equalTo(weakSelf.passwordTextField.mas_right);
            make.height.offset(KHEIGHT(90));
        }];
    }
    return _loginButton;
}

- (UIButton *)loginWithQQButton {
    if (!_loginWithQQButton) {
        UIImageView *thirdLoginImageView = [[UIImageView alloc] init];
        [thirdLoginImageView setImage:[UIImage imageNamed:@"Login_Third"]];
        [self.view addSubview:thirdLoginImageView];
        [thirdLoginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(KHEIGHT(-168));
            make.width.offset(KWIDTH(586));
            make.height.offset(KHEIGHT(30));
        }];
        _loginWithQQButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginWithQQButton setBackgroundImage:[UIImage imageNamed:@"Login_QQ"] forState:UIControlStateNormal];
        [self.view addSubview:_loginWithQQButton];
        [_loginWithQQButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KWIDTH(90));
            make.top.equalTo(thirdLoginImageView.mas_bottom).offset(KHEIGHT(40));
            make.width.offset(KWIDTH(86));
            make.height.offset(KHEIGHT(68));
        }];
    }
    return _loginWithQQButton;
}

- (UIButton *)loginWithWechatButton {
    if (!_loginWithWechatButton) {
        _loginWithWechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginWithWechatButton setBackgroundImage:[UIImage imageNamed:@"Login_Wechat"] forState:UIControlStateNormal];
        [self.view addSubview:_loginWithWechatButton];
        __weak typeof(self) weakSelf = self;
        [_loginWithWechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(weakSelf.loginWithQQButton);
            make.width.offset(KWIDTH(82));
            make.height.offset(KHEIGHT(68));
        }];
    }
    return _loginWithWechatButton;
}

- (UIButton *)loginWithWeiboButton {
    if (!_loginWithWeiboButton) {
        _loginWithWeiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginWithWeiboButton setBackgroundImage:[UIImage imageNamed:@"Login_Weibo"] forState:UIControlStateNormal];
        [self.view addSubview:_loginWithWeiboButton];
        __weak typeof(self) weakSelf = self;
        [_loginWithWeiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(KWIDTH(-90));
            make.top.equalTo(weakSelf.loginWithQQButton);
            make.width.offset(KWIDTH(86));
            make.height.offset(KHEIGHT(68));
        }];
    }
    return _loginWithWeiboButton;
}

#pragma mark - 按钮点击事件
// 忘记密码
- (void)fogotPassword:(UIButton *)sender {
//    isReg = NO;
//    [self performSegueWithIdentifier:@"Register" sender:nil];
    OrgRegisterViewController *orgRegisterVC = [[OrgRegisterViewController alloc] init];
    orgRegisterVC.registerType = RegisterTypeResetPassword;
    [self.navigationController pushViewController:orgRegisterVC animated:YES];
    
}

// 登录
- (void)loginButtonAction:(UIButton *)sender {
    if (self.phoneTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (![Util checkTelNumber:self.phoneTextField.text])
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.passwordTextField.text.length < 6||self.passwordTextField.text.length > 12) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码长度在6位到12位之间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    isThird = NO;
    [self startGetData];
}

-(void)startGetData
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //    HUD.frame =CGRectMake(0, 0, 240, 240);
    HUD.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中...";
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(getResourceList) onTarget:self withObject:nil animated:YES];
}
-(void)getResourceList{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.phoneTextField.text forKey:@"phone"];
    [dict setValue:self.passwordTextField.text forKey:@"password"];
    if (isThird) {
        [dict setValue:openID forKey:@"thirdId"];
    }
    
    [MusicNetWorkTool POST:@"service/login" parameters:dict success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            [Util showMesssage:[responseObject objectForKey:@"msg"]];
            
            [DataManager writeDictionary:[responseObject objectForKey:@"user"] ToFile:@"user"];
            [DataManager setNSString:@"YES" forKey:@"isLogin"];
            [DataManager setNSString:self.passwordTextField.text forKey:@"password"];
            NSDictionary *userDict = [responseObject objectForKey:@"user"];
            [DataManager setNSString:[userDict objectForKey:@"key"]  forKey:@"userKey"];
            
            NSLog(@"user dict ---- %@", [DataManager mutableDictionaryFromFile:@"user"]);
            NSLog(@"count : %ld", [[responseObject objectForKey:@"org"] count]);
            
            if ([[responseObject objectForKey:@"org"] count] > 1) {
                //                [list setArray:[dic objectForKey:@"org"]];
                
                [DataManager writeArray:[responseObject objectForKey:@"org"] ToFile:@"orgList"];
                OrgListVC *orgListVC = [[OrgListVC alloc] init];
                orgListVC.type = 2;
                orgListVC.navTitle = @"选择机构";
                orgListVC.buttonTitle = @"立即进入";
                [self.navigationController pushViewController:orgListVC animated:YES];
            } else  if ([[responseObject objectForKey:@"org"] count] == 1) {
                
                [DataManager writeDictionary:[[responseObject objectForKey:@"org"] objectAtIndex:0]  ToFile:@"org"];
                // TODO: 从引导页登录
                [self.phoneTextField resignFirstResponder];
                [self.passwordTextField resignFirstResponder];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                [self.phoneTextField resignFirstResponder];
                [self.passwordTextField resignFirstResponder];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginDoneNotification" object:nil];
            
        } else {
            
            if (isThird&&[[responseObject objectForKey:@"msg"] isEqualToString:@"用户不存在"]) {
                //                [self performSegueWithIdentifier:@"Register" sender:nil];
                OrgRegisterViewController *orgRegisterVC = [[OrgRegisterViewController alloc] init];
                
                NSLog(@"thirdWay = %@", thirdWay);
                
                orgRegisterVC.registerType = RegisterTypePhoneNumber;
                orgRegisterVC.thirdId = openID;
                orgRegisterVC.thirdWay = thirdWay;
                orgRegisterVC.name = name;
                orgRegisterVC.pic = pic;
                if ([gender isEqualToString:@"男"]) {
                    orgRegisterVC.gender = @"0";
                } else if ([gender isEqualToString:@"女"]) {
                    orgRegisterVC.gender = @"1";
                } else {
                    orgRegisterVC.gender = @"2";
                }
                [self.navigationController pushViewController:orgRegisterVC animated:YES];
            }
            else{
                [Util showMesssage:[responseObject objectForKey:@"msg"] ];
                
            }
            
            //            [Util showMesssage:[dic objectForKey:@"msg"] ];
            
        }
    } failure:^(NSError *error) {
        [Util showMesssage:@"请求失败，请稍后再试"];
    }];
    
//    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/login"];
//    
//    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//    [request addPostValue: self.phoneTextField.text  forKey:@"phone"];
//    [request addPostValue: self.passwordTextField.text  forKey:@"password"];
//    
//    if (isThird) {
//        NSLog(@"openID === %@",openID);
//        [request addPostValue: openID  forKey:@"thirdId"];
//        
//    }
//    
////    NSLog(@"registrationID==%@",[JPUSHService registrationID]);
////    if ([JPUSHService registrationID] ) {
////        [request addPostValue: [JPUSHService registrationID]  forKey:@"pushId"];
////    }
//    NSLog(@"%@", request);
//    
//    [request startSynchronous];
//    if (request.responseString.length>0) {
//        
//        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
//        
//        //        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
//        [self performSelectorOnMainThread:@selector(requestFinished:) withObject:string waitUntilDone:YES];
//        
//    }
//    else{
//        [Util showMesssage:@"出现未知错误，请重试！"];
//    }
    
    
}


- (void)requestFinished:(NSString *)aString {
    
    NSLog(@"login=====%@",aString);
        NSLog(@"kkkkkkkkkk%@", [parser objectWithString:aString ]);
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]]) {
        NSDictionary *dic = [parser objectWithString:aString ];
        
        if ([[dic objectForKey:@"status"] intValue] == 0) {
            [Util showMesssage:[dic objectForKey:@"msg"]];
            
            [DataManager writeDictionary:[dic objectForKey:@"user"] ToFile:@"user"];
            [DataManager setNSString:@"YES" forKey:@"isLogin"];
            [DataManager setNSString:self.passwordTextField.text forKey:@"password"];
            NSDictionary *userDict = [dic objectForKey:@"user"];
            [DataManager setNSString:[userDict objectForKey:@"key"]  forKey:@"userKey"];

            NSLog(@"user dict ---- %@", [DataManager mutableDictionaryFromFile:@"user"]);
            NSLog(@"count : %ld", [[dic objectForKey:@"org"] count]);
            
            if ([[dic objectForKey:@"org"] count] > 1) {
//                [list setArray:[dic objectForKey:@"org"]];
                
                [DataManager writeArray:[dic objectForKey:@"org"] ToFile:@"orgList"];
//                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                OrgSelect *orgSelectVC = (OrgSelect *)[sb instantiateViewControllerWithIdentifier:@"ORGSELECT"];
//                
//                
//                NSArray* arr = [dic objectForKey:@"org"];
//                [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"org"];
//                
//                NSLog(@"%@", orgSelectVC);
////                [self presentViewController:orgSelectVC animated:YES completion:nil];
//                [self.navigationController pushViewController:orgSelectVC animated:YES];
                OrgListVC *orgListVC = [[OrgListVC alloc] init];
                orgListVC.type = 2;
                orgListVC.navTitle = @"选择机构";
                orgListVC.buttonTitle = @"立即进入";
                [self.navigationController pushViewController:orgListVC animated:YES];
            } else  if ([[dic objectForKey:@"org"] count] == 1) {
                
                [DataManager writeDictionary:[[dic objectForKey:@"org"] objectAtIndex:0]  ToFile:@"org"];
                // TODO: 从引导页登录
                [self.phoneTextField resignFirstResponder];
                [self.passwordTextField resignFirstResponder];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
                [self dismissViewControllerAnimated:YES completion:nil];

            } else {
                [self.phoneTextField resignFirstResponder];
                [self.passwordTextField resignFirstResponder];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginDoneNotification" object:nil];
            
        } else {
            
            if (isThird&&[[dic objectForKey:@"msg"] isEqualToString:@"用户不存在"]) {
//                [self performSegueWithIdentifier:@"Register" sender:nil];
                OrgRegisterViewController *orgRegisterVC = [[OrgRegisterViewController alloc] init];
                
                NSLog(@"thirdWay = %@", thirdWay);
                
                orgRegisterVC.registerType = RegisterTypePhoneNumber;
                orgRegisterVC.thirdId = openID;
                orgRegisterVC.thirdWay = thirdWay;
                orgRegisterVC.name = name;
                orgRegisterVC.pic = pic;
                if ([gender isEqualToString:@"男"]) {
                    orgRegisterVC.gender = @"0";
                } else if ([gender isEqualToString:@"女"]) {
                    orgRegisterVC.gender = @"1";
                } else {
                    orgRegisterVC.gender = @"2";
                }
                [self.navigationController pushViewController:orgRegisterVC animated:YES];
            }
            else{
                [Util showMesssage:[dic objectForKey:@"msg"] ];
                
            }
            
            //            [Util showMesssage:[dic objectForKey:@"msg"] ];
            
        }
        
    }
    else{
        NSLog(@"失败失败");
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
    
}


#pragma mark 第三方登录
// QQ登录
- (void)loginWithQQButtonAction:(UIButton *)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"QQ登录失败");
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ refreshToken: %@", resp.refreshToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            isThird = YES;
            
//            [openID setString:resp.uid];
            openID = resp.uid;
            thirdWay = @"QQ";
            name = resp.name;
            pic = resp.iconurl;
            gender = resp.unionGender;
            
            [self startGetData];
            
        }
    }];
}

// 微信登录
- (void)loginWithWechatButtonAction:(UIButton *)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"微信登录失败");
        } else {
            UMSocialUserInfoResponse *resp = result;
            NSLog(@"result : %@", result);
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            isThird = YES;
            
//            [openID setString:resp.uid];
            openID = resp.openid;
            thirdWay = @"WeiXin";
            name = resp.name;
            pic = resp.iconurl;
            gender = resp.unionGender;
            [self startGetData];
            
        }
    }];
}

// 微博登录
- (void)loginWithWeiboButtonAction:(UIButton *)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"微博登录失败");
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Weibo uid: %@", resp.uid);
            NSLog(@"Weibo openid: %@", resp.openid);
            NSLog(@"Weibo accessToken: %@", resp.accessToken);
            NSLog(@"Weibo refreshToken: %@", resp.refreshToken);
            NSLog(@"Weibo expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Weibo name: %@", resp.name);
            NSLog(@"Weibo iconurl: %@", resp.iconurl);
            NSLog(@"Weibo gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Weibo originalResponse: %@", resp.originalResponse);
            isThird = YES;
            
//            [openID setString:resp.uid];
            openID = resp.uid;
            thirdWay = @"WeiBo";
            name = resp.name;
            pic = resp.iconurl;
            gender = resp.unionGender;
            [self startGetData];
            
        }
    }];
}

#pragma mark - View controller life cycle
- (void)viewWillAppear:(BOOL)animated {
    // 去除navigation bar下面的黑线
    UIColor *color = [CommonTool colorWithHexString:@"#f8f8f8"];
    [self.navigationController.navigationBar setBackgroundImage:[CommonTool imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
//    openID  = [[NSMutableString alloc] init];
    parser = [[SBJsonParser alloc] init];

    [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginWithQQButton addTarget:self action:@selector(loginWithQQButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginWithWechatButton addTarget:self action:@selector(loginWithWechatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginWithWeiboButton addTarget:self action:@selector(loginWithWeiboButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Common_back_button"] style:UIBarButtonItemStyleDone target:self action:@selector(returnBtnTapped:)];
    self.view.backgroundColor = [CommonTool colorWithHexString:@"#f8f8f8"];
}

- (void)returnBtnTapped:(id)sender {
    //    [self.view endEditing:YES];
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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

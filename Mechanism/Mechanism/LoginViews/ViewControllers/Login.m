//
//  Login.m
//  UCreate
//
//  Created by iMobile on 15/12/24.
//  Copyright © 2015年 imobile. All rights reserved.
//

#import "Login.h"
#import "OrgSelect.h"
#import "Register.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MD5Encryption.h"


#import "OrgRegisterViewController.h"
#import "LoginViewController.h"

@interface Login ()
{
    NSMutableString *reString;
    NSMutableString *openID;

    SBJsonParser * parser;
    NSMutableArray  *list;
    
    BOOL isReg;
    BOOL isThird;
}

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registeButton;
@property (nonatomic, strong) UIButton *orgRegisteButton;
@property (nonatomic, strong) UIButton *browseButton;

@end

@implementation Login

- (void)setUpViews {
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenHeight)];
    [backImageView setImage:[UIImage imageNamed:@"Login_background"]];
    [self.view addSubview:backImageView];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake((kLayoutScreenWidth - KWIDTH(500)) / 2, KHEIGHT(866), KWIDTH(500), KHEIGHT(80));
//    self.loginButton.backgroundColor = [UIColor redColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"Login_Button"] forState:UIControlStateNormal];
    self.loginButton.showsTouchWhenHighlighted = YES;
    [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    self.registeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registeButton.frame = CGRectMake((kLayoutScreenWidth - KWIDTH(500)) / 2, KHEIGHT(986), KWIDTH(500), KHEIGHT(80));
//    self.registeButton.backgroundColor = [UIColor redColor];
    [self.registeButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registeButton setBackgroundImage:[UIImage imageNamed:@"Login_Button"] forState:UIControlStateNormal];
    self.registeButton.showsTouchWhenHighlighted = YES;
    [self.registeButton addTarget:self action:@selector(registeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registeButton];
    
    self.orgRegisteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orgRegisteButton.frame = CGRectMake((kLayoutScreenWidth - KWIDTH(500)) / 2, KHEIGHT(1106), KWIDTH(500), KHEIGHT(80));
//    self.orgRegisteButton.backgroundColor = [UIColor redColor];
    [self.orgRegisteButton setTitle:@"机构注册" forState:UIControlStateNormal];
    [self.orgRegisteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.orgRegisteButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.orgRegisteButton.showsTouchWhenHighlighted = YES;
    [self.orgRegisteButton addTarget:self action:@selector(orgRegisteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.orgRegisteButton];
    
    self.browseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.browseButton.frame = CGRectMake((kLayoutScreenWidth - KWIDTH(350)) / 2, kLayoutScreenHeight - KHEIGHT(95), KWIDTH(350), KHEIGHT(80));
//    self.browseButton.backgroundColor = [UIColor redColor];
//    [self.browseButton setTitle:@"先看看 〉" forState:UIControlStateNormal];
//    [self.browseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.browseButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.browseButton.bounds) - KWIDTH(62), CGRectGetMidY(self.browseButton.bounds) - KHEIGHT(15), KWIDTH(100), KWIDTH(30))];
    label.text = @"先看看";
    label.font = [UIFont systemFontOfSize:KWIDTH(30)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.browseButton addSubview:label];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame) + KHEIGHT(5), KWIDTH(12), KHEIGHT(20))];
    [imageView setImage:[UIImage imageNamed:@"Login_scan"]];
    imageView.userInteractionEnabled = YES;
    [self.browseButton addSubview:imageView];
    self.browseButton.showsTouchWhenHighlighted = YES;
    [self.browseButton addTarget:self action:@selector(browseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.browseButton];

}

- (void)loginButtonAction:(UIButton *)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    nVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:nVC animated:YES completion:nil];
}

- (void)registeButtonAction:(UIButton *)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    Register *registeVC = (Register *)[sb instantiateViewControllerWithIdentifier:@"REGISTE"];
//    NSLog(@"%@", registeVC);
//    //    [self.navigationController pushViewController:registeVC animated:YES];
//    [self presentViewController:registeVC animated:YES completion:nil];
//    //    [self performSegueWithIdentifier:@"Register" sender:nil];
    
    OrgRegisterViewController *orgRegisterVC = [[OrgRegisterViewController alloc] init];
    orgRegisterVC.registerType = RegisterTypeUser;
    //    [self.navigationController pushViewController:orgRegisterVC animated:YES];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:orgRegisterVC];
    nVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:nVC animated:YES completion:nil];
}

- (void)orgRegisteButtonAction:(UIButton *)sender {
    OrgRegisterViewController *orgRegisterVC = [[OrgRegisterViewController alloc] init];
    orgRegisterVC.registerType = RegisterTypeOrg;
    //    [self.navigationController pushViewController:orgRegisterVC animated:YES];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:orgRegisterVC];
    nVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:nVC animated:YES completion:nil];
}

- (void)browseButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



//- (IBAction)orgRegister:(UIButton *)sender {
//    OrgRegisterViewController *orgRegisterVC = [[OrgRegisterViewController alloc] init];
////    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:orgRegisterVC];
//////    [self.navigationController pushViewController:orgRegisterVC animated:YES];
////    [self presentViewController:naviVC animated:YES completion:^{
////        
////    }];
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController pushViewController:orgRegisterVC animated:YES];
//}

//-(IBAction)closeAction:(id)sender
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    //    if ([DataManager getNSStringForKey:KUserKey].length > 0) {
    //        _coverView.hidden = NO;
    ////        [self performSegueWithIdentifier:@"NavVC" sender:nil];
    //    }
    //    else{
    //        _coverView.hidden = YES;
    //        
    //    }
    //
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    reString = [[NSMutableString alloc] init];

    parser = [[SBJsonParser alloc] init];
    
//    _pwdText.text =@"123456";
//
//    _acountText.text =@"15801959685";
//    _acountText.keyboardType = UIKeyboardTypeNumberPad;
    /*
    _button.layer.masksToBounds=YES;
    _button.layer.borderColor =[[UIColor colorWithHexString:@"#4A90E2"] CGColor];
    _button.layer.borderWidth =1;
    _button.layer.cornerRadius= 1;
     
     */
    list = [[ NSMutableArray alloc] init];
    openID  = [[NSMutableString alloc] init];
    
//    [self performSegueWithIdentifier:@"NavVC" sender:nil];


    
    if ([DataManager getNSStringForKey:KUserKey].length > 0) {
//        _coverView.hidden = NO;
//        [self performSegueWithIdentifier:@"NavVC" sender:nil];
//        [JPUSHService setAlias:[NSString stringWithFormat:@"JPush%@", [[DataManager mutableDictionaryFromFile:@"profile"]   objectForKey:@"account" ] ] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        
        
        
    }
    
    
//    ////////NSLog(@"hello%@",[NSString stringWithFormat:@"JPush%@", [[DataManager mutableDictionaryFromFile:@"profile"]   objectForKey:@"account" ]] );
//    else{
//        _coverView.hidden = YES;
//
//    }
//

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    // Do any additional setup after loading the view.
}

-(void)tapAction
{
    [self.view endEditing:YES];
}
//         - (void)tagsAliasCallback:(int)iResCode
//                          tags:(NSSet *)tags
//                         alias:(NSString *)alias {
//                             
//                             //    if ([alias isEqualToString:[NSString stringWithFormat:@"m%@",_acountText.text]]) {
//                             //
//                             //
//                             //
//                             //    }
//                             
//                             //    [Util showMesssage:@"设置成功"];
//                             
//                             NSString *callbackString =[NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
//                                                        [self logSet:tags], alias];
//                             ////////NSLog(@"TagsAlias回调:%@", callbackString);
//                         }
//         
//         
//         - (NSString *)logSet:(NSSet *)dic {
//             if (![dic count]) {
//                 return nil;
//             }
//             NSString *tempStr1 =
//             [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                          withString:@"\\U"];
//             NSString *tempStr2 =
//             [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//             NSString *tempStr3 =
//             [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//             NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//             NSString *str =
//             [NSPropertyListSerialization propertyListFromData:tempData
//                                              mutabilityOption:NSPropertyListImmutable
//                                                        format:NULL
//                                              errorDescription:NULL];
//             return str;
//         }










//-(IBAction)registerAction:(id)sender
//{
//    isReg = YES;
//    [self performSegueWithIdentifier:@"Register" sender:nil];
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(IBAction)loginAction:(id)sender
//{
//    [_acountText resignFirstResponder];
//    [_pwdText resignFirstResponder];
//    
//    if (_acountText.text.length==0) {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//        return;
//    }
//    
////    if (![_acountText.text checkPhoneNumInput] )
//          if (![Util checkTelNumber:  _acountText.text] )
//    {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//        return;
//    }
//    
//    
//    if (_pwdText.text.length==0) {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//        return;
//    }
//    if (_pwdText.text.length<6||_pwdText.text.length>12) {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"密码长度在6位到12位之间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//        return;
//    }
//    
//    isThird = NO;
//    [self startGetData];
//    
//}
//-(void)startGetData
//{
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    //    HUD.frame =CGRectMake(0, 0, 240, 240);
//    HUD.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//    HUD.mode = MBProgressHUDModeIndeterminate;
//    HUD.labelText = @"加载中...";
//    [self.view addSubview:HUD];
//    [HUD showWhileExecuting:@selector(getResourceList) onTarget:self withObject:nil animated:YES];
//}
//
//-(IBAction)forgetAction:(id)sender
//{
//    isReg = NO;
//    [self performSegueWithIdentifier:@"Register" sender:nil];
//}
//
//
//-(IBAction)thirdLogin:(id)sender {
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            NSLog(@"微信登录失败");
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            
//            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.unionGender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
//            isThird = YES;
//            
//            [openID setString:resp.uid];
//            
//            [self startGetData];
//
//        }
//    }];
//    
////    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
////                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
////                                       
////                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
////                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
////                                       associateHandler (user.uid, user, user);
////                                       
////                                       
////                                       //
////                                       isThird = YES;
////                                       
////                                       [openID setString:user.uid];
////                                       
////                                       [self startGetData];
////                                       
////                                       //                                       NSLog(@"qquid=%@",user.uid);
////                                       
////                                       //                                       NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:user.icon, @"icon", user.nickname,@"nickname",nil];
////                                       //
////                                       //                                       [DataManager writeDictionary:dictionary ToFile:@"ThirdUser"];
////                                       //
////                                       //                                       [self loginThird:user.uid type:2];
////                                       //
////                                       //                                       [self performSegueWithIdentifier:@"BindRegister" sender:nil];
////                                       
////                                       //                                       [self getResourceList1:@"3" ID: user.uid];
////                                       
////                                       //                                               [self getResourceList1:@"5" ID: user.uid];
////                                       
////                                       //                                               [self getResourceList1:@"3"];
////                                       
////                                       
////                                       
////                                   }
////                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
////                                    
////                                    if (state == SSDKResponseStateSuccess)
////                                    {
//////                                        NSLog(@"登录成功");
////                                        
////                                        //                                                //NSLog(@"uid=%@",user.uid);
////                                        //                                                //NSLog(@"%@",user.credential);
////                                        //                                                //NSLog(@"token=%@",user.credential.token);
////                                        //                                                //NSLog(@"nickname=%@",user.nickname);
////                                        //                                        //判断是否已经在用户列表中，避免用户使用同一账号进行重复登录
////                                        //                                        if (![theController.users containsObject:user])
////                                        //                                        {
////                                        //                                            [theController.users addObject:user];
////                                        //                                        }
////                                        //
////                                        //                                        //刷新表格
////                                        //                                        [theController.tableView reloadData];
////                                    }
////                                    NSLog(@"state :%ld  error : %@", state, error);
////                                    
////                                }];
//    
//    /*
//     
//     [ShareSDK getUserInfo:SSDKPlatformTypeWechat
//     onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//     
//     NSLog(@"SSDKResponseStateSuccess %d",state);
//     if (state == SSDKResponseStateSuccess)
//     {
//     
//     NSLog(@"uid=%@",user.uid);
//     //NSLog(@"%@",user.credential);
//     //NSLog(@"token=%@",user.credential.token);
//     //NSLog(@"nickname=%@",user.nickname);
//     //NSLog(@"icon=%@",user.icon);
//     
//     //             NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:user.icon, @"icon", user.nickname,@"nickname",nil];
//     //
//     isThird = YES;
//     
//     [openID setString:user.uid];
//     
//     [self startGetData];
//     //             [self getResourceList3:user.uid];
//     
//     
//     
//     //             [DataManager writeDictionary:dictionary ToFile:@"ThirdUser"];
//     //
//     //             [self loginThird:user.uid type:0];
//     //                       [self performSegueWithIdentifier:@"BindRegister" sender:nil];
//     
//     //                     [self getResourceList1:@"4" ID:user.uid];
//     }
//     else if (state == SSDKResponseStateFail)
//     {
//     [Util showMesssage:@"第三方登录失败"];
//     }
//     
//     
//     else
//     {
//     ////NSLog(@"%@",error);
//     }
//     
//     }];
//     
//     */
//    
//}
//
//
//
//-(void)getResourceList{
//    
//    //
//    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/login"];
//    
//    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
//    [request addPostValue: _acountText.text  forKey:@"phone"];
//    [request addPostValue: _pwdText.text  forKey:@"password"];
//    
//    if (isThird) {
//        [request addPostValue: openID  forKey:@"thirdId"];
//    }
//    NSLog(@"registrationID==%@",[JPUSHService registrationID]);
//    if ([JPUSHService registrationID] ) {
//        [request addPostValue: [JPUSHService registrationID]  forKey:@"pushId"];
//    }
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
//}
//
//
//- (void)requestFinished:(NSString *)aString
//{ 
//    
//    NSLog(@"login=====%@",aString);
//    NSLog(@"kkkkkkkkkk%@", [parser objectWithString:aString ]);
//    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]]) {
//        NSDictionary *dic = [parser objectWithString:aString ];
//        
//        if ([[dic objectForKey:@"status"] intValue]==0) {
//            [Util showMesssage:[dic objectForKey:@"msg"]];
//            
//            [DataManager writeDictionary:[dic objectForKey:@"user"] ToFile:@"user"];
//            [DataManager setNSString:@"YES" forKey:@"isLogin"];
//            [DataManager setNSString:_pwdText.text forKey:@"password"];
//          
//            NSLog(@"count : %ld", [[dic objectForKey:@"org"] count]);
//            
//            if ([[dic objectForKey:@"org"] count]>1) {
//                [list setArray:[dic objectForKey:@"org"]];
//                
//                [DataManager writeArray:[dic objectForKey:@"org"] ToFile:@"orgList"];
//                [self performSegueWithIdentifier:@"OrgSelect" sender:nil];
//            } else  if ([[dic objectForKey:@"org"] count]==1) {
//                
//                [DataManager writeDictionary:[[dic objectForKey:@"org"] objectAtIndex:0]  ToFile:@"org"];
//
//                [self dismissViewControllerAnimated:YES completion:nil];
//
//            }
//            else{
//                [self dismissViewControllerAnimated:YES completion:nil];
//
//            }
//            
//            
//            NSArray* arr = [dic objectForKey:@"org"];
//            [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"org"];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginDoneNotification" object:nil];
//
//        }
//        
//        else{
//            
//            if (isThird&&[[dic objectForKey:@"msg"] isEqualToString:@"用户不存在"]) {
//                [self performSegueWithIdentifier:@"Register" sender:nil];
//
//            }
//            else{
//                [Util showMesssage:[dic objectForKey:@"msg"] ];
//
//            }
//            
////            [Util showMesssage:[dic objectForKey:@"msg"] ];
//            
//        }
//        
//    }
//    else{
//        NSLog(@"失败失败");
//        [Util showMesssage:@"请求失败，请稍后再试"];
//    }
//    
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    return YES;
}

/*
-(IBAction)smallAction:(UIButton *)button
{
    
              ////////NSLog(@"%d",button.tag);
    switch (button.tag) {
            
  
            
        case 0:
        {
            [ShareSDK getUserInfo:SSDKPlatformTypeWechat
                   onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
             {
                 if (state == SSDKResponseStateSuccess)
                 {
                     
                     ////////NSLog(@"uid=%@",user.uid);
                     ////////NSLog(@"%@",user.credential);
                     ////////NSLog(@"token=%@",user.credential.token);
                     ////////NSLog(@"nickname=%@",user.nickname);
                     
                     [self getResourceList1:@"4" ID:user.uid];
                 }
                 
                 else
                 {
                     ////////NSLog(@"%@",error);
                 }
                 
             }];
            

        }
            break;

        case 1:
            [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                           onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                               
                                               //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                               //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                               associateHandler (user.uid, user, user);
                                                  ////////NSLog(@"qquid=%@",user.uid);
//                                               [self getResourceList1:@"3"];

                                               
                                               
                                           }
                                        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                            
                                            if (state == SSDKResponseStateSuccess)
                                            {
                                                
//                                                ////////NSLog(@"uid=%@",user.uid);
//                                                ////////NSLog(@"%@",user.credential);
//                                                ////////NSLog(@"token=%@",user.credential.token);
//                                                ////////NSLog(@"nickname=%@",user.nickname);
                                                //                                        //判断是否已经在用户列表中，避免用户使用同一账号进行重复登录
                                                //                                        if (![theController.users containsObject:user])
                                                //                                        {
                                                //                                            [theController.users addObject:user];
                                                //                                        }
                                                //
                                                //                                        //刷新表格
                                                //                                        [theController.tableView reloadData];
                                            }
                                            
                                        }];
            break;
        case 2:
        {
            
            
            [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo
                                           onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                               
                                               //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                               //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                               associateHandler (user.uid, user, user);
                                               ////////NSLog(@"SinaWeibouid=%@",user.uid);
                                               
                                               [self getResourceList1:@"5" ID: user.uid];


                                           }
                                        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                            
                                            if (state == SSDKResponseStateSuccess)
                                            {
                                                if (![users containsObject:user])
                                                {
                                                    [users addObject:user];
                                                }
                                                
                                            }
                                            
                                        }];
        }
            
            break;
            
        default:
            break;
    }
    
}

-(void)startGetData1
{
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //    HUD.frame =CGRectMake(0, 0, 240, 240);
    HUD.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中...";
    [self.view addSubview:HUD];
//    [HUD showWhileExecuting:@selector(getResourceList1:) onTarget:self withObject:nil animated:YES];
    
}

-(void)getResourceList1:(NSString *)string ID:(NSString *)ID {
    
    
    //
    NSURL *url = [ NSURL URLWithString :[NSString stringWithFormat:@"%@/get_login_info.action",REMOTE_HOST]];
    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
    
    
    [loginKeyString setString:ID];
    
    [typeString setString:string];
    
    NSArray *array= [_label0.text componentsSeparatedByString:@"("];
    
    NSRange range = {1, [[array objectAtIndex:1] length ]-2};
    
    //    NSString *nationID = [[array objectAtIndex:1] substringToIndex:[[array objectAtIndex:1] length]-1];
    NSString *nationID = [[array objectAtIndex:1] substringWithRange:range];
    
    if (nationID.length>0) {
        [request addPostValue: nationID forKey:@"nationID"];

    }

    //    [request addPostValue: [MD5Encryption md5:_pwdText.text]  forKey:@"password"];
    if (_pwdText.text.length>0) {
        [request addPostValue: _pwdText.text forKey:@"password"];

    }
    if (_acountText.text.length>0) {
        [request addPostValue:_acountText.text forKey:@"mobilePhone"];

    }
    [request addPostValue:ID forKey:@"isLoginKey"];
    [request addPostValue:[APService registrationID] forKey:@"registID"];

    
//    [request addPostValue:_acountText.text forKey:@"mobilePhone"];
    [request addPostValue:nationID forKey:@"nationID"];
    [request addPostValue:string forKey:@"type"];

    
    
    
 
    
    [request startSynchronous];
    
    ////////NSLog(@"what%@",request.responseString);
    if (request.responseString.length>0) {
        [reString1  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
        [self performSelectorOnMainThread:@selector(requestFinished1:) withObject:nil waitUntilDone:YES];
        
    }
    else{
        
        
        
        [Util showMesssage:@"出现未知错误，请重试！"];
    }
}



- (void)requestFinished1:(ASIHTTPRequest *)request
{
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    //
//        ////////NSLog(@"what%@",reString1);
    
    if ([[parser objectWithString:reString1 ] objectForKey:@"returnCode"] != [NSNull null]
        )
    {
        
        if ([[[parser objectWithString:reString1 ] objectForKey:@"returnCode"] integerValue] ==1)
        {
            
            
            
            
 
            
            [DataManager setNSString:loginKeyString forKey:@"isLoginKey"];
            
            [DataManager setNSString:typeString forKey:@"type"];
            
            [DataManager setNSString:@"YES" forKey:@"is_update_mine"];


            [self performSegueWithIdentifier:@"NavVC" sender:nil];

        }
        else{
            
            if ([[[parser objectWithString:reString1 ]  objectForKey:@"msg"] length]>0) {
                [Util showMesssage:[[parser objectWithString:reString1 ]  objectForKey:@"msg"]];
                
            }
            else
            {
                [Util showMesssage:@"请求失败，请稍后再试"];
                
            }
            
        }
        
        
    }
    
    
}

*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    _acountText.text = nil;
//    _pwdText.text = nil;
    if ([segue.identifier isEqualToString:@"OrgSelect"]) {
//        OrgSelect *vc = segue.destinationViewController;
//        vc.list =list;
    }
    
    if ([segue.identifier isEqualToString:@"Register"]) {
             Register *vc = segue.destinationViewController;
    vc.thirdID =openID;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

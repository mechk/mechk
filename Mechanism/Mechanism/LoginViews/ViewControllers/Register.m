//
//  Login.m
//  UCreate
//
//  Created by iMobile on 15/12/24.
//  Copyright © 2015年 imobile. All rights reserved.
//

#import "Register.h"

#import "MD5Encryption.h"
#import "NSString+Check.h"
#import "RegisterNext.h"
@interface Register ()
{
    NSMutableString *reString;
    NSMutableString *codeString;

    SBJsonParser * parser;
    NSTimer *timer;
    
    int count;

}

@end

@implementation Register


@synthesize isReg;
@synthesize  thirdID;



- (void)viewDidLoad {

    reString = [[NSMutableString alloc] init];
    parser = [[SBJsonParser alloc] init];

    codeString = [[NSMutableString alloc] init];
    [super viewDidLoad];
    
    [_acountText becomeFirstResponder];

    
//    if (isReg) {
//        _titleLabel.text =@"用户注册";
//    }
//    else{
//        _titleLabel.text =@"验证手机";
//
//    }
//    
//    _acountText.text = @"15801959685";
//    _pwdText.text=@"123456";
    
    
    /*
    
    if ([DataManager getNSStringForKey:KUserKey].length > 0) {
        
        [self performSegueWithIdentifier:@"NavVC" sender:nil];
    }
     
     */

    
    
 
    
    

    // Do any additional setup after loading the view.
}
-(IBAction)getCodeAction:(id)sender
{
    
    /*
    [self getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_acountText.text zone:@"86"];
    
    [self successAction];
     
     */
}


/*
-(void)successAction
{
    
    _codeButton.enabled =NO;
    count = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
}
-(void)countTime
{
    if (count>0) {
        [_codeButton setTitle:[NSString stringWithFormat:@"重新获取(%d)",count] forState:UIControlStateNormal];
        count--;
        
    }
    else{
        [_codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        
        _codeButton.enabled=YES;
        [timer invalidate];
    }
}
- (void)getVerificationCodeByMethod:(SMSGetCodeMethod)getCodeMethod phoneNumber:(NSString *)phoneNumber zone:(NSString *)zone
{
    //    __weak RegViewController *regViewController = self;
    
    
    ////////NSLog(@"phoneNumber %@",phoneNumber);
    
    if (getCodeMethod == SMSGetCodeMethodSMS) {
        
        
        //        _codeButton.enabled =YES;
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber
                                       zone:zone
                           customIdentifier:nil
                                     result:^(NSError *error)
         {
             
             ////////NSLog(@"%@",[error description]);
             
             if (!error) {
                 [Util showMesssage:@"短信发送成功"];
             }
             else{
                 if (error.code ==477) {
                     [Util showMesssage:@"短信发送失败，验证码请求超过当天限额"];
                     
                 }
                 else{
                     [Util showMesssage:@"短信发送失败"];
                     
                 }
                 
                 
                 
                 
             }             //             ////////NSLog(@"发送失败");
             //
             //
             //             [regViewController getVerificationCodeResultHandler:phoneNumber zone:zone error:error];
             //
             
         }];
        
    }
    else if (getCodeMethod == SMSGetCodeMethodVoice)
    {
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodVoice phoneNumber:phoneNumber
                                       zone:zone
                           customIdentifier:nil
                                     result:^(NSError *error)
         {
             
             
             
             
             ////////NSLog(@"发送成功");
             //             [regViewController getVerificationCodeResultHandler:phoneNumber zone:zone error:error];
             
             
         }];
    }
}
 
 */



-(IBAction)gotoBack:(id)sender
{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
//    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    
   
    
 
     

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)regAction:(id)sender
{
    
    
    
    /*
    
    if (_pwdText.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    if (_pwdText.text.length<6||_pwdText.text.length>12) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码长度在6位到12位之间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (_rePwdText.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"请再次输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (_rePwdText.text.length<6||_rePwdText.text.length>12) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码长度在6位到12位之间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (![_rePwdText.text isEqualToString:_pwdText.text]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"两次输入的密码不一样，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
           */
    if (_acountText.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
     
   

    
//    [self startGetData];
//    
//    return;

    [_acountText resignFirstResponder];
    
    
    
    [self startGetData];
    
    /*

    [_pwdText resignFirstResponder];
    [SMSSDK commitVerificationCode:self.codeText.text phoneNumber:_acountText.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            
        }
        else
        {
            
            
            ////////NSLog(@"%@",error.description);
            
            [[[UIAlertView alloc] initWithTitle:nil message:@"验证码输入不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            return;
            
        }
    }
     
     
     ];
     
     */


    
   
    
  
  
    
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
    
    /*
     HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
     [self.navigationController.view addSubview:HUD];
     HUD.delegate = self;
     HUD.labelText = @"加载中...";
     
     [HUD showWhileExecuting:@selector(getList) onTarget:self withObject:nil animated:YES];
     
     */
    
}

-(void)getResourceList{
    
    NSURL *url = [NSURL URLWithString :@"http://www.8lingling.com/ms/service/sendSms"];
    
    ASIFormDataRequest *request= [ASIFormDataRequest requestWithURL :url];
    [request addPostValue: _acountText.text  forKey:@"phone"];
    [request addPostValue: @"0" forKey:@"type"];

    [request startSynchronous];
    if (request.responseString.length>0) {
        
        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
        
//        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
        [self performSelectorOnMainThread:@selector(requestFinished:) withObject:string waitUntilDone:YES];
        
    }
    else{
        [Util showMesssage:@"出现未知错误，请重试！"];
    }
}


- (void)requestFinished:(NSString *)aString
{
    
    NSLog(@"login%@",aString);
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dic = [parser objectWithString:aString ];
        
        if ([[dic objectForKey:@"status"] intValue]==0) {
            [codeString setString:[dic objectForKey:@"code"]];
            [Util showMesssage:[dic objectForKey:@"msg"]];
            
            [self performSegueWithIdentifier:@"RegisterNext" sender:nil];

            
        }
        
        else{
            [Util showMesssage:[dic objectForKey:@"msg"] ];
            
        }
        
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
    
}
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
    if ([segue.identifier isEqualToString:@"RegisterNext"]) {
        RegisterNext *vc = segue.destinationViewController;
        vc.acountString = _acountText.text;
        vc.codeString = codeString;
        
        if (thirdID) {
            vc.thirdID = thirdID;
        }
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

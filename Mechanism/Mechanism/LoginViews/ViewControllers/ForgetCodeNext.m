//
//  ForgetCodeNext.m
//  ShuGeShow
//
//  Created by iMobile on 16/2/21.
//  Copyright © 2016年 iMobile. All rights reserved.
//

#import "ForgetCodeNext.h"
#import "MD5Encryption.h"

@interface ForgetCodeNext ()
{
    NSMutableString *reString;
    SBJsonParser * parser;
    NSTimer *timer;
    
    int count;
}

@end

@implementation ForgetCodeNext

@synthesize  isForget;

@synthesize  account;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    reString = [[NSMutableString alloc] init];
    
    parser = [[SBJsonParser alloc] init];
    [self successAction];
    
    [_orgPwdText becomeFirstResponder];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)gotoBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)doneAction:(id)sender
{
    
    if (_orgPwdText.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"验证码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    
    if (_pwdText.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"新密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    if (_pwdText.text.length<6||_pwdText.text.length>12) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"密码长度在6位到12位之间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    /*
    
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
    
    


    
    [self getResourceList];
    
    //  [self performSegueWithIdentifier:@"ForgetCodeNext" sender:nil];
    
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
    
    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/forget"];
    
    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
    [request addPostValue:account  forKey:@"phone"];
    [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
    [request addPostValue: _orgPwdText.text  forKey:@"code"];
    [request addPostValue: _pwdText.text  forKey:@"newPassword"];

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
-(IBAction)getCodeAction:(id)sender
{
    //    [self getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_acountText.text zone:@"86"];
    
    [self getResourceList3];
    
    [self successAction];
}
-(void)successAction
{
    
    _codeButton.enabled =NO;
//    [_codeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
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
-(void)getResourceList3{
    
    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/sendSms"];
    
    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
    [request addPostValue:account  forKey:@"phone"];
    [request addPostValue: @"1" forKey:@"type"];

    [request startSynchronous];
    if (request.responseString.length>0) {
        
        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
        
        //        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
        [self performSelectorOnMainThread:@selector(requestFinished3:) withObject:string waitUntilDone:YES];
        
    }
    else{
        [Util showMesssage:@"出现未知错误，请重试！"];
    }
}


- (void)requestFinished3:(NSString *)aString
{
    
    //////////NSLog(@"login%@",aString);
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dic = [parser objectWithString:aString ];
        
        if ([[dic objectForKey:@"status"] intValue]==0) {
            //            [codeString setString:[dic objectForKey:@"code"]];
            [Util showMesssage:[dic objectForKey:@"msg"]];
            
            //            [self performSegueWithIdentifier:@"RegisterNext" sender:nil];
            
            
        }
        
        else{
            [Util showMesssage:[dic objectForKey:@"msg"] ];
            
        }
        
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
    
}

- (void)requestFinished:(NSString *)aString
{
    
    //////////NSLog(@"login%@",aString);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

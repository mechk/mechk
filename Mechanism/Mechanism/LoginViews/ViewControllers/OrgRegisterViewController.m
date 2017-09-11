//
//  OrgLoginViewController.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgRegisterViewController.h"
#import "Masonry.h"
#import "Contant.h"
#import "CommonTool.h"
#import "OrgRegisterStepTowVC.h"

@interface OrgRegisterViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation OrgRegisterViewController {
    SBJsonParser * parser;

}

- (UITextField *)phoneNumTextField {
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[UITextField alloc] init];
        _phoneNumTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _phoneNumTextField.background = [UIImage imageNamed:@"Org_Register_TextField"];
        _phoneNumTextField.delegate = self;
        
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _phoneNumTextField.placeholder = @"请输入手机号";
        
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
        
        _phoneNumTextField.leftView = frontView;
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_phoneNumTextField];
        [_phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(40));
            make.left.offset(KWIDTH(30));
            make.right.offset(KWIDTH(-30));
            make.height.offset(KHEIGHT(120));
        }];
        
    }
    return _phoneNumTextField;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button"] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button_Select"] forState:UIControlStateSelected];
        [_nextButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_nextButton];
        
        __weak typeof(self) weakSelf = self;

        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.phoneNumTextField.mas_bottom).offset(KHEIGHT(40));
            make.left.equalTo(weakSelf.phoneNumTextField.mas_left);
            make.right.equalTo(weakSelf.phoneNumTextField.mas_right);
            make.height.offset(KHEIGHT(90));
        }];
        
    }
    return _nextButton;
}

#pragma mark - View controller life cycle
- (void)viewWillAppear:(BOOL)animated {
    [self.phoneNumTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.phoneNumTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    parser = [[SBJsonParser alloc] init];
    switch (self.registerType) {
        case RegisterTypeUser: {
            self.navigationItem.title = @"用户注册";
        }
            break;
        case RegisterTypeOrg: {
            self.navigationItem.title = @"机构注册";
        }
            break;
        case RegisterTypeResetPassword: {
            self.navigationItem.title = @"密码重置";
        }
            break;
        case RegisterTypePhoneNumber: {
            self.navigationItem.title = @"绑定手机号码";
        }
            break;
        default:
            break;
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Common_back_button"] style:UIBarButtonItemStyleDone target:self action:@selector(returnBtnTapped:)];
    self.view.backgroundColor = [CommonTool colorWithHexString:@"#f8f8f8"];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KHEIGHT(270) - 64 , [UIScreen mainScreen].bounds.size.width, KHEIGHT(270))];
    [bottomImageView setImage:[UIImage imageNamed:@"Org_Register_Background"]];
    [self.view addSubview:bottomImageView];
    
    [self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextButtonAction:(UIButton *)sender {
    if (self.phoneNumTextField.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (![Util checkTelNumber:self.phoneNumTextField.text] )
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    
    
    // TODO:
    [self getCode];
    
    
//    OrgRegisterStepTowVC *orgRegisterTwoVC = [[OrgRegisterStepTowVC alloc] init];
//    orgRegisterTwoVC.phoneNum = self.phoneNumTextField.text;
//    orgRegisterTwoVC.registerType = self.registerType;
//    [self.navigationController pushViewController:orgRegisterTwoVC animated:YES];
}

- (void)returnBtnTapped:(id)sender {
//    [self.view endEditing:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
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

- (void)getCode {
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
//    [request addPostValue:self.phoneNumTextField.text forKey:@"phone"];
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
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.phoneNumTextField.text forKey:@"phone"];
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
        if ([[responseObject objectForKey:@"status"] intValue]==0) {
            
            OrgRegisterStepTowVC *orgRegisterTwoVC = [[OrgRegisterStepTowVC alloc] init];
            orgRegisterTwoVC.phoneNum = self.phoneNumTextField.text;
            orgRegisterTwoVC.registerType = self.registerType;
            orgRegisterTwoVC.thirdId = self.thirdId;
            orgRegisterTwoVC.thirdWay = self.thirdWay;
            orgRegisterTwoVC.name = self.name;
            orgRegisterTwoVC.pic = self.pic;
            orgRegisterTwoVC.gender = self.gender;
            
            [self.navigationController pushViewController:orgRegisterTwoVC animated:YES];
            
        } else {
            [Util showMesssage:responseObject[@"msg"]];
        }

    } failure:^(NSError *error) {
        
    }];
}



- (void)requestFinished:(NSString *)aString
{ 
    NSLog(@"requestFinished1%@",aString);
    
    NSDictionary *dict = [parser objectWithString:aString ];
    
    NSLog(@"=======%@", dict);
    
    if ([[dict objectForKey:@"status"] intValue]==0) {
        
        OrgRegisterStepTowVC *orgRegisterTwoVC = [[OrgRegisterStepTowVC alloc] init];
        orgRegisterTwoVC.phoneNum = self.phoneNumTextField.text;
        orgRegisterTwoVC.registerType = self.registerType;
        orgRegisterTwoVC.thirdId = self.thirdId;
        orgRegisterTwoVC.thirdWay = self.thirdWay;
        orgRegisterTwoVC.name = self.name;
        orgRegisterTwoVC.pic = self.pic;
        orgRegisterTwoVC.gender = self.gender;
        
        [self.navigationController pushViewController:orgRegisterTwoVC animated:YES];
        
    } else {
        [Util showMesssage:dict[@"msg"]];
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

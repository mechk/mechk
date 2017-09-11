//
//  SetPassword.h
//  ShuGeShow
//
//  Created by iMobile on 16/2/21.
//  Copyright © 2016年 iMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetPasswordDelegate <NSObject>

-(void)setPasswordDelegateDone;

@end
@interface SetPassword : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *orgPwdText;

@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UITextField *rePwdText;

@property (assign, nonatomic) BOOL isForget;
@property (retain, nonatomic) NSString *account;

@property(nonatomic,assign) id< SetPasswordDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *acountText;

@end
